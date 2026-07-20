#!/usr/bin/env bash
set -euo pipefail

# scripts/fetch-skill-files.sh
# Fetches the worldwonderer/oh-story-claudecode repo (branch default: main)
# and copies its contents into this repository under a target directory.
# Usage:
#   chmod +x scripts/fetch-skill-files.sh
#   ./scripts/fetch-skill-files.sh [--branch BRANCH] [--target TARGET_DIR]
# Example:
#   ./scripts/fetch-skill-files.sh --branch main --target skills/oh-story-claudecode

BRANCH="main"
TARGET="skills/oh-story-claudecode"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --branch)
      shift
      BRANCH="$1"
      ;;
    --target)
      shift
      TARGET="$1"
      ;;
    -h|--help)
      echo "Usage: $0 [--branch BRANCH] [--target TARGET_DIR]"
      exit 0
      ;;
    *)
      echo "Unknown arg: $1" >&2
      echo "Usage: $0 [--branch BRANCH] [--target TARGET_DIR]"
      exit 2
      ;;
  esac
  shift
done

REPO="worldwonderer/oh-story-claudecode"
ZIP_URL="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.zip"
TMPDIR=$(mktemp -d)
ZIPFILE="$TMPDIR/skill.zip"

echo "Downloading ${REPO}@${BRANCH} -> ${ZIPFILE}"
curl -fsSL --max-time 60 -o "$ZIPFILE" "$ZIP_URL"

echo "Unpacking..."
unzip -q "$ZIPFILE" -d "$TMPDIR"
SRC_DIR="$TMPDIR/$(basename ${REPO})-${BRANCH}"
if [ ! -d "$SRC_DIR" ]; then
  # Some repos use branch name different mapping; try listing
  SRC_DIR=$(find "$TMPDIR" -maxdepth 1 -type d -name "*${BRANCH}" | head -n 1 || true)
fi

if [ -z "$SRC_DIR" ] || [ ! -d "$SRC_DIR" ]; then
  echo "Failed to find source directory inside zip. Contents:" >&2
  ls -la "$TMPDIR"
  exit 3
fi

# Prepare target
mkdir -p "$(dirname "$TARGET")"
# Remove existing target directory to replace with fresh snapshot
if [ -d "$TARGET" ]; then
  echo "Removing existing target directory $TARGET"
  rm -rf "$TARGET"
fi

echo "Copying files to $TARGET"
mkdir -p "$TARGET"
# Preserve hidden files
shopt -s dotglob || true
cp -R "$SRC_DIR"/* "$TARGET"/

# Cleanup
rm -rf "$TMPDIR"

echo "Snapshot of ${REPO}@${BRANCH} copied into $TARGET"

# If running inside a git repository, create a commit for the added files (optional)
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git add "$TARGET" || true
  if git diff --staged --quiet; then
    echo "No changes to commit for $TARGET"
  else
    git commit -m "Add skill files: ${REPO}@${BRANCH} -> ${TARGET}" || true
    echo "Committed changes (local). Push if you want: git push"
  fi
else
  echo "Not inside a git worktree; skipped git commit. You can manually move $TARGET into your project."
fi

exit 0
