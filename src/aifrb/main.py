import typer

from .commands.broadcast import app as broadcast_app
from .commands.generate_image import app as generate_image_app
from .commands.edit_image import app as edit_image_app
from .commands.generate_video import app as generate_video_app
from .commands.edit_video import app as edit_video_app
from .commands.remaining_credits import app as remaining_credits_app

app = typer.Typer(no_args_is_help=True)

@app.callback()
def callback():
    """
    AI Facial Recognition Breaker CLI.
    """

app.add_typer(broadcast_app)
app.add_typer(generate_image_app)
app.add_typer(edit_image_app)
app.add_typer(generate_video_app)
app.add_typer(edit_video_app)
app.add_typer(remaining_credits_app)

