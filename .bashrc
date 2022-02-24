#!/bin/bash

#################
##
## .bashrc adapted a bit for github codespaces / msoft web-vscode
##


export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced

#######################################
# PATH and other env VARIABLES
# export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="code"
# export BASHRC_SRC="$HOME/.bashrc"
# export LOCALIP=$(ipconfig getifaddr en0)


#######################################
# commands and aliases
# http://stackoverflow.com/a/3572628/957984
#
# https://devhints.io/bash
lsa() { for i in "$@"; do ls -d -1 "$PWD/$i"; done }
alias pyserv="python -m SimpleHTTPServer 8080"

grepkill() {
	if [[ -n $2 ]]; then
		# for finding bash parent PID, use $PPID
		pids=$(ps aux | grep $1 | grep $2 | awk '{print $2}')
	else
		pids=$(ps aux | grep $1 | awk '{print $2}')
	fi
	pids=$(echo "$pids" | tr "\012" " ")
	echo "killing bashes; pids:"
	echo $pids
	kill $(echo "$pids")
}
alias bashkill="grepkill /usr/local/bin/bash"
#--------------------------------------
# commands and aliases - from dotfiles
#   https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"
# alias bashrc="source $HOME/.bashrc"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias ll="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# IP addresses
# -- TODO need dig
# alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# -- TODO need ipconfig
# alias localip="ipconfig getifaddr en0"
# alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
# -- TODO needs pcregrep
# alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Recursively delete `.DS_Store` files
alias cleanup_DS_files="find . -type f -name '*.DS_Store' -ls -delete"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Print each PATH entry on a separate line
alias paths='echo -e ${PATH//:/\\n} && echo ""'

#
# end dotfiles aliases
#--------------------------------------//

############################################
# get colors in man pages (colorize less)
#
# https://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
# http://www.cyberciti.biz/faq/linux-unix-colored-man-pages-with-less-command/

# export LESS_TERMCAP_mb='\E[01;31m'       # begin blinking
# export LESS_TERMCAP_md='\E[01;38;5;74m'  # begin bold
# export LESS_TERMCAP_me='\E[0m'           # end mode
# export LESS_TERMCAP_se='\E[0m'           # end standout-mode
# export LESS_TERMCAP_so='\E[38;5;246m'    # begin standout-mode - info box
# export LESS_TERMCAP_ue='\E[0m'           # end underline
# export LESS_TERMCAP_us='\E[04;38;5;146m' # begin underline



############################################
# Modified from emilis bash prompt script
# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1
#
# Modified for Mac OS X by
# @corndogcomputer


###########################################
# Fill with minuses
# (this is recalculated every time the prompt is shown in function prompt_command):
fill="--- "

# note: The color is specified as follows. To colorized a section of text, you use the opening tag:
#     \[\033[COLORm\]
# Then to “close” that color tag, you use:
#     [\033[00m\]
# Where 00m indicates to clear that color.

# if [ "$?" -gt "0" ]; then return_style='\e[41m\]'; else return_style=$status_style; fi # red background if last status > 0
# if [ $? -gt 0 ]; then return_style=$reset_style'\e[41m\]'; else return_style=$prompt_style; fi # red background if last status > 0
# return_style=$status_style
# status=$(if [[ $? -gt 0 ]]; then printf "$reset_style'\e[41m\]'"; fi)


# status_width=$(( ($? >= 100 ? 1 : 0) + ($? >= 10 ? 1 : 0) + ($? >= 1 ? 1 : 0) ))
# Prompt variable:
# PS1="$status_style"'$fill \t '`if [[ $? -gt 0 ]]; then printf "\[\033[01;31m\]:("; else printf "\[\033[01;32m\]$?"; fi`'\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\u:\W\$'"$command_style "
# PS1="$status_style"'$fill \t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\u:\W\$'"$command_style "

# Reset color for command output
# (this one is invoked every time before a command is executed):
trap 'echo -ne "\033[00m"' DEBUG
function prompt_command {
		local EXIT="$?" # store current exit code
		local status_width=$(( ($EXIT >= 100 ? 1 : 0) + ($EXIT >= 10 ? 1 : 0) + 4 ))

		# define some colors
		local RESET='\[\033[00m\]'   							# reset_style='\[\033[00m\]'
		local STATUS=$RESET'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
		local prompt_style=$RESET
		local command_style=$RESET'\[\033[1;29m\]' # bold black
    # local RESET='\[\e[0m\]'
    local RED='\[\e[1;31m\]'
    local GREEN='\[\e[1;32m\]'
    local BOLD_GRAY='\[\e[1;30m\]'
		local fill="--- "

		# create a $fill of all screen width minus the time string and a space:
		# let fillsize=${COLUMNS}-9
		let fillsize=${COLUMNS}-9-${status_width}
		fill=""
		while [ "$fillsize" -gt "0" ]
		do
		    fill="-${fill}" # fill with underscores to work on
		    let fillsize=${fillsize}-1
		done

		PS1=""
		PS1+="$STATUS""$fill \t "

		if [[ $EXIT -eq 0 ]]; then
				# PS1+="$[${GREEN}️${EXIT}${RESET}]\n"      # Add green for success
				PS1+="${STATUS}[${GREEN}️${EXIT}${STATUS}]\n\n"      # Add green for success
		else
				PS1+="${STATUS}[${RED}${EXIT}${STATUS}]\n\n" # Add red if exit code non 0
		fi

		PS1+="$prompt_style"'${debian_chroot:+($debian_chroot)}\u:\W\$'"$command_style "

		# If this is an xterm set the title to user@host:dir
		case "$TERM" in
		xterm*|rxvt*)
		bname=`basename "${PWD/$HOME/~}"`
		echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME} ${PWD/$HOME/~}\007"
		;;
		*)
		;;
		esac
}
PROMPT_COMMAND=prompt_command


###########################################
# additions from dotfiles repo; note reversing of
# .bash_profile <-> .bashrc sourcing order
#   https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
#
# see for descriptions of each `shopt` option
#   https://wiki.bash-hackers.org/internals/shell_options
#   use 'shopt -s|-u' to get all enabled|disabled options
#
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Make Tab autocomplete regardless of filename case
set completion-ignore-case on

# List all matches in case multiple possible completions are possible
set show-all-if-ambiguous on

# Immediately add a trailing slash when autocompleting symlinks to directories
set mark-symlinked-directories on

# Use the text that has already been typed as the prefix for searching through
# commands (i.e. more intelligent Up/Down behavior)
# "\e[B": history-search-forward
# "\e[A": history-search-backward

# Do not autocomplete hidden files unless the pattern explicitly begins with a dot
set match-hidden-files off

# Show all autocomplete results at once
set page-completions off

# If there are more than 100 possible completions for a word, ask to show them all
set completion-query-items 100

# Show extra file information when completing, like `ls -F` does
set visible-stats on

# Be more intelligent when autocompleting by also looking at the text after
# the cursor. For example, when the current line is "cd ~/src/mozil", and
# the cursor is on the "z", pressing Tab will not autocomplete it to "cd
# ~/src/mozillail", but to "cd ~/src/mozilla". (This is supported by the
# Readline used by Bash 4.)
set skip-completed-text on

# Allow UTF-8 input and output, instead of showing stuff like $'\0123\0456'
set input-meta on
set output-meta on
set convert-meta off

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;
