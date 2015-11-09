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

unset -f __git_set_user_in_current_repository
unset -f git_set_environment

function __git_set_user_in_current_repository() {
	git config user.name "${1}"
	git config user.email "${2}"
}

function git_set_environment() {
  case "${1}" in
    "")
      echo >&2 "error: no environment selected" ;;
    --gfk)
      __git_set_user_in_current_repository "Alexander Fahlke" "alexander.fahlke@gfk.com" ;;
    --github)
      __git_set_user_in_current_repository "Alexander Fahlke" "alexander.fahlke@gmail.com" ;;
    *)
      echo >&2 "error: unknown environment: ${1}" ;;
  esac
}
