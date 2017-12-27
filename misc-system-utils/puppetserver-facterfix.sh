#!/bin/sh
FACTER_SYMLINK=/usr/local/lib/ruby/gems/default/gems/facter/lib
SYSTEM_RUBY_VER=$( pkg info ruby | grep Version | awk -F ":" '{print $2}' | cut -c 2- | cut -c -3 )
SYSTEM_RFACTER_VER=$( pkg info rubygem-facter | grep Version | awk -F ":" '{print $2}' | cut -c 2- | cut -c -5 )
FACTER_REALLINK=/usr/local/lib/ruby/gems/"$SYSTEM_RUBY_VER"/gems/facter-"$SYSTEM_RFACTER_VER"/lib
if [ -L "$FACTER_SYMLINK" ]; then
	rm "$FACTER_SYMLINK"
fi
ln -s "$FACTER_REALLINK" "$FACTER_SYMLINK"
