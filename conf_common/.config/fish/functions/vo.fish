function vo
    $argv 2>&1 | extract-paths -files -vim | ifne "$EDITOR" -q - -c copen
end
