from pathlib import Path
from typing import Annotated

import typer

from api import generate_video_kling_3_0, get_video_url, upload_image
from utils.download_file import download_file

app = typer.Typer(no_args_is_help=True)

@app.callback(invoke_without_command=True, rich_help_panel="AI Commands")
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
    """
    start_image_url = ""
    end_image_url = ""

    if start_image is not None:
        if not start_image.is_file():
            raise ValueError(f"Start image file not found: {start_image}")
        
        start_image_url = upload_image(start_image)
        print("Start image uploaded successfully!")

    if end_image is not None:
        if not end_image.is_file():
            raise ValueError(f"End image file not found: {end_image}")
        
        end_image_url = upload_image(end_image)
        print("End image uploaded successfully!")

    task_id = ""

    match model:
        case "kling-3.0":
            task_id = generate_video_kling_3_0(prompt, duration, aspect_ratio, start_image_url, end_image_url)
            print("Video generation started successfully!")
            print("Waiting for video generation to complete...")
        case _:
            raise ValueError(f"Unsupported model: {model}")
    
    video_url = get_video_url(task_id)
    
    print(f"Downloading video...")
    video_path = download_file(video_url)
    print(f"Video downloaded successfully: {video_path}")