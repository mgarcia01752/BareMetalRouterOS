#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


class VersionCheckTool:
    """Verify BMROS release version wiring."""

    VERSION_FILE_PATH = Path("VERSION")
    INSTALL_SCRIPT_PATH = Path("install-yocto-poky.sh")
    VERSION_PATTERN = re.compile(r"^\d+\.\d+\.\d+$")
    EXIT_OK = 0
    EXIT_ERROR = 1

    @staticmethod
    def _read_version() -> str:
        try:
            return VersionCheckTool.VERSION_FILE_PATH.read_text(encoding="utf-8").strip()
        except OSError:
            return ""

    @staticmethod
    def _install_script_uses_version_file() -> bool:
        try:
            text = VersionCheckTool.INSTALL_SCRIPT_PATH.read_text(encoding="utf-8")
        except OSError:
            return False
        return "BMROS_VERSION_FILE=" in text and "BMROS_DISTRO_VERSION=" in text

    @staticmethod
    def _build_parser() -> argparse.ArgumentParser:
        parser = argparse.ArgumentParser(description="Verify BMROS VERSION wiring.")
        parser.add_argument("--json", action="store_true", help="Print results as JSON.")
        return parser

    @staticmethod
    def run(options: argparse.Namespace) -> int:
        version = VersionCheckTool._read_version()
        valid_version = bool(VersionCheckTool.VERSION_PATTERN.match(version))
        installer_wired = VersionCheckTool._install_script_uses_version_file()
        status = "ok" if valid_version and installer_wired else "error"

        payload = {
            "version": version,
            "valid_version": valid_version,
            "installer_wired": installer_wired,
            "status": status,
        }

        if options.json:
            print(json.dumps(payload, ensure_ascii=True))
        else:
            print(f"VERSION: {version or 'missing'}")
            print(f"valid version: {'yes' if valid_version else 'no'}")
            print(f"installer wired: {'yes' if installer_wired else 'no'}")
            print(f"status: {status}")

        if status == "ok":
            return VersionCheckTool.EXIT_OK
        return VersionCheckTool.EXIT_ERROR


if __name__ == "__main__":
    parser = VersionCheckTool._build_parser()
    sys.exit(VersionCheckTool.run(parser.parse_args()))
