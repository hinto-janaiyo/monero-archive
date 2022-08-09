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

# This script lists and formats all
# the keys found in /monero-archive/pgp/
#
# It formats it into markdown like so:
#
# * KEY_OWNER `KEY_FINGERPRINT`
# * KEY_OWNER2 `KEY_FINGERPRINT2`
#
# etc, etc...

# Error handling
set -e
trap 'ERR_CODE=$?; printf "\e[1;91m%s\e[0m%s\n" "[ERROR CAUGHT] " "$BASH_COMMAND"; exit $ERR_CODE' ERR

# Check for directory
if [[ $PWD = */monero-archive/utils ]]; then
	cd ../pgp
elif [[ $PWD = */monero-archive ]]; then
	cd pgp
fi

# List/format keys
list_and_format_keys() {
	for i in *; do
		printf "%s\n" "* ${i/.asc} \`$(gpg --show-keys "$i" | grep -o "[[:alnum:]]\{40\}$")\`"
	done
}

# If xclip is detected, auto-copy to clipboard
# else, just print to standard out.
KEY_LIST=$(list_and_format_keys)
if hash xclip; then
	printf "%s\n" "$KEY_LIST" | xclip -selection clipboard
	printf "%s\n" "xclip detected, copied to clipboard"
else
	printf "%s\n" "$KEY_LIST"
fi
