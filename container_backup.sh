#!/bin/bash

backup_dir="$HOME/backups"
#archive_name="$id+$(date).tar
if [[ -d $backup_dir ]]; then
	echo "Directory exists, skipping"
else
	mkdir -vp $backup_dir
fi
for id in $(podman ps -q); do
	is_active=$(podman inspect "$id" | grep -i "source" | awk -F '"' '{print $4}')

	#archive_name="$id_$date.tar"
	if [[ $is_active ]]; then
		
		archive_name="$id.tar"
		#cd $is_active
		tar -cf "$backup_dir/$archive_name" -C "$is_active" .
		echo "backed up $id to $backup_dir/$archive_name"
	else
		echo "Volume not found for" $id
	fi
done
