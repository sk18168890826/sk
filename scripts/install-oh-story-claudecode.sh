#!/usr/bin/env bash
set -euo pipefail

# install-oh-story-claudecode.sh
# Automates installation of the oh-story-claudecode skill into this project using npx.
# Usage:
#   chmod +x scripts/install-oh-story-claudecode.sh
#   ./scripts/install-oh-story-claudecode.sh [--global]
# Options:
#   --global  Install globally (adds skill to global skills list). Without it installs locally into this directory.

TARGET_REPO="worldwonderer/oh-story-claudecode"
NPX_CMD=(npx skills add "$TARGET_REPO" -y)

if [ "${1:-}" = "--global" ]; then
  NPX_CMD+=( -g )
fi

echo "Running: ${NPX_CMD[*]}"
"${NPX_CMD[@]}"

echo "Installation command finished."

cat <<'EOF'
Next steps:
 1) If you installed globally (use --global), the skill will be available system-wide; otherwise it's installed into the current directory.
 2) In a writing project (this repo or a subdirectory), run the skill's setup step via your Agent/CLI or run the command provided by your platform. Example (Claude/OpenCode/Codex/ZCode/OpenClaw):
      /story-setup
    or, if you have a local wrapper, run:
      $story-setup
 3) After running /story-setup, open a new session in your platform so custom agents (if any) can register.

If you want me to copy the skill files directly into this repository (so the skill is available offline from this repo), reply "copy files" and I'll paste the skill into a ./skills/oh-story-claudecode/ directory in this repository.
EOF
