function fish_user_key_bindings
    fish_vi_key_bindings
    bind \cf __fzf_find_file
    bind \cr __fzf_reverse_isearch
    bind -M insert \cf __fzf_find_file
    bind -M insert \cr __fzf_reverse_isearch
end
