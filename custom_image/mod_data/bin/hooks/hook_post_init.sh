#!/bin/sh

# ---- TEMPLATE ----

# Hook for modifcation stuff right after
#          piratebox/bin/install  ... part2 
# is run.

if [ !  -f $1 ] ; then
  echo "Config-File $1 not found..."
  exit 255
fi

#Load config
. $1

# You can uncommend this line to see when hook is starting:
 echo "------------------ Running $0 ------------------"



if [ -f $WWW_FOLDER/content/index.* ] ; then
   echo "Content found, do nothing"
else
   echo "bringing some init files to $WWW_FOLDER/content if no index-file exists"
   SRC_FOLDER=$PIRATEBOX_FOLDER/src_content
   cp -vr $SRC_FOLDER/* $WWW_FOLDER/content/
fi
