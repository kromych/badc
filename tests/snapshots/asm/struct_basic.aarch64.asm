
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
               	mov	x14, x0
               	mov	x0, #0x3                // =3
               	str	w0, [x14]
               	add	x13, x14, #0x4
               	mov	x0, #0x4                // =4
               	str	w0, [x13]
               	ldrsw	x12, [x14]
               	ldrsw	x0, [x14]
               	mul	x12, x12, x0
               	sxtw	x12, w12
               	add	x14, x14, #0x4
               	ldrsw	x0, [x14]
               	ldrsw	x14, [x14]
               	mul	x0, x0, x14
               	sxtw	x0, w0
               	add	x12, x12, x0
               	sxtw	x12, w12
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
