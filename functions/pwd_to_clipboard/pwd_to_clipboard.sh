#   Copyright 2014 Alexander Fahlke
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

unset -f pwd_to_clipboard

function pwd_to_clipboard() {
	if [[ -n $(which 'xclip') ]]; then
		clipboard='xclip -i -selection clipboard'
	elif [[ -n $(which 'xsel') ]]; then
		clipboard='xsel -i --clipboard'
	elif [[ -n $(which 'pbcopy') ]]; then
		clipboard='pbcopy'
	fi

	[[ -n "${clipboard}" ]] && unalias 'pwd' 2> /dev/null
	alias pwd="pwd && pwd | ${clipboard}"
}

pwd_to_clipboard # create the pwd-alias
unset -f pwd_to_clipboard
