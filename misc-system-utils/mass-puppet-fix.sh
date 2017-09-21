#!/bin/sh
# mass run puppet-lint --fix
# run from inside whatever directory is above your puppet modules dir.
brokenmodules=$(puppet-lint ./modules | awk -F "-" '!/nagios/ {print $1}' | uniq)
for i in $brokenmodules; do
	puppet-lint --fix "$i"
done
