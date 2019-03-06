function paste_home
    set -l haste_url "https://paste.home.senan.xyz"
    read -lz data
    set -l key (curl -sf --data-binary "$data" $haste_url"/documents" | jq -r '.key')
    printf "%s/%s\n" $haste_url $key
end
