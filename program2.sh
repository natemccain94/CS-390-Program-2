#!/bin/bash
# Nate McCain
# CS 390
# 09/27/2017

# Create temporary files to hold for comparisons.
# previoussweep holds the results from the last sweep.
# It is empty on the first run.
previoussweep=$(mktemp)

# latestsweep holds the latest results from the find command.
latestsweep=$(mktemp)

# differencefile is used to execute the comm function between
# previoussweep and latestsweep, but only comparing one
# line of latestsweep against previoussweep at a time.
differencefile=$(mktemp)

# Infinite loop
while true
do
	# Output a message so the user knows the program is running.
	echo Scanning the directory.

	# Find all pdf files within the current directory.
	find ./ -iname \*.pdf -print | sort > $latestsweep
	
	# Read every line in latestsweep,
	while read helper; do

		# and store that line in differencefile.
		echo $helper > $differencefile

		# Then see if that line is in previoussweep.
		comm -13 $previoussweep $differencefile

	# This reads in every line in latestsweep and stores
	# it in the helper variable.
	done < $latestsweep

	# store all of the newest files into previoussweep.
	cat $latestsweep > $previoussweep

	# Let the user know that the scan and comparison is complete.
	echo Scan complete.

	# Sleep for 60 seconds, then return to the top of the loop.
	sleep 60

	# Clear the terminal output to help illustrate the start
	# of a new scan.
	clear

done
# End of inifinite loop (so this technically doesn’t exist).