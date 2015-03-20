pwd-to-clipboard
================

# About

This tool creates an alias for ```pwd``` that will copy the output of ```pwd``` to your clipboard and show the output in **stdout** as usual.
I use this almost everyday to quickly copy the current directory I'm in, for documentation or opening directories and their files in editors that do not run on a shell.
Note: Any existing alias for ```pwd``` will be **unaliased**.

It tries this with the following commandline tools of which at least one should be installed and available in your ```PATH```:

- [```xclip```](http://linux.die.net/man/1/xclip "man page xclip")
- [```xsel```](http://linux.die.net/man/1/xsel "man page xsel")
- [```pbcopy```](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/pbcopy.1.html "man page pbcopy")

**Note:** If none of the tools are present, there will be no alias created for ```pwd```.

#### Tested on
- OS X 10.9.x, 10.10.x

# Usage

### One time use

Simply just ```source``` the file ```pwd-to-clipboard```.

    $ source pwd-to-clipboard

    # check if the alias was created.
    $ alias pwd
    alias pwd='pwd && pwd | pbcopy'

    $ pwd
    /home/alexanderfahlke # this now get's also copied to your clipboard

### Everyday usage

- create a directory named ```.functions``` in your home directory
- copy ```pwd-to-clipboard``` into this directory
- let ```.bash_profile``` source all files in ```${HOME}/.functions``` everytime you login


Contents of ```${HOME}```

    $ ls -la ${HOME}
    ...
    0 drwxr-x---   3 alexanderfahlke  alexanderfahlke    102 12 Nov 09:01 .functions
    ...

Contents of ```${HOME}/.functions```

    $ ls -la ${HOME}/.functions
    ...
    -rw-r-----   1 alexanderfahlke  alexanderfahlke   971 12 Nov 08:44 pwd-to-clipboard
    ...

Contents of ```${HOME}/.bash_profile```

    ...
    if [[ -d "${HOME}/.functions" ]]; then
      for func in $(find "${HOME}/.functions" -type f); do
        [ -r "${func}" ] && [ -f "${func}" ] && source "${func}"
      done
      unset func
    fi
    ...
