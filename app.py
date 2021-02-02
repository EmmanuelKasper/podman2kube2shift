#!/usr/bin/python3
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!\n"

@app.route("/healthy")
def healthy():
    return "feeling quite healthy\n"

if __name__ == "__main__":
    app.run(port=8080, host= '0.0.0.0')
