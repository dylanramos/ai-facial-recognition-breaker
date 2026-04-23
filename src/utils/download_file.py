import os

import requests


def download_file(url):
    """Download a file from a URL and save it to the local filesystem, returning the local file path."""
    filename = url.split("/")[-1]
    output_dir = "downloads"
    os.makedirs(output_dir, exist_ok=True)
    local_filename = os.path.join(output_dir, filename)

    # Reads the response in chunks, preventing memory issues with large files.
    with requests.get(url, stream=True) as response:
        response.raise_for_status()  # Raises an error for bad status codes
        with open(local_filename, 'wb') as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)

    return local_filename