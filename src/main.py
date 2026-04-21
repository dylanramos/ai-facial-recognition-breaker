import typer
from commands.generate import app as generate_app
from commands.broadcast import app as broadcast_app

app = typer.Typer()

app.add_typer(generate_app, name="generate")
app.add_typer(broadcast_app, name="broadcast")

if __name__ == "__main__":
    app()