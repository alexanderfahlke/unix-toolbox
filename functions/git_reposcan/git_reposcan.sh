#   Copyright 2015 Alexander Fahlke
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

unset -f git_reposcan

function git_reposcan() {
	GITBASEDIRECTORY=$(pwd)

	# short circuit if already in a git repository
	git symbolic-ref -q HEAD > /dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		echo "-- ${GITBASEDIRECTORY##*/} --"
		git branch -a
		echo
		return
	fi

	# get branches from all subdirs that are a git repository
	find -L "${GITBASEDIRECTORY}" -maxdepth 1 -mindepth 1 -type d -print0 | while read -d $'\0' REPOSITORY; do
		cd "${REPOSITORY}"

		git symbolic-ref -q HEAD > /dev/null 2>&1
		if [[ $? -eq 0 ]]; then
			echo "-- ${REPOSITORY##*/} --"
			git branch -a
			echo
		fi
	done

	cd "${GITBASEDIRECTORY}"
}
