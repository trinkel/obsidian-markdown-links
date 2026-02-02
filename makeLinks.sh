#! /bin/bash

# constants

dBugg=0
FINDER_OPS_BASE="/Users/trinkel/Development/DevOps"
FINDER_OPS_PATH=`pwd`
OBSIDIAN_OPS_PATH="/Users/trinkel/Library/Mobile Documents/iCloud~md~obsidian/Documents/dBugg Dev/RepoDocs.nosync"

all=false

# Function to clean Obsidian Links directory
function cleanLinks() {
	results=$( ps -ef | grep Obsidian | grep -v grep )
	if [[ ! -z $results ]]; then
		printf "\nObsidian is running. Quit the application before running the --clean option\n\n"
		exit 4
	fi

	files=$(find "$OBSIDIAN_OPS_PATH" ! -type d ! -name "*.md" ! -name '.DS_Store')
	if [[ -z $files ]]; then
		printf "\n$OBSIDIAN_OPS_PATH contains only Markdown files. Do you want to remove its contents?\nTHIS IS DESTRUCTIVE and may cause a delay next time Obsidian is launched.\n**Entire Obsidian directory may disappear from the Finder for several minutes.**\n"
		printf "\nContinue? [ y | n ]: "
		read delete
		if [[ $delete != [yY] ]]; then
			printf "Respond \"Y\" if you really want to remove this directory structure. In the mean time\n   ...Bye 👋\n"
			exit 0
		fi
		printf "Removing $OBSIDIAN_OPS_PATH/*\n"
		rm -rf "$OBSIDIAN_OPS_PATH"/*
	else
		printf "There are non-Markdown files in destination path:\n$files\n   ...Bye 👋\n"
		exit 3
	fi
}

if [[ $dBugg -gt 0 ]]; then
	printf "Obsidian Ops Path [0]: $OBSIDIAN_OPS_PATH\n"
fi

case $# in
	0)
		all=true
		;;

	1)
		if [ $1 == "--base" ]; then
			FINDER_OPS_PATH=$FINDER_OPS_BASE
		elif [ $1 == "--clean" ]; then
			FINDER_OPS_PATH=$FINDER_OPS_BASE
			cleanLinks
		else
			FINDER_OPS_PATH=$( echo $FINDER_OPS_PATH/$1 | sed 's,/\.,,' )
		fi
		;;

	2)
		if [[ $( echo $* | grep -- "--base" ) || $( echo $* | grep -- "--clean" ) ]]; then
			printf -- "--base and --clean are not compatible with other arguments\n   Usage: makeLinks '[--base || --clean || <input_path> <obsidian_link_path>]'\n"
			exit 5
		fi

		FINDER_OPS_PATH=$( echo $FINDER_OPS_PATH/$1 | sed 's,/\.,,' )
		OBSIDIAN_OPS_PATH=$2
		;;

	*)
		printf "I think there are too many arguments. Syntax:\n   Usage: makeLinks '[--base || --clean || <input_path> <obsidian_link_path>]'"
		exit 2
		;;
esac

if [ $dBugg -gt 0 ]; then
	printf "Obsidian Ops Path [1]: $OBSIDIAN_OPS_PATH\n"
fi

MD_PATH=$( echo $FINDER_OPS_PATH | sed "s,$FINDER_OPS_BASE,," )
OBSIDIAN_OPS_PATH=$( echo "$OBSIDIAN_OPS_PATH$MD_PATH" | sed "s,\./,,")

if [ $dBugg -gt 0 ]; then
	printf "Obsidian Ops Path [2]: $OBSIDIAN_OPS_PATH\n"
fi


# if [ $# -ne 0 ]; then
# 	set FINDER_OPS_PATH="$1"
# fi

if [ $dBugg -gt 0 ]; then
	echo $#
	echo $0
	echo "MD: "$MD_PATH
	echo "OB_PATH: "$OBSIDIAN_OPS_PATH
fi

printf "\ninput path is:\n   $FINDER_OPS_PATH\n"
printf "\nObsidian path is:\n   $OBSIDIAN_OPS_PATH\n"

if [ $dBugg == 2 ]; then
	exit
fi

printf "\nContinue? [ y | n ]: "

read continue
#printf "continue: $continue\n"

# Main function
#Find markdown files and create links in Obsidian pat
if [[ $continue != [yY] ]]; then
	printf "Respond \"Y\" if you really want to do this.  In the mean time\n   ...Bye 👋\n"
	exit 0
fi

cd "$FINDER_OPS_PATH" \
&& find . -type d \( -name node_modules -o -name vendor -o -name src \) -prune -o -iname '*.md' -print0 | while IFS= read -r -d '' path; do

	path=$( echo "$found_path" | sed "s,\./,,")
	file_path=$FINDER_OPS_PATH/$found_path
	link_file_path=$OBSIDIAN_OPS_PATH/$found_path
	link_base_path=$( dirname "$link_file_path" )

	if [[ $dBugg -eq -3 ]]; then
		printf "NOTE: this is the find exec\n"
		printf "Find path: $found_path\n"
		printf "file_path: $file_path\n"
		printf "link_base_path: $link_base_path\n"
		printf "dirname path: $( dirname $found_path )\n"
		printf "mkdir: $link_base_path/$( dirname $found_path )\n"
		printf "link_file: $link_file_path -> $file_path\n"
		continue
	fi

	# Create link directory if necessary
	if [[ ( -e $link_base_path || -L $link_base_path ) && ! -d $link_base_path ]]; then
		printf "$link_base_path exists, but is not a directory\n"
		continue
	elif [[ ! -d $link_base_path ]]; then
		mkdir -p "$link_base_path"
	fi

	# Create link if it doesn't exist
	# TODO: check if -e doesn't work correctly with invalid link
	if [[ -e $link_file_path && ! -L $link_file_path && ! -d $link_file_path ]]; then
		printf "The file exists and is not a link: '$link_file_path'\n"
		continue

	elif [[ -L $link_file_path ]]; then
		printf "The link exists: '$link_file_path'\n"
		continue

	elif [[ -d $link_file_path ]]; then
		printf "Location exists and is a directory: '$link_file_path'\n"
		continue

	else
		if [[ ! -e $file_path ]]; then
			printf "Source file does not exist: '$file_path'"
			continue
		fi

		ln -s "$file_path" "$link_file_path"

		if [[ -L $link_file_path && -e $link_file_path ]]; then
			printf "'$link_file_path' created\n"
		else
			printf "'$link_file_path' was not created\n"
		fi

	fi
done

printf "\n"
	# echo "***This should not print***"
	# -exec /bin/bash -c 'link_md "{}"' \;
	# link_md test
		#-exec printf "$OBSIDIAN_OPS_PATH{}\n" \; #-exec ln -s "{}" "$OBSIDIAN_OPS_PATH" \;


# find "$OBSIDIAN_OPS_PATH" -type d \( -name node_modules -o -name vendor -o -name src \) -prune -o -iname '*.md' -print -exec printf "{}" "$OBSIDIAN_OPS_PATH/{{}//$FINDER_OPS_BASE/}"

# Put the find results in a forEach (either in a variable or as condition for forEach). then
# mkdir -p dirname ObsidanPath
# ln -s basename ObsidianPath
