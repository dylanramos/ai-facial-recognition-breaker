from pathlib import Path

import typer

from api import generate_video_kling_3_0, get_video_url, upload_image

app = typer.Typer(no_args_is_help=True)

@app.callback(invoke_without_command=True)
def generate_video(
    prompt: str = typer.Argument(..., help="The prompt to generate the video from."),
    model: str = typer.Option("kling-3.0", "--model", "-m", help="The model to use for video generation."),
    image: Path = typer.Option(None, "--image", "-i", help="The path to the image for start and end frames"),
):
    """
    Generate a video from a text prompt and optional images.
    """
    image_url = ""

    if image is not None:
        if not image.is_file():
            raise ValueError(f"Image file not found: {image}")
        
        image_url = upload_image(image)
        print("Image uploaded successfully!")

    task_id = ""

    match model:
        case "kling-3.0":
            print("Using Kling 3.0 model for video generation")
            task_id = generate_video_kling_3_0(prompt, image_url)
            print("Video generation started successfully!")
            print("Waiting for video generation to complete...")
        case _:
            raise ValueError(f"Unsupported model: {model}")
    
    video_url = get_video_url(task_id)
    print(f"Video URL: {video_url}")