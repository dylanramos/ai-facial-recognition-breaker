import subprocess
from pathlib import Path
import platform

import cv2
import pyvirtualcam
import typer
from pyvirtualcam import PixelFormat

app = typer.Typer()

# Source: https://github.com/letmaik/pyvirtualcam/blob/main/examples/video.py
@app.callback(invoke_without_command=True)
def broadcast(
    video: Path = typer.Option(..., "--video", "-v", help="The path to the video file"),
    fps: Path = typer.Option(None, "--fps", "-f", help="The frames per second for the video"),
    device: Path = typer.Option(None, "--device", "-d", help="The path to the device for video input"),
):
    if platform.system() == "Linux":
        # Reload the v4l2loopback module
        subprocess.run(["sudo", "modprobe", "-r", "v4l2loopback"])
        # Create the virtual camera
        subprocess.run(["sudo", "modprobe", "v4l2loopback", "devices=1", "video_nr=2", "card_label=\"Virtual Cam\"", "exclusive_caps=1"])

    video = cv2.VideoCapture(video)
    if not video.isOpened():
        raise ValueError("Failed to open video file")
    length = int(video.get(cv2.CAP_PROP_FRAME_COUNT))
    width = int(video.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(video.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fps = video.get(cv2.CAP_PROP_FPS)

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