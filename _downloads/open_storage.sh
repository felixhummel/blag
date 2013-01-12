#!/bin/bash
sudo cryptsetup luksOpen /dev/md0 crypt0

# wait until block device is available
while [[ ! -b /dev/raid/storage ]]; do
  echo -n '.'
  sleep 0.5
done
echo
sudo mount /dev/raid/storage /media/storage

