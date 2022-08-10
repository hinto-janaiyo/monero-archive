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

# This script recursively clones all
# the GitHub links found in README.md

# Error handling
set -e
trap 'ERR_CODE=$?; printf "\e[1;91m%s\e[0m%s\n" "[ERROR CAUGHT] " "$BASH_COMMAND"; exit $ERR_CODE' ERR

# Make sure we're in the correct directory
if [[ $PWD = */monero-archive/build ]]; then
	:
elif [[ $PWD = */monero-archive ]]; then
	cd build
fi

# Get the list from the README.md
# Everything inbetween "## GitHub" and the first empty line found.
LIST=$(sed -n '/## GitHub/,/^$/p' ../README.md | sed '/^#.*$/d; /^$/d')

# Get the amount of repos we're cloning
NUM_MAX=$(printf "%s\n" "$LIST" | grep -c '^[[:blank:]]\+-')
NUM_NOW=1

# Create build directory 'monero-archive-github-$GIT_BRANCH'
BUILD_UUID=$(git rev-parse --short HEAD 2>/dev/null)
BUILD_DIRECTORY="$PWD/monero-archive-${BUILD_UUID}/github_repos"
mkdir -p "$BUILD_DIRECTORY"
cd "$BUILD_DIRECTORY"

# Add to timestamp file
# and add other files.
echo "[github_html.sh start time] $(date +"%Y-%m-%d")" >> ../timestamp
cp -f ../../../README.md ../

# Begin
printf "\e[1;92m[monero-archive] \e[1;97m%s\e[0m\n" "starting build in: $BUILD_DIRECTORY"

# Loop over list
IFS=$'\n'
for i in $LIST; do
	# Get author name from "*"
	if [[ $i = \** ]]; then
		AUTHOR="${i/\* }"
		# Create author directory
		mkdir -p "${BUILD_DIRECTORY}/$AUTHOR"
		cd "${BUILD_DIRECTORY}/$AUTHOR"
		continue
	# Else, get repo from "-"
	else
		REPO="${i/[[:blank:]]- }"
		# If a directory is found, skip it
		if [[ -d "$BUILD_DIRECTORY/$AUTHOR/$REPO" ]]; then
 			printf "\e[1;93m%s\e[0m%s\n" "[REPO FOUND, SKIPPING ${NUM_NOW}/${NUM_MAX}] " "monero-archive-${BUILD_UUID}/github_repos/$AUTHOR/$REPO"
			((NUM_NOW++))
			continue
		fi
		# Clone into $AUTHOR
		# Ask if user would like to continue
		# if git clone fails.
		printf "\e[1;92m[CLONING \e[1;93m${NUM_NOW}\e[1;92m/\e[1;95m${NUM_MAX}\e[1;92m] \e[1;97m%s\e[0m\n" "monero-archive-${BUILD_UUID}/github_repos/$AUTHOR/$REPO"
		until git clone --recursive "https://github.com/$AUTHOR/$REPO"; do
			# Remove if failed
			rm -rf "$BUILD_DIRECTORY/$AUTHOR/$REPO"
			# Ask user either to retry or skip
			printf "\e[1;91m%s\e[0m%s\n" "[GIT CLONE ERROR: https://github.com/$AUTHOR/$REPO] " "What to do? (Retry / skip / exit) "
			read -r RETRY_SKIP
			case "$RETRY_SKIP" in
				skip|Skip|SKIP) break;;
				exit|Exit|EXIT) exit 1;;
				*) :;;
			esac
		done
		# Increment current number
		((NUM_NOW++))
	fi
done

# End message
printf "\e[1;92m[monero-archive] \e[1;97m%s\e[0m\n" "github.sh done!"
