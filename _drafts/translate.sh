#!/bin/sh

# * converts <tt>...</tt> to `..`
# TODO: spaces after full stops?

# http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
replace=0
fullstop=0

show_help() {
    echo "$0 [-i] [-f] inputfile"
    echo ""
    echo "Arguments:"
    echo "-i        | modify input file in-place? (default no)"
    echo "-f        | try ensure full stops have following spaces?"
    echo "inputfile | the input file"
    echo ""
    echo "Note: -f is experimental. It finds full-stops followed by capital"
    echo "letters and no space in-between, and puts a space in between."
    echo "In particular, it has NO awareness of code/URLs and may replace these"
    echo "too. Try `grep '\.[A-Z]' inputfile` to see what will be replaced."
    echo ""
}

while getopts "h?if" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    i)  replace=1
        ;;
    f)  fullstop=1
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

if [ "$#" -lt 1 ] || [ ! -f "$1" ]; then
    echo "Error: Input file '$1' not found."
    echo ""
    show_help
    exit 1 
fi

PERL=perl

[ "$replace" = "1" ] && PERL="perl -i"

# <tt>..</tt> with `..`
$PERL -pe 's!<tt>(.*?)</tt>!`\1`!g' "$1"

if [ "$fullstop" = "1" ]; then
    # EXPERIMENTAL full stop with no space after
    $PERL -pe 's!\.([A-Z])!. \1 !g' "$1"
fi

exit 0
