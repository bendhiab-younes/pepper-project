from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Message(BaseModel):
    text: str

@app.get("/")
def home():
    return {"message": "CERIBot server is running"}

@app.post("/chat")
def chat(message: Message):
    text = message.text.lower()

    if "bonjour" in text:
        response = "Bonjour ! Comment puis-je vous aider ?"

    elif "salle" in text:
        response = "Quelle salle recherchez-vous ?"

    elif "merci" in text:
        response = "Avec plaisir !"

    else:
        response = "Désolé, je n'ai pas compris votre demande."

    return {"response": response}