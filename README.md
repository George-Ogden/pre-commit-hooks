# Pre-Commit Hooks

If you are unfamiliar with pre-commit hooks, see their website: https://pre-commit.com/.

## Hooks
This repository provides the following pre-commit hooks:
- [format-yaml](#format-yaml) - automatically format YAML files with Prettier
- [dbg-check](#dbg-check) - ensure no `dbg` statements or headers are included in the source code.
- [pragma-once](#pragma-once) - ensure all headers start with `#pragma once`.

### format-yaml
Use Prettier to format YAML files (`.yaml` and `.yml`).
This requires an installation of `node`.

### dbg-check
Remove `dbg` expressions/statements from C++/CUDA source and header files.
It also checks for `#included <dbg.h>` or `#include "dbg.h"` directives.
See https://github.com/sharkdp/dbg-macro for the `dbg(...)` macro.

### pragma once
Ensure all C++/CUDA headers contain `#pragma once`.
This doesn't have to be the first line, but it must come before any `#include ...` statements.

## Example Use
Here's a sample `.pre-commit-config.yaml`:
```yaml
default_stages: ["pre-commit", "commit-msg", "pre-push"]

repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.6.0
    hooks:
      - id: end-of-file-fixer
      - id: mixed-line-ending
      - id: trailing-whitespace
      - id: check-merge-conflict

  - repo: https://github.com/George-Ogden/pre-commit-hooks/
    rev: v0.1.2
    hooks:
      - id: format-yaml
      - id: dbg-check
        files: ^(src/|include/|test/)
      - id: pragma-once
```

### Development
Use the GitHub issue tracker for bugs/feature requests.
I made these hooks because I use them, can't find them somewhere else, and find them valuable during developing other software.
I hope you can make use of them too!
