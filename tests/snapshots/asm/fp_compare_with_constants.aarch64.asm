
fp_compare_with_constants.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<double_lt>:
               	fmov	d1, #4.00000000
               	fcmpe	d0, d1
               	cset	x0, mi
               	ret

<double_le>:
               	fmov	d1, #4.00000000
               	fcmpe	d0, d1
               	cset	x0, ls
               	ret

<double_gt>:
               	fmov	d1, #4.00000000
               	fcmpe	d0, d1
               	cset	x0, gt
               	ret

<double_ge>:
               	fmov	d1, #4.00000000
               	fcmpe	d0, d1
               	cset	x0, ge
               	ret

<double_eq>:
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	cset	x0, eq
               	ret

<double_ne>:
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	cset	x0, ne
               	ret

<double_klt>:
               	fmov	d1, #4.00000000
               	fcmpe	d1, d0
               	cset	x0, mi
               	ret

<double_kle>:
               	fmov	d1, #4.00000000
               	fcmpe	d1, d0
               	cset	x0, ls
               	ret

<double_kgt>:
               	fmov	d1, #4.00000000
               	fcmpe	d1, d0
               	cset	x0, gt
               	ret

<double_kge>:
               	fmov	d1, #4.00000000
               	fcmpe	d1, d0
               	cset	x0, ge
               	ret

<double_blt>:
               	fmov	d1, #4.00000000
               	fcmpe	d0, d1
               	b.pl	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_ble>:
               	fmov	d1, #4.00000000
               	fcmpe	d0, d1
               	b.hi	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_bgt>:
               	fmov	d1, #4.00000000
               	fcmpe	d0, d1
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_bge>:
               	fmov	d1, #4.00000000
               	fcmpe	d0, d1
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_beq>:
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_bne>:
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_bklt>:
               	fmov	d1, #4.00000000
               	fcmpe	d1, d0
               	b.pl	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_bkle>:
               	fmov	d1, #4.00000000
               	fcmpe	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_bkgt>:
               	fmov	d1, #4.00000000
               	fcmpe	d1, d0
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<double_bkge>:
               	fmov	d1, #4.00000000
               	fcmpe	d1, d0
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_lt>:
               	fmov	s1, #4.00000000
               	fcmpe	s0, s1
               	cset	x0, mi
               	ret

<float_le>:
               	fmov	s1, #4.00000000
               	fcmpe	s0, s1
               	cset	x0, ls
               	ret

<float_gt>:
               	fmov	s1, #4.00000000
               	fcmpe	s0, s1
               	cset	x0, gt
               	ret

<float_ge>:
               	fmov	s1, #4.00000000
               	fcmpe	s0, s1
               	cset	x0, ge
               	ret

<float_eq>:
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	cset	x0, eq
               	ret

<float_ne>:
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	cset	x0, ne
               	ret

<float_klt>:
               	fmov	s1, #4.00000000
               	fcmpe	s1, s0
               	cset	x0, mi
               	ret

<float_kle>:
               	fmov	s1, #4.00000000
               	fcmpe	s1, s0
               	cset	x0, ls
               	ret

<float_kgt>:
               	fmov	s1, #4.00000000
               	fcmpe	s1, s0
               	cset	x0, gt
               	ret

<float_kge>:
               	fmov	s1, #4.00000000
               	fcmpe	s1, s0
               	cset	x0, ge
               	ret

