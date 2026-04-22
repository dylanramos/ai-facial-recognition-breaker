import typer

from commands.broadcast import app as broadcast
from commands.generate_video import app as generate_video

app = typer.Typer(no_args_is_help=True)

app.add_typer(generate_video, name="generate-video")
app.add_typer(broadcast, name="broadcast")

if __name__ == "__main__":
    app()