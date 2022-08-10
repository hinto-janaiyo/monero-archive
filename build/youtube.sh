 # I don't actually care about copying, just don't sue me please :D
#
# Copyright (c) 2022 hinto.janaiyo <https://github.com/hinto-janaiyo>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# This script uses `yt-dlp` or `youtube-dl`
# to download the Youtube channesl found in README.md

# Error handling
set -e
trap 'ERR_CODE=$?; printf "\e[1;91m%s\e[0m%s\n" "[ERROR CAUGHT] " "$BASH_COMMAND"; exit $ERR_CODE' ERR

# Make sure we're in the correct directory
if [[ $PWD = */monero-archive/build ]]; then
	:
elif [[ $PWD = */monero-archive ]]; then
	cd build
fi

# Find out which downloader we're gonna use
# [yt-dlp]
if hash yt-dlp; then
	printf "\e[1;92m%s\e[0m%s\n" "[monero-archive] " "yt-dlp detected"
	YT_DLP=true
	COMMAND=(--write-description --write-thumbnail --write-subs --no-write-info-json)
	# check for aria2
	if hash aria2c; then
		printf "\e[1;92m%s\e[0m%s\n" "[monero-archive] " "aria2 detected"
		COMMAND=(${COMMAND[@]} --downloader aria2c --merge-output-format mp4 -f bestvideo+bestaudio[ext=m4a]/best)
	else
		printf "\e[1;93m%s\e[0m%s\n" "[monero-archive] " "warning: arai2 not detected, detected, quality and speed might be lower"
	fi
# [youtube-dl]
elif hash youtube-dl; then
	printf "\e[1;92m%s\e[0m%s\n" "[monero-archive] " "youtube-dl detected"
	COMMAND=(--write-description --write-thumbnail --all-subs)
	# check for aria2
	if hash aria2c; then
		printf "\e[1;92m%s\e[0m%s\n" "[monero-archive] " "aria2 detected"
		COMMAND=(${COMMAND[@]} --external-downloader aria2c --merge-output-format mp4 -f bestvideo+bestaudio[ext=m4a]/best)
	else
		printf "\e[1;93m%s\e[0m%s\n" "[monero-archive] " "warning: aria2 not detected, quality and speed might be lower"
	fi
# else, error + exit
else
	printf "\e[1;92m%s\e[0m\n" "[monero-archive] " "you need either yt-dlp OR youtube-dl to use this script"
	exit 1
fi

# Get the list from the README.md
# Everything inbetween "## Youtube" and the first empty line found.
LIST=$(sed -n '/## Youtube/,/^$/p' ../README.md | sed '/^#.*$/d; /^$/d; s/^* //g')

# Create build directory 'monero-archive-$GIT_BRANCH'
BUILD_UUID=$(git rev-parse --short HEAD 2>/dev/null)
BUILD_DIRECTORY="$PWD/monero-archive-${BUILD_UUID}/youtube"
mkdir -p "$BUILD_DIRECTORY"
cd "$BUILD_DIRECTORY"

# Add to timestamp file
# and add other files.
echo "[youtube.sh start time] $(date +"%Y-%m-%d")" >> ../timestamp
cp -f ../../../README.md ../

# Begin
printf "\e[1;92m[monero-archive] \e[1;97m%s\e[0m\n" "starting build in: $BUILD_DIRECTORY"

# Loop over list
IFS=$'\n'
for i in $LIST; do
	# Seperate name & link
	NAME=${i/ *}
	LINK=${i/* }

	# Make channel directory
	mkdir -p "${BUILD_DIRECTORY}/${NAME}"
	cd "${BUILD_DIRECTORY}/${NAME}"

	# Fix COMMAND to include build directory
	COMMAND=(${COMMAND[@]} --output "${BUILD_DIRECTORY}/${NAME}/%(title)s/%(title)s.%(ext)s")
	# Because printf splits arrays
	PRINTF_COMMAND="${COMMAND[@]}"

	# Download
	printf "\e[1;92m[DOWNLOADING]\e[0m %s\n" "monero-archive-${BUILD_UUID}/youtube/${NAME}"
	# [yt-dlp]
	if [[ $YT_DLP = true ]]; then
		printf "\e[1;92m[COMMAND USED]\e[0m %s\n" "yt-dlp $PRINTF_COMMAND"
		echo
		yt-dlp ${COMMAND[@]} "$LINK"
	# [youtube-dl]
	else
		printf "\e[1;92m[COMMAND USED]\e[0m %s\n" "youtube-dl $PRINTF_COMMAND"
		echo
		youtube-dl ${COMMAND[@]} "$LINK"
	fi
done

# End message
printf "\e[1;92m[monero-archive] \e[1;97m%s\e[0m\n" "youtube.sh done!"
