import argparse
import sys
import textwrap
from typing import NoReturn, cast

import libcst as cst
from libcst._position import CodeRange
import libcst.matchers as m
import libcst.metadata as metadata


class DictChecker(cst.CSTTransformer):
    METADATA_DEPENDENCIES = (metadata.PositionProvider,)

    def __init__(self, fix: bool) -> None:
        self.fix = fix

    def setup(self, filename: str) -> None:
        with open(filename) as f:
            self.lines = f.readlines()
        self.num_changes = 0
        self.filename = filename

    def leave_Dict(self, original_node: cst.Dict, updated_node: cst.Dict) -> cst.BaseExpression:
        existing_elements: list[cst.DictElement] = [
            element  # type: ignore
            for element in updated_node.elements
            if m.matches(element, m.DictElement())
        ]
        if existing_elements and all(
            self.is_compatible_element(element) for element in existing_elements
        ):
            self.num_changes += 1
            if self.fix:
                return cst.Call(
                    cst.Name("dict"),
                    args=[
                        cst.Arg(
                            keyword=cst.Name(cast(cst.SimpleString, element.key).raw_value),
                            value=element.value,
                            equal=cst.AssignEqual(
                                whitespace_before=cst.SimpleWhitespace(""),
                                whitespace_after=cst.SimpleWhitespace(""),
                            ),
                            comma=element.comma,
                        )
                        if isinstance(element, cst.DictElement)
                        else cst.Arg(
                            value=element.value,
                            star="**",
                            comma=element.comma,
                            whitespace_after_star=cast(
                                cst.StarredDictElement, element
                            ).whitespace_before_value,
                        )
                        for element in updated_node.elements
                    ],
                )
            else:
                position: CodeRange | None = self.get_metadata(
                    metadata.PositionProvider, original_node
                )  # type: ignore
                print(
                    f"{self.filename}:{self.format_range(position)} {self.format_code(original_node, position=position)}"
                )
        return updated_node

    def format_range(self, range: CodeRange | None) -> str:
        if range is None:
            return ""
        return f"{range.start.line}:{range.start.column + 1}:"

    def format_code(self, node: cst.CSTNode, position: CodeRange | None) -> str:
        source_code = self.module.code_for_node(node)
        if position is None:
            first_line, *lines = source_code.split("\n", maxsplit=1)
            if lines:
                [line] = lines
                return f"{first_line}\n{textwrap.dedent(line)}"
            else:
                return first_line
        else:
            prefix = position.start.column * " "
            padded_source = prefix + source_code
            return textwrap.dedent(padded_source)

    @classmethod
    def is_compatible_element(cls, element: cst.DictElement) -> bool:
        return (
            m.matches(element.key, m.SimpleString())
            and cast(cst.SimpleString, element.key).raw_value.isidentifier()
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
            self.module = cst.parse_module("".join(self.lines))
        except (SyntaxError, ValueError):
            return True
        else:
            wrapper = cst.MetadataWrapper(self.module)
            updated_module = wrapper.visit(self)
        if self.num_changes and self.fix:
            error = "error" if self.num_changes == 1 else "errors"
            print(f"Fixed {self.num_changes} {error} in '{filename}'.")
            with open(filename, "w") as f:
                f.write(updated_module.code)
        return self.num_changes > 0


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


def main_cli() -> NoReturn:
    args = parse_args()
    sys.exit(main(args))


if __name__ == "__main__":
    main_cli()
