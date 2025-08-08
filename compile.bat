@echo off
nasm -f bin bootloader.asm -o bootloader.com
dosbox-x -c "mount c C:\Users\Andrew\Documents\projects\ASMos" -c "c:" -c "bootloader.com" -c "exit"
