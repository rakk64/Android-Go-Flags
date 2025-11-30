#!/system/bin/sh
# uninstall.sh - Clean up running processes

# Terminate all background scripts based on file name:
pkill -f automove.sh
pkill -f Optimization_Storage.sh
pkill -f Optimize_Habits.sh

# Note: Remove the 'rm -rf' line if you have NOT created files outside MODDIR.
# If you have created custom data (for example: in /data/local/tmp), delete it here.
# Example: rm -rf /data/local/tmp/your_custom_data

# Allow KernelSU Next to remove the main module folder and disable system.prop.