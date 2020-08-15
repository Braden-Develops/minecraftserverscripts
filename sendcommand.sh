#!/bin/bash
#
#HOW TO USE THIS SCRIPT
#Enter an argument in quotations after the sendcommand command

#$YOURPORT is defined as the 'rcon port' in server.properties
#$YOURPASSWORD is defined as the 'rcon password' in server.properties

if [[ $# = 2 ]]; then
	case $1 in
		-q) # Quiet
			/var/minecraft/mcrcon -H localhost -P $YOURPORT -p $YOURPASSWORD "$2"
			;;
		-v) # Verbose
			echo "Sending command '$2' to Minecraft server... Reply from server (if applicable) below line."
			/var/minecraft/mcrcon -H localhost -P $YOURPORT -p $YOURPASSWORD "$2"			;;
	esac
elif [[ $# > 2 ]]; then
	echo "Please pass only one option to the command"
else
	echo "Sending command to Minecraft server... Reply from server (if applicable) below line."
	echo ---------------------------
	/var/minecraft/mcrcon -H localhost -P $YOURPORT -p $YOURPASSWORD "$1"
fi
