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

DUMPFILE_NAME='/tmp/dump.pcap' # filename
DUMPFILE_MAX_SIZE='1' # file site in MB
DUMPFILE_MAX_COUNT='2' # filecount
DUMPFILE_ROTATE_SECONDS='60' # rotate every x seconds
INTERFACE='en1' # interface
PACKET_CAPTURE_MAX_SIZE='96' # max packet capture size
TCPDUMP_COMMAND='tcp port 80 and host hadooppowered.com'

# filename is in the following form nameXXX.pcap
# check if the dumpfie already exists
#if [[ -f ${DUMPFILE_NAME%%} ]]; then
#	echo "The dumpfile \"${DUMPFILE_NAME}\" already exists, exiting..."
#	exit 1
#fi

# check if script is run as root
if [[ "${EUID}" -ne 0 ]]; then
	echo "Must be run as root, exiting..."
	exit 1
fi

nohup tcpdump \
	-n \
	-w ${DUMPFILE_NAME} \
	-C ${DUMPFILE_MAX_SIZE} \
	-W ${DUMPFILE_MAX_COUNT} \
	-G ${DUMPFILE_ROTATE_SECONDS} \
	-i ${INTERFACE} \
	-s ${PACKET_CAPTURE_MAX_SIZE} \
	${TCPDUMP_COMMAND} > /dev/null 2>&1 & PID=$!

#echo "tcpdump running as PID ${PID}"
