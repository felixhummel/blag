#!/bin/bash
sudo cryptsetup luksOpen /dev/md0 crypt0
sudo mount /dev/raid/storage /media/storage

