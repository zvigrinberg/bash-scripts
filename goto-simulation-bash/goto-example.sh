# Simulation of goto command using 'Here' Document

#!/bin/bash

shopt -s expand_aliases
if [ -n "$DEBUG" ] ; then
  alias goto="cat >/dev/null <<$2"
else
  alias goto=":"
fi

goto '#GOTO1' 


echo "Wont run this"

#GOTO1

echo "Run this"

goto '#GOTO2'

echo "Wont run this either"

#GOTO2

echo "End!!"
