import typer

from commands.broadcast import app as broadcast
from commands.generate_image import app as generate_image
from commands.generate_video import app as generate_video
from commands.remaining_credits import app as remaining_credits

app = typer.Typer(no_args_is_help=True)

app.add_typer(generate_image)
app.add_typer(generate_video)
app.add_typer(broadcast)
app.add_typer(remaining_credits)

if __name__ == "__main__":
    app()