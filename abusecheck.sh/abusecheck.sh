#!/bin/sh
abusedoc=$(cat "$HOME"/abusedoc.txt)
for line in $abusedoc; do
	xargs whois
done