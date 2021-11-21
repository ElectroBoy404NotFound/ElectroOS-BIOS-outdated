@echo off
"tools/nasm/nasm.exe" Bootloader/bootloader.asm -f bin -o output/bootloader.bin
"tools/nasm/nasm.exe" Kernel/Kernelloader.asm -f bin -o output/kernel.bin
cd output
copy /b "bootloader.bin"+"kernel.bin" "os.bin"
cd ..
"tools/mkisofs" -o output/os.iso -b os.bin -no-emul-boot -boot-load-size 4 output/
pause