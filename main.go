package main

import (
	"encoding/json"
	"net/http"
	"strconv"
	"time"
)

func main() {
	// db.go runs init() automatically, so _connection is ready
	http.ListenAndServe(":9090", &handler{})
}

type handler struct{}

type row struct {
	ID        int64     `json:"id"`
	CreatedAt time.Time `json:"created_at"`
}

func (h *handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path == "/healthcheck" {
		w.WriteHeader(200)
		w.Write([]byte(`{"status":"ok"}`))
		return
	}

	switch r.Method {
	case "GET":
		rs, err := _connection.Query(`SELECT id,created_at FROM stuff`)
		if err != nil {
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}
		defer rs.Close()

		var ret []row
		for rs.Next() {
			cur := row{}
			err = rs.Scan(
				&cur.ID,
				&cur.CreatedAt,
			)
			if err != nil {
				http.Error(w, "Internal Server Error", http.StatusInternalServerError)
				return
			}
			ret = append(ret, cur)
		}

		bs, err := json.Marshal(ret)
		if err != nil {
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}
		w.Write(bs)

	case "POST":
		_, err := _connection.Exec("INSERT INTO stuff (created_at) VALUES (NOW())")
		if err != nil {
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}
		w.Write([]byte(`OK`))

	case "PATCH":
		idStr := r.URL.Query().Get("id")
		id, err := strconv.ParseInt(idStr, 10, 64)
		if err != nil {
			http.Error(w, "Invalid id value", http.StatusBadRequest)
			return
		}

		_, err = _connection.Exec(`UPDATE stuff SET created_at=NOW() WHERE id=?`, id)
		if err != nil {
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}

		w.Write([]byte(`OK`))
	}
}
