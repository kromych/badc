
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
               	mov	x0, #0x0                // =0
               	ret
               	ldr	x0, [x1, #0x8]
               	ldrb	w0, [x0]
               	ret
