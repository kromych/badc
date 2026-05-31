
expression_precedence.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0xc               // =12
               	sxtw	x15, w15
               	add	x15, x15, #0x2
               	sxtw	x15, w15
               	cmp	x15, #0xe
               	cset	x0, eq
               	ret
