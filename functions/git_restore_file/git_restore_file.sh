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

unset -f git_restore_file

function git_restore_file() {
    commit=${1}
    filename=${2}

    if [[ -z "${commit}" ]]; then
        echo "got no commit hash, exiting..."
        return 1
    fi

    if [[ -z "${filename}" ]]; then
        echo "got no file to restore, exiting..."
        return 2
    fi

    git checkout "${commit}"~1 "${filename}"
}

