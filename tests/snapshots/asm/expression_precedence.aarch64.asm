
expression_precedence.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0xc               // =12
               	sxtw	x15, w15
               	add	x14, x15, #0x2
               	sxtw	x14, w14
               	cmp	x14, #0xe
               	cset	x0, eq
               	ret
