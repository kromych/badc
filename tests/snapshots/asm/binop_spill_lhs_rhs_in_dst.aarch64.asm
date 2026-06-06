
binop_spill_lhs_rhs_in_dst.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x5, x1
               	mov	x1, x2
               	sxtw	x5, w5
               	sxtw	x1, w1
               	lsl	x2, x1, #2
               	add	x2, x0, x2
               	ldrsw	x2, [x2]
               	mov	x4, #0x0                // =0
               	b	<addr>
               	sxtw	x3, w5
               	cmp	x3, x1
               	b.gt	<addr>
               	b	<addr>
               	sxtw	x3, w5
               	add	x5, x3, #0x1
               	b	<addr>
               	sxtw	x3, w4
               	sxtw	x4, w5
               	lsl	x4, x4, #2
               	add	x4, x0, x4
               	ldrsw	x4, [x4]
               	add	x3, x3, x4
               	sxtw	x4, w3
               	b	<addr>
               	sxtw	x0, w4
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	mov	x2, #0xc                // =12
               	str	w2, [x0]
               	sub	x0, x29, #0x18
               	mov	x2, #0x4                // =4
               	add	x0, x0, #0x4
               	mov	x3, #0x7                // =7
               	str	w3, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	mov	x3, #0xf                // =15
               	str	w3, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0xc
               	mov	x3, #0x5                // =5
               	str	w3, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	mov	x3, #0xa                // =10
               	str	w3, [x0]
               	sub	x0, x29, #0x18
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
