
binop_spill_lhs_rhs_in_dst.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x1, w1
               	sxtw	x2, w2
               	lsl	x3, x2, #2
               	add	x3, x0, x3
               	ldrsw	x3, [x3]
               	mov	x5, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	b	<addr>
               	ldursw	x1, [x29, #-0x8]
               	cmp	x1, x2
               	b.gt	<addr>
               	b	<addr>
               	sub	x1, x29, #0x8
               	ldrsw	x4, [x1]
               	add	x4, x4, #0x1
               	str	w4, [x1]
               	b	<addr>
               	sxtw	x1, w5
               	ldursw	x4, [x29, #-0x8]
               	lsl	x4, x4, #2
               	add	x4, x0, x4
               	ldrsw	x4, [x4]
               	add	x1, x1, x4
               	sxtw	x5, w1
               	b	<addr>
               	sxtw	x0, w5
               	add	x0, x0, x3
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
