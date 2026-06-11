# AI facial recognition breaker (aifrb)

This repository contains my bachelor's thesis project. This work aims to understand and demonstrate the risks associated with the use of facial recognition in online services in light of the growing threat posed by AI-generated videos.

## Repository structure

```
aifrb/
├── docs/
│   ├── rapport/                  # Main report and chapter sources
│   ├── rapports-de-recherche/    # Topic-specific research reports
│   ├── diagrammes/               # Draw.io architecture and workflow diagrams
│   ├── images/                   # Images used in the reports
│   └── videos/                   # Videos used in the reports
├── src/
│   └── aifrb/
│       ├── main.py               # CLI entry point (Typer app)
│       ├── api/                  # API providers directory (currently only KIE AI)
│       │   └── kieai/            # KIE AI API implementation
│       ├── commands/             # Commands implementation
│       └── utils/                # Utility functions (e.g. file downloading)
├── templates/                    # Images and videos used for generating fake content (e.g. ID card template)
└── downloads/                    # Destination for AI generated content (created automatically)
```

## Prerequisites

- Ubuntu 26.04+
- Python 3.12+
- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- [KIE AI](https://kie.ai/) account and API key

> Note: This project also works on a virtual machine.

## Installation

1. Install v4l2loopback module and FFmpeg:
   ```bash
   sudo apt install v4l2loopback-dkms v4l2loopback-utils ffmpeg
   ```

2. Create virtual environment and install dependencies:
   ```bash
   uv sync
   source .venv/bin/activate
   ```

3. Set up environment variable for KIE AI API key:
   ```bash
   cp .env.example .env
   nano .env
   # Replace xxx with your API key
   ```

4. Run the application:
   ```bash
   aifrb
   ```

## Important notice

This project studies security weaknesses in online identity checks. Use it only in legal, authorized, and ethical contexts such as research, testing, and defense.
