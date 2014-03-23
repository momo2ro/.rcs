#!/bin/sh

ls |grep ^_ |sed -e s/^_//g |xargs -i -t ln -s ~/dotfiles/_{} ~/.{}
