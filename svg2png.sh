#!/usr/bin/env sh

MINPARAMS=10

if [ -n "$1" ]
 # Tested variable is quoted.
then
echo "Parameter #1 is $1"
 # Need quotes to escape #
fi

if [ -n "${10}" ] # Parameters > $9 must be enclosed in {brackets}.
then
echo "Parameter #10 is ${10}"
fi
echo "-----------------------------------"
echo "All the command-line parameters are: "$*""
if [ $# -lt "$MINPARAMS" ]
then
echo
echo "This script needs at least $MINPARAMS command-line arguments!"
fi


for file in *.svg
do
     /usr/bin/inkscape -z -f "${file}" -w 1080 -e "${file%svg}png"
done
