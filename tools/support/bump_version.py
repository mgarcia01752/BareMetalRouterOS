#!/usr/bin/env python3
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


VERSION_FILE_PATH = Path("VERSION")
INSTALL_SCRIPT_PATH = Path("install-yocto-poky.sh")
VERSION_SEPARATOR = "."
VERSION_PATTERN = re.compile(r"^\d+\.\d+\.\d+$")


def _validate_version(version: str) -> None:
    if not VERSION_PATTERN.match(version):
        print(
            f"ERROR: Invalid version '{version}'. Expected MAJOR.MINOR.PATCH, for example 0.1.0.",
            file=sys.stderr,
        )
        sys.exit(1)


def _read_current_version() -> str:
    if not VERSION_FILE_PATH.is_file():
        print(f"ERROR: Version file not found: {VERSION_FILE_PATH}", file=sys.stderr)
        sys.exit(1)

    version = VERSION_FILE_PATH.read_text(encoding="utf-8").strip()
    _validate_version(version)
    return version


def _write_version(version: str) -> None:
    VERSION_FILE_PATH.write_text(f"{version}\n", encoding="utf-8")


def _compute_next_version(current_version: str, mode: str) -> str:
    parts = [int(part) for part in current_version.split(VERSION_SEPARATOR)]

    if mode == "major":
        parts[0] += 1
        parts[1] = 0
        parts[2] = 0
    elif mode == "minor":
        parts[1] += 1
        parts[2] = 0
    elif mode == "patch":
        parts[2] += 1
    else:
        print(f"ERROR: Unsupported --next mode '{mode}'.", file=sys.stderr)
        sys.exit(1)

    return VERSION_SEPARATOR.join(str(part) for part in parts)


def _check_install_script_uses_version_file() -> bool:
    if not INSTALL_SCRIPT_PATH.is_file():
        return False

    text = INSTALL_SCRIPT_PATH.read_text(encoding="utf-8")
    return "BMROS_VERSION_FILE=" in text and "BMROS_DISTRO_VERSION=" in text


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Inspect or update the BMROS release version in VERSION."
    )
    parser.add_argument(
        "version",
        nargs="?",
        help="Explicit version to set (MAJOR.MINOR.PATCH), for example 0.1.0.",
    )
    parser.add_argument(
        "--current",
        action="store_true",
        help="Show the current version and exit.",
    )
    parser.add_argument(
        "--next",
        choices=["major", "minor", "patch"],
        help="Compute and apply the next version by incrementing the selected component.",
    )
    return parser


def main() -> None:
    args = _build_parser().parse_args()

    if args.current:
        if args.version is not None or args.next is not None:
            print("ERROR: --current cannot be combined with a version argument or --next.", file=sys.stderr)
            sys.exit(1)
        print(f"Current version: {_read_current_version()}")
        sys.exit(0)

    if args.next is not None:
        if args.version is not None:
            print("ERROR: --next cannot be combined with an explicit version argument.", file=sys.stderr)
            sys.exit(1)
        current_version = _read_current_version()
        new_version = _compute_next_version(current_version, args.next)
    elif args.version is not None:
        current_version = _read_current_version()
        new_version = args.version
        _validate_version(new_version)
    else:
        print("ERROR: You must specify --current, --next <mode>, or an explicit version.", file=sys.stderr)
        sys.exit(1)

    if current_version == new_version:
        print(f"No change: version is already {current_version}.")
        sys.exit(0)

    if not _check_install_script_uses_version_file():
        print(
            f"ERROR: {INSTALL_SCRIPT_PATH} is not wired to read VERSION; refusing partial bump.",
            file=sys.stderr,
        )
        sys.exit(1)

    _write_version(new_version)
    print(f"Updated version: {current_version} -> {new_version}")


if __name__ == "__main__":
    main()
