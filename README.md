# notes.sh

Shortcuts for easily managing text-based notes.

See: https://pig-monkey.com/2012/12/notes-unix/

## Configuration

The variable `$NOTEDIR` defines the location of the note directory. It should
be exported in the shell environment. 

    export NOTEDIR=~/documents/notes

The optional variable `$NOTEXDGEXT` defines a space-separated list of
extensions for files which should be opened via `xdg-open` rather than the
default `$EDITOR`. This may be useful if you want CSV files to be opened in a
spreadsheet program (such as [visidata](http://visidata.org/)).

    export NOTEXDGEXT="csv tsv"
