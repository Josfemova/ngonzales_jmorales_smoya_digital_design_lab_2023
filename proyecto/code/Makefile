clean: 
	rm -rf build
	mkdir build

build: clean
	arm-none-eabi-as -march=armv4t -o build/main.o main.S
	arm-none-eabi-ld -o build/main.elf build/main.o -Tlink.ld
	arm-none-eabi-objcopy -O ihex build/main.elf build/program.hex
	arm-none-eabi-objcopy -O binary build/main.elf build/program.bin
	arm-none-eabi-objdump -Dxg  build/main.elf -a >> build/assembly_generado.txt
	xxd -c 4 -e build/program.bin build/mem_file.txt
