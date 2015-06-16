# git_restore_file

# About

This tool restores a deleted file by its commit hash and filename.

# Usage

### One time usage

Simply just ```source``` the file ```git_restore_file.sh``` and run the function ```git_restore_file```.

    $ source ~/git_restore_file.sh
    $ git_restore 81a6b58 ssh-tunnler/ssh-tunnler


### Everyday usage

- create a directory named ```.functions``` in your home directory
- copy ```git_restore_file.sh``` into this directory
- let ```.bash_profile``` source all files in ```$HOME/.functions``` everytime you login


Contents of ```$HOME```

    $ ls -la $HOME
    ...
    0 drwxr-x---   2 alexanderfahlke  alexanderfahlke  4096 Jun 16 11:19 .functions
    ...

Contents of ```$HOME/.functions```

    $ ls -la $HOME/.functions
    ...
    -rw-r-----   1 alexanderfahlke  alexanderfahlke   947 Jun 16 11:19 git_restore_file.sh
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
