#!/bin/sh
# installs a pre-commit hook that runs stylua on staged lua files
# idempotent; safe to run multiple times

hook_dir=$(git rev-parse --git-dir)/hooks
hook_path="$hook_dir/pre-commit"

hook_content='#!/bin/sh
# runs stylua on staged lua files, re-stages them, commit continues
staged=$(git diff --cached --name-only --diff-filter=ACM | grep '\''\.lua$'\'')
[ -z "$staged" ] && exit 0
echo "$staged" | xargs stylua
echo "$staged" | xargs git add'

mkdir -p "$hook_dir"

if [ -f "$hook_path" ]; then
    existing=$(cat "$hook_path")
    if [ "$existing" = "$hook_content" ]; then
        echo "pre-commit hook already installed"
        exit 0
    fi
fi

printf '%s\n' "$hook_content" > "$hook_path"
chmod +x "$hook_path"
echo "pre-commit hook installed"
