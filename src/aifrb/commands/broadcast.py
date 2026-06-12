import sys
from pathlib import Path
from typing import Annotated

import ffmpeg
import typer

app = typer.Typer()

# Real camera parameters
OUT_WIDTH = 640
OUT_HEIGHT = 480
FPS = 30

# Valid extensions
VALID_IMAGE_EXTENSIONS = {".jpg", ".jpeg", ".png", ".webp"}
VALID_VIDEO_EXTENSIONS = {".mp4", ".avi", ".webm"}


@app.command(rich_help_panel="Camera Commands", no_args_is_help=True)
def broadcast(
    input: Annotated[
        Path, typer.Argument(help="Path to the input video or image file.")
    ],
    device: Annotated[
        Path,
        typer.Argument(
            help="Path to the virtual camera device (e.g. /dev/video0).",
        ),
    ],
    pixel_format: Annotated[
        str,
        typer.Option(
            "--pixel-format", "-f", help="Pixel format to use. (e.g., yuv420p, yuv422p)"
        ),
    ] = "yuv420p",
    no_crop: Annotated[
        bool,
        typer.Option(
            "--no-crop",
            "-n",
            help="Keep the original aspect ratio.",
        ),
    ] = False,
):
    """
    Broadcast an image or a video file to a virtual camera.
    """
    if not device.exists():
        print(
            f"Error: Virtual camera device {device} does not exist. Please create a virtual camera using the create-camera command."
        )
        sys.exit(1)

    extension = input.suffix.lower()

    if extension in VALID_IMAGE_EXTENSIONS:
        ffmpeg_input = ffmpeg.input(str(input), re=None, loop=1)
    elif extension in VALID_VIDEO_EXTENSIONS:
        ffmpeg_input = ffmpeg.input(str(input), re=None, stream_loop=-1)
    else:
        print(
            f"Error: Unsupported file type: {extension}. Supported image formats: {', '.join(VALID_IMAGE_EXTENSIONS)}. Supported video formats: {', '.join(VALID_VIDEO_EXTENSIONS)}."
        )
        sys.exit(1)

    if not no_crop:
        ffmpeg_input = ffmpeg_input.filter("crop", "min(iw,ih*4/3)", "min(ih,iw*3/4)")

    ffmpeg_input.filter("scale", OUT_WIDTH, OUT_HEIGHT).filter("fps", FPS).filter(
        "noise", c0s=8, c0f="t+u", c1s=2, c1f="t", c2s=2, c2f="t"
    ).output(f"{device}", format="v4l2", pix_fmt=pixel_format).run()
