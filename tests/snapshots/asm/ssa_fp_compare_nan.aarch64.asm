
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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x118
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x11e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x125
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fdiv	d0, d0, d0
               	fmov	x0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	bl	<addr>
               	fmov	d0, x0
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x2               // =2
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ls
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x4               // =4
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ge
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x8               // =8
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x10              // =16
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x20              // =32
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	fcmp	d0, d0
               	cset	x0, mi
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x40              // =64
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	fcmp	d0, d0
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x80              // =128
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
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
               	adrp	x0, <page>
               	add	x0, x0, #0x160
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
