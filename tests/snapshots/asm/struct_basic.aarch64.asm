
struct_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	mov	x2, #0x4                // =4
               	str	w2, [x0, #0x4]
               	sxtw	x2, w1
               	sxtw	x1, w1
               	mul	x1, x2, x1
               	sxtw	x1, w1
               	add	x0, x0, #0x4
               	ldrsw	x2, [x0]
               	mul	x0, x2, x2
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
