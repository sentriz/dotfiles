# Defined in /tmp/fish.L2itCH/start_keychain.fish @ line 2
function start_keychain
	keychain --gpg2 --quiet --agents ssh,gpg
end
