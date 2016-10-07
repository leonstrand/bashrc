# do nothing for passive shell
[[ $- != *i* ]] && return

directory=~/bashrc

source_alias() {
  __file=$1
  echo $0: source $__file
  source $__file
}

echo
echo
files='
.vimrc
.toprc
'
for file in $files; do
if [ -f ~/$file ]; then
  if ! diff ~/$file ~/bashrc/$file 1>/dev/null; then
    echo
    echo
    echo $0: ~/$file differs from default
    echo $0: backing up ~/$file
    command='mv -v ~/'$file' ~/'$file'.backup.'$(sha1sum ~/$file | awk '{print $1}')
    echo $command
    eval $command
    command='cp -v ~/bashrc/'$file' ~/'$file
    echo $command
    eval $command
  fi
else
  echo
  echo
  echo $0: ~/$file does not exist, copying default
  command='cp -v ~/bashrc/$file ~/$file'
  echo $command
  eval $command
fi
done

echo
echo
echo $0: sourcing custom bashrc files in $directory
for file in $(find ~/bashrc -type d -name .git -prune -o -type d -name utility -prune -o -type f -name .bash_aliases -prune -o -type f -name hud -prune -o -type f -name .vimrc -prune -o -type f -name .toprc -prune -o -type f -print); do
  source_alias $file
done
source_alias $directory/hud
