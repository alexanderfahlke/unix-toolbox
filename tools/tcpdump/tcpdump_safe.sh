#!/usr/bin/env bash

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

DUMPFILE='/tmp/tcpdumpfile.pdump'
TCPDUMP_PARAMS="-w ${DUMPFILE} -s96 -i eth0 tcp port 80 and host hadooppowered.com"
DUMPSIZE_MAX_BYTES="$((1024 * 1024 * 100))" # 100MB

DATEFORMAT="+%Y-%m-%d%t%H:%M:%S"

if [[ -f ${DUMPFILE} ]]; then
	echo "The dumpfile \"${DUMPFILE}\" already exists, exiting..."
	exit 1
fi

if [[ "${EUID}" -ne 0 ]]; then
	echo "Must be run as root, exiting..."
	exit 2
fi

nohup tcpdump ${TCPDUMP_PARAMS} > /dev/null 2>&1 & PID=$!

while true; do
	FILESIZE=$(stat -c '%s' "${DUMPFILE}" 2> /dev/null)
	echo -e "$(date ${DATEFORMAT})\t${FILESIZE}"
	if [[ ! -z ${FILESIZE} ]] && [[ ${FILESIZE} -gt ${DUMPSIZE_MAX_BYTES} ]]; then
		echo "Quitting tcpdump ${PID}. Maximum dump filesize reached."
		/usr/bin/kill ${PID}
		break
	fi
	sleep 5
done
