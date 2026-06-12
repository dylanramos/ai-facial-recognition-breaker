import base64
import json
import os
import time
from pathlib import Path

import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("KIEAI_API_KEY")


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
        file_data = base64.b64encode(f.read()).decode("utf-8")
        base64_data = f"data:image/{path.suffix[1:]};base64,{file_data}"

    url = "https://kieai.redpandaai.co/api/file-base64-upload"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}

    payload = {
        "base64Data": base64_data,
        "uploadPath": "images",
        "fileName": path.name,  # Optional
    }

    response = requests.post(url, headers=headers, json=payload)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to upload image: {data['msg']}")

    return data["data"]["downloadUrl"]


def upload_video(path: Path) -> str:
    """Upload a video to the Kie platform and return the video URL."""
    files = {"file": (os.path.basename(path), open(path, "rb"))}

    url = "https://kieai.redpandaai.co/api/file-stream-upload"
    headers = {"Authorization": f"Bearer {API_KEY}"}
    data = {"uploadPath": "videos", "fileName": path.name}  # Optional

    response = requests.post(url, headers=headers, files=files, data=data)
    data = response.json()

    if data["code"] != 200:
        raise ValueError(f"Failed to upload video: {data['msg']}")

    return data["data"]["downloadUrl"]


def get_content_url(task_id: str) -> str:
    """Poll the Kie platform for the content generation result and return the content URL."""
    url = "https://api.kie.ai/api/v1/jobs/recordInfo"
    headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
    params = {"taskId": task_id}
    start_time = time.time()
    max_duration = 15 * 60  # 15 minutes

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
