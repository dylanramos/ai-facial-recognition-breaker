import platform
import subprocess
from pathlib import Path
from typing import Annotated

import cv2
import pyvirtualcam
import typer
from pyvirtualcam import PixelFormat

app = typer.Typer()

@app.command(rich_help_panel="Camera Commands", no_args_is_help=True)
def broadcast(
    video: Annotated[Path, typer.Argument(help="Path to the video file.")]
):
    """
    Broadcast a video file to a virtual camera.
    """
    if platform.system() == "Linux":
        # Reload the v4l2loopback module
        subprocess.run(["sudo", "modprobe", "-r", "v4l2loopback"])
        # Create the virtual camera
        subprocess.run(["sudo", "modprobe", "v4l2loopback", "devices=1", "video_nr=2", "card_label=\"Virtual Cam\"", "exclusive_caps=1"])

    # Source: https://github.com/letmaik/pyvirtualcam/blob/main/examples/video.py
    video = cv2.VideoCapture(video)
    if not video.isOpened():
        raise ValueError("Failed to open video file")
    length = int(video.get(cv2.CAP_PROP_FRAME_COUNT))
    width = int(video.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(video.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fps = video.get(cv2.CAP_PROP_FPS)
    device = None # Use default device

    with pyvirtualcam.Camera(width, height, fps, fmt=PixelFormat.BGR,device=device, print_fps=fps) as cam:
        print(f'Virtual cam started: {cam.device} ({cam.width}x{cam.height} @ {cam.fps}fps)')
        count = 0
        while True:
            # Restart video on last frame
            if count == length:
                count = 0
                video.set(cv2.CAP_PROP_POS_FRAMES, 0)

            # Read video frame
            ret, frame = video.read()
            if not ret:
                raise RuntimeError('Error fetching frame')

            # Send to virtual cam
            cam.send(frame)

            # Wait until it's time for the next frame
            cam.sleep_until_next_frame()

            count += 1