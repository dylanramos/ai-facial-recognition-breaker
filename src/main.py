import typer
from commands.generate import app as generate_app

app = typer.Typer()

app.add_typer(generate_app, name="generate")

if __name__ == "__main__":
    app()