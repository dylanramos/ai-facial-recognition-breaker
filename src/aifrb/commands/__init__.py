import typer

from .create_camera import app as create_camera
from .broadcast import app as broadcast
from .generate_image import app as generate_image
from .edit_image import app as edit_image
from .generate_video import app as generate_video
from .edit_video import app as edit_video
from .remaining_credits import app as remaining_credits

app = typer.Typer()

app.add_typer(broadcast)
app.add_typer(generate_image)
app.add_typer(edit_image)
app.add_typer(generate_video)
app.add_typer(edit_video)
app.add_typer(remaining_credits)