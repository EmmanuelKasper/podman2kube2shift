#!/usr/bin/python3
import signal, sys
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!\n"

@app.route("/healthy")
def healthy():
    return "feeling quite healthy\n"

def sigterm_handler(sig, frame):
    print("sigterm received, exiting", file=sys.stderr)
    sys.exit(0)

if __name__ == "__main__":
    signal.signal(signal.SIGTERM, sigterm_handler)
    app.run(port=8080, host= '0.0.0.0')
