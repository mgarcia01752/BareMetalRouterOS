# AGENTS.md

This file provides guidance for coding agents working in this repository.
Keep it short, accurate, and updated when workflows change.

## Project Basics

- Repository: `BareMetalRouterOS`
- Purpose: Yocto-based x86-64 router image integration using the BMROS layer and RouterShell CLI.
- This repo is NOT greenfield; extend existing scripts, docs, and Yocto layer patterns.
- Read `README.md` first for setup and usage.
- Treat this repository as a Yocto integration workspace, not a Python application workspace.

## Repository Shape

- `README.md` is the user-facing setup overview.
- `doc/` contains workflow and recipe documentation.
- `lib/common.sh` defines shared script constants and helpers.
- Root `*.sh` files drive host setup, Poky installation, layer updates, image builds, QEMU runs, media creation, and menuconfig.
- `tools/` contains repository helper tooling for Git save and release/version checks.
- `yocto-meta-layers/meta-bare-metal-router/` is the BMROS Yocto layer source tracked in this repository.
- `poky/`, `downloads/`, build outputs, temporary state, and generated images are local/generated artifacts and are ignored by Git.

## Yocto Baseline

- Yocto codename is `scarthgap`, set in `lib/common.sh` as `YOCTO_CODE_NAME`.
- BMROS release version is tracked in `VERSION`.
- The normal build directory is `poky/build-bmros`.
- The default production image recipe is `bare-metal-router`.
- Other image targets include `bare-metal-router-vanilla`, `bare-metal-router-debug`, and `core-image-minimal`.
- `install-yocto-poky.sh` clones Poky and external layers, copies `yocto-meta-layers/meta-bare-metal-router` into `poky/`, initializes `build-bmros`, and adds required layers.
- `install-yocto-poky.sh` reads `VERSION` and uses it when rewriting Poky's `DISTRO_VERSION` to the BMROS distro version.
- `update-layers.sh` copies tracked layer content from `yocto-meta-layers/` into `poky/`.
- Treat `yocto-meta-layers/` as source of truth; treat `poky/` as generated/vendor working state unless the user explicitly asks to inspect build output.

## RouterShell Integration

- RouterShell is consumed through `yocto-meta-layers/meta-bare-metal-router/recipes-core/router-shell/router-shell_git.bb`.
- The recipe currently pins:
  - `RS_SRC_REV = "0.1.14"`
  - `SRCREV = "2bf9313a8e4722ff643902e6efc7df826c50c48e"`
  - branch `v${RS_SRC_REV}` from `https://github.com/mgarcia01752/RouterShell.git`
- Before changing RouterShell recipe version, source revision, runtime dependencies, install paths, or startup integration, inspect the corresponding RouterShell source/release state in `/home/dev01/Projects/RouterShell` when that repository is present.
- Call out cross-repo impact in the final response for RouterShell-related changes.

## Operational Safety

- Do not create Python virtual environments in this repository unless the user explicitly asks.
- Do not install Python packages globally from this repository during routine coding-agent work.
- `setup-yocto-env.sh` runs `sudo apt` and `pip install`; do not run it casually on the development box.
- `install-yocto-poky.sh`, `build-bmros.sh`, `run-bmros.sh`, and media scripts can be expensive or host-impacting. Confirm intent before running long builds, QEMU launches, media writes, or destructive cleanup.
- For script validation, prefer syntax checks such as `bash -n` on changed scripts.
- Preserve destructive-command prompts and make destructive behavior opt-in.

## Editing Guidance

- Keep changes minimal and scoped to the requested workflow.
- Extend existing Bash script patterns and shared constants in `lib/common.sh` instead of inventing parallel config.
- Use `#!/usr/bin/env bash` and `set -euo pipefail` for new Bash scripts unless compatibility requires otherwise.
- Quote shell variables unless word splitting is intentional.
- Update `doc/` or `README.md` alongside behavior changes.
- Do not edit generated `poky/` layer copies as the only source of a fix; edit the tracked layer under `yocto-meta-layers/`.

## Tools

- `tools/git/git-save.sh` is the normal save-commit helper and accepts `--commit-msg "<message>"`.
- `tools/support/bump_version.py` updates the tracked BMROS `VERSION`.
- `tools/release/check_version.py` verifies `VERSION` and installer release-version wiring.
- Keep `tools/` organized by category; do not add files directly under `tools/` root.

## Useful Validation

```bash
tools/release/check_version.py
```

```bash
bash -n script-name.sh
```

```bash
git status --short --branch
```

For recipe or image behavior changes, a full Yocto validation may require:

```bash
./build-bmros.sh
```

Run expensive validation only when the user asks for it or when it is clearly necessary and acceptable.

## Agent Self-Checks

Before responding after edits:

- Re-read this file and `README.md`.
- Confirm changed files are in the intended BMROS repo.
- Confirm relevant syntax checks or tests were run, or state why not.
- Confirm no sensitive content was printed or added.
- Confirm formatting and alignment are preserved.
