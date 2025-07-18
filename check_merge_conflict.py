import argparse
from collections.abc import Sequence
from typing import Literal

from pre_commit_hooks.check_merge_conflict import CONFLICT_PATTERNS


def detect_conflict(filename: str) -> Literal[0] | Literal[1]:
    retcode = 0
    with open(filename) as inputfile:
        try:
            for i, line in enumerate(inputfile.readlines(), start=1):
                for pattern in CONFLICT_PATTERNS:
                    pattern = pattern.decode("utf-8")
                    if "=" in pattern and filename.endswith(".rst"):
                        # Ignore `=======` in .rst files, where it may be part of the file.
                        # But allow other checks.
                        continue
                    if line.startswith(pattern):
                        print(
                            f"{filename}:{i}: Merge conflict string {pattern.strip()} found",
                        )
                        retcode = 1
        except UnicodeDecodeError:
            ...
    return retcode


def main(argv: None | Sequence[str] = None) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("filenames", nargs="*")
    args = parser.parse_args(argv)

    retcode = 0
    for filename in args.filenames:
        file_retcode = detect_conflict(filename)
        if file_retcode != 0:
            retcode = file_retcode

    return retcode


if __name__ == "__main__":
    raise SystemExit(main())
