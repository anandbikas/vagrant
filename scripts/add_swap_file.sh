#!/bin/sh
# Add SWAP file of 10 GB

SWAP_FILE_SIZE=10240
SWAP_FILE_PATH=/root/my_swap_file

# Add SWAP file if not present
grep -q "$SWAP_FILE_PATH" /etc/fstab

if [ $? -ne 0 ]; then
  echo "$SWAP_FILE_PATH not found, creating..."
  dd if=/dev/zero of=$SWAP_FILE_PATH bs=1M count=$SWAP_FILE_SIZE
  chmod 600 $SWAP_FILE_PATH
  mkswap -f $SWAP_FILE_PATH
  swapon $SWAP_FILE_PATH
  echo "$SWAP_FILE_PATH none swap defaults 0 0" >> /etc/fstab

  # print swap details
  cat /proc/swaps
  cat /proc/meminfo | grep Swap
  free
fi

