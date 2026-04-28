import typer

from api import get_remaining_credits

app = typer.Typer()

@app.command(rich_help_panel="Kie Account Commands")
def remaining_credits():
    """Get the current credit balance available in the Kie account."""
    credits = get_remaining_credits()
    print(f"Remaining credits: {credits}")