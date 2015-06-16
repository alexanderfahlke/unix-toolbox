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

unset -f digmany

function digmany() {
	domain="${1}"
	if [[ -z "${domain}" ]]; then
		echo "got no domain to query, exiting..."
		return 1
	fi

	for record_type in A AAAA NS MD MF CNAME SOA MB MG MR NULL WKS PTR HINFO MINFO MX TXT; do
		record=$(dig +short "${domain}" "${record_type}")
		if [[ ! -z "${record}" ]]; then
			echo "${record}" | while read line; do
				echo -e "${record_type}\t${line}"
			done
		fi
	done
}
