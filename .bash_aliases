directory=~/bashrc

source_alias() {
  __file=$1
  echo $0: source $__file
  source $__file
}

echo
echo
echo $0: sourcing custom bashrc files in $directory
for file in $(find ~/bashrc -type d -name .git -prune -o -type f -name .bash_aliases -prune -o -type f -name hud -prune -o -type f -print); do
  source_alias $file
done
source_alias $directory/hud
