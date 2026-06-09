import os

import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("KIE_API_KEY")


def kling_3_0(
    prompt: str, duration: int, aspect_ratio: str, image_urls: list[str]
) -> str:
    """
    Generate a video using the Kling 3.0 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "kling-3.0/video",
        "input": {
            "mode": "std",
            "image_urls": image_urls,
            "sound": False,
            "duration": str(duration),
            "aspect_ratio": aspect_ratio,
            "multi_shots": False,
            "prompt": prompt,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to generate video: {data['msg']}")

    return data["data"]["taskId"]


def grok_imagine(
    prompt: str, duration: int, aspect_ratio: str, image_urls: list[str]
) -> str:
    """
    Generate a video using the Grok Imagine model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "grok-imagine/image-to-video",
        "input": {
            "mode": "normal",
            "image_urls": image_urls,
            "duration": str(duration),
            "aspect_ratio": aspect_ratio,
            "prompt": prompt,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to generate video: {data['msg']}")

    return data["data"]["taskId"]


def seedance_2_0(
    prompt: str, duration: int, aspect_ratio: str, image_urls: list[str]
) -> str:
    """
    Generate a video using the Seedance 2.0 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "bytedance/seedance-2",
        "input": {
            "first_frame_url": image_urls[0] if image_urls else None,
            "last_frame_url": image_urls[1] if len(image_urls) > 1 else None,
            "generate_audio": "false",
            "duration": str(duration),
            "resolution": "480p",
            "aspect_ratio": aspect_ratio,
            "prompt": prompt,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to generate video: {data['msg']}")

    return data["data"]["taskId"]
