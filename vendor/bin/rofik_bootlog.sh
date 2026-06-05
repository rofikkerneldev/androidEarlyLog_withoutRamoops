#!/system/bin/sh

BASE_DIR=/metadata/rofiklog
STATUS_FILE=$BASE_DIR/last_status

mkdir -p $BASE_DIR

# Toggle log slot
if [ ! -f "$STATUS_FILE" ]; then
    CURRENT_SLOT=0
elif [ "$(cat "$STATUS_FILE" 2>/dev/null)" = "1" ]; then
    CURRENT_SLOT=0
else
    CURRENT_SLOT=1
fi

LOGDIR=$BASE_DIR/log$CURRENT_SLOT

rm -rf "$LOGDIR"
mkdir -p "$LOGDIR"

echo "$CURRENT_SLOT" > "$STATUS_FILE"

echo "========================================" > "$LOGDIR/bootinfo.txt"
echo "RofikKernelDev Early Boot Logger" >> "$LOGDIR/bootinfo.txt"
echo "========================================" >> "$LOGDIR/bootinfo.txt"

date >> "$LOGDIR/bootinfo.txt"

getprop > "$LOGDIR/getprop.txt"

dmesg > "$LOGDIR/dmesg.txt"

logcat -b all -d > "$LOGDIR/logcat.txt"

cat /proc/last_kmsg > "$LOGDIR/last_kmsg.txt" 2>/dev/null

cat /sys/fs/pstore/* > "$LOGDIR/pstore.txt" 2>/dev/null

echo "done" > "$LOGDIR/status.txt"
