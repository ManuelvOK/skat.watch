from http.server import BaseHTTPRequestHandler
import os
import re
import socketserver
import time
from urllib import parse

import multiplayer

class S(BaseHTTPRequestHandler):
    HTML = None
    CSV = None

    def do_GET(self):
        self.send_response(200)
        requested_file_match = re.search(
                "static/(css|js|svg)/([0-9A-Za-z]*)\\.\\1",
                self.requestline
        )
        if requested_file_match:
            file_path = requested_file_match.group()
            extension = requested_file_match.group(1)
            mime_type = { "css":    "text/css",
                        "js":     "application/javascript",
                        "svg":    "image/svg+css" }[extension]
            self.send_header("Content-type", mime_type)
            self.end_headers()
            with open(file_path, "rb") as f:
                self.wfile.write(f.read())
            return

        if self.path.startswith("/quarantine"):
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            params = parse.parse_qs(parse.urlparse(self.path).query)
            try:
                player = int(params["player"][0])
            except (IndexError, KeyError, ValueError):
                player = 3
            if not player in range(0, 4):
                player = 3
            try:
                seed = int(params["seed"][0])
            except (IndexError, KeyError, ValueError):
                seed = 1337
            for card in multiplayer.get_hand(player, seed):
                self.wfile.write(card.encode("latin1")+b"\n")
            return

        self.send_header('Content-type', 'text/html')
        self.end_headers()
        with open(self.HTML, "rb") as f:
            self.wfile.write(f.read())
            return

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
