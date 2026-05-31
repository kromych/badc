
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
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	bl	<addr>
               	mov	x20, #0x3               // =3
               	str	w20, [x0]
               	add	x13, x0, #0x4
               	mov	x20, #0x4               // =4
               	str	w20, [x13]
               	ldrsw	x12, [x0]
               	ldrsw	x20, [x0]
               	mul	x12, x12, x20
               	sxtw	x12, w12
               	add	x0, x0, #0x4
               	ldrsw	x20, [x0]
               	ldrsw	x13, [x0]
               	mul	x20, x20, x13
               	sxtw	x20, w20
               	add	x12, x12, x20
               	sxtw	x0, w12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
