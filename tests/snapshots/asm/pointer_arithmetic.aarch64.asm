
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
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x0]
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
