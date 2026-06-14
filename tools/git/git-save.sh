#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Stage and commit the current Git repository.

Usage:
  tools/git/git-save.sh [--commit-msg "Message"] [--push] [--dry-run]

Options:
  --commit-msg  Commit message prefix (default: "Update BMROS").
  --push        Push the current branch after commit.
  --dry-run     Show what would be committed without staging or committing.
  -h, --help    Show this help.
EOF
}

commit_msg="Update BMROS"
do_push="false"
dry_run="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --commit-msg)
      shift
      if [[ "${1:-}" == "" ]]; then
        echo "ERROR: --commit-msg requires a value." >&2
        exit 1
      fi
      commit_msg="$1"
      shift
      ;;
    --push)
      do_push="true"
      shift
      ;;
    --dry-run)
      dry_run="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: This script must be run inside a Git repository." >&2
  exit 1
fi

repo_root="$(git rev-parse --show-toplevel)"
cd "${repo_root}"

current_branch="$(git rev-parse --abbrev-ref HEAD)"
pending_changes="$(git status --short)"

echo "========================================"
echo "BMROS Git Save"
echo "Branch: ${current_branch}"
echo "Changes:"
if [[ -z "${pending_changes}" ]]; then
  echo "  (none)"
else
  printf '%s\n' "${pending_changes}"
fi
echo "========================================"

if [[ -z "${pending_changes}" ]]; then
  echo "No changes to commit."
  exit 0
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "Dry run complete. No files were staged or committed."
  exit 0
fi

timestamp="$(date +'%Y-%m-%d %H:%M:%S')"
final_msg="${commit_msg} - ${timestamp}"

echo "Staging changes..."
git add -A

echo "Creating commit..."
git commit -m "${final_msg}"

if [[ "${do_push}" == "true" ]]; then
  remote_name="$(git config "branch.${current_branch}.remote" || true)"
  if [[ -z "${remote_name}" ]]; then
    echo "Pushing to origin (${current_branch})..."
    git push -u origin "${current_branch}"
  else
    echo "Pushing to ${remote_name} (${current_branch})..."
    git push "${remote_name}" "${current_branch}"
  fi
else
  echo "Push skipped. Use --push to push."
fi

echo "Done."
