import base64
import json
import os
import sys
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

# Source: https://docs.kie.ai/file-upload-api/quickstart#base64-upload
def upload_image(path: Path) -> str:
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
        print(f"Failed to upload image: {data['msg']}")
        sys.exit(1)
    
    return data["data"]["downloadUrl"]

# Source: https://kie.ai/kling-3-0
def generate_video_kling(prompt: str, image_url: str) -> str:
    url = "https://api.kie.ai/api/v1/jobs/createTask"
    payload = {
        "model": "kling-3.0/video",
        "input": {
            "mode": "std",
            "image_urls": [
                image_url,
                image_url
            ],
            "sound": False,
            "duration": "3",
            "aspect_ratio": "9:16",
            "multi_shots": False,
            "prompt": prompt,
        }
    }

    response = requests.post(url, headers=HEADERS, json=payload)
    data = response.json()
    
    if data["code"] != 200:
        print(f"Failed to generate video: {data['msg']}")
        sys.exit(1)
    
    return data["data"]["taskId"]

# Source: https://docs.kie.ai/market/common/get-task-detail
def get_video_url(task_id: str) -> str:
    url = "https://api.kie.ai/api/v1/jobs/recordInfo"
    params = { "taskId": task_id }
    start_time = time.time()
    max_duration = 15 * 60 # 15 minutes

    while True:
        elapsed_time = time.time() - start_time

        if elapsed_time > max_duration:
            print("Video generation timed out after 15 minutes.")
            sys.exit(1)
        
        response = requests.get(url, headers=HEADERS, params=params)
        data = response.json()

        if data["data"]["state"] == "success":
            result_json = json.loads(data["data"]["resultJson"])
            return result_json["resultUrls"][0]

        if data["data"]["state"] == "fail":
            print(f"Video generation failed: {data['data']['failMsg']}")
            sys.exit(1)
        
        # Recommended polling interval
        if elapsed_time < 30:
            wait = 3
        elif elapsed_time < 120:
            wait = 10
        else:
            wait = 30

        time.sleep(wait)
