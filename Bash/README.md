# Features
- Debugging
- File
- Get stdin
- Options
# Requirements
- `bash` 4.x+
- `getopt` on `util-linux` or `gnu-getopt`
# Notes
on MacOS or possibly on another operating system,
(This assumes you have installed Homebrew, if not. Visit [brew homepage](https://brew.sh/)).
Bash version is below 4.x+ which does not support `readarray` and `mapfile` commands.
Install `bash` by running `brew install bash`.
You may need to install or upgrade `gnu-getopt` (if installed already) by running `brew install gnu-getopt`, or `brew upgrade gnu-getopt` respectively.
If you did not already, follow instructions for setting `PATH` when installing.
