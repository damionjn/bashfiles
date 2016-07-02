#!/bin/bash

#-----------------------------------------------------------------------------
# Functions
#-----------------------------------------------------------------------------

# Notice title
notice() { printf "$1"; }

backup() {
  mkdir -p $backupdir

  local files=( $(ls -a) )
  for file in "${files[@]}"; do
    in_array $file "${excluded[@]}" || cp -Rf "$HOME/$file" "$backupdir/$file"
  done
}

install() {
  local files=( $(ls -a) )
  for file in "${files[@]}"; do
    in_array $file "${excluded[@]}"
    should_install=$?
    if [ $should_install -gt 0 ]; then
      [ -d "$HOME/$file" ] && rm -rf "$HOME/$file"
      cp -Rf "$file" "$HOME/$file"
    fi
  done
  sudo apt-get update; sudo apt-get install -yq tree git vim tmux
}

in_array() {
  local hay needle=$1
  shift
  for hay; do
    [[ $hay == $needle ]] && return 0
  done
  return 1
}


#-----------------------------------------------------------------------------
# Initialize
#-----------------------------------------------------------------------------

backupdir="$HOME/.bashfiles-backup/$(date "+%Y%m%d%H%M.%S")"
excluded=(. .. .git .gitignore .gitmodules bootstrap.sh Gemfile Gemfile.lock Rakefile README.md)


#-----------------------------------------------------------------------------
# Install
#-----------------------------------------------------------------------------

# Assumes $HOME/.dotfiles is *ours*
if [ -d $HOME/.bashfiles ]; then
  pushd $HOME/.bashfiles

  # Backup
  notice "Backup up old files ($backupdir)...\n"
  backup

  # Install
  notice "Installing...\n"
  install

  # Clean up z backups
  rm -rf ~/.z.*

else
  # Clone Repo
  notice "Downloading...\n"
  git clone --recursive git://github.com/damionvega/bashfiles.git $HOME/.bashfiles

  pushd $HOME/.dotfiles

  # Backup
  notice "Backup up old files ($backupdir)...\n"
  backup

  # Install
  notice "Installing...\n"
  install
fi


#-----------------------------------------------------------------------------
# Finished
#-----------------------------------------------------------------------------

popd
notice "\nFinished! The following packages have been installed: \n- tree\n- git\n- vim\n- tmux\n"
exec $SHELL -l

