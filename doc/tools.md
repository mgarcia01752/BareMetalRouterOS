# BMROS Tools

BMROS helper tools live under `tools/` and are grouped by purpose.

## Git Save

Use `tools/git/git-save.sh` to stage and commit local changes with a timestamped message.

```bash
tools/git/git-save.sh --commit-msg "Update BMROS tooling"
```

Preview the current change set without staging or committing:

```bash
tools/git/git-save.sh --dry-run
```

Push the current branch after committing:

```bash
tools/git/git-save.sh --commit-msg "Update BMROS tooling" --push
```

## Version Bump

BMROS stores its release version in `VERSION`. The installer reads that file when it stamps the Yocto distro version during Poky setup.

Show the current version:

```bash
tools/support/bump_version.py --current
```

Bump the next patch, minor, or major version:

```bash
tools/support/bump_version.py --next patch
```

Set an explicit version:

```bash
tools/support/bump_version.py 0.2.0
```

Verify version wiring:

```bash
tools/release/check_version.py
```
