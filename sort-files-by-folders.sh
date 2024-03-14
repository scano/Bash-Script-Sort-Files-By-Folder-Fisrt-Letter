#!/bin/bash

if [[ $# -eq 0 ]] ;  then
	echo "Need source folder parameter.\nEx: /Full/Path/To_Folder_With_Files_To_Sort"
	exit 0
fi


OIFS="$IFS"
IFS=$'\n'

uppercase_folders=0
source_folder="$1"

echo "Uppercase target folders? (Ex: A, B, C, ...)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) 
			uppercase_folders=1
			break;;
        No | * ) break;;
    esac
done

for file in $(find $source_folder -type f -name '*.*' -maxdepth 1)
do	
	filename=$(basename "$file")

	#.s. firts char
	target_folder=${filename:0:1}
	if [ $uppercase_folders -eq 1 ]
	then
		target_folder=$(echo "$target_folder" | awk '{print toupper($0)}')
	else
		target_folder=$(echo "$target_folder" | awk '{print tolower($0)}')
	fi

	final_folder="$source_folder/$target_folder"
	echo "$file to $final_folder"

	mkdir -p "$final_folder"
	mv "$file" "$final_folder"
done

IFS="$OIFS"
