import os

import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("KIEAI_API_KEY")


def nano_banana_2(
    prompt: str, aspect_ratio: str, resolution: str, image_urls: list[str]
) -> str:
    """
    Edit an image using the Nano Banana 2 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "nano-banana-2",
        "input": {
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
            "resolution": resolution,
            "image_input": image_urls,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to edit image: {data['msg']}")

    return data["data"]["taskId"]


def gpt_image_2(
    prompt: str, aspect_ratio: str, resolution: str, image_urls: list[str]
) -> str:
    """
    Edit an image using the GPT Image 2 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "gpt-image-2-image-to-image",
        "input": {
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
            "resolution": resolution,
            "input_urls": image_urls,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to edit image: {data['msg']}")

    return data["data"]["taskId"]


def grok_imagine(prompt: str, image_urls: list[str]) -> str:
    """
    Edit an image using the Grok Imagine model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "grok-imagine/image-to-image",
        "input": {
            "prompt": prompt,
            "image_urls": image_urls,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to edit image: {data['msg']}")

    return data["data"]["taskId"]


def wan_2_7(
    prompt: str, aspect_ratio: str, resolution: str, image_urls: list[str]
) -> str:
    """
    Edit an image using the Wan 2.7 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    payload = {
        "model": "wan/2-7-image",
        "input": {
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
            "resolution": resolution,
            "input_urls": image_urls,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to edit image: {data['msg']}")

    return data["data"]["taskId"]


def seedream_4_5(
    prompt: str, aspect_ratio: str, resolution: str, image_urls: list[str]
) -> str:
    """
    Edit an image using the Seedream 4.5 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}

    if resolution == "4K":
        resolution = "high"
    else:
        resolution = "basic"

    payload = {
        "model": "seedream/4.5-edit",
        "input": {
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
            "quality": resolution,
            "image_urls": image_urls,
        },
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to edit image: {data['msg']}")

    return data["data"]["taskId"]
