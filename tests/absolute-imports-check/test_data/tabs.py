if TYPE_CHECKING:
	from src.bar import fuz

def outer():
	def inner():
		from src.bar import fuz
