
strtof_and_wcstof_report_range_errors.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	stur	xzr, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x10]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	x0, x0, #0x1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x10]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldr	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x28]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x28]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldr	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x40]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x40]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldr	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x58]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x58]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldr	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x70]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	bl	<addr>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s1, [x0, #0x70]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldr	w0, [x0]
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	str	d0, [sp, #0x58]
               	bl	<addr>
               	ldr	d0, [sp, #0x58]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	b.ne	<addr>
               	movi	d1, #0000000000000000
               	fcmpe	s0, s1
               	b.le	<addr>
               	mov	x16, #0x800000          // =8388608
               	fmov	s1, w16
               	fcmpe	s0, s1
               	b.mi	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x40]
               	ldur	x10, [x29, #-0x38]
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
               	fmov	d1, #0.37500000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x20]
               	ldrb	w0, [x0]
               	cmp	w0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x18
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x40]
               	ldur	x10, [x29, #-0x38]
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
               	fmov	d1, #-2.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x18]
               	ldr	w0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
