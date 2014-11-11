pwd-to-clipboard
================

# About

This tool creates an alias for ```pwd``` that will copy the output of ```pwd``` to your clipboard and show the output in **stdout** as usual.
I use this almost everyday to quickly copy the current directory I'm in for documentation or opening directories and their files in editors that do not run on a shell.
Note: Any existing alias for ```pwd``` will be **unaliased**.

Currently it tries this with the following tools of which at least one should be installed and available in your ```PATH```:

- [```xclip```](http://linux.die.net/man/1/xclip "man page xclip")
- [```xsel```](http://linux.die.net/man/1/xsel "man page xsel")
- [```pbcopy```](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/pbcopy.1.html "man page pbcopy")

If none of the tools are present, there will be no alias created for ```pwd```.

# Usage

### One time use

Simply just ```source``` the file ```pwd-to-clipboard``` and run the function ```pwd-to-clipboard```.

	$ source ~/pwd-to-clipboard
	$ pwd-to-clipboard
	$ pwd
	/home/alexanderfahlke # this now get's also copied to your clipboard

### Everyday usage

- one of the following
 - copy ```pwd-to-clipboard``` into the directory of your choice
 - copy the function itself into a **functions-file** (I personally have a file ```.functions``` in my ```$HOME``` )
- let ```.bash_profile``` source the file ```$HOME/.functions```
- let ```.bash_profile``` run the function ```pwd-to-clipboard``` everytime you login

In ```$HOME/.bash_profile```

	...
	# Load the additional dotfiles
	# ~/.path can be used to extend $PATH.
	for file in ~/.{path,functions,aliases}; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file"
	done
	unset file
	...

In ```$HOME/.aliases```

	...
	# copy the output of pwd into the clipboard
	pwd-to-clipboard
	...
