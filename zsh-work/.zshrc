# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
ZSH_THEME="spaceship"
export SPACESHIP_DIR_TRUNC=0

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
plugins=(git autojump fzf ansible aws)

source $ZSH/oh-my-zsh.sh

export PATH=$HOME/.emacs.d/bin:$HOME/.local/bin:$HOME/bin:$HOME/.jenv/bin:/opt/atlassian-plugin-sdk/bin:$HOME/todo:$PATH
export EDITOR=vim

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
#eval "$(jenv init -)" #Loads jenv

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

alias notify="noti --banner --time --message"
alias notify-telegram="noti --banner --telegram --time --message"
STASH="$HOME/atlassian/bitbucket/bitbucket-server/"
alias bbs_es="docker run -it --rm -p 9200:9200 -p 7992:9300 -e "discovery.type=single-node" -e "xpack.security.enabled=false" docker.elastic.co/elasticsearch/elasticsearch:5.5.3"
alias bbdir="cd $STASH"
alias bbs_nuke_mirror_home="rm -rvf analytics-logs bin caches export lib log plugins tmp home.properties shared/config shared/data shared/plugins && mv shared/bitbucket.properties.bak shared/bitbucket.properties"
alias bbs_nuke_home="rm -rvf analytics-logs bin caches export log plugins tmp home.properties shared/config shared/data shared/plugins shared/search"
alias mii="notify 'Maven build done!' mvn install -DskipTests -Dskip.unit.tests=true -Dincrementalbuild.enabled=true -Dincrementalbuild.metrics.disabled=true -T2C"
alias miii="mii -DskipNpmInstall"
alias mci="notify 'Maven build done!' mvn clean && mii"
alias rand_sentence="shuf -n $[$RANDOM % 10] /usr/share/dict/words | tr '\n' ' '"
alias pshow="find ~/.password-store -type f | fzf | cut -f 5- -d /|sed 's/ /\\ /g'|sed 's/.gpg//g'| xargs -r pass show"
alias cal="cal --color"
alias ec="emacsclient --c"

alias t="topydo"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

function git_add_commit {
	if [[ -f $1 ]]; then
		echo "$(date): $(rand_sentence)" >> $1
	else
		echo "$(date): Making file $1" > $1
	fi
	git add $1
	git commit -m "Commit $1"
}

function git_create_branches {
	root=$(git symbolic-ref --short HEAD)
	echo "Root branch: $root"
	for i ({0..$1})
	do
		git checkout -b branch-$i
		echo "Created branch-$i"
		git_add_commit file-$i > /dev/null
		git checkout $root
	done
}

function is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

function gf() {
  is_in_git_repo &&
    git -c color.status=always status --short |
    fzf --height 40% -m --ansi --nth 2..,.. | awk '{print $2}'
}

function gb() {
  is_in_git_repo &&
    git branch -a -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 40% --ansi --multi --tac | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##'
}

function gt() {
  is_in_git_repo &&
    git tag --sort -version:refname |
    fzf --height 40% --multi
}

function gh() {
  is_in_git_repo &&
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph |
    fzf --height 40% --ansi --no-sort --reverse --multi | grep -o '[a-f0-9]\{7,\}'
}

function gr() {
  is_in_git_repo &&
    git remote -v | awk '{print $1 " " $2}' | uniq |
    fzf --height 40% --tac | awk '{print $1}'
}

#bind '"\er": redraw-current-line'
#bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
#bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
#bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
#bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
#bind '"\C-g\C-r": "$(gr)\e\C-e\er"'

export VIMCONFIG=~/.vim
export VIMDATA=~/.vim
export VISUAL=nvim
export DIRSTACKSIZE=10

# Use nvim!
alias vim=nvim
alias vi=nvim
alias clip='xclip -selection clipboard'

if [[ -f "${HOME}/.config/cloudtoken/bashrc_additions" ]]; then
    source "${HOME}/.config/cloudtoken/bashrc_additions"
fi

# Load pyenv into the shell by adding
eval "$(pyenv init -)"

# Load pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/csubraveti/.sdkman"
[[ -s "/home/csubraveti/.sdkman/bin/sdkman-init.sh" ]] && source "/home/csubraveti/.sdkman/bin/sdkman-init.sh"
