#!/usr/bin/env bash
# Publish this instance's site to gh-pages, by an agent: main to the root,
# any other branch to its preview folder. The steps before the publish are the
# ones whose absence made a first publish fail:
#   1. gh-pages exists on origin; if not, it is started as an empty orphan
#      branch holding only .nojekyll (stage-local clones gh-pages and refuses
#      when it is missing);
#   2. the mounted layers are re-laid fresh from index.lock.json (a site build
#      writes into the mounts, and stage-local refuses a modified mount);
#   3. the checkout's IG inputs are the commit's: an earlier site build draws
#      SVGs beside input/business-processes/*.bpmn, and any untracked file under
#      input/ makes the cached AST "stale-inputs", which a root publish refuses;
#   4. stage-local --plan, then the publish.
# Usage: bash tools/publish/publish.sh [--plan]
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
remote="$(git remote get-url origin)"

if [ -z "$(git ls-remote --heads origin gh-pages)" ]; then
  echo "· gh-pages is missing on origin: starting it as an empty orphan branch"
  tmp="$(mktemp -d)"
  git -C "$tmp" init -q
  git -C "$tmp" checkout -q --orphan gh-pages
  touch "$tmp/.nojekyll"
  git -C "$tmp" add .nojekyll
  git -C "$tmp" -c user.name="$(git config user.name || echo publisher)" -c user.email="$(git config user.email || echo publisher@localhost)" \
    commit -q -m "Start gh-pages: published by an agent (main to the root, other branches to previews)"
  git -C "$tmp" push -q "$remote" gh-pages
  rm -rf "$tmp"
fi
echo "✓ gh-pages exists on origin"

# Re-lay every mount from the lock, discarding what an earlier build wrote there.
while read -r h _; do rm -rf "$h"; done < <(python3 -c "import json;[print(m['harness'],m['ref']) for m in json.load(open('index.lock.json'))['mounts']]")
python3 -c "import json;[print(m['harness'],m['repository'],m['ref']) for m in json.load(open('index.lock.json'))['mounts']]" |
  while read -r h r ref; do git clone -q --filter=blob:none --no-checkout "https://github.com/$r" "$h" && git -C "$h" checkout -q "$ref" && rm -rf "$h/.git"; done
bun install --frozen-lockfile --ignore-scripts > /dev/null
rm -rf smart-base && bun cat-harness-tools/scripts/remote-mount.ts --fresh > /dev/null
bun cat-harness-tools/scripts/run-script.ts mount:remote:check | sed -n 3p
echo "✓ mounts laid fresh from index.lock.json"

# The IG inputs must be exactly the commit's (untracked files under input/ are build leftovers).
git clean -fdq input/
if [ -n "$(git status --porcelain -- input sushi-config.yaml ig.ini)" ]; then
  echo "✗ input/ has uncommitted changes: commit them first; the site is built from the commit's AST" >&2; exit 1
fi
echo "✓ input/ is the commit's"

bun cat-harness-tools/scripts/stage-local.ts --repo . --plan
[ "${1:-}" = "--plan" ] && exit 0
bun cat-harness-tools/scripts/stage-local.ts --repo .
