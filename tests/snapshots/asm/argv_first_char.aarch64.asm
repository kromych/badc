
argv_first_char.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ge	<addr>
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ret
               	add	x1, x1, #0x8
               	ldr	x1, [x1]
               	ldrb	w0, [x1]
               	ret
