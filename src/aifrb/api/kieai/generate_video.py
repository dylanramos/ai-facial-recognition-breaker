import os
import sys

import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("KIEAI_API_KEY")


def grok_imagine_video_1_5(
    prompt: str,
    duration: int,
    aspect_ratio: str,
    resolution: str,
    start_image_url: str,
) -> str:
    """
    Generate a video using the Grok Imagine Video 1.5 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "grok-imagine-video-1-5-preview",
        "input": {
            "prompt": prompt,
            "image_urls": [start_image_url],
            "aspect_ratio": aspect_ratio,
            "resolution": resolution,
            "duration": duration,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        print(f"Error: Failed to generate video: {data['msg']}")
        sys.exit(1)

    return data["data"]["taskId"]


def happyhorse_1_0(
    prompt: str,
    duration: int,
    resolution: str,
    start_image_url: str,
) -> str:
    """
    Generate a video using the HappyHorse 1.0 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "happyhorse/image-to-video",
        "input": {
            "prompt": prompt,
            "image_urls": [start_image_url],
            "resolution": resolution,
            "duration": duration,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        print(f"Error: Failed to generate video: {data['msg']}")
        sys.exit(1)

    return data["data"]["taskId"]


def kling_3_0(
    prompt: str,
    duration: int,
    aspect_ratio: str,
    resolution: str,
    start_image_url: str,
    end_image_url: str,
) -> str:
    """
    Generate a video using the Kling 3.0 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}

    match resolution:
        case "1080p":
            resolution = "pro"
        case "4K":
            resolution = "4K"
        case _:
            resolution = "std"

    payload = {
        "model": "kling-3.0/video",
        "input": {
            "prompt": prompt,
            "image_urls": [start_image_url, end_image_url],
            "sound": False,
            "duration": str(duration),
            "aspect_ratio": aspect_ratio,
            "mode": resolution,
            "multi_shots": False,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        print(f"Error: Failed to generate video: {data['msg']}")
        sys.exit(1)

    return data["data"]["taskId"]


def wan_2_7(
    prompt: str,
    duration: int,
    resolution: str,
    start_image_url: str,
    end_image_url: str,
) -> str:
    """
    Generate a video using the Wan 2.7 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "wan/2-7-image-to-video",
        "input": {
            "prompt": prompt,
            "first_frame_url": start_image_url,
            "last_frame_url": end_image_url,
            "resolution": resolution,
            "duration": duration,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        print(f"Error: Failed to generate video: {data['msg']}")
        sys.exit(1)

    return data["data"]["taskId"]
