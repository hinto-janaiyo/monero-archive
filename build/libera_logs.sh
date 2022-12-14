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

# This script fetches all the libera logs
# off of: https://libera.monerologs.net

# Error handling
set -e
trap 'ERR_CODE=$?; printf "\e[1;91m%s\e[0m%s\n" "[ERROR CAUGHT] " "$BASH_COMMAND"; exit $ERR_CODE' ERR

# Make sure we're in the correct directory
if [[ $PWD = */monero-archive/build ]]; then
	:
elif [[ $PWD = */monero-archive ]]; then
	cd build
fi

# Set URL
URL="https://libera.monerologs.net"

# Set channels
CHANNELS="$(sed -n '/## Libera Logs/,/^$/p' ../README.md | sed '/^#.*$/d; /^$/d; s/* //g')"

# Get the date
DATE_TODAY=$(date +"%Y%m%d")

# Create build directory 'monero-archive-$GIT_BRANCH'
BUILD_UUID=$(git rev-parse --short HEAD 2>/dev/null)
BUILD_DIRECTORY="$PWD/monero-archive-${BUILD_UUID}/libera_logs"
mkdir -p "$BUILD_DIRECTORY"
cd "$BUILD_DIRECTORY"

# Add to timestamp file
# and add other files.
echo "[libera_logs.sh start time] $(date +"%Y-%m-%d")" >> ../timestamp
cp -f ../../../README.md ../

# Loop over channel
for c in $CHANNELS; do
mkdir -p "$c"
cd "$c"

# BEGINNING OF 2021
# Loop over months in a year
y=2021
for m in {06..12}; do
	# Loop over days in a month
	for d in {01..31}; do
		DATE="${y}${m}${d}"
		# If a file is found, skip it
		if [[ -e "$BUILD_DIRECTORY/$c/$DATE" ]]; then
			printf "\e[1;93m%s\e[0m%s\n" "[LOG FOUND, SKIPPING] " "monero-archive-${BUILD_UUID}/libera_logs/$c/$DATE"
			continue
		fi
		until wget -q "$URL/$c/$DATE/raw" -O "$DATE"; do
			printf "\e[1;91m%s\e[0m%s\n" "[WGET ERROR, RETRYING] " "monero-archive-${BUILD_UUID}/libera_logs/$URL/$c/$DATE"
		done
		printf "\e[1;92m%s\e[0m%s\n" "[  OK  ] " "monero-archive-${BUILD_UUID}/libera_logs/$c/$DATE"
	done
done

# Loop over year
# MAX 2025... just in case.
for y in {2022..2025}; do
	# EVERYTHING AFTER
	# Loop over months in a year
	for m in {01..12}; do
		# Loop over days in a month
		for d in {01..31}; do
			DATE="${y}${m}${d}"
			# Exit if the date is the current day.
			[[ $DATE = "$DATE_TODAY" ]] && break 3
			# If a file is found, skip it
			if [[ -e "$BUILD_DIRECTORY/$c/$DATE" ]]; then
				printf "\e[1;93m%s\e[0m%s\n" "[LOG FOUND, SKIPPING] " "monero-archive-${BUILD_UUID}/libera_logs/$c/$DATE"
				continue
			fi
			until wget -q "$URL/$c/$DATE/raw" -O "$DATE"; do
				printf "\e[1;91m%s\e[0m%s\n" "[WGET ERROR, RETRYING] " "monero-archive-${BUILD_UUID}/libera_logs/$c/$DATE"
			done
			printf "\e[1;92m%s\e[0m%s\n" "[  OK  ] " "monero-archive-${BUILD_UUID}/libera_logs/$c/$DATE"
		done
	done
done
cd "$BUILD_DIRECTORY"
done

# End message
printf "\e[1;92m[monero-archive] \e[1;97m%s\e[0m\n" "libera_logs.sh done!"
