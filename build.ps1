nasm -f bin bootloader.asm -o bootloader.bin
nasm -f bin kernel.asm -o kernel.bin
nasm -f bin snake.asm -o snake.bin

fsutil file createnew os.img 1474560

dd if=bootloader.bin of=os.img bs=512 count=1 conv=notrunc
dd if=kernel.bin    of=os.img bs=512 seek=1 conv=notrunc
dd if=snake.bin     of=os.img bs=512 seek=2 conv=notrunc

qemu-system-x86_64 -drive file=os.img,format=raw,index=0,if=floppy
