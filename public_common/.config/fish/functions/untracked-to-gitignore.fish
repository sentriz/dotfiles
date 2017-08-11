function untracked-to-gitignore
	if not git rev-parse --is-inside-work-tree > /dev/null 2>&1
        echo not in a repo
        return 1
    end
    cd (git rev-parse --show-toplevel)
	git ls-files --others --exclude-standard | read -z untracked
    echo 'would add the following to .gitignore?'
    echo $untracked
    if confirm
        echo $untracked >> .gitignore
    end
end
