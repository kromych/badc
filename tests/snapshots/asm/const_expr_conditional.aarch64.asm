
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
               	sub	x15, x29, #0x10
               	mov	x14, #0x5               // =5
               	str	w14, [x15]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x4
               	mov	x14, #0x7               // =7
               	str	w14, [x13]
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x8
               	mov	x14, #0xe               // =14
               	str	w14, [x15]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0xc
               	mov	x14, #0x1               // =1
               	str	w14, [x13]
               	sub	x15, x29, #0x10
               	ldrsw	x15, [x15]
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	add	x15, x15, x14
               	sxtw	x15, w15
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	add	x15, x15, x14
               	sxtw	x15, w15
               	sub	x14, x29, #0x10
               	add	x14, x14, #0xc
               	ldrsw	x14, [x14]
               	add	x15, x15, x14
               	sxtw	x0, w15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
