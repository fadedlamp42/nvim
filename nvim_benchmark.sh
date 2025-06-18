#!/bin/bash

# Neovim Startup Performance Benchmark Script
# Usage: ./nvim_benchmark.sh [number_of_runs]
# Make executable with: chmod +x nvim_benchmark.sh

set -euo pipefail

RUNS=${1:-10}
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
TEMP_DIR=$(mktemp -d)
RESULTS_FILE="$TEMP_DIR/startup_times.txt"

echo "🚀 Neovim Startup Performance Benchmark"
echo "========================================"
echo "Config directory: $NVIM_CONFIG_DIR"
echo "Number of runs: $RUNS"
echo "Results will be saved to: $RESULTS_FILE"
echo

# Function to run startup benchmark
benchmark_startup() {
    local mode=$1
    local description=$2
    local extra_args=$3
    
    echo "📊 Testing: $description"
    echo "Command: nvim $extra_args"
    
    local total_time=0
    local times=()
    
    for ((i=1; i<=RUNS; i++)); do
        echo -n "  Run $i/$RUNS... "
        
        # Measure startup time
        local start_time=$(date +%s.%N)
        timeout 30s nvim $extra_args +qa! 2>/dev/null || true
        local end_time=$(date +%s.%N)
        
        local run_time=$(echo "$end_time - $start_time" | bc -l)
        times+=($run_time)
        total_time=$(echo "$total_time + $run_time" | bc -l)
        
        printf "%.3fs\n" $run_time
    done
    
    # Calculate statistics
    local avg_time=$(echo "scale=3; $total_time / $RUNS" | bc -l)
    
    # Find min and max
    local min_time=${times[0]}
    local max_time=${times[0]}
    for time in "${times[@]}"; do
        if (( $(echo "$time < $min_time" | bc -l) )); then
            min_time=$time
        fi
        if (( $(echo "$time > $max_time" | bc -l) )); then
            max_time=$time
        fi
    done
    
    echo "  📈 Results:"
    printf "    Average: %.3fs\n" $avg_time
    printf "    Min:     %.3fs\n" $min_time
    printf "    Max:     %.3fs\n" $max_time
    echo
    
    # Save to results file
    echo "$mode,$description,$avg_time,$min_time,$max_time" >> "$RESULTS_FILE"
}

# Create results file with header
echo "mode,description,avg_time,min_time,max_time" > "$RESULTS_FILE"

# 1. Baseline startup (clean config)
echo "🧪 BASELINE TESTS"
echo "=================="

# Test with minimal config
echo 'vim.opt.loadplugins = false' > "$TEMP_DIR/minimal_init.lua"
benchmark_startup "minimal" "Minimal config (no plugins)" "-u $TEMP_DIR/minimal_init.lua"

# Test with no config
benchmark_startup "clean" "Clean Neovim (no config)" "-u NONE"

echo "🔌 PLUGIN TESTS"
echo "==============="

# Test current config
benchmark_startup "current" "Current config (all plugins)" ""

# Test with lazy loading disabled
echo "⚡ OPTIMIZATION TESTS"
echo "===================="

# Test lazy loading impact
benchmark_startup "no_lazy" "Config with lazy=false" "--cmd 'lua vim.g.lazy_disabled = true'"

echo "📋 DETAILED STARTUP PROFILE"
echo "============================"

echo "Generating detailed startup profile..."

# Create startup profile
nvim --startuptime "$TEMP_DIR/startup_profile.txt" +qa!

echo "Top 20 slowest startup items:"
echo "-----------------------------"
tail -n +2 "$TEMP_DIR/startup_profile.txt" | sort -k2 -nr | head -20 | \
    awk '{printf "  %8.3fms  %s\n", $2, $3}' | \
    sed 's/.*\/\([^\/]*\)$/  \1/'

echo
echo "Startup profile breakdown by category:"
echo "-------------------------------------"

# Analyze startup profile by categories
awk 'NR>1 {
    if ($3 ~ /lazy\.nvim/ || $3 ~ /plugins/) 
        plugins += $2
    else if ($3 ~ /init\.lua/ || $3 ~ /config/) 
        config += $2
    else if ($3 ~ /treesitter/) 
        treesitter += $2
    else if ($3 ~ /lsp/) 
        lsp += $2
    else 
        other += $2
    total += $2
}
END {
    printf "  Plugins:     %8.3fms (%.1f%%)\n", plugins, plugins/total*100
    printf "  Config:      %8.3fms (%.1f%%)\n", config, config/total*100
    printf "  Treesitter:  %8.3fms (%.1f%%)\n", treesitter, treesitter/total*100
    printf "  LSP:         %8.3fms (%.1f%%)\n", lsp, lsp/total*100
    printf "  Other:       %8.3fms (%.1f%%)\n", other, other/total*100
    printf "  Total:       %8.3fms\n", total
}' "$TEMP_DIR/startup_profile.txt"

