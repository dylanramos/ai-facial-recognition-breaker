from pathlib import Path
from typing import Annotated

import typer

from aifrb.api import get_content_url, upload_image, edit_image_gpt_image_2, edit_image_nano_banana_2
from aifrb.utils.download_file import download_file

app = typer.Typer()

@app.command(rich_help_panel="AI Commands", no_args_is_help=True)
def edit_image(
    prompt: Annotated[str, typer.Argument(help="Text prompt to generate the image from.")],
    model: Annotated[str, typer.Option("--model", "-m", help="Image generation model to use.")] = "nano-banana-2",
    image_1: Annotated[Path, typer.Option("--image-1", "-1", help="Path to the first image.")] = None,
    image_2: Annotated[Path, typer.Option("--image-2", "-2", help="Path to the second image.")] = None,
):
    """
    Edit an image and download it to the local filesystem.
    
    Available models:
    - gpt-image-2
    - nano-banana-2
    """
    images_urls = []

    if image_1 is not None:
        if not image_1.is_file():
            raise ValueError(f"Image file not found: {image_1}")
        
        image_1_url = upload_image(image_1)
        images_urls.append(image_1_url)
        print("First image uploaded successfully!")

    if image_2 is not None:
        if not image_2.is_file():
            raise ValueError(f"Image file not found: {image_2}")
        
        image_2_url = upload_image(image_2)
        images_urls.append(image_2_url)
        print("Second image uploaded successfully!")

    task_id = ""

    match model:
        case "gpt-image-2":
            task_id = edit_image_gpt_image_2(prompt, images_urls)
        case "nano-banana-2":
            task_id = edit_image_nano_banana_2(prompt, images_urls)
        case _:
            raise ValueError(f"Unsupported model: {model}")
    
    print("Image editing started successfully!")
    print("Waiting for image editing to complete...")
    image_url = get_content_url(task_id)
    
    print(f"Downloading image...")
    image_path = download_file(image_url)
    print(f"Image downloaded successfully: {image_path}")