# git_list_deleted_files

# About

This tool lists deleted files in the current repository. It can list **all files in the current repository**, **all files in the current directory** or **all files by author**.

# Usage

### One time usage

Simply just ```source``` the file ```git_list_deleted_files.sh``` and run the function ```git_list_deleted_files```.

    $ source ~/git_list_deleted_files.sh
    $ git_list_deleted_files -a fahlke
    6e1b473 - added sh-extension to the scripts (3 months ago) <Alexander Fahlke>
     delete mode 100644 functions/digmany/digmany
     delete mode 100644 functions/pwd_to_clipboard/pwd_to_clipboard

    c95a074 - moved pwd-to-clipboard to pwd_to_clipboard (3 months ago) <Alexander Fahlke>
     delete mode 100644 functions/pwd-to-clipboard/README.md
     delete mode 100644 functions/pwd-to-clipboard/pwd-to-clipboard

    81a6b58 - removed ssh-tunnel-thing (3 months ago) <Alexander Fahlke>
     delete mode 100644 ssh-tunnler/.ssh-tunnler
     delete mode 100755 ssh-tunnler/ssh-tunnler


### Everyday usage

- create a directory named ```.functions``` in your home directory
- copy ```git_list_deleted_files.sh``` into this directory
- let ```.bash_profile``` source all files in ```$HOME/.functions``` everytime you login


Contents of ```$HOME```

    $ ls -la $HOME
    ...
    0 drwxr-x---   2 alexanderfahlke  alexanderfahlke  4096 Jun 16 11:16 .functions
    ...

Contents of ```$HOME/.functions```

    $ ls -la $HOME/.functions
    ...
    -rw-r-----   1 alexanderfahlke  alexanderfahlke   2084 Jun 16 11:16 git_list_deleted_files.sh
    ...

Contents of ```$HOME/.bash_profile```

    ...
    if [[ -d $HOME/.functions ]]; then
      for func in $(find -L "${HOME}/.functions" -type f -and -not -name '.gitignore'); do
        [[ -r "$func" ]] && [[ -f "$func" ]] && source "$func"
      done
      unset func
    fi
    ...
