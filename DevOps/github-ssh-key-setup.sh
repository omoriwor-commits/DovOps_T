#!/usr/bin/env bash
# GitHub SSH key setup reference for Git Bash / Linux
# Creates a dedicated ED25519 key for GitHub authentication.

set -e

KEY="$HOME/.ssh/id_ed25519_github"
PUB="$KEY.pub"
CONFIG="$HOME/.ssh/config"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# 1. Create a GitHub SSH key pair.
# If the key already exists, stop instead of overwriting it.
if [ -e "$KEY" ] || [ -e "$PUB" ]; then
  echo "GitHub SSH key already exists:"
  ls -l "$KEY" "$PUB" 2>/dev/null || true
  echo "Not overwriting existing key."
  exit 1
fi

ssh-keygen -t ed25519 -C "github-ssh-key" -f "$KEY"

# 2. Verify the key files.
ls -l "$KEY" "$PUB"

# 3. Display the PUBLIC key.
echo
echo "Copy this public key into GitHub -> Settings -> SSH and GPG keys -> New SSH key:"
cat "$PUB"

# 4. Add a GitHub SSH config entry only if one is not already present.
touch "$CONFIG"
chmod 600 "$CONFIG"

if ! grep -qE '^[[:space:]]*Host[[:space:]]+github\.com([[:space:]]|$)' "$CONFIG"; then
  cat >> "$CONFIG" <<'EOF'

Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github
    IdentitiesOnly yes
EOF
  echo "Added github.com entry to $CONFIG"
else
  echo "A github.com SSH config entry already exists in $CONFIG"
  echo "Review it before making changes."
fi

# 5. Test authentication after the public key has been added to GitHub.
echo
echo "After adding the public key to GitHub, test with:"
echo "ssh -T git@github.com"

# SECURITY:
# Never share or commit the private key:
#   ~/.ssh/id_ed25519_github
# Only the .pub file is safe to copy:
#   ~/.ssh/id_ed25519_github.pub
