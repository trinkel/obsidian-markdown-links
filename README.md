---
Date Modified: Saturday, December 27, 2025 | 3:51 pm
---
# makeLinks.sh

by [dBugg.dev](https://dbugg.dev)

## Description

Viewing Markdown files in VSCode and other code editors kind of sucks. We wanted to use a Markdown file editor for viewing `README.md` and other Markdown files within project repositories. Using [Obsidian](https://obsidian.md) as an example, if you open a repository, or group of repositories, as a "vault", Obsidian will traverse and gather Markdown files from unintended folders such as `node_modules` which can add enough files and directories to bring Obsidian to it's knees. The vault will take a long time to open and can be unstable.

The **`makeLinks`** script creates links (within an Obsidian vault) to relevant Markdown files within repositories avoiding unwanted directories such as `node_modules`. The ignored directories and location of the Obsidian vault can be configured in the script.

`makeLinks.sh` is a Bash script and can be placed anywhere in your filesystem. Execution is from the command line and follows typical shell practices.
## Installation

- Download the script and copy to the desired location in your filesystem. This can be a location already in your `$PATH` such as `/usr/local/bin`, another location to be added to your `$PATH` or any location and use the full path to the the script to execute.
- Make the script executable: - `chmod a+x <path>/makeLinks.sh`
- Add the location to the $PATH variable in the appropriate profile file for your system if needed/desired (or plan to execute using the full path to the script)

## Use

- Set any variable preferences within the script
- `cd` to the directory you want to examine such as the top level of a repository or your top-level development folder
- `makeLinks.sh` without arguments will examine the filesystem starting at the current directory and rebuild links using the same directory structure in the configured Obsidian vault.
- `makeLinks.sh <path>` will start examining the filesystem at the specified path.
- The script will echo back the effective source and link paths.
- Entering 'Y' to the `continue` question will create the links checking for conflicts in the destination path


