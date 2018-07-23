function ssh
	switch $argv[1]
        case (cat ~/.ssh/mosh_servers)
            echo (set_color brgreen)"using mosh"(set_color normal)
            sleep 0.25
            mosh $argv
        case '*'
            command ssh $argv
    end
end
