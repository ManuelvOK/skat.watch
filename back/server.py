from http.server import BaseHTTPRequestHandler
import os
import socketserver
import time
from urllib import parse

class S(BaseHTTPRequestHandler):
    HTML = None
    JS = None
    CSS = None
    CSV = None

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        if "js" in self.requestline:
            with open(self.JS, "rb") as f:
                self.wfile.write(f.read())
        elif "css" in self.requestline:
            with open(self.CSS, "rb") as f:
                self.wfile.write(f.read())
        else:
            with open(self.HTML, "rb") as f:
                self.wfile.write(f.read())

    def do_HEAD(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_POST(self):
        content_length = int(self.headers['Content-Length']) # <--- Gets the size of data
        post_data = self.rfile.read(content_length) # <--- Gets the data itself
        params = dict(parse.parse_qsl(post_data))
        timestamp = int(time.time())
        player = params[b"player"].decode("UTF-8") if b"player" in params else params[b"new_player_name"].decode("UTF-8")
        win = 1 if params[b"win"] == b"win" else 0
        jacks = params[b"jack"].decode("UTF-8")
        mode = "h"
        color = params[b"color"].decode("UTF-8")
        entry = (str(x) for x in (timestamp, player, win, jacks + mode + color))
        with open(self.CSV, "a") as f:
            f.write(",".join(entry))
            f.write("\n")
        os.system("make {}".format(self.HTML))
        self.send_response(301)
        self.send_header('Location', 'http://skat.watch')
        self.end_headers()

def run(html, js, css, csv):
    S.HTML = html
    S.JS = js
    S.CSS = css
    S.CSV = csv
    with socketserver.TCPServer(("", 8000), S) as httpd:
         httpd.serve_forever()

if __name__ == "__main__":
    from sys import argv
    if len(argv) != 5:
        print("usage: {} <page> <js> <css> <games>".format(argv[0]))
    else:
        run(argv[1], argv[2], argv[3], argv[4])
