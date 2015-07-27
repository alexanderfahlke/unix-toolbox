#!/usr/bin/env bash

# Copyright 2015 Alexander Fahlke
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

unset -f get_swap

function get_swap() {
	# ask for sudo credentials upfront (needed for grepping the smaps-files)
	sudo -v

	# summarize all swap used by PID
	for PID in $(find /proc/ -maxdepth 1 -type d | grep -oP "[0-9]+"); do
		PROGNAME=$(ps -p ${PID} -o comm --no-headers)
		for SWAP in $(sudo grep 'Swap' /proc/${PID}/smaps 2> /dev/null | awk '{print $2}'); do
			let SUM_PID=$((SUM_PID+SWAP))
		done
		if [[ $SUM_PID -gt 0 ]]; then
			printf "PID = %-6s %-20s %10s kb\n" "${PID}" "${PROGNAME}" "${SUM_PID}"
		fi
		let SUM_OVERALL=$((SUM_OVERALL+SUM_PID))
		SUM_PID=0
	done
	echo -e "\nOverall swap usage: ${SUM_OVERALL} kb (~$((SUM_OVERALL/1024)) MB)"

	# invalidates the user's cached credentials
	sudo -k
}
