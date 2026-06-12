import sys
from pathlib import Path
from typing import Annotated

import typer

from aifrb.api.kieai.generate_video import (
    grok_imagine_video_1_5,
    happyhorse_1_0,
    kling_3_0,
    wan_2_7,
)
from aifrb.api.kieai.utils import get_content_url, upload_image
from aifrb.utils.download_file import download_file

app = typer.Typer()


@app.command(rich_help_panel="AI Commands", no_args_is_help=True)
def generate_video(
    prompt: Annotated[
        str, typer.Argument(help="Text prompt to generate the video from.")
    ],
    model: Annotated[
        str, typer.Option("--model", "-m", help="Video generation model to use.")
    ] = "Grok Imagine Video 1.5",
    duration: Annotated[
        int, typer.Option("--duration", "-d", help="Duration of the video in seconds.")
    ] = 3,
    aspect_ratio: Annotated[
        str,
        typer.Option(
            "--aspect-ratio",
            "-a",
            help="Aspect ratio of the video (e.g. 1:1, 16:9, 9:16).",
        ),
    ] = "16:9",
    resolution: Annotated[
        str,
        typer.Option(
            "--resolution",
            "-r",
            help="Resolution of the video (e.g. 480p, 720p, 1080p, 4K).",
        ),
    ] = "720p",
    start_image: Annotated[
        Path,
        typer.Option(
            "--start-image", "-s", help="Path to the image for the start frame."
        ),
    ] = None,
    end_image: Annotated[
        Path,
        typer.Option("--end-image", "-e", help="Path to the image for the end frame."),
    ] = None,
):
    """
    Generate a video and download it to the local filesystem.

    Available models:
    - Grok Imagine Video 1.5
    - HappyHorse 1.0
    - Kling 3.0
    - Wan 2.7
    """
    start_image_url = None
    end_image_url = None

    if start_image is not None:
        start_image_url = upload_image(start_image)
        print("Start image uploaded successfully!")

    if end_image is not None:
        end_image_url = upload_image(end_image)
        print("End image uploaded successfully!")

    task_id = ""

    match model:
        case "Grok Imagine Video 1.5":
            task_id = grok_imagine_video_1_5(
                prompt, duration, aspect_ratio, resolution, start_image_url
            )
        case "HappyHorse 1.0":
            task_id = happyhorse_1_0(prompt, duration, resolution, start_image_url)
        case "Kling 3.0":
            task_id = kling_3_0(
                prompt,
                duration,
                aspect_ratio,
                resolution,
                start_image_url,
                end_image_url,
            )
        case "Wan 2.7":
            task_id = wan_2_7(
                prompt, duration, resolution, start_image_url, end_image_url
            )
        case _:
            print(f"Error: Unsupported model: {model}")
            sys.exit(1)

    print("Video generation started successfully!")
    print("Waiting for video generation to complete...")
    video_url = get_content_url(task_id)

    print(f"Downloading video...")
    video_path = download_file(video_url)
    print(f"Video downloaded successfully: {video_path}")
