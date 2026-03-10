#!/bin/zsh

TRIPLET = "$1"

if echo "$TRIPLET" | grep -Eq 'i[[:digit:]]86-'; then
    echo i386
else 
    echo "$TRIPLET" | grep -Eo '^[[:alnum:]_]*'
fi

