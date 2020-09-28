CFLAGS := -g -m32 -O1

kern0: kern0.o boot.o
	ld -m elf_i386 -Ttext 0x100000 $^ -o $@
# Verificar imagen Multiboot v1.
	grub-file --is-x86-multiboot $@

%.o: %.S
	$(CC) $(CFLAGS) -c $<

run: kern0
	qemu-system-i386 -serial mon:stdio -kernel kern0
.PHONY: run

clean:
	rm -f kern0 *.o core
.PHONY: clean
