#!/system/bin/sh

# Command to clear the contents of the custom cache folder
# Using 'rm -rf .../*' is a quick way to remove folder contents

# without deleting the folder itself.
su -c cleaner

# Clear main cache
rm -rf /data/data/com.google.android.gms/cache/*

rm -rf /data/data/com.google.android.gms/code_cache/*

rm -rf /data/system/dropbox/*

rm -rf /data/tombstones/*

rm -rf /data/adb/modules/BetterKnownInstalled/backup/*

rm -rf /data/anr/*

rm -rf /storage/self/primary/Android/data/com.hiby.music/files/AlbumArt/*

echo "GMS cache has been cleared."

echo "Finding and disabling iostats for all block devices..."

# Loop through each block device in /sys/class/block
# (e.g., mmcblk0, sda, dm-0, etc.)
for device in /sys/class/block/*; do
    
    # Define the path to the iostats file inside the queue folder
    iostats_file="$device/queue/iostats"
    
    # Check if the file exists and is writable
    if [ -w "$iostats_file" ]; then
        # If it exists, write '0' to disable it
        echo 0 > "$iostats_file"
        echo "   -> iostats disabled for: $(basename $device)"
    fi
done

echo "Done."

#Command for late start service if not working you can use service.d or kernel manager support.sh.
su -c zsm -n