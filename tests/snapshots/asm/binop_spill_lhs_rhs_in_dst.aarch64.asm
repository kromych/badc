
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
               	mov	x15, x0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	lsl	x12, x13, #2
               	add	x12, x15, x12
               	ldrsw	x12, [x12]
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x10]
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, x13
               	b.gt	<addr>
               	b	<addr>
               	sub	x10, x29, #0x8
               	ldrsw	x14, [x10]
               	add	x14, x14, #0x1
               	str	w14, [x10]
               	b	<addr>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x11, [x29, #-0x8]
               	lsl	x11, x11, #2
               	add	x11, x15, x11
               	ldrsw	x11, [x11]
               	add	x14, x14, x11
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x10]
               	b	<addr>
               	ldursw	x14, [x29, #-0x10]
               	add	x14, x14, x12
               	sxtw	x0, w14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x15, x29, #0x18
               	mov	x1, #0x0                // =0
               	mov	x13, #0xc               // =12
               	str	w13, [x15]
               	sub	x12, x29, #0x18
               	mov	x2, #0x4                // =4
               	add	x12, x12, #0x4
               	mov	x15, #0x7               // =7
               	str	w15, [x12]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	mov	x15, #0xf               // =15
               	str	w15, [x11]
               	sub	x12, x29, #0x18
               	add	x12, x12, #0xc
               	mov	x15, #0x5               // =5
               	str	w15, [x12]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x10
               	mov	x15, #0xa               // =10
               	str	w15, [x11]
               	sub	x0, x29, #0x18
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
