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

#-------------------------------#
# AUTO-VPN SWITCH CONFIGURATION #
#-------------------------------#
# If you want this script to auto
# switch your IP every time you
# get rate-limted, please enter
# the command that makes your VPN
# connect to a random server below.
VPN_COMMAND=(protonr)





# This script downloads the issues
# of the GitHub links found in README.md

# Error handling
set -eo pipefail
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
BUILD_DIRECTORY="$PWD/monero-archive-${BUILD_UUID}/github_issues"
mkdir -p "$BUILD_DIRECTORY"
cd "$BUILD_DIRECTORY"

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
		mkdir -p "${BUILD_DIRECTORY}/$AUTHOR/$REPO"
		cd "${BUILD_DIRECTORY}/$AUTHOR/$REPO"

		# Get the latest issue number
		until NUM_MAX_ISSUES=$(wget -qO- "https://api.github.com/repos/$AUTHOR/$REPO/issues?state=all&page=1&per_page=1"); do
			# Detect rate-limit
			if [[ $? = 8 ]]; then
				printf "\e[1;91m%s\e[0m\n" "[GITHUB API RATE-LIMIT DETECTED]"
				# AUTO VPN SWITCH COMMAND
				if [[ $VPN_COMMAND && ${VPN_COMMAND[*]} != "my_vpn --connect --random" ]]; then
					${VPN_COMMAND[@]}
				fi
			fi
			# Remove if failed
			rm -rf "$BUILD_DIRECTORY/$AUTHOR/$REPO"
			# Ask user either to retry or skip
			printf "\e[1;91m%s\e[0m%s" "[GITHUB ISSUES API ERROR: https://api.github.com/repos/$AUTHOR/$REPO] " "What to do? (Retry / skip / exit) "
			read -r RETRY_SKIP
			case "$RETRY_SKIP" in
				skip|Skip|SKIP) ((NUM_NOW++)); break 2;;
				exit|Exit|EXIT) exit 1;;
				*) :;;
			esac
		done
		# Skip if no issues found
		if ! NUM_MAX_ISSUES=$(printf "%s\n" "$NUM_MAX_ISSUES" | grep number); then
			printf "\e[1;93m%s\e[0m%s\n" "[NO ISSUES FOUND, SKIPPING ${NUM_NOW}/${NUM_MAX}] " "monero-archive-${BUILD_UUID}/github_issues/$AUTHOR/$REPO"
			((NUM_NOW++))
			continue
		fi
		# If found, use it as reference for many issues there are
		NUM_MAX_ISSUES=${NUM_MAX_ISSUES//[!0-9]}

		# Download:
		# -   issue json
		# -   /comments
		# -   /timeline
		# -   issue html
		for seq in $(seq 1 $NUM_MAX_ISSUES); do
			mkdir -p "${BUILD_DIRECTORY}/$AUTHOR/$REPO/$seq"
			cd "${BUILD_DIRECTORY}/$AUTHOR/$REPO/$seq"

			# print author/repo count
			printf "\e[1;92m[REPO \e[1;93m${NUM_NOW}\e[1;92m/\e[1;95m${NUM_MAX}\e[1;92m] %s"
			printf "\e[1;92m[ISSUE \e[1;93m${seq}\e[1;92m/\e[1;95m${NUM_MAX_ISSUES}\e[1;92m]\e[0m %s\n" \
				"monero-archive-${BUILD_UUID}/github_issues/$AUTHOR/$REPO/$seq"

			# main issue
	        # If a file is found, skip it
	        if [[ -e "$BUILD_DIRECTORY/$AUTHOR/$REPO/$seq/${seq}.json" ]]; then
	            printf "\e[1;93m%s\e[0m%s\n" "[FILE FOUND, SKIPPING ${NUM_NOW}/${NUM_MAX}] " "monero-archive-${BUILD_UUID}/github_issues/$AUTHOR/$REPO/$seq/${seq}.json"
			else
				until wget -q "https://api.github.com/repos/$AUTHOR/$REPO/issues/$seq" -O ${seq}.json; do
					# Detect rate-limit
					if [[ $? = 8 ]]; then
						printf "\e[1;91m%s\e[0m\n" "[GITHUB API RATE-LIMIT DETECTED]"
						# AUTO VPN SWITCH COMMAND
						if [[ $VPN_COMMAND && ${VPN_COMMAND[*]} != "my_vpn --connect --random" ]]; then
							${VPN_COMMAND[@]}
						fi
					fi
					echo "retrying: https://api.github.com/repos/$AUTHOR/$REPO/issues/$seq"
					sleep 1
				done
			fi
			# /comments
	        if [[ -e "$BUILD_DIRECTORY/$AUTHOR/$REPO/$seq/comments" ]]; then
	            printf "\e[1;93m%s\e[0m%s\n" "[FILE FOUND, SKIPPING ${NUM_NOW}/${NUM_MAX}] " "monero-archive-${BUILD_UUID}/github_issues/$AUTHOR/$REPO/$seq/comments"
			else
				until wget -q "https://api.github.com/repos/$AUTHOR/$REPO/issues/$seq/comments"; do
					# Detect rate-limit
					if [[ $? = 8 ]]; then
						printf "\e[1;91m%s\e[0m\n" "[GITHUB API RATE-LIMIT DETECTED]"
						# AUTO VPN SWITCH COMMAND
						if [[ $VPN_COMMAND && ${VPN_COMMAND[*]} != "my_vpn --connect --random" ]]; then
							${VPN_COMMAND[@]}
						fi
					fi
					echo "retrying: https://api.github.com/repos/$AUTHOR/$REPO/issues/$seq/comments"
					sleep 1
				done
			fi
			# /timeline
	        if [[ -e "$BUILD_DIRECTORY/$AUTHOR/$REPO/$seq/timeline" ]]; then
	            printf "\e[1;93m%s\e[0m%s\n" "[FILE FOUND, SKIPPING ${NUM_NOW}/${NUM_MAX}] " "monero-archive-${BUILD_UUID}/github_issues/$AUTHOR/$REPO/$seq/timeline"
			else
				until wget -q "https://api.github.com/repos/$AUTHOR/$REPO/issues/$seq/timeline"; do
					# Detect rate-limit
					if [[ $? = 8 ]]; then
						printf "\e[1;91m%s\e[0m\n" "[GITHUB API RATE-LIMIT DETECTED]"
						# AUTO VPN SWITCH COMMAND
						if [[ $VPN_COMMAND && ${VPN_COMMAND[*]} != "my_vpn --connect --random" ]]; then
							${VPN_COMMAND[@]}
						fi
					fi
					echo "retrying: https://api.github.com/repos/$AUTHOR/$REPO/issues/$seq/timeline"
					sleep 1
				done
			fi
			# /html
	        if [[ -e "$BUILD_DIRECTORY/$AUTHOR/$REPO/$seq/${seq}.html" ]]; then
	            printf "\e[1;93m%s\e[0m%s\n" "[FILE FOUND, SKIPPING ${NUM_NOW}/${NUM_MAX}] " "monero-archive-${BUILD_UUID}/github_issues/$AUTHOR/$REPO/$seq/${seq}.html"
			else
				until wget -q "https://github.com/$AUTHOR/$REPO/issues/$seq" -O ${seq}.html; do
					# Detect rate-limit
					if [[ $? = 8 ]]; then
						printf "\e[1;91m%s\e[0m\n" "[GITHUB API RATE-LIMIT DETECTED]"
						# AUTO VPN SWITCH COMMAND
						if [[ $VPN_COMMAND && ${VPN_COMMAND[*]} != "my_vpn --connect --random" ]]; then
							${VPN_COMMAND[@]}
						fi
					fi
					echo "retrying: https://github.com/$AUTHOR/$REPO/issues/$seq"
					sleep 1
				done
			fi
		done
		# Increment current repo number
		((NUM_NOW++))
	fi
done

# End message
printf "\e[1;92m[monero-archive] \e[1;97m%s\e[0m\n" "github_metadata.sh done!"
