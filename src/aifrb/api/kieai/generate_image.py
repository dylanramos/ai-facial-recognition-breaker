import os

import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("KIE_API_KEY")


def nano_banana_2(prompt: str, aspect_ratio: str, resolution: str) -> str:
    """
    Generate an image using the Nano Banana 2 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "nano-banana-2",
        "input": {
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
            "resolution": resolution,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to generate image: {data['msg']}")

    return data["data"]["taskId"]


def gpt_image_2(prompt: str, aspect_ratio: str, resolution: str) -> str:
    """
    Generate an image using the GPT Image 2 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "gpt-image-2-text-to-image",
        "input": {
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
            "resolution": resolution,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to generate image: {data['msg']}")

    return data["data"]["taskId"]


def grok_imagine(prompt: str, aspect_ratio: str) -> str:
    """
    Generate an image using the Grok Imagine model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "grok-imagine/text-to-image",
        "input": {"prompt": prompt, "aspect_ratio": aspect_ratio},
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to generate image: {data['msg']}")

    return data["data"]["taskId"]


def wan_2_7(prompt: str, aspect_ratio: str, resolution: str) -> str:
    """
    Generate an image using the Wan 2.7 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "wan/2-7-image",
        "input": {
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
            "resolution": resolution,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to generate image: {data['msg']}")

    return data["data"]["taskId"]
