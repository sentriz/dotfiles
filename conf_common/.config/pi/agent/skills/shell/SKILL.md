---
name: shell
description: Use when reading, writing or refactoring shell scripts - bash, sh or fish
---

- `set -u` goes in every bash/sh script, right after the shebang. A script that depends on an env var should abort when it is unset, not act on an empty string.
- `set -e` is not the default. Add it only to linear procedural scripts where aborting on any failure is correct. Event-driven scripts treat non-zero as ordinary control flow, so `-e` there causes silent early exits. Where a script already has `set -e`, write `set -eu` rather than adding a second line.
- `${VAR-}` means "a caller may legitimately omit this", and the bar for using it is being able to name the caller that omits it. Otherwise leave it bare so `set -u` asserts the invariant. Defaulting a value that should always be there is not a fix - it converts a loud abort into an empty string handed to the next command, which is the failure `set -u` exists to prevent. Prefer initialising once (`pid=""`) over sprinkling `${VAR-}` at every use.
- `"$@"` is fine when empty. Never "fix" it to `"${@-}"` - with zero args that expands to one empty argument, so `cat "${@-}"` becomes `cat ""` instead of reading stdin.
- `${a[@]}` and `${#a[@]}` are fine on an empty array; `${a[0]}` is not. When splitting a line into fields, work out the arity the producer actually emits before defaulting anything - producers often pad with trailing separators to keep it fixed, and a field you can prove is always present should be read bare. Where one line shape genuinely is shorter, branch on the field that identifies it and handle it before reading the wider fields, or move the split into the branch that needs them.
- Before adding `set -e`, check for: `x="$(grep ...)"` where no match is normal, and `cond && action` as a function's last statement. Both return non-zero and abort. Mid-script `cond && action` is safe.
- fish has no `set -u`; guard with `set -q VAR; or begin; echo "VAR not set" >&2; exit 1; end`. Note fish sources `config.fish` even for scripts, so such guards rarely fire.
- Verify with `shellcheck -S warning` and `bash -n`. Don't run scripts to test them - a script in a `bin` directory usually has side effects. Check for symlinks before editing; one real script is often reachable under several names.
