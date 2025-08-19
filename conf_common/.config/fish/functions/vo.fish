function vo
    $argv 2>&1 | extract-paths -files -vim | "$EDITOR" -q -
end
