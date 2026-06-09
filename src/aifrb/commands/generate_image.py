from typing import Annotated

import typer

from aifrb.api.kieai.generate_image import (
    gpt_image_2,
    grok_imagine,
    nano_banana_2,
    wan_2_7,
)
from aifrb.api.kieai.utils import get_content_url
from aifrb.utils.download_file import download_file

app = typer.Typer()


@app.command(rich_help_panel="AI Commands", no_args_is_help=True)
def generate_image(
    prompt: Annotated[
        str, typer.Argument(help="Text prompt to generate the image from.")
    ],
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
):
    """
    Generate an image and download it to the local filesystem.

    Available models:
    - Nano Banana 2
    - GPT Image 2
    - Grok Imagine
    - Wan 2.7
    """
    task_id = ""

    match model:
        case "Nano Banana 2":
            task_id = nano_banana_2(prompt, aspect_ratio, resolution)
        case "GPT Image 2":
            task_id = gpt_image_2(prompt, aspect_ratio, resolution)
        case "Grok Imagine":
            task_id = grok_imagine(prompt, aspect_ratio)
        case "Wan 2.7":
            task_id = wan_2_7(prompt, aspect_ratio, resolution)
        case _:
            raise ValueError(f"Unsupported model: {model}")

    print("Image generation started successfully!")
    print("Waiting for image generation to complete...")
    image_url = get_content_url(task_id)

    print(f"Downloading image...")
    image_path = download_file(image_url)
    print(f"Image downloaded successfully: {image_path}")
