#!/system/bin/sh

LOGDIR=/metadata/rofik_logs

mkdir -p $LOGDIR

echo "========================================" > $LOGDIR/bootinfo.txt
echo "RofikKernelDev Early Boot Logger" >> $LOGDIR/bootinfo.txt
echo "========================================" >> $LOGDIR/bootinfo.txt

date >> $LOGDIR/bootinfo.txt

getprop > $LOGDIR/getprop.txt

dmesg > $LOGDIR/dmesg.txt

logcat -b all -d > $LOGDIR/logcat.txt

cat /proc/last_kmsg > $LOGDIR/last_kmsg.txt 2>/dev/null

cat /sys/fs/pstore/* > $LOGDIR/pstore.txt 2>/dev/null

echo "done" > $LOGDIR/status.txt
