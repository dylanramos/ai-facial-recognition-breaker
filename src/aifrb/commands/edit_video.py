from pathlib import Path
from typing import Annotated

import typer

from aifrb.api import (edit_video_kling_3_0, get_content_url, upload_image, upload_video)
from aifrb.utils.download_file import download_file

app = typer.Typer()

@app.command(rich_help_panel="AI Commands", no_args_is_help=True)
def edit_video(
    prompt: Annotated[str, typer.Argument(help="Text prompt to generate the video from.")],
    video: Annotated[Path, typer.Argument(help="Path to the video to edit.")],
    image: Annotated[Path, typer.Argument(help="Path to the reference image for editing.")],
    model: Annotated[str, typer.Option("--model", "-m", help="Video generation model to use.")] = "kling-3.0",
    quality: Annotated[str, typer.Option("--quality", "-q", help="Quality of the edited video (720p or 1080p).")] = "720p",
):
    """
    Edit a video using a reference image and download it to the local filesystem.
    
    Available models:
    - kling-3.0
    """
    if not video.is_file():
        raise ValueError(f"Video file not found: {video}")
    
    if not image.is_file():
        raise ValueError(f"Image file not found: {image}")
    
    video_url = upload_video(video)
    image_url = upload_image(image)
    
    print("Video and reference image uploaded successfully!")

    task_id = ""

    match model:
        case "kling-3.0":
            task_id = edit_video_kling_3_0(prompt, video_url, image_url, quality)
        case _:
            raise ValueError(f"Unsupported model: {model}")
    
    print("Video editing started successfully!")
    print("Waiting for video editing to complete...")
    edited_video_url = get_content_url(task_id)
    
    print(f"Downloading edited video...")
    edited_video_path = download_file(edited_video_url)
    print(f"Edited video downloaded successfully: {edited_video_path}")