from typing import TYPE_CHECKING

from src.bar import baz
from src.foo import (
    foobar,
    foobaz,
)
from src import foo

if TYPE_CHECKING:
    from src.bar import fuz

def inner():
    from src import fuzz
