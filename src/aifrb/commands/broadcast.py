import subprocess
from pathlib import Path
from typing import Annotated

import typer
import ffmpeg

app = typer.Typer()


@app.command(rich_help_panel="Camera Commands", no_args_is_help=True)
def broadcast(
    video: Annotated[
        Path, typer.Option("--video", "-v", help="Path to the video file.")
    ] = None,
    image: Annotated[
        Path, typer.Option("--image", "-i", help="Path to the image file.")
    ] = None,
    portrait: Annotated[
        bool,
        typer.Option(
            "--portrait",
            "-p",
            help="Specify the output mode (portrait or landscape).",
        ),
    ] = False,
    pixel_format: Annotated[
        str,
        typer.Option(
            "--pixel-format", "-f", help="Pixel format to use. (e.g., yuv420p, yuv422p)"
        ),
    ] = "yuv420p",
    crop_x: Annotated[
        int, typer.Option("--crop-x", "-x", help="X coordinate for cropping the video.")
    ] = 0,
    crop_y: Annotated[
        int, typer.Option("--crop-y", "-y", help="Y coordinate for cropping the video.")
    ] = 0,
):
    """
    Broadcast an image or a video file to a virtual camera.
    """
    device = "/dev/video1"

    if not Path(device).exists():
        # Reload the v4l2loopback module
        subprocess.run(["sudo", "modprobe", "-r", "v4l2loopback"])
        # Create the virtual camera
        subprocess.run(
            [
                "sudo",
                "modprobe",
                "v4l2loopback",
                "devices=1",
                "video_nr=1",
                f'card_label="AIFRB Virtual Camera"',
                "exclusive_caps=1",
            ]
        )
        # Grant current user access to the device without requiring video group membership
        subprocess.run(["sudo", "chmod", "666", device])

    if video is not None:
        if portrait:
            ffmpeg.input(str(video), re=None, stream_loop=-1).filter(
                "crop", "min(iw,ih*9/16)", "ih", crop_x, crop_y
            ).filter("scale", 640, 480).filter("fps", 30).output(
                device, format="v4l2", pix_fmt=pixel_format
            ).run()
        else:
            ffmpeg.input(str(video), re=None, stream_loop=-1).filter(
                "crop", "iw", "min(ih,iw*9/16)", crop_x, crop_y
            ).filter("scale", 640, 480).filter("fps", 30).output(
                device, format="v4l2", pix_fmt=pixel_format
            ).run()

    elif image is not None:
        if portrait:
            ffmpeg.input(str(image), re=None, loop=1).filter(
                "crop", "min(iw,ih*9/16)", "ih", crop_x, crop_y
            ).filter("scale", 640, 480).filter("fps", 30).output(
                device, format="v4l2", pix_fmt=pixel_format
            ).run()
        else:
            ffmpeg.input(str(image), re=None, loop=1).filter(
                "crop", "iw", "min(ih,iw*9/16)", crop_x, crop_y
            ).filter("scale", 640, 480).filter("fps", 30).output(
                device, format="v4l2", pix_fmt=pixel_format
            ).run()
