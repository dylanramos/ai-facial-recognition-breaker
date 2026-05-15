import base64
import json
import os
import time
from pathlib import Path

import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("KIE_API_KEY")

def get_remaining_credits() -> float:
    """Get the current credit balance available in the Kie account."""
    url = "https://api.kie.ai/api/v1/chat/credit"
    headers = {"Authorization": f"Bearer {API_KEY}"}

    response = requests.get(url, headers=headers)
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
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }

    payload = {
        "base64Data": base64_data,
        "uploadPath": "images",
        "fileName": path.name # Optional
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to upload image: {data['msg']}")
    
    return data["data"]["downloadUrl"]

def upload_video(path: Path) -> str:
    """Upload a video to the Kie platform and return the video URL."""
    files = {
        "file": (os.path.basename(path), open(path, 'rb'))
    }
    
    url = "https://kieai.redpandaai.co/api/file-stream-upload"
    headers = {
        "Authorization": f"Bearer {API_KEY}"
    }
    data = {
        "uploadPath": "videos",
        "fileName": path.name # Optional
    }

    response = requests.post(url, headers=headers, files=files, data=data)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to upload video: {data['msg']}")
    
    return data["data"]["downloadUrl"]

def get_content_url(task_id: str) -> str:
    """Poll the Kie platform for the content generation result and return the content URL."""
    url = "https://api.kie.ai/api/v1/jobs/recordInfo"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    params = { "taskId": task_id }
    start_time = time.time()
    max_duration = 15 * 60 # 15 minutes

    while True:
        elapsed_time = time.time() - start_time

        if elapsed_time > max_duration:
            raise ValueError("Content generation timed out after 15 minutes.")

        response = requests.get(url, headers=headers, params=params)
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

def generate_video_kling_3_0(prompt: str, duration: int, aspect_ratio: str, image_urls: list[str]) -> str:
    """
    Generate a video using the Kling 3.0 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
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
        }
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to generate video: {data['msg']}")
    
    return data["data"]["taskId"]

def generate_video_grok_imagine(prompt: str, duration: int, aspect_ratio: str, image_urls: list[str]) -> str:
    """
    Generate a video using the Grok Imagine model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": "grok-imagine/image-to-video",
        "input": {
            "mode": "normal",
            "image_urls": image_urls,
            "duration": str(duration),
            "aspect_ratio": aspect_ratio,
            "prompt": prompt,
        }
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to generate video: {data['msg']}")
    
    return data["data"]["taskId"]

def edit_video_kling_3_0(prompt: str, video_url: str, image_url: str, quality: str) -> str:
    """
    Edit a video using the Kling 3.0 motion control model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": "kling-3.0/motion-control",
        "input": {
            "prompt": prompt,
            "input_urls": [image_url],
            "video_urls": [video_url],
            "mode": quality,
        }
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to edit video: {data['msg']}")
    
    return data["data"]["taskId"]

def edit_video_wan_2_7(prompt: str, video_url: str, image_url: str, quality: str) -> str:
    """
    Edit a video using the Wan 2.7 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": "wan/2-7-videoedit",
        "input": {
            "prompt": prompt,
            "reference_image": image_url,
            "video_url": video_url,
            "resolution": quality,
        }
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to edit video: {data['msg']}")
    
    return data["data"]["taskId"]

def edit_video_happyhorse(prompt: str, video_url: str, image_url: str, quality: str) -> str:
    """
    Edit a video using the Happy Horse model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": "happyhorse/video-edit",
        "input": {
            "prompt": prompt,
            "video_url": video_url,
            "reference_image": image_url,
            "resolution": quality,
            "audio_setting" : "origin"
        }
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to edit video: {data['msg']}")
    
    return data["data"]["taskId"]

def generate_image_nano_banana_2(prompt: str, aspect_ratio: str) -> str:
    """
    Generate an image using the Nano Banana 2 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": "nano-banana-2",
        "input": {          
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
        }
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to generate image: {data['msg']}")
    
    return data["data"]["taskId"]

def generate_image_grok_imagine(prompt: str, aspect_ratio: str) -> str:
    """
    Generate an image using the Grok Imagine model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": "grok-imagine/text-to-image",
        "input": {          
            "prompt": prompt,
            "aspect_ratio": aspect_ratio,
        }
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to generate image: {data['msg']}")
    
    return data["data"]["taskId"]

def edit_image_gpt_image_2(prompt: str, image_urls: list[str]) -> str:
    """
    Edit an image using the GPT Image 2 model and return the task ID.
    """
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": "gpt-image-2-image-to-image",
        "input": {          
            "prompt": prompt,
            "input_urls": image_urls,
        }
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        raise ValueError(f"Failed to edit image: {data['msg']}")
    
    return data["data"]["taskId"]