#! /bin/bash
# Usage: sudo install.sh <source_path>? <exec_path>?

if [[ $EUID -ne 0 ]]; then
	printf "This script must be executed with root privileges.\n"
	exit 1
fi

dBugg=0
SOURCE_PATH=$( pwd )
SOURCE_NAME='makeLinks.sh'
EXEC_PATH='/usr/local/bin'
EXEC_NAME='makeLinks'

case $# in
	0)
	;;

	1)
		SOURCE_PATH=$1
	;;

	2)
		SOURCE_PATH=$1
		EXEC_PATH=$2
	;;

	*)
		printf "Incorrect number of arguments. Syntax:\n
		sudo install.sh <source_path>? <exec_path>?"
	;;
esac

if [[ ! -e $SOURCE_PATH/$SOURCE_NAME ]]; then
	printf "Source \`$SOURCE_PATH/$SOURCE_NAME\` does not exist\n"
	exit 2
fi

if [[ -e $EXEC_PATH/$EXEC_NAME ]]; then
	printf "Executable link location \`$EXEC_PATH/$EXEC_NAME\` exists\n"
	exit 3
fi

ln -s $SOURCE_PATH/$SOURCE_NAME $EXEC_PATH/$EXEC_NAME

if [[ -L $EXEC_PATH/$EXEC_NAME ]]; then
	printf "Link created:\n"
	ls -la "$EXEC_PATH/$EXEC_NAME"
else
	printf "Link failed:\n"
	ls -la "$EXEC_PATH/$EXEC_NAME"
fi