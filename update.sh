#!/bin/env bash

# Read help option and exit.

if [[ $1 = "--help" ]]
then
        echo "Run this script to update Spigot and back up the original jar. Pass the option -u if you want to force the Spigot BuildTools to update."
        exit
fi

# Download Spigot BuildTools if it does not already exist.

if [[ $1 = "-u" ]]
then
	getBuildTools
else
	if [[ -f BuildTools.jar ]]
	then
		echo "Spigot BuildTools already exists, proceeding with update."
	else
		getBuildTools
	fi
fi

function getBuildTools {
	wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O BuildTools.jar &> lastdl.log && echo "Latest release of Spigot BuildTools downloaded successfully."
}

# Build
# use --rev version to overwrite latest with given argument else use the latest build.
java -jar BuildTools.jar --rev ${1:-latest} &> lastbuild.log && echo "Build Successful"

# Backup jar
mv ../../server/spigot.jar ../../backup/server/`date +"%Y-%m-%H-spigot.jar"` && echo "Backup Successful"

# Install jar
mv spigot-1.*.jar ../../server/spigot.jar && echo "Install Successful"

# Re-establish permissions if this was run by any user other than minecraft.
if [[ $(whoami) = "root" ]]
then
        echo "Re-establishing file structure permissions since this was run as root."
	chown -R minecraft:minecraft /var/minecraft
fi