echo
echo "📊 PLUGIN-SPECIFIC ANALYSIS"
echo "==========================="

# Check which plugins are loading at startup vs lazy
if command -v nvim >/dev/null; then
    echo "Checking lazy.nvim plugin loading status..."
    nvim --headless -c "
        local lazy = require('lazy')
        local plugins = lazy.plugins()
        local startup_count = 0
        local lazy_count = 0
        
        print('Plugins loaded at startup:')
        for _, plugin in pairs(plugins) do
            if not plugin.lazy then
                print('  - ' .. plugin.name)
                startup_count = startup_count + 1
            else
                lazy_count = lazy_count + 1
            end
        end
        
        print('')
        print('Summary:')
        print('  Startup plugins: ' .. startup_count)
        print('  Lazy plugins:    ' .. lazy_count)
        print('  Total plugins:   ' .. (startup_count + lazy_count))
        print('  Lazy ratio:      ' .. math.floor(lazy_count / (startup_count + lazy_count) * 100) .. '%')
    " +qa! 2>/dev/null
fi

echo
echo "🎯 OPTIMIZATION RECOMMENDATIONS"
echo "==============================="

# Analyze results and provide recommendations
awk -F',' 'NR>1 {
    if ($1 == "current") current = $3
    if ($1 == "minimal") minimal = $3
    if ($1 == "clean") clean = $3
}
END {
    if (current && minimal && clean) {
        config_overhead = current - clean
        plugin_overhead = current - minimal
        
        printf "Current startup time:     %.3fs\n", current
        printf "Clean Neovim baseline:    %.3fs\n", clean
        printf "Config overhead:          %.3fs (%.1f%%)\n", config_overhead, config_overhead/current*100
        printf "Plugin overhead:          %.3fs (%.1f%%)\n", plugin_overhead, plugin_overhead/current*100
        printf "\n"
        
        if (current > 0.100) {
            print "⚠️  Startup time is > 100ms. Consider:"
            print "   • Enable more lazy loading"
            print "   • Remove unused plugins"
            print "   • Defer non-critical configurations"
        } else if (current > 0.050) {
            print "⚡ Startup time is good but could be better:"
            print "   • Check for plugins loading at startup"
            print "   • Consider deferring some configurations"
        } else {
            print "✅ Excellent startup time!"
        }
    }
}' "$RESULTS_FILE"

echo
echo "📄 FULL RESULTS"
echo "=============="
echo "Detailed results saved to: $RESULTS_FILE"
echo "Startup profile saved to: $TEMP_DIR/startup_profile.txt"
echo
cat "$RESULTS_FILE"

echo
echo "🔧 USEFUL COMMANDS FOR OPTIMIZATION"
echo "==================================="
cat << 'EOF'
# Manual benchmarking commands:
nvim --startuptime startup.log +qa!           # Generate detailed startup log
nvim --cmd 'profile start profile.log' \
     --cmd 'profile file ~/.config/nvim/*' \
     +qa!                                      # Profile config files

# Check lazy loading status:
nvim -c 'Lazy profile' +qa!                   # Show lazy.nvim plugin timing

# Test startup without plugins:
nvim --noplugin                               # Disable all plugins
nvim -u NONE                                  # Completely clean start

# Minimal config test:
echo 'vim.opt.loadplugins = false' > minimal.lua
nvim -u minimal.lua                           # Test with minimal config

# Check for slow autocommands:
nvim --cmd 'set verbose=9' +qa! 2>&1 | grep autocmd

# Profile specific operations:
nvim --cmd 'profile start prof.log' \
     --cmd 'profile func *' \
     -c 'source ~/.config/nvim/init.lua' +qa!
EOF

# Cleanup
echo
echo "🧹 Cleaning up temporary files..."
# Keep the temp directory for now so user can examine files
echo "Temporary files kept in: $TEMP_DIR"
echo "You can examine the detailed logs there and remove when done."

echo
echo "✅ Benchmark complete!"
