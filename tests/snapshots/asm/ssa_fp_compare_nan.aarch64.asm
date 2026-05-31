
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	bl	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, mi
               	cbz	x13, <addr>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	mov	x17, #0x1               // =1
               	orr	x13, x13, x17
               	str	w13, [x14]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x12, gt
               	cbz	x12, <addr>
               	sub	x13, x29, #0x10
               	ldrsw	x12, [x13]
               	mov	x17, #0x2               // =2
               	orr	x12, x12, x17
               	str	w12, [x13]
               	b	<addr>
               	mov	x12, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x14, ls
               	cbz	x14, <addr>
               	sub	x12, x29, #0x10
               	ldrsw	x14, [x12]
               	mov	x17, #0x4               // =4
               	orr	x14, x14, x17
               	str	w14, [x12]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, ge
               	cbz	x13, <addr>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	mov	x17, #0x8               // =8
               	orr	x13, x13, x17
               	str	w13, [x14]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x12, eq
               	cbz	x12, <addr>
               	sub	x13, x29, #0x10
               	ldrsw	x12, [x13]
               	mov	x17, #0x10              // =16
               	orr	x12, x12, x17
               	str	w12, [x13]
               	b	<addr>
               	mov	x12, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x14, ne
               	cmp	x14, #0x0
               	b.ne	<addr>
               	sub	x12, x29, #0x10
               	ldrsw	x14, [x12]
               	mov	x17, #0x20              // =32
               	orr	x14, x14, x17
               	str	w14, [x12]
               	b	<addr>
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, mi
               	cbz	x14, <addr>
               	sub	x13, x29, #0x10
               	ldrsw	x14, [x13]
               	mov	x17, #0x40              // =64
               	orr	x14, x14, x17
               	str	w14, [x13]
               	b	<addr>
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x14, x29, #0x10
               	ldrsw	x0, [x14]
               	mov	x17, #0x80              // =128
               	orr	x0, x0, x17
               	str	w0, [x14]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x20, x19
               	ldursw	x21, [x29, #-0x10]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x160
               	mov	x22, x19
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
