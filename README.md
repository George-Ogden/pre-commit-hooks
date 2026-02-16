# Pre-Commit Hooks

If you are unfamiliar with pre-commit hooks, see their website: https://pre-commit.com/.

## Compatibility

This hook is tested with Python 3.9-3.14.
The hooks use bash scripts, so is tested and run on Ubuntu.
It may work with other Python versions or operating systems (such as MacOS or WSL).

## Hooks

This repository provides the following pre-commit hooks:

- [dbg-check](#dbg-check) - ensure no `dbg` statements, macros or imports are included in the source code.
- [todo-check](#todo-check) - ensure no "todo"s, "fixme"s or "deleteme"s are left in the source code.
- [pragma-once](#pragma-once) - ensure all headers start with `#pragma once`.
- [check-merge-conflict](#check-merge-conflict) - check for merge conflicts.
- [mypy](#mypy) - run [MyPy](#https://github.com/python/mypy).
- [spell-check-commit-msgs](#spell-check-commit-msgs) - check for spelling errors in commit messages.

### dbg-check

Check `dbg` expressions/statements have been removed from Rust/Python/C++/CUDA/other files.
It also checks for `#included <dbg.h>` or `from debug import dbg` imports. (see https://github.com/George-Ogden/dbg).

### todo-check

Find any "todo"s or "fixme"s or "deleteme"s that are left in your source code.
It checks comments and code, such as `todo!()` or `# TODO: ...`.
Any words that contain either of these phrases are ignored (such as "pho**todo**cumentary").
Hidden files are ignored.

### pragma-once

Ensure all C++/CUDA headers contain `#pragma once`.
This doesn't have to be the first line, but it must come before any `#include ...` statements.

### check-merge-conflict

Check for unresolved merge conflicts when committing.
This is intended as an improved version of `check-merge-conflict` in https://github.com/pre-commit/pre-commit-hooks.
The additional features are handling LFS conflicts, conflicts from the stash, underlines of `=` in `.rst` files and 3-way merge conflict markers.
This hook takes no arguments.

### mypy

Run [MyPy](#https://github.com/python/mypy) in an environment with dependencies.
This is intended as an improved version of https://github.com/pre-commit/mirrors-mypy.
It allows you to pass in a requirements file using the `-r` or `--requirements-file` flag (installed via [`uv`](https://docs.astral.sh/uv/)). Any additional flags are passed to the `mypy` executable (no defaults).
It requires that you have `pip` installed, but if you're using pre-commit, that shouldn't be an issue.
You can set the MyPy version in the requirements file (eg `mypy==1.17.1`), otherwise, the latest is installed.

### spell-check-commit-msgs

> _[If you] make spelling mistakes in commit messages, it's then a real pain to amend the commit. And god forbid if you pushed._

This uses [`codespell`](https://github.com/codespell-project/codespell) under the hood, and accepts the same flags via the `args` field, but interactive mode is not supported.
You need to ensure that you install the `commit-msg` hooks, which you can do with `pre-commit install -t pre-commit -t commit-msg` or adding `default_install_hook_types: ["pre-commit", "commit-msg"]` to the `.pre-commit-config.yaml` (like below).

## Example Use

Here's a sample `.pre-commit-config.yaml`:

```yaml
default_stages: ["pre-commit"]
default_install_hook_types: ["pre-commit", "commit-msg"]

repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v6.0.0
    hooks:
      - id: end-of-file-fixer
      - id: mixed-line-ending
      - id: trailing-whitespace

  - repo: https://github.com/George-Ogden/linter
    rev: v1.2.1
    hooks:
      - id: lint
        exclude: ^tests/[^/].*/test_data/

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.14.10
    hooks:
      - id: ruff-format
      - id: ruff
        args:
          - --fix

  - repo: https://github.com/George-Ogden/pre-commit-hooks/
    rev: v2.3.0
    hooks:
      - id: dbg-check
        exclude: ^test/
      - id: todo-check
        exclude: README
      - id: pragma-once
      - id: check-merge-conflict
      - id: mypy
        args: [-r, requirements.txt, --strict]
      - id: spell-check-commit-msgs
```

### Development

Use the GitHub issue tracker for bugs/feature requests.
I made these hooks because I use them, can't find them somewhere else, and find them valuable during developing other software.
I hope you can make use of them too!
