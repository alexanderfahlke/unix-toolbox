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

unset -f git_list_deleted_files

function git_list_deleted_files() {
    local OPTIND FLAG a

    while getopts ":a:h" FLAG; do
        case $FLAG in
            a)  # all files deleted by <author>
                OPT_A=$OPTARG
                git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --diff-filter=D --author=$OPT_A --summary
                return 0
                ;;
            h)  # show help
                echo "usage: git_list_deleted_files            # get all deleted files"
                echo "       git_list_deleted_files .          # get all deleted files in current cwd"
                echo "       git_list_deleted_files -a author  # get all deleted files by author"
                return 0
                ;;
            \?) # unrecognized option
                echo "Option -${BOLD}$OPTARG${NORM} not allowed."
                return 2
                ;;
        esac
    done

    # all deleted files ever
    if [[ "$#" -ne 1 ]]; then
        git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --diff-filter=D --summary
        return 0
    fi

    # all deleted files in cwd
    if [[ "${1}" == "." ]]; then
        echo "."
        git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --diff-filter=D --summary .
        return 0
    fi
}
