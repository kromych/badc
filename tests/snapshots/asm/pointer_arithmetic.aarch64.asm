
pointer_arithmetic.aarch64:	file format elf64-littleaarch64

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
               	mov	x15, #0x8               // =8
               	sxtw	x20, w15
               	mov	x0, x20
               	bl	<addr>
               	mov	x20, #0x1               // =1
               	str	w20, [x0]
               	add	x13, x0, #0x4
               	mov	x20, #0x2               // =2
               	str	w20, [x13]
               	ldrsw	x12, [x0]
               	add	x0, x0, #0x4
               	ldrsw	x20, [x0]
               	add	x12, x12, x20
               	sxtw	x0, w12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
