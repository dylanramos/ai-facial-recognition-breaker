import os

import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("KIE_API_KEY")


def kling_3_0(prompt: str, video_url: str, image_url: str, resolution: str) -> str:
    """
    Edit a video using the Kling 3.0 Motion Control model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "kling-3.0/motion-control",
        "input": {
            "prompt": prompt,
            "input_urls": [image_url],
            "video_urls": [video_url],
            "mode": resolution,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to edit video: {data['msg']}")

    return data["data"]["taskId"]


def wan_2_7(prompt: str, video_url: str, image_url: str, resolution: str) -> str:
    """
    Edit a video using the Wan 2.7 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "wan/2-7-videoedit",
        "input": {
            "prompt": prompt,
            "reference_image": image_url,
            "video_url": video_url,
            "resolution": resolution,
            "audio_setting": "origin",
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to edit video: {data['msg']}")

    return data["data"]["taskId"]


def happyhorse_1_0(prompt: str, video_url: str, image_url: str, resolution: str) -> str:
    """
    Edit a video using the HappyHorse 1.0 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "happyhorse/video-edit",
        "input": {
            "prompt": prompt,
            "video_url": video_url,
            "reference_image": [image_url],
            "resolution": resolution,
            "audio_setting": "origin",
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to edit video: {data['msg']}")

    return data["data"]["taskId"]
