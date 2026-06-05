
const_expr_conditional.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x4
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	mov	x1, #0xe                // =14
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0xc
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x4
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x8
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	add	x1, x1, #0xc
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
