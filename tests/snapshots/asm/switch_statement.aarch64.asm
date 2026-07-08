
switch_statement.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x14               // =20
               	add	x0, x0, #0x5
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
