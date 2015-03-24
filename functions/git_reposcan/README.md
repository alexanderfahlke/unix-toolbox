# git_reposcan

# About

This tool scans the current directory for git repositories and prints out all branches for each found repository.

# Usage

### One time usage

Simply just ```source``` the file ```git_reposcan.sh``` and run the function ```git_reposcan```.

    $ source ~/git_reposcan.sh
    $ git_reposcan
    -- puppet-nagios-nrpe --
    * fix-broken-debian6-nrpe-init
      master
      remotes/origin/HEAD -> origin/master
      remotes/origin/fix-broken-debian6-nrpe-init
      remotes/origin/master

    -- puppet-bamboo_agent --
    * add-INIT-INFO-to-init-script
      master
      remotes/origin/HEAD -> origin/master
      remotes/origin/add-INIT-INFO-to-init-script
      remotes/origin/master



### Everyday usage

- create a directory named ```.functions``` in your home directory
- copy ```git_reposcan.sh``` into this directory
- let ```.bash_profile``` source all files in ```$HOME/.functions``` everytime you login


Contents of ```$HOME```

    $ ls -la $HOME
    ...
    0 drwxr-x---   2 alexanderfahlke  alexanderfahlke  4096 Mar 24 15:37 .functions
    ...

Contents of ```$HOME/.functions```

    $ ls -la $HOME/.functions
    ...
    -rw-r-----   1 alexanderfahlke  alexanderfahlke   956 Mar 24 15:37 git_reposcan.sh
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
