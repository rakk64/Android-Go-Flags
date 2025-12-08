#!/system/bin/sh

# Wait until the system has finished booting if script cannot load please move manualy to service.d
(sys.boot_completed property equals 1)
while [ "$(getprop sys.boot_completed)" != "1" ]; do 
    sleep 5
done

#GPU Throttle Level
echo 1 > /sys/devices/platform/soc/5900000.qcom,kgsl-3d0/kgsl/kgsl-3d0/thermal_pwrlevel

#IO Level 0 (Best balanced)
echo simple_ondemand > /sys/class/devfreq/mmc0/governor

echo 52000000 > /sys/class/mmc_host/mmc0/speed

#IO  Level 1 ( powersave)
echo powersave > /sys/class/devfreq/mmc1/governor

echo 52000000 > /sys/class/mmc_host/mmc1/speed

# Target: Internal Storage Block Device (eMMC)
QUEUE="/sys/block/mmcblk0/queue/iosched"

# 1. IOPS & Throughput Tuning
# Low Quantum for fast task switching. Prevents single process hogging the bus.
echo 4 > $QUEUE/quantum

# 2. Strict Latency Control
# Enable low latency mode.
echo 1 > $QUEUE/low_latency
# Aggressive target latency (20ms) ensures frequent queue checks for reads.
echo 20 > $QUEUE/target_latency

# 3. Write Starvation Tweak (Mitigating Half-Duplex)
# FIFO Expire Async (Write): Set very high to starve writes, prioritizing the bus for reads.
echo 500 > $QUEUE/fifo_expire_async
# FIFO Expire Sync (Read): Set very low (16ms) to treat read requests as highly urgent.
echo 16 > $QUEUE/fifo_expire_sync

# 4. Slice Time & Batching Control
# Slice Async (Write Time): Minimal time slice (5ms) to quickly free up the half-duplex bus.
echo 5 > $QUEUE/slice_async
# Slice Sync (Read Time): Generous time slice (100ms) for reads to complete in one go.
echo 100 > $QUEUE/slice_sync
# Slice Async Request: Limit write requests per batch to 1 to prevent queue clogging.
echo 1 > $QUEUE/slice_async_rq

# 5. Idle & Seek Penalty Removal
# Disable idle waiting, as flash storage doesn't benefit from waiting for I/O locality.
echo 0 > $QUEUE/slice_idle
echo 0 > $QUEUE/group_idle
# Minimal penalty for seeking (reads are random and cheap on eMMC).
echo 1 > $QUEUE/back_seek_penalty
echo 1 > $QUEUE/back_seek_max

# 6. Optional: Microsecond Target Latency (If supported by the kernel)
if [ -e $QUEUE/target_latency_us ]; then
  echo 20000 > $QUEUE/target_latency_us
fi

# Target: External Storage Block (SD Card)
QUEUE="/sys/block/mmcblk1/queue/iosched"

# 1. IOPS & Throughput Tuning
# Low Quantum for fast task switching. Prevents single process hogging the bus.
echo 4 > $QUEUE/quantum

# 2. Strict Latency Control
# Enable low latency mode.
echo 1 > $QUEUE/low_latency
# Aggressive target latency (20ms) ensures frequent queue checks for reads.
echo 20 > $QUEUE/target_latency

# 3. Write Starvation Tweak (Mitigating Half-Duplex)
# FIFO Expire Async (Write): Set very high to starve writes, prioritizing the bus for reads.
echo 500 > $QUEUE/fifo_expire_async
# FIFO Expire Sync (Read): Set very low (16ms) to treat read requests as highly urgent.
echo 16 > $QUEUE/fifo_expire_sync

# 4. Slice Time & Batching Control
# Slice Async (Write Time): Minimal time slice (5ms) to quickly free up the half-duplex bus.
echo 5 > $QUEUE/slice_async
# Slice Sync (Read Time): Generous time slice (100ms) for reads to complete in one go.
echo 100 > $QUEUE/slice_sync
# Slice Async Request: Limit write requests per batch to 1 to prevent queue clogging.
echo 1 > $QUEUE/slice_async_rq

# 5. Idle & Seek Penalty Removal
# Disable idle waiting, as flash storage doesn't benefit from waiting for I/O locality.
echo 0 > $QUEUE/slice_idle
echo 0 > $QUEUE/group_idle
# Minimal penalty for seeking (reads are random and cheap on eMMC).
echo 1 > $QUEUE/back_seek_penalty
echo 1 > $QUEUE/back_seek_max

# 6. Optional: Microsecond Target Latency (If supported by the kernel)
if [ -e $QUEUE/target_latency_us ]; then
  echo 20000 > $QUEUE/target_latency_us
fi

#Resetprop
resetprop -n ro.boot.loglevel "0"
resetprop -n ro.debuggable "0"

# Kernel Edit (This can make bootloop if wrong settings)
echo 0 0 0 0 > /proc/sys/kernel/printk
echo 1  > /sys/touchpanel/double_tap
echo 0 > /proc/sys/net/ipv4/tcp_low_latency

# add Execute command with in first boot.
su -c sysctl -w kernel.dmesg_restrict=1
su -c dmesg -n 1
exit 0