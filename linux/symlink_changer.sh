# !/usr/bin/sh

SRC_DIR=$1

LINK_NAMES=( $(find ${SRC_DIR} -type l -exec sh -c "file -b {} | grep -q ^broken" \; -print) )

for (( i=0; i<${#LINK_NAMES[@]}; i++ ))
do
	link_name=${LINK_NAMES[i]}
	link_target=$(readlink -m ${link_name})
	# printf "%s points to %s \n" "${link_name}" "${link_target}"
	new_link_target=$(sed -r 's/(.*)\/arogowiec\/(.*)/\1\/inv\/\2/' <<< ${link_target})
	printf "[%s] changing to %s\n\n" "${link_name}" "${new_link_target}"
	ln -sfn ${new_link_target} ${link_name}
done

# | sed -r 's/(.*)\/arogowiec\/(.*)/\1\/inv\/\2/'

