
ssa_fp_compare_nan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x0               // =0
               	fmov	d0, x15
               	fmov	d1, x15
               	fdiv	d0, d0, d1
               	fmov	x0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	mov	x15, #0x0               // =0
               	fmov	d0, x15
               	fmov	d1, x15
               	fdiv	d7, d0, d1
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x10]
               	fmov	d1, x15
               	fcmp	d7, d1
               	cset	x14, mi
               	cbz	x14, <addr>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	mov	x17, #0x1               // =1
               	orr	x14, x14, x17
               	str	w14, [x15]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	fmov	d1, x13
               	fcmp	d7, d1
               	cset	x15, gt
               	cbz	x15, <addr>
               	sub	x13, x29, #0x10
               	ldrsw	x15, [x13]
               	mov	x17, #0x2               // =2
               	orr	x15, x15, x17
               	str	w15, [x13]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	fmov	d1, x14
               	fcmp	d7, d1
               	cset	x13, ls
               	cbz	x13, <addr>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	mov	x17, #0x4               // =4
               	orr	x13, x13, x17
               	str	w13, [x14]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	fmov	d1, x15
               	fcmp	d7, d1
               	cset	x14, ge
               	cbz	x14, <addr>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	mov	x17, #0x8               // =8
               	orr	x14, x14, x17
               	str	w14, [x15]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	fmov	d1, x13
               	fcmp	d7, d1
               	cset	x15, eq
               	cbz	x15, <addr>
               	sub	x13, x29, #0x10
               	ldrsw	x15, [x13]
               	mov	x17, #0x10              // =16
               	orr	x15, x15, x17
               	str	w15, [x13]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	fmov	d1, x14
               	fcmp	d7, d1
               	cset	x13, ne
               	cmp	x13, #0x0
               	b.ne	<addr>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	mov	x17, #0x20              // =32
               	orr	x13, x13, x17
               	str	w13, [x14]
               	b	<addr>
               	fcmp	d7, d7
               	cset	x15, mi
               	cbz	x15, <addr>
               	sub	x14, x29, #0x10
               	ldrsw	x15, [x14]
               	mov	x17, #0x40              // =64
               	orr	x15, x15, x17
               	str	w15, [x14]
               	b	<addr>
               	fcmp	d7, d7
               	cset	x13, eq
               	cbz	x13, <addr>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	mov	x17, #0x80              // =128
               	orr	x13, x13, x17
               	str	w13, [x14]
               	b	<addr>
               	ldursw	x15, [x29, #-0x10]
               	cbz	x15, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldursw	x1, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
