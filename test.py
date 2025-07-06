from glob import glob
import os.path
import subprocess

import pytest

TEST_ROOT = os.path.join(os.path.dirname(__file__), "tests")


def get_test_files() -> list[str]:
    tests = glob(os.path.join(TEST_ROOT, "**", "test_*.sh"), recursive=True)
    return tests


def simplify_test_name(test_name: str) -> str:
    name = os.path.relpath(test_name, start=TEST_ROOT)
    name, _ = os.path.splitext(name)
    name = name.replace(os.path.sep, "-")
    name = name.replace("_", "-")
    name = name.replace("test-", "")
    return name


TEST_FILES = {simplify_test_name(name): name for name in get_test_files()}


@pytest.mark.parametrize("test_name", TEST_FILES.keys())
def test(test_name: str) -> None:
    test_script = TEST_FILES[test_name]
    subprocess.run(test_script, shell=True, check=True)
