from pathlib import Path

import typer

from api import generate_video_kling, get_video_url, upload_image

app = typer.Typer()

@app.callback(invoke_without_command=True)
def generate_video(
    prompt: str = typer.Option(..., "--prompt", "-p", help="The text prompt to generate the video from"),
    image: Path = typer.Option(None, "--image", "-i", help="The path to the image for start and end frames"),
):
    image_url = upload_image(image)
    print("Image uploaded successfully!")

    task_id = generate_video_kling(prompt, image_url)
    print("Video generation started successfully!")
    print("Waiting for video generation to complete...")
    
    video_url = get_video_url(task_id)
    print(f"Video URL: {video_url}")