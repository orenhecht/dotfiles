#!/usr/bin/env sh

# the directory where git templates reside
TEMPLATE_DIR="$HOME/.git_template"

mkdir -p "$TEMPLATE_DIR/hooks"

# configure the template directory
git config --global init.templatedir "$TEMPLATE_DIR"

# add a git alias: 'git ctags' that generates ctags
git config --global alias.ctags '!.git/hooks/ctags'

# create all the hooks
cat << 'EOF' > "$TEMPLATE_DIR/hooks/ctags"
#!/bin/sh
set -e
PATH="/usr/local/bin:$PATH"
trap 'rm -f "$$.tags"' EXIT
git ls-files | \
  ctags --tag-relative -L - -f"$$.tags"
mv "$$.tags" "tags"
EOF

for f in "post-checkout" "post-commit" "post-merge"; do
   cat << 'EOF' >> "$TEMPLATE_DIR/hooks/$f"
#!/bin/sh
.git/hooks/ctags >/dev/null 2>&1 &
EOF
done

cat << 'EOF' >> "$TEMPLATE_DIR/hooks/post-rewrite"
#!/bin/sh
case "$1" in
  rebase) exec .git/hooks/post-merge ;;
esac
EOF

# make all hooks executable
for f in "post-checkout" "post-commit" "post-merge" "post-rewrite" "ctags"; do
   chmod u+x "$TEMPLATE_DIR/hooks/$f"
done

