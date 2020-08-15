#!/bin/bash

if [[ $(systemctl is-active minecraft) = "active" ]]; then
	for i in {20..0}; do
		case $i in
			20) sendcommand -q "say Server will perform its daily restart in $i minutes."
				;;
			15) sendcommand -q "say Server will perform its daily restart in $i minutes."
				;;
			10) sendcommand -q "say Server will perform its daily restart in $i minutes."
				;;
			5) sendcommand -q "say Server will perform its daily restart in $i minutes."
				;;
			4) sendcommand -q "say Server will perform its daily restart in $i minutes."
				;;
			3) sendcommand -q "say Server will perform its daily restart in $i minutes."
				;;
			2) sendcommand -q "say Server will perform its daily restart in $i minutes."
				;;
			1) sendcommand -q "say Server will perform its daily restart in $i minute. Please log off, it should be back up in just a few minutes, if not message Goat on Discord."
				;;
			0) sendcommand -q "say Restarting......"
				systemctl stop minecraft
				sleep 15
				systemctl start minecraft
				;;
		esac
			[ ! $i = 0 ] && sleep 60
		done
else
       	echo "Chron tried to reboot the minecraft server on $(date) but it was not running." >> /home/$YOURUSER/minecraft-server-error #$YOURUSER is obviously whoever you want to receive that message.
fi

exit 0
