package main

import (
    "fmt"
    "html/template"
    "io/ioutil"
    "log"
    "net/http"
    "os"
    "os/exec"
    "path/filepath"
    "math/rand"
    "sort"
    "strconv"
    "time"
)

var templates = template.Must(template.ParseFiles("view/quarantine.html"))

var colors = [...]string{"schell", "herz", "blatt", "eichel"}
var values = [...]string{"7", "8", "9", "10", "U", "O", "K", "A"}

func viewHandler(w http.ResponseWriter, r *http.Request) {
    if r.Method == "POST" {
        player := r.FormValue("player")
        win := r.FormValue("win")
        jack := r.FormValue("jack")
        color := r.FormValue("color")
        if player == "" || win == "" || jack == "" || color == "" {
            http.Error(w, "invalid form", http.StatusInternalServerError)
            return
        }
        new_player_name := r.FormValue("new_player_name")
        if new_player_name != "" {
            player = new_player_name
        }
        game := ""
        for _, mod := range "tbhTBo" {
            mod_value := r.FormValue("mod_" + string(mod))
            if mod_value != "" {
                game += string(mod)
            }
        }
        if jack == "N" {
            color = ""
        }
        timestamp := time.Now().Unix()
        victory := "0"
        if win == "win" {
            victory = "1"
        }
        entry := strconv.FormatInt(timestamp, 10) + "," + player + "," + victory + "," + jack + color + game + "\n"
        f, err := os.OpenFile("games.csv", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
        if err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
        }
        _, err = f.WriteString(entry)
        if err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
        }
        err = f.Close()
        if err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
        }
        cmd := exec.Command("make", "index.html")
        err = cmd.Run()
        if err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
        }
    }
    p, _ := ioutil.ReadFile("index.html")
    fmt.Fprintf(w, "%s", p)
}

func serveStatic(w http.ResponseWriter, r *http.Request) {
    path := r.URL.Path[1:]
    p, err := ioutil.ReadFile(path)
    if err != nil {
        http.NotFound(w, r)
        return
    }
    extension := filepath.Ext(path)
    extension_content_type := map[string]string{
        ".css": "text/css",
        ".js": "application/javascript",
        ".svg": "image/svg+xml",
    }
    content_type, found := extension_content_type[extension]
    if found {
        w.Header().Set("Content-Type", content_type)
    }
    fmt.Fprintf(w, "%s", p)
}

type Hands struct {
    Player0 []Card
    Player1 []Card
    Player2 []Card
    Skat []Card
}

type Card struct {
     Color string
     Value string
}

func quarantine(w http.ResponseWriter, r *http.Request) {
    seed, _ := strconv.Atoi(r.FormValue("seed"))
    rand.Seed(int64(seed))
    game_cards := rand.Perm(len(colors) * len(values))
    sort.Ints(game_cards[:10])
    sort.Ints(game_cards[10:20])
    sort.Ints(game_cards[20:30])
    sort.Ints(game_cards[30:])
    cards := []Card{}
    for _, c := range game_cards {
        cards = append(cards, get_card(c))
    }
    err := templates.ExecuteTemplate(w, "quarantine.html", Hands{cards[:10], cards[10:20], cards[20:30], cards[30:]})
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
    }
}

func get_card(card_id int) Card {
    color := colors[card_id / len(values)]
    value := values[card_id % len(values)]
    return Card{color, value}
}

func serveAPI(w http.ResponseWriter, r *http.Request) {
    path := r.URL.Path[len("/api/"):]
    if path != "games.csv" {
        http.NotFound(w, r)
        return
    }
    p, err := ioutil.ReadFile(path)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    w.Header().Set("Content-Type", "text/csv")
    fmt.Fprintf(w, "%s", p)
}

func main() {
    http.HandleFunc("/", viewHandler)
    http.HandleFunc("/quarantine", quarantine)
    http.HandleFunc("/static/", serveStatic)
    http.HandleFunc("/api/", serveAPI)
    log.Fatal(http.ListenAndServe(":8000", nil))
}
