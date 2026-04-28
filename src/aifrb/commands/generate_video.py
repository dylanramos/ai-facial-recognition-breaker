from pathlib import Path
from typing import Annotated

import typer

from aifrb.api import (generate_video_grok_imagine, generate_video_kling_3_0,
                       get_content_url, upload_image)
from aifrb.utils.download_file import download_file

app = typer.Typer()

@app.command(rich_help_panel="AI Commands", no_args_is_help=True)
def generate_video(
    prompt: Annotated[str, typer.Argument(help="Text prompt to generate the video from.")],
    model: Annotated[str, typer.Option("--model", "-m", help="Video generation model to use.")] = "kling-3.0",
    duration: Annotated[int, typer.Option("--duration", "-d", help="Duration of the video in seconds.")] = 3,
    aspect_ratio: Annotated[str, typer.Option("--aspect-ratio", "-a", help="Aspect ratio of the video.")] = "16:9",
    start_image: Annotated[Path, typer.Option("--start-image", "-s", help="Path to the image for the start frame.")] = None,
    end_image: Annotated[Path, typer.Option("--end-image", "-e", help="Path to the image for the end frame.")] = None,
):
    """
    Generate a video and download it to the local filesystem.
    
    Available models:
    - kling-3.0
    - grok-imagine
    """
    images_urls = []

    if start_image is not None:
        if not start_image.is_file():
            raise ValueError(f"Start image file not found: {start_image}")
        
        start_image_url = upload_image(start_image)
        images_urls.append(start_image_url)
        print("Start image uploaded successfully!")

    if end_image is not None:
        if not end_image.is_file():
            raise ValueError(f"End image file not found: {end_image}")
        
        end_image_url = upload_image(end_image)
        images_urls.append(end_image_url)
        print("End image uploaded successfully!")

    task_id = ""

    match model:
        case "kling-3.0":
            task_id = generate_video_kling_3_0(prompt, duration, aspect_ratio, images_urls)
        case "grok-imagine":
            task_id = generate_video_grok_imagine(prompt, duration, aspect_ratio, images_urls)
        case _:
            raise ValueError(f"Unsupported model: {model}")
    
    print("Video generation started successfully!")
    print("Waiting for video generation to complete...")
    video_url = get_content_url(task_id)
    
    print(f"Downloading video...")
    video_path = download_file(video_url)
    print(f"Video downloaded successfully: {video_path}")