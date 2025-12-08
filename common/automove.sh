#!/system/bin/sh

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Base paths for internal storage and SD card
SRC_BASE="/storage/emulated/0"
DST_BASE="/storage/08FC-EF18"

# Move the DCIM/Camera folder
SRC="$SRC_BASE/DCIM"
DST="$DST_BASE"
if [ -d "$SRC" ]; then
    # Create the destination directory if it does not exist
    mkdir -p "$(dirname "$DST")"
    mv "$SRC" "$DST"
    echo "DCIM folder has been moved."
else
    echo "DCIM folder not found."
fi

# Move the DCIM/Camera folder
SRC="$SRC_BASE/Documents"
DST="$DST_BASE/Documents"
if [ -d "$SRC" ]; then
    # Create the destination directory if it does not exist
    mkdir -p "$(dirname "$DST")"
    mv "$SRC" "$DST"
    echo "Documents folder has been moved."
else
    echo "Documents folder not found."
fi

# Move the Download folder
SRC="$SRC_BASE/Download"
DST="$DST_BASE/Download"
if [ -d "$SRC" ]; then
    mkdir -p "$DST"
    mv "$SRC" "$DST"
    echo "Download folder has been moved."
else
    echo "Download folder not found."
fi

# Move the Pictures folder
SRC="$SRC_BASE/Pictures"
DST="$DST_BASE/Pictures"
if [ -d "$SRC" ]; then
    mkdir -p "$DST"
    mv "$SRC" "$DST"
    echo "Pictures folder has been moved."
else
    echo "Pictures folder not found."
fi

# Move the Movies folder
SRC="$SRC_BASE/Movies"
DST="$DST_BASE/Movies"
if [ -d "$SRC" ]; then
    mkdir -p "$DST"
    mv "$SRC" "$DST"
    echo "Movies folder has been moved."
else
    echo "Movies folder not found."
fi

# Move the Recordings folder
SRC="$SRC_BASE/Recordings"
DST="$DST_BASE/Recordings"
if [ -d "$SRC" ]; then
    mkdir -p "$DST"
    mv "$SRC" "$DST"
    echo "Recordings folder has been moved."
else
    echo "Recordings folder not found."
fi

echo "File transfer process is complete."
