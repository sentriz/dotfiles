function extract --description "expand or extract bundled & compressed files"
    for file in $argv
        if not test -f $file
            return 1
        end
        switch $file
            case *.tar;             tar -xvf $file
            case *.tar.bz2 *.tbz2;  tar -jxvf $file
            case *.tar.gz *.tgz;    tar -zxvf $file
            case *.bz2;             bunzip2 $file
            case *.gz;              gunzip $file
            case *.rar;             unrar x $file
            case *.zip *.ZIP;       unzip $file
            case *.pax;             pax -r < $file
            case '*';               echo "Extension not recognized, cannot extract $file"
        end
    end
end
