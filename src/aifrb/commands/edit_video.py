import sys
from pathlib import Path
from typing import Annotated

import typer

from aifrb.api.kieai.edit_video import happyhorse_1_0, kling_3_0, wan_2_7
from aifrb.api.kieai.utils import get_content_url, upload_image, upload_video
from aifrb.utils.download_file import download_file

app = typer.Typer()


@app.command(rich_help_panel="AI Commands", no_args_is_help=True)
def edit_video(
    prompt: Annotated[
        str, typer.Argument(help="Text prompt to generate the video from.")
    ],
    video: Annotated[Path, typer.Argument(help="Path to the video to edit.")],
    image: Annotated[
        Path, typer.Argument(help="Path to the reference image to use for editing.")
    ],
    model: Annotated[
        str, typer.Option("--model", "-m", help="Video generation model to use.")
    ] = "Kling 3.0",
    resolution: Annotated[
        str,
        typer.Option(
            "--resolution", "-r", help="Resolution of the edited video (720p or 1080p)."
        ),
    ] = "720p",
):
    """
    Edit a video using a reference image and download it to the local filesystem.

    Available models:
    - Kling 3.0
    - Wan 2.7
    - HappyHorse 1.0
    """
    video_url = upload_video(video)
    image_url = upload_image(image)

    print("Video and reference image uploaded successfully!")

    task_id = ""

    match model:
        case "Kling 3.0":
            task_id = kling_3_0(prompt, video_url, image_url, resolution)
        case "Wan 2.7":
            task_id = wan_2_7(prompt, video_url, image_url, resolution)
        case "HappyHorse 1.0":
            task_id = happyhorse_1_0(prompt, video_url, image_url, resolution)
        case _:
            print(f"Error: Unsupported model: {model}")
            sys.exit(1)

    print("Video editing started successfully!")
    print("Waiting for video editing to complete...")
    edited_video_url = get_content_url(task_id)

    print(f"Downloading edited video...")
    edited_video_path = download_file(edited_video_url)
    print(f"Edited video downloaded successfully: {edited_video_path}")
