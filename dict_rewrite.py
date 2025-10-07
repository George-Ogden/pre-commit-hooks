import argparse
import ast
import sys
import textwrap
from typing import cast


class DictChecker(ast.NodeTransformer):
    def __init__(self, fix: bool) -> None:
        self.fix = fix

    def setup(self, filename: str) -> None:
        with open(filename) as f:
            self.lines = f.readlines()
        self.has_changed = False
        self.filename = filename

    def visit_Dict(self, node: ast.Dict) -> ast.expr:
        node = self.generic_visit(node)  # type: ignore
        if node.keys is None:
            return node
        existing_keys = [key for key in node.keys if key is not None]
        if existing_keys and all(self.is_compatible_key(key) for key in existing_keys):
            print(f"{self.filename}:{node.lineno}:{node.col_offset}: {self.get_lines(node)}")
            self.has_changed = True
            if self.fix:
                return ast.Call(
                    ast.Name(
                        "dict",
                        lineno=node.lineno,
                        col_offset=node.col_offset,
                        end_lineno=node.end_lineno,
                        end_col_offset=node.end_col_offset,
                    ),
                    args=[],
                    keywords=[
                        ast.keyword(
                            arg=(k if k is None else cast(str, k.value)),
                            value=v,
                        )
                        for k, v in zip(
                            cast(list[ast.Constant | None], node.keys), node.values, strict=True
                        )
                    ],
                )
        return node

    def _rstrip(self, line: str) -> str:
        return line.rstrip() + "\n"

    def get_lines(self, node: ast.expr) -> str:
        lineno = node.lineno
        if node.lineno == node.end_lineno or node.end_lineno is None:
            source = self.lines[lineno - 1][node.col_offset : node.end_col_offset]
        else:
            first_line = self._rstrip(self.lines[lineno - 1][node.col_offset :])
            lineno += 1
            tail_lines = ""
            while lineno < node.end_lineno:
                tail_lines += self._rstrip(self.lines[lineno - 1])
                lineno += 1
            tail_lines += self.lines[lineno - 1][: node.end_col_offset]
            source = first_line + textwrap.dedent(tail_lines)
        return source

    @classmethod
    def is_compatible_key(cls, key: ast.expr | None) -> bool:
        return (
            key is None
            or isinstance(key, ast.Constant)
            and isinstance(key.value, str)
            and key.value.isidentifier()
        )

    def check_files(self, filenames: str) -> bool:
        """Return whether the check fails for any file."""
        failed = False
        for filename in filenames:
            self.filename = filename
            if self.check_file(filename):
                failed = True

        return failed

    def check_file(self, filename: str) -> bool:
        """Return whether the check fails."""
        self.setup(filename)
        try:
            root = ast.parse("".join(self.lines), filename=filename)
        except (SyntaxError, ValueError):
            return True
        else:
            self.visit(root)
        return self.has_changed


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("files", nargs="+", metavar="FILES")
    parser.add_argument("--fix", action="store_true", help="Modify files in place.")
    return parser.parse_args()


def main(args: argparse.Namespace) -> int:
    filenames = args.files
    fix = args.fix

    checker = DictChecker(fix)
    if checker.check_files(filenames):
        return 1
    return 0


if __name__ == "__main__":
    args = parse_args()
    sys.exit(main(args))
