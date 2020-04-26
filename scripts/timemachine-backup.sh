#!/bin/bash
diskutil mount timemachine && tmutil startbackup -b && diskutil eject timemachine

