#!/bin/bash

cpupower frequency-set -g conservative

echo 1 > /sys/devices/system/cpu/cpufreq/conservative/ignore_nice_load
echo 30 > /sys/devices/system/cpu/cpufreq/conservative/down_threshold
echo 10000 > /sys/devices/system/cpu/cpufreq/conservative/sampling_rate
