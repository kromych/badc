
do_while.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x5
               	b.ge	<addr>
               	b	<addr>
               	mov	x0, x1
               	ret
