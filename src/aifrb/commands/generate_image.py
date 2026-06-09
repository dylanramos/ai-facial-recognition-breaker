from typing import Annotated

import typer

from aifrb.api.kieai.generate_image import grok_imagine, nano_banana_2
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
    ] = "grok-imagine",
    aspect_ratio: Annotated[
        str,
        typer.Option(
            "--aspect-ratio",
            "-a",
            help="Aspect ratio for the generated image (e.g. 1:1, 16:9, 3:2).",
        ),
    ] = "1:1",
):
    """
    Generate an image and download it to the local filesystem.

    Available models:
    - nano-banana-2
    - grok-imagine
    """
    task_id = ""

    match model:
        case "nano-banana-2":
            task_id = nano_banana_2(prompt, aspect_ratio)
        case "grok-imagine":
            task_id = grok_imagine(prompt, aspect_ratio)
        case _:
            raise ValueError(f"Unsupported model: {model}")

    print("Image generation started successfully!")
    print("Waiting for image generation to complete...")
    image_url = get_content_url(task_id)

    print(f"Downloading image...")
    image_path = download_file(image_url)
    print(f"Image downloaded successfully: {image_path}")
