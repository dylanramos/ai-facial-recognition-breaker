import subprocess
from typing import Annotated

import typer

app = typer.Typer()


@app.command(rich_help_panel="Camera Commands", no_args_is_help=True)
def create_camera(
    name: Annotated[str, typer.Argument(help="Name of the virtual camera to create.")],
    number: Annotated[
        int,
        typer.Argument(
            help="Number of the virtual camera to create (e.g. 0 for /dev/video0).",
        ),
    ],
):
    """
    Create or replace a virtual camera.
    """
    # Reload the v4l2loopback module
    subprocess.run(["sudo", "modprobe", "-r", "v4l2loopback"])
    # Create the virtual camera
    subprocess.run(
        [
            "sudo",
            "modprobe",
            "v4l2loopback",
            "devices=1",
            f"video_nr={number}",
            f'card_label="{name}"',
            "exclusive_caps=1",
        ]
    )
    # Grant current user access to the device without requiring video group membership
    subprocess.run(["sudo", "chmod", "666", f"/dev/video{number}"])
