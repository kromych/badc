
builtin_library_functions_need_no_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<format>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x20
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x28             // =-40
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	ldr	x0, [x29, #0x10]
               	ldr	x1, [x29, #0x18]
               	ldr	x2, [x29, #0x20]
               	sub	x3, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	stp	x20, x21, [sp, #0x40]
               	mov	x0, #-0x7               // =-7
               	stur	w0, [x29, #-0x38]
               	mov	x0, #-0x8               // =-8
               	stur	x0, [x29, #-0x30]
               	mov	x0, #-0x9               // =-9
               	stur	x0, [x29, #-0x28]
               	fmov	d0, #-2.50000000
               	stur	d0, [x29, #-0x20]
               	fmov	s0, #-1.50000000
               	stur	s0, [x29, #-0x18]
               	fmov	d0, #-3.25000000
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d0
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	and	x12, x9, #0xfffffffffffff
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, x11, lsl #48
               	b	<addr>
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, #0x7fff000000000000
               	cbz	x12, <addr>
               	orr	x10, x10, #0x800000000000
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	and	x12, x12, #0xfffffffffffff
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	stur	x9, [x29, #-0x70]
               	stur	x10, [x29, #-0x68]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	ldursw	x0, [x29, #-0x38]
               	asr	x1, x0, #31
               	eor	x0, x0, x1
               	sub	x0, x0, x1
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x30]
               	asr	x1, x0, #63
               	eor	x0, x0, x1
               	sub	x0, x0, x1
               	cmp	x0, #0x8
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x28]
               	asr	x1, x0, #63
               	eor	x0, x0, x1
               	sub	x0, x0, x1
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	asr	x1, x0, #63
               	eor	x0, x0, x1
               	sub	x0, x0, x1
               	cmp	x0, #0x9
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	neg	x0, x0
               	sxtw	x0, w0
               	asr	x1, x0, #31
               	eor	x0, x0, x1
               	sub	x0, x0, x1
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x20]
               	fabs	d0, d0
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x18]
               	fabs	s0, s0
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x70]
               	ldur	x10, [x29, #-0x68]
               	lsr	x11, x10, #63
               	lsl	x11, x11, #63
               	lsl	x12, x10, #1
               	lsr	x12, x12, #49
               	and	x10, x10, #0xffffffffffff
               	mov	x13, #0x7fff            // =32767
               	cmp	x12, x13
               	b.ne	<addr>
               	orr	x13, x10, x9
               	cbz	x13, <addr>
               	lsl	x13, x10, #4
               	orr	x13, x13, x9, lsr #60
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	orr	x10, x10, x9, lsr #49
               	cmp	x12, #0x0
               	cset	x13, ne
               	orr	x10, x10, x13, lsl #63
               	and	x9, x9, #0x1ffffffffffff
               	cmp	x9, #0x0
               	cset	x9, ne
               	cmp	x12, #0x0
               	cset	x13, eq
               	add	x12, x12, x13
               	cbz	x10, <addr>
               	clz	x13, x10
               	lsl	x10, x10, x13
               	sub	x12, x12, x13
               	sub	x12, x12, #0x3, lsl #12 // =0x3000
               	sub	x12, x12, #0xc00
               	mov	x13, #0x7ff             // =2047
               	cmp	x12, x13
               	b.ge	<addr>
               	mov	x13, #0x1               // =1
               	sub	x13, x13, x12
               	bic	x13, x13, x13, asr #63
               	add	x13, x13, #0xa
               	mov	x15, #0x3f              // =63
               	cmp	x13, x15
               	b.gt	<addr>
               	lsr	x14, x10, #1
               	lsr	x14, x14, x13
               	lsr	x15, x10, x13
               	neg	x13, x13
               	lsl	x10, x10, x13
               	cmp	x10, #0x0
               	cset	x10, ne
               	orr	x9, x9, x10
               	and	x10, x14, #0x1
               	orr	x9, x9, x10
               	and	x15, x15, #0x1
               	and	x9, x9, x15
               	sub	x10, x12, #0x1
               	bic	x12, x10, x10, asr #63
               	add	x14, x14, x12, lsl #52
               	add	x14, x14, x9
               	add	x14, x14, x11
               	b	<addr>
               	orr	x14, x11, #0x7ff0000000000000
               	b	<addr>
               	mov	x14, x11
               	fmov	d0, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	fabs	d0, d0
               	fmov	d1, #3.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x20]
               	fmul	d0, d0, d1
               	fsqrt	d0, d0
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x20]
               	frintm	d0, d0
               	fmov	d1, #-3.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x18]
               	frintp	s0, s0
               	fmov	s1, #-1.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x58
               	mov	x1, #0x78               // =120
               	ldur	x2, [x29, #-0x10]
               	bl	<addr>
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldur	x2, [x29, #-0x10]
               	bl	<addr>
               	sub	x0, x29, #0x58
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldur	w2, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x58
               	mov	x1, #0x6c               // =108
               	bl	<addr>
               	sub	x1, x29, #0x58
               	add	x1, x1, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldur	w2, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldur	w2, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	mov	x1, #0x20               // =32
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2a               // =42
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	fmov	d0, #0.50000000
               	bl	<addr>
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x58
               	ldur	x2, [x29, #-0x10]
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldur	x2, [x29, #-0x10]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0xc                // =12
               	cmp	x21, #0x0
               	csel	x0, x0, x1, eq
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
