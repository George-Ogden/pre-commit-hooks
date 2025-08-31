from collections import defaultdict
from glob import glob
import os.path
import textwrap

import git
import pytest

TEST_ROOT = os.path.join(os.path.dirname(__file__), "tests")


def get_test_files() -> list[str]:
    tests = glob(os.path.join(TEST_ROOT, "**", "test_*.sh"), recursive=True)
    return tests


def simplify_test_name(test_file: str) -> str:
    name = os.path.relpath(test_file, start=TEST_ROOT)
    _, name = os.path.split(name)
    name, _ = os.path.splitext(name)
    name = name.replace(os.path.sep, "-")
    name = name.replace("_", "-")
    name = name.replace("test-", "")
    return name


def get_test_folder(test_file: str) -> str:
    name = os.path.relpath(test_file, start=TEST_ROOT)
    folder, *_ = name.split(os.path.sep)
    folder = folder.replace("-", "_")
    return folder


TEST_FILES: dict[str, dict[str, str]] = defaultdict(dict)
for test_file in get_test_files():
    TEST_FILES[get_test_folder(test_file)][simplify_test_name(test_file)] = test_file


@pytest.fixture(autouse=True)
def git_setup():
    repository = git.Repo()
    diff = repository.index.diff(None, paths=TEST_ROOT)
    if diff:
        raise Exception(
            "Git repository has changes to the worktree."
            "Please, `git restore` before using the test script."
        )
    yield
    repository.git.restore(TEST_ROOT)


for folder, params in TEST_FILES.items():
    keys = list(params.keys())
    code = textwrap.dedent(
        f"""
        import subprocess
        @pytest.mark.parametrize("test_name", {keys})
        def test_{folder}(test_name: str) -> None:
            test_script = TEST_FILES["{folder}"][test_name]
            subprocess.run(test_script, shell=True, check=True)
        """
    )
    exec(code)
