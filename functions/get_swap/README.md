# get_swap

# About

This tool lists all swap used by every running process in the system. You need root permissions to use this.

# Usage

### One time usage

Simply just ```source``` the file ```get_swap.sh``` and run the function ```get_swap```.

    $ source ~/get_swap.sh
    $ get_swap

### Everyday usage

- create a directory named ```.functions``` in your home directory
- copy ```get_swap.sh``` into this directory
- let ```.bash_profile``` source all files in ```$HOME/.functions``` everytime you login


Contents of ```$HOME```

    $ ls -la $HOME
    ...
    0 drwxr-x---   2 alexanderfahlke  alexanderfahlke  4096 Jul 27 10:28
    ...

Contents of ```$HOME/.functions```

    $ ls -la $HOME/.functions
    ...
    -rw-r-----   1 alexanderfahlke  alexanderfahlke   1317 Jul 27 10:28 get_swap.sh
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
