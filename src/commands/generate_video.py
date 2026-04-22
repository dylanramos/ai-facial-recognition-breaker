from pathlib import Path

import typer

from api import generate_video_kling_3_0, get_video_url, upload_image
from utils.download_file import download_file

app = typer.Typer(no_args_is_help=True)

@app.callback(invoke_without_command=True)
def generate_video(
    prompt: str = typer.Option(..., "--prompt", "-p", help="The prompt to generate the video from."),
    model: str = typer.Option("kling-3.0", "--model", "-m", help="The model to use for video generation."),
    duration: int = typer.Option(3, "--duration", "-d", help="The duration of the generated video in seconds."),
    aspect_ratio: str = typer.Option("16:9", "--aspect-ratio", "-a", help="The aspect ratio of the generated video."),
    start_image: Path = typer.Option(None, "--start-image", "-s", help="The path to the image for the start frame"),
    end_image: Path = typer.Option(None, "--end-image", "-e", help="The path to the image for the end frame"),
):
    """Generate a video from a text prompt and optional images and download the video."""
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