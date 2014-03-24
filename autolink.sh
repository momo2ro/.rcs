#!/bin/sh

FILES=`ls |grep ^_ |sed -e s/^_//g`

for FILE in $FILES; do
	if [ -e $HOME/.$FILE ];then
		rm $HOME/.$FILE
	fi
done

echo "$FILES\n" |xargs -i -t ln -s $HOME/dotfiles/_{} $HOME/.{}
