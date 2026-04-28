import base64
import json
import os
import time
from pathlib import Path

import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("KIE_API_KEY")

HEADERS = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json"
}

def get_remaining_credits() -> float:
    """Get the current credit balance available in the Kie account."""
    url = "https://api.kie.ai/api/v1/chat/credit"
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to get remaining credits: {data['msg']}")

    return data["data"]

def upload_image(path: Path) -> str:
    """Upload an image to the Kie platform and return the image URL."""
    with open(path, "rb") as f:
        file_data = base64.b64encode(f.read()).decode('utf-8')
        base64_data = f'data:image/{path.suffix[1:]};base64,{file_data}'
    
    url = "https://kieai.redpandaai.co/api/file-base64-upload"

    payload = {
        "base64Data": base64_data,
        "uploadPath": "images",
        "fileName": path.name # Optional
    }

    response = requests.post(url, headers=HEADERS, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to upload image: {data['msg']}")
    
    return data["data"]["downloadUrl"]

def get_content_url(task_id: str) -> str:
    """Poll the Kie platform for the content generation result and return the content URL."""
    url = "https://api.kie.ai/api/v1/jobs/recordInfo"
    params = { "taskId": task_id }
    start_time = time.time()
    max_duration = 15 * 60 # 15 minutes

    while True:
        elapsed_time = time.time() - start_time

        if elapsed_time > max_duration:
            raise ValueError("Content generation timed out after 15 minutes.")

        response = requests.get(url, headers=HEADERS, params=params)
        data = response.json()

        if data["data"]["state"] == "success":
            result_json = json.loads(data["data"]["resultJson"])
            return result_json["resultUrls"][0]

        if data["data"]["state"] == "fail":
            raise ValueError(f"Content generation failed: {data['data']['failMsg']}")
        
        # Recommended polling interval
        if elapsed_time < 30:
            wait = 3
        elif elapsed_time < 120:
            wait = 10
        else:
            wait = 30

        time.sleep(wait)

def generate_video_kling_3_0(prompt: str, duration: int, aspect_ratio: str, start_image_url: str, end_image_url: str) -> str:
    """
    Generate a video using the Kling 3.0 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    payload = {
        "model": "kling-3.0/video",
        "input": {
            "mode": "std",
            "image_urls": [
                start_image_url,
                end_image_url
            ],
            "sound": False,
            "duration": str(duration),
            "aspect_ratio": aspect_ratio,
            "multi_shots": False,
            "prompt": prompt,
        }
    }

    response = requests.post(url, headers=HEADERS, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to generate video: {data['msg']}")
    
    return data["data"]["taskId"]

def generate_image_nano_banana_2(prompt: str, image_urls: list[str]) -> str:
    """
    Generate or edit an image using the Nano Banana 2 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    payload = {
        "model": "nano-banana-2",
        "input": {          
            "prompt": prompt,
            "image_input": image_urls,
            "aspect_ratio": "auto",
            "resolution": "1K",
            "output_format": "png",
        }
    }

    response = requests.post(url, headers=HEADERS, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to generate image: {data['msg']}")
    
    return data["data"]["taskId"]