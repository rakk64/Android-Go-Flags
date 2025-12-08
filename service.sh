#!/system/bin/sh
# service.sh - Controller for optimisation scripts

# Obtain the current module path
MODDIR=${0%/*}

# Define the path to the common folder where custom scripts reside
COMMON_DIR=$MODDIR/common

# Pause for 5 seconds to allow Android system services to be ready before optimisation begins
sleep 5

# --- Begin Script Execution ---

# Invoke custom scripts with /system/bin/sh, running them in the background (&)

# 1. Run automove.sh
/system/bin/sh $COMMON_DIR/automove.sh &

# 2. Run Optimization_Storage.sh
/system/bin/sh $COMMON_DIR/Optimization_Storage.sh &

# 3. Run Optimize_Habits.sh
#/system/bin/sh $COMMON_DIR/Optimize_Habits.sh &

# All scripts are now triggered in the background and do not generate log files.