# AI facial recognition breaker

This repository contains my bachelor's thesis project. This work aims to understand and demonstrate the risks associated with the use of facial recognition in online services in light of the growing threat posed by AI-generated videos.

## Repository structure

- `docs/rapport/`: Main report and chapter sources.
- `docs/rapports-de-recherche/`: Topic-specific research reports.
- `docs/diagrammes/`: Draw.io architecture and workflow diagrams.
- `src/main.py`: CLI entry point (Typer app).
- `src/commands/`: Command implementations.
- `src/api.py`: API calls to the AI generation service (Kie AI)

## Installation

### Prerequisites
- Python 3.12+
- [Kie AI](https://kie.ai/) account and API key

### Linux

1. Install v4l2loopback module:
   ```bash
   sudo apt install v4l2loopback-dkms v4l2loopback-utils
   ```

2. Create virtual environment and install dependencies:
   ```bash
   cd src
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

3. Set up environment variable for Kie AI API key:
   ```bash
   cp .env.example .env
   nano .env
   # Replace xxx with your API key
   ```

4. Run the application:
   ```bash
   python3 main.py --help
   ```

### Windows

1. Install [OBS Studio](https://obsproject.com/download).

2. Create virtual environment and install dependencies:
   ```bash
   cd src
   python -m venv venv
   .\venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. Set up environment variable for Kie AI API key:
   ```bash
   copy .env.example .env
   notepad .env
   # Replace xxx with your API key
   ```

4. Run the application:
   ```bash
   python main.py --help
   ```

## Important notice

This project studies security weaknesses in online identity checks. Use it only in legal, authorized, and ethical contexts such as research, testing, and defense.
