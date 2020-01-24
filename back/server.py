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
        self.end_headers()
        if "js" in self.requestline:
            self.send_header('Content-type', 'application/javascript')
            with open(self.JS, "rb") as f:
                self.wfile.write(f.read())
        elif "css" in self.requestline:
            self.send_header('Content-type', 'text/css')
            with open(self.CSS, "rb") as f:
                self.wfile.write(f.read())
        else:
            self.send_header('Content-type', 'text/html')
            with open(self.HTML, "rb") as f:
                self.wfile.write(f.read())

    def do_HEAD(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_POST(self):
        content_length = int(self.headers['Content-Length']) # <--- Gets the size of data
        post_data = self.rfile.read(content_length) # <--- Gets the data itself
        params = stringify_dict(parse.parse_qsl(post_data))
        if any(x not in params for x in ("player", "win", "jack", "color")):
            self._rebuff()
            return
        timestamp = int(time.time())
        player = params["new_player_name"] if "new_player_name" in params else params["player"]
        win = 1 if params["win"] == "win" else 0
        jacks = params["jack"]
        game = ""
        for mod in "tbhTBo":
            if "mod_" + mod in params:
                game += mod
        color = params["color"] if jacks != "N" else ""
        entry = (str(x) for x in (timestamp, player, win, jacks + color + game))
        with open(self.CSV, "a") as f:
            f.write(",".join(entry))
            f.write("\n")
        os.system("make {}".format(self.HTML))
        self.send_response(301)
        self.send_header('Location', 'http://skat.watch')
        self.end_headers()

    def _rebuff(self):
        self.send_response(404)
        self.end_headers()

def stringify_dict(bytesdict):
    return { k.decode("UTF-8"): v.decode("UTF-8")
             for k, v in dict(bytesdict).items() }

def run(html, js, css, csv):
    S.HTML = html
    S.JS = js
    S.CSS = css
    S.CSV = csv
    httpd = socketserver.TCPServer(("", 8000), S)
    httpd.serve_forever()
    httpd.server_close()

if __name__ == "__main__":
    from sys import argv
    if len(argv) != 5:
        print("usage: {} <page> <js> <css> <games>".format(argv[0]))
    else:
        run(argv[1], argv[2], argv[3], argv[4])