<float_blt>:
               	fmov	s1, #4.00000000
               	fcmpe	s0, s1
               	b.pl	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_ble>:
               	fmov	s1, #4.00000000
               	fcmpe	s0, s1
               	b.hi	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_bgt>:
               	fmov	s1, #4.00000000
               	fcmpe	s0, s1
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_bge>:
               	fmov	s1, #4.00000000
               	fcmpe	s0, s1
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_beq>:
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_bne>:
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_bklt>:
               	fmov	s1, #4.00000000
               	fcmpe	s1, s0
               	b.pl	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_bkle>:
               	fmov	s1, #4.00000000
               	fcmpe	s1, s0
               	b.hi	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_bkgt>:
               	fmov	s1, #4.00000000
               	fcmpe	s1, s0
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<float_bkge>:
               	fmov	s1, #4.00000000
               	fcmpe	s1, s0
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<escapes>:
               	fmov	d4, d0
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	movi	d2, #0000000000000000
               	fmul	d3, d0, d0
               	fnmsub	d3, d2, d2, d3
               	fadd	d3, d3, d4
               	fmov	d5, #2.00000000
               	fmul	d2, d5, d2
               	fmadd	d0, d2, d0, d1
               	fmul	d2, d0, d0
               	fmadd	d2, d3, d3, d2
               	fmov	d5, #4.00000000
               	fcmpe	d2, d5
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	fmov	d2, d3
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	str	d8, [sp]
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	str	x24, [sp, #0x30]
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	fcvt	d0, s0
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0xf8
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	stp	xzr, xzr, [x0, #0x60]
               	stp	xzr, xzr, [x0, #0x70]
               	stp	xzr, xzr, [x0, #0x80]
               	stp	xzr, xzr, [x0, #0x90]
               	stp	xzr, xzr, [x0, #0xa0]
               	stp	xzr, xzr, [x0, #0xb0]
               	stp	xzr, xzr, [x0, #0xc0]
               	stp	xzr, xzr, [x0, #0xd0]
               	stp	xzr, xzr, [x0, #0xe0]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	stur	d0, [x29, #-0xf8]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x1                // =1
               	mov	x20, #0x0               // =0
               	stur	x1, [x29, #-0xf0]
               	stur	w20, [x29, #-0xe8]
               	fmov	d0, #-5.00000000
               	stur	d0, [x29, #-0xe0]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0xd8]
               	stur	w20, [x29, #-0xd0]
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	stur	d0, [x29, #-0xc8]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0xc0]
               	stur	w20, [x29, #-0xb8]
               	stur	x20, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	stur	w20, [x29, #-0xa0]
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x98]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x90]
               	stur	w20, [x29, #-0x88]
               	fmov	d0, #4.00000000
               	stur	d0, [x29, #-0x80]
               	mov	x1, #0x100000000        // =4294967296
               	stur	x1, [x29, #-0x78]
               	stur	w20, [x29, #-0x70]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	stur	d0, [x29, #-0x68]
               	stur	xzr, [x29, #-0x60]
               	stur	w20, [x29, #-0x58]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x10]
               	stur	d0, [x29, #-0x50]
               	stur	xzr, [x29, #-0x48]
               	stur	w20, [x29, #-0x40]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	stur	d0, [x29, #-0x38]
               	stur	xzr, [x29, #-0x30]
               	stur	w20, [x29, #-0x28]
               	stur	x20, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0xa
               	b.hs	<addr>
               	sub	x0, x29, #0xf8
               	mov	x17, #0x18              // =24
               	mul	x21, x20, x17
               	add	x1, x0, x21
               	ldrsw	x0, [x1, #0x10]
               	cbz	x0, <addr>
               	ldur	d8, [x29, #-0x8]
               	ldrsw	x2, [x1, #0x8]
               	ldrsw	x0, [x1, #0xc]
               	ldrsw	x1, [x1, #0x10]
               	cmp	w0, #0x0
               	cset	x3, eq
               	cmp	w2, #0x0
               	csel	x3, xzr, x3, ne
               	cmp	w1, #0x0
               	cset	x1, eq
               	cmp	x3, #0x0
               	csel	x1, x1, xzr, ne
               	mov	x3, #0x1                // =1
               	cmp	w0, #0x0
               	cset	x4, ne
               	cmp	x2, #0x0
               	csel	x4, x3, x4, ne
               	cmp	w0, #0x0
               	cset	x5, ne
               	cmp	x1, #0x0
               	csel	x3, x3, x5, ne
               	orr	x5, x2, x4, lsl #1
               	orr	x5, x5, x1, lsl #2
               	orr	x5, x5, x3, lsl #3
               	orr	x5, x5, x0, lsl #4
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x0, x5, x0, lsl #5
               	orr	x0, x0, x2, lsl #6
               	orr	x0, x0, x4, lsl #7
               	orr	x0, x0, x1, lsl #8
               	orr	x23, x0, x3, lsl #9
               	fmov	d0, d8
               	bl	<addr>
               	mov	x22, x0
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #1
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #2
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #3
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #4
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #5
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #6
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #7
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #8
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #9
               	fmov	d0, d8
               	bl	<addr>
               	mov	x24, x0
               	fmov	d0, d8
               	bl	<addr>
               	orr	x24, x24, x0, lsl #1
               	fmov	d0, d8
               	bl	<addr>
               	orr	x24, x24, x0, lsl #2
               	fmov	d0, d8
               	bl	<addr>
               	orr	x24, x24, x0, lsl #3
               	fmov	d0, d8
               	bl	<addr>
               	orr	x24, x24, x0, lsl #4
               	fmov	d0, d8
               	bl	<addr>
               	orr	x24, x24, x0, lsl #5
               	fmov	d0, d8
               	bl	<addr>
               	orr	x24, x24, x0, lsl #6
               	fmov	d0, d8
               	bl	<addr>
               	orr	x24, x24, x0, lsl #7
               	fmov	d0, d8
               	bl	<addr>
               	orr	x24, x24, x0, lsl #8
               	fmov	d0, d8
               	bl	<addr>
               	orr	x0, x24, x0, lsl #9
               	cmp	w22, w0
               	mov	x17, #-0x1              // =-1
               	csel	x0, x22, x17, eq
               	cmp	w0, w23
               	b.ne	<addr>
               	sub	x0, x29, #0xf8
               	add	x0, x0, x21
               	ldr	d0, [x0]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fcmp	d0, d1
               	b.eq	<addr>
               	fcvt	s8, d8
               	fmov	d0, d8
               	bl	<addr>
               	mov	x21, x0
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #1
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #2
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #3
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #4
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #5
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #6
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #7
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #8
               	fmov	d0, d8
               	bl	<addr>
               	orr	x21, x21, x0, lsl #9
               	fmov	d0, d8
               	bl	<addr>
               	mov	x22, x0
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #1
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #2
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #3
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #4
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #5
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #6
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #7
               	fmov	d0, d8
               	bl	<addr>
               	orr	x22, x22, x0, lsl #8
               	fmov	d0, d8
               	bl	<addr>
               	orr	x0, x22, x0, lsl #9
               	cmp	w21, w0
               	mov	x17, #-0x1              // =-1
               	csel	x0, x21, x17, eq
               	cmp	w0, w23
               	b.eq	<addr>
               	b	<addr>
               	ldr	d8, [x1]
               	b	<addr>
               	add	x0, x20, #0x14
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x1
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.00000000
               	fmov	d1, d0
               	bl	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	movi	d0, #0000000000000000
               	fmov	d1, d0
               	bl	<addr>
               	cmn	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
