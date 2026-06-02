
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
               	mov	x14, #0x3               // =3
               	str	w14, [x0]
               	add	x13, x0, #0x4
               	mov	x14, #0x4               // =4
               	str	w14, [x13]
               	ldrsw	x12, [x0]
               	ldrsw	x14, [x0]
               	mul	x12, x12, x14
               	sxtw	x12, w12
               	add	x0, x0, #0x4
               	ldrsw	x14, [x0]
               	ldrsw	x0, [x0]
               	mul	x14, x14, x0
               	sxtw	x14, w14
               	add	x12, x12, x14
               	sxtw	x0, w12
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
