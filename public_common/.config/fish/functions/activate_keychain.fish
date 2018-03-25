# Defined in /tmp/fish.dxZgk4/activate_keychain.fish @ line 2
function activate_keychain
	if test -f ~/.keychain/(hostname)-fish-gpg
        source ~/.keychain/(hostname)-fish-gpg
    end

    if test -f ~/.keychain/(hostname)-fish
        source ~/.keychain/(hostname)-fish
    end
end
