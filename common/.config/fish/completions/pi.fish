function __pi_sessions
    set -l dir "$XDG_CONFIG_HOME/pi/agent/sessions/--"(string replace -a / - (string replace -r '^/' '' $PWD))--
    path filter -f $dir/*.jsonl | sort -r | xargs -r awk '
        function emit() { if (id != "") print id "\t" (name != "" ? name : text) }
        FNR == 1 {
            emit()
            id = FILENAME; sub(/.*_/, "", id); sub(/\\.jsonl$/, "", id)
            text = ""; name = ""
        }
        match($0, /"type":"session_info".*"name":"[^"]*/) {
            name = substr($0, RSTART, RLENGTH); sub(/.*"name":"/, "", name)
        }
        text == "" && /"role":"user"/ && match($0, /"text":"[^"]*/) {
            text = substr($0, RSTART + 8, RLENGTH - 8)
            gsub(/\\\\[nrt]/, " ", text)
            text = substr(text, 1, 80)
        }
        END { emit() }
    '
end

complete -c pi -x -k -l session -a '(__pi_sessions)'
complete -c pi -x -k -l fork -a '(__pi_sessions)'
