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

dumpfile_name='/tmp/dump.pcap'
dumpfile_max_size='100' # maximum file size in MB
dumpfile_max_count='10' # maximum filecount
interface='eth0' # interface name
packet_capture_max_size='96' # max packet capture size in bytes
tcpdump_expression='tcp port 80 and host hadooppowered.com'

# check if script is run as root
if [[ "${EUID}" -ne 0 ]]; then
	echo "Must be run as root, exiting..."
	exit 1
fi

# check if enough disk capacity is remaining
dumpfile_basedir=$(dirname "${dumpfile_name}")
remaining_disk_capacity=$(df -m "${dumpfile_basedir}" | tail -n 1 | awk '{print $4}')
if [[ $((${dumpfile_max_size} * ${dumpfile_max_count})) -gt ${remaining_disk_capacity} ]]; then
	echo "Not enough space on disk to capture $((${dumpfile_max_size} * ${dumpfile_max_count})) MB of pcap files."
	exit 2
fi

# run tcpdump
tcpdump \
	-n \
	-w "${dumpfile_name}" \
	-C "${dumpfile_max_size}" \
	-W "${dumpfile_max_count}" \
	-i "${interface}" \
	-s "${packet_capture_max_size}" \
	"${tcpdump_expression}"
