import typer

from .broadcast import app as broadcast
from .generate_image import app as generate_image
from .generate_video import app as generate_video
from .remaining_credits import app as remaining_credits

app = typer.Typer()

app.add_typer(broadcast)
app.add_typer(generate_image)
app.add_typer(generate_video)
app.add_typer(remaining_credits)