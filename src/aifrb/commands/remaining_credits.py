import typer

from aifrb.api.kieai.utils import get_remaining_credits

app = typer.Typer()


@app.command(rich_help_panel="KIE AI Account Commands")
def remaining_credits():
    """Get the current credit balance available in the KIE AI account."""
    credits = get_remaining_credits()
    print(f"Remaining credits: {credits}")
