import typer

from api import get_remaining_credits

app = typer.Typer()

@app.callback(invoke_without_command=True)
def remaining_credits():
    """Get the current credit balance available in the Kie account."""
    credits = get_remaining_credits()
    typer.echo(f"Remaining credits: {credits}")