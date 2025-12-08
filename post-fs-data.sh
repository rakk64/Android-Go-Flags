#!/system/bin/sh

# Get the current module directory
MODDIR=${0%/*}
COMMON_DIR=$MODDIR/common

# Run Optimize_Habits.sh
/system/bin/sh $COMMON_DIR/Optimize_Habits.sh &