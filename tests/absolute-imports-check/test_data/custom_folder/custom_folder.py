from custom_folder.none import script
from custom_folder import script2
from src.foo import ignored

if TYPE_CHECKING:
    from custom_folder.bar import fuz

def inner():
    from custom_folder import fuzz
