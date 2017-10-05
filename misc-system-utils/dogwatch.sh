#!/bin/sh
dog=FILENAME
dogsize=GIMMEASIZE #list in non-human format. 2684354560 = 2.5Gb
rotatecmd=RUNSOMETHING

dogwatch() {
	dogactually=$(ls -la | awk '{print $5}' ${dog})
	if [ "${dogactually}" -le "${dogsize}" ]; then
		sleep 30
		dogwatch
	else
		"${rotatecmd}"
		sleep 5
		dogwatch
	fi
}