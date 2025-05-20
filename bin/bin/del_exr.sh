#!/usr/bin/env bash

dropbox_uploader list | grep -iE "^ [F] .+.exr$" |
sed "s|^ [F] ||g" |
while read item
do
  drop_box_uploader delete "$item"
done
