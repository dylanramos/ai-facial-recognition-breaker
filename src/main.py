import typer

from commands.broadcast import app as broadcast
from commands.generate_video import app as generate_video

app = typer.Typer()

app.add_typer(generate_video, name="generate-video", help="Generate a video from a text prompt and an optional image or video")
app.add_typer(broadcast, name="broadcast", help="Broadcast a video file to a virtual camera")

if __name__ == "__main__":
    app()