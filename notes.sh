# Attempt to append the appropriate extension to a filename, preferring gpg
# over txt.
buildfile() {
    # If an extension was given, use it.
    if [[ "$1" == *.* ]]; then
        echo "$1"
    # If no extension was given...
    else
        # ... try the file without any extension.
        if [ -e "$1" ]; then
            echo "$1"
        # ... try the file with a gpg extension.
        elif [ -e "$1".gpg ]; then
            echo "$1".gpg
        # ... use a txt extension.
        else
            echo "$1".txt
        fi
    fi
}

# Verify the note directory is defined and exists.
init() {
    if [ -z "$NOTEDIR" ]; then
        echo '$NOTEDIR is undefined.'
        return 2
    fi
    if [ ! -d "$NOTEDIR" ]; then
        mkdir -p "$NOTEDIR"
    fi
}

# Create or edit notes.
n() {
    if init; then
        # If no note was given, list the notes.
        if [ -z "$1" ]; then
            ls -lhtr --color=always "$NOTEDIR"
        # If a note was given, open it.
        else
            $EDITOR "$(buildfile "$NOTEDIR"/"$1")"
        fi
    else
        return $?
    fi
}

# Find a note by title.
nf() {
    if init; then
        if [ -z "$1" ]; then
            ls -lhtr --color=always "$NOTEDIR"
        else
            ls -lhtr --color=always "$NOTEDIR" | grep -i --color=always "$1"
        fi
    else
        return $?
    fi
}

# Search within notes.
ns() {
    if init; then
        cd "$NOTEDIR"
        grep -rin --exclude-dir=.git --color=always "$1"
        cd "$OLDPWD"
    else
        return $?
    fi
}

# Set zsh autocompletion for notes.
if [ -n "$ZSH_NAME" ]; then
    compctl -W "$NOTEDIR" -f n
fi
