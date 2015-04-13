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

DUMPFILE_NAME='/tmp/dump.pcap'
DUMPFILE_MAX_SIZE='100' # maximum file size in MB
DUMPFILE_MAX_COUNT='10' # maximum filecount
INTERFACE='eth0' # interface name
PACKET_CAPTURE_MAX_SIZE='96' # max packet capture size in bytes
TCPDUMP_EXPRESSION='tcp port 80 and host hadooppowered.com'

# check if script is run as root
if [[ "${EUID}" -ne 0 ]]; then
	echo "Must be run as root, exiting..."
	exit 1
fi

# check if enough disk capacity is remaining
DUMPFILE_BASEDIR=$(dirname "${DUMPFILE_NAME}")
REMAINING_DISK_CAPACITY=$(df -m "${DUMPFILE_BASEDIR}" | tail -n 1 | awk '{print $4}')
if [[ $((${DUMPFILE_MAX_SIZE} * ${DUMPFILE_MAX_COUNT})) -gt ${REMAINING_DISK_CAPACITY} ]]; then
	echo "Not enough space on disk to capture $((${DUMPFILE_MAX_SIZE} * ${DUMPFILE_MAX_COUNT})) MB of pcap files."
	exit 2
fi

# run tcpdump
tcpdump \
	-n \
	-w "${DUMPFILE_NAME}" \
	-C "${DUMPFILE_MAX_SIZE}" \
	-W "${DUMPFILE_MAX_COUNT}" \
	-i "${INTERFACE}" \
	-s "${PACKET_CAPTURE_MAX_SIZE}" \
	"${TCPDUMP_EXPRESSION}"
