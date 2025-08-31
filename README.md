# Pre-Commit Hooks

If you are unfamiliar with pre-commit hooks, see their website: https://pre-commit.com/.

## Compatibility

This hook is tested with Python 3.9-3.13.
The hooks use bash scripts, so is tested and run on Ubuntu.
It may work with other Python versions or operating systems (such as MacOS or WSL).

## Hooks

This repository provides the following pre-commit hooks:

-   [dbg-check](#dbg-check) - ensure no `dbg` statements, macros or imports are included in the source code.
-   [todo-check](#todo-check) - ensure no "todo"s or "fixme"s are left in the source code.
-   [pragma-once](#pragma-once) - ensure all headers start with `#pragma once`.
-   [check-merge-conflict](#check-merge-conflict) - check for merge conflicts.
-   [mypy](#mypy) - run [MyPy](#https://github.com/python/mypy).

### dbg-check

Check `dbg` expressions/statements have been removed from Rust/Python/C++/CUDA/other files.
It also checks for `#included <dbg.h>` or `from debug import dbg` imports. (see https://github.com/George-Ogden/dbg).

### todo-check

Remove any "fixme"s or "todo"s that are left in your code.
It checks comments and code, such as `todo!()` or `# TODO: ...`.
Any words that contain either of these phrases are ignored (such as "pho**todo**cumentary").
Hidden files are ignored.

### pragma-once

Ensure all C++/CUDA headers contain `#pragma once`.
This doesn't have to be the first line, but it must come before any `#include ...` statements.

### check-merge-conflict

Check for unresolved merge conflicts when committing.
This is intended as an improved version of `check-merge-conflict` in https://github.com/pre-commit/pre-commit-hooks.
The two additional features are handling LFS conflicts and underlines of `=` in `.rst` files.
Unlink the original, this hook takes no arguments.

# mypy

Run [MyPy](#https://github.com/python/mypy) in an environment with dependencies.
This is intended as an improved version of https://github.com/pre-commit/mirrors-mypy.
It allows you to pass in a requirements file using the `-r` or `--requirements-file` flag (installed via `pip`). Any additional flags are passed to the `mypy` executable (no defaults).
It requires that you have `pip` installed, but if you're using pre-commit, that shouldn't be an issue.
You can set the MyPy version in the requirements file (eg `mypy==1.17.1`), otherwise, the latest is installed.

## Example Use

Here's a sample `.pre-commit-config.yaml`:

```yaml
default_stages: ["pre-commit", "commit-msg", "pre-push"]

repos:
    - repo: https://github.com/pre-commit/pre-commit-hooks
      rev: v5.0.0
      hooks:
          - id: end-of-file-fixer
          - id: mixed-line-ending
          - id: trailing-whitespace
          - id: check-merge-conflict

    - repo: https://github.com/George-Ogden/pre-commit-hooks/
      rev: v1.2.1
      hooks:
          - id: dbg-check
            exclude: ^test/
          - id: todo-check
            exclude: README
          - id: pragma-once
          - id: check-merge-conflict
          - id: mypy
            args: [-r, requirements.txt, --strict]
```

### Development

Use the GitHub issue tracker for bugs/feature requests.
I made these hooks because I use them, can't find them somewhere else, and find them valuable during developing other software.
I hope you can make use of them too!
