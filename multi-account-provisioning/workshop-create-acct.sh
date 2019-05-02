#!/bin/bash
for ((c=7; c<=30; c++))
do
   aws organizations create-account --email hubertc+workshop$c@amazon.com --account-name "Workshop Account $c"
   sleep 2
done