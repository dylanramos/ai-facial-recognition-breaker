import sys
from pathlib import Path
from typing import Annotated

import typer

from aifrb.api.kieai.edit_image import (
    gpt_image_2,
    grok_imagine,
    nano_banana_2,
    seedream_4_5,
    wan_2_7,
)
from aifrb.api.kieai.utils import get_content_url, upload_image
from aifrb.utils.download_file import download_file

app = typer.Typer()


@app.command(rich_help_panel="AI Commands", no_args_is_help=True)
def edit_image(
    prompt: Annotated[
        str, typer.Argument(help="Text prompt to generate the image from.")
    ],
    image: Annotated[Path, typer.Argument(help="Path to the image to edit.")],
    model: Annotated[
        str, typer.Option("--model", "-m", help="Image generation model to use.")
    ] = "Nano Banana 2",
    aspect_ratio: Annotated[
        str,
        typer.Option(
            "--aspect-ratio",
            "-a",
            help="Aspect ratio for the generated image (e.g. 1:1, 16:9, 9:16).",
        ),
    ] = "1:1",
    resolution: Annotated[
        str,
        typer.Option(
            "--resolution",
            "-r",
            help="Resolution for the generated image (e.g. 1K, 2K, 4K).",
        ),
    ] = "1K",
    reference_image: Annotated[
        Path,
        typer.Option(
            "--reference-image",
            "-i",
            help="Path to the reference image to use for editing.",
        ),
    ] = None,
):
    """
    Edit an image and download it to the local filesystem.

    Available models:
    - Nano Banana 2
    - GPT Image 2
    - Grok Imagine
    - Wan 2.7
    - Seedream 4.5
    """
    images_url = []

    image_url = upload_image(image)
    images_url.append(image_url)
    print("Image to edit uploaded successfully!")

    if reference_image is not None:
        reference_image_url = upload_image(reference_image)
        images_url.append(reference_image_url)
        print("Reference image uploaded successfully!")

    task_id = ""

    match model:
        case "Nano Banana 2":
            task_id = nano_banana_2(prompt, aspect_ratio, resolution, images_url)
        case "GPT Image 2":
            task_id = gpt_image_2(prompt, aspect_ratio, resolution, images_url)
        case "Grok Imagine":
            task_id = grok_imagine(prompt, images_url)
        case "Wan 2.7":
            task_id = wan_2_7(prompt, aspect_ratio, resolution, images_url)
        case "Seedream 4.5":
            task_id = seedream_4_5(prompt, aspect_ratio, resolution, images_url)
        case _:
            print(f"Error: Unsupported model: {model}")
            sys.exit(1)

    print("Image editing started successfully!")
    print("Waiting for image editing to complete...")
    image_url = get_content_url(task_id)

    print(f"Downloading image...")
    image_path = download_file(image_url)
    print(f"Image downloaded successfully: {image_path}")
