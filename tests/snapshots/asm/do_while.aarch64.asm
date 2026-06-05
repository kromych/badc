
do_while.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
               	b	<addr>
