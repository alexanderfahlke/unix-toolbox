# digmany

# About

This tool creates a little helper function to support you when digging DNS records.

# Usage

### One time usage

Simply just ```source``` the file ```digmany``` and run the function ```digmany``` with any fqdn.

    $ source ~/digmany
    $ digmany hadooppowered.com
    A	54.231.13.244
    NS	ns-1703.awsdns-20.co.uk.
    NS	ns-79.awsdns-09.com.
    NS	ns-811.awsdns-37.net.
    NS	ns-1431.awsdns-50.org.
    SOA	ns-1703.awsdns-20.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
    MX	10 mx.redirect.domainoffensive.de.
    MX	20 mxfallback.redirect.domainoffensive.de.
    TXT	"v=spf1 mx mx:mx.redirect.domainoffensive.de mx:mxfallback.redirect.domainoffensive.de ~all"

### Everyday usage

- create a directory named ```.functions``` in your home directory
- copy ```digmany``` into this directory
- let ```.bash_profile``` source all files in ```$HOME/.functions``` everytime you login


Contents of ```$HOME```

    $ ls -la $HOME
    ...
    0 drwxr-x---   2 alexanderfahlke  alexanderfahlke  4096 Mar 10 19:32 .functions
    ...

Contents of ```$HOME/.functions```

    $ ls -la $HOME/.functions
    ...
    -rw-r-----   1 alexanderfahlke  alexanderfahlke   884 Mar 10 19:31 digmany
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
