
variadic_hfa_va_arg.aarch64:	file format elf64-littleaarch64

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

<sum_d2>:
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
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x30
               	add	x1, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	movi	d0, #0000000000000000
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x1, x29, #0x10
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x20
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x1]
               	ldr	x17, [x9, #0x10]
               	str	x17, [x1, #0x8]
               	mov	x16, x1
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	ldr	d2, [x1]
               	fmov	d3, #10.00000000
               	fmul	d2, d2, d3
               	fmadd	d0, d0, d1, d2
               	ldr	d1, [x1, #0x8]
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	sub	x0, x29, #0x30
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<sum_f4>:
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
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x30
               	add	x1, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xf8]
               	movi	d0, #0000000000000000
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x1, x29, #0x10
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x40
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	w17, [x9]
               	str	w17, [x1]
               	ldr	w17, [x9, #0x10]
               	str	w17, [x1, #0x4]
               	ldr	w17, [x9, #0x20]
               	str	w17, [x1, #0x8]
               	ldr	w17, [x9, #0x30]
               	str	w17, [x1, #0xc]
               	mov	x16, x1
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldr	s2, [x1]
               	mov	x16, #0x447a0000        // =1148846080
               	fmov	s3, w16
               	fmul	s2, s2, s3
               	fcvt	d2, s2
               	fmadd	d0, d0, d1, d2
               	ldr	s2, [x1, #0x4]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s3, w16
               	fmul	s2, s2, s3
               	fcvt	d2, s2
               	fadd	d0, d0, d2
               	ldr	s2, [x1, #0x8]
               	fmov	s3, #10.00000000
               	fmul	s2, s2, s3
               	fcvt	d2, s2
               	fadd	d0, d0, d2
               	ldr	s2, [x1, #0xc]
               	fcvt	d2, s2
               	fadd	d0, d0, d2
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	sub	x0, x29, #0x30
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<straddle>:
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
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x38
               	add	x1, x29, #0x10
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	sub	x2, x29, #0x38
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	d0, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x100]
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x1, x29, #0x18
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x30
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x1]
               	ldr	x17, [x9, #0x10]
               	str	x17, [x1, #0x8]
               	ldr	x17, [x9, #0x20]
               	str	x17, [x1, #0x10]
               	mov	x16, x1
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x18
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x1, #0x10]
               	ldr	d2, [x1]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d3, x16
               	fmul	d2, d2, d3
               	fmadd	d0, d0, d1, d2
               	ldr	d2, [x1, #0x8]
               	fmov	d3, #10.00000000
               	fmadd	d0, d2, d3, d0
               	ldr	d2, [x1, #0x10]
               	fadd	d0, d0, d2
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	fmov	d1, #10.00000000
               	sub	x0, x29, #0x38
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	d2, [x0]
               	fmadd	d0, d0, d1, d2
               	sub	x0, x29, #0x38
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<last_ld>:
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
               	sub	sp, sp, #0x50
               	sub	x1, x29, #0x50
               	stp	xzr, xzr, [x1]
               	sub	x2, x29, #0x30
               	add	x0, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	mov	x0, #0x0                // =0
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.ge	<addr>
               	sub	x3, x29, #0x40
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x3]
               	ldr	x17, [x9, #0x8]
               	str	x17, [x3, #0x8]
               	mov	x16, x3
               	b	<addr>
               	ldr	x16, [x17]
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	add	x0, x0, #0x1
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.lt	<addr>
               	sub	x0, x29, #0x30
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x50]
               	ldur	x10, [x29, #-0x48]
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
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
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
               	asr	x15, x13, #63
               	bic	x13, x13, x15
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
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
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
               	add	sp, sp, #0x40
               	sub	x0, x29, #0x10
               	sub	sp, sp, #0x30
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
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	lsl	x13, x11, #48
               	orr	x10, x10, x13
               	b	<addr>
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
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
               	str	x9, [x0]
               	str	x10, [x0, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<mixed>:
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
               	sub	sp, sp, #0x30
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x28
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	mov	x3, #0xa                // =10
               	movi	d0, #0000000000000000
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x4, [x2]
               	sub	x2, x29, #0x8
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x2]
               	mov	x16, x2
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x5, x16
               	sub	x2, x29, #0x30
               	ldr	x16, [x5]
               	str	x16, [x2]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	mul	x4, x4, x3
               	sxtw	x4, w4
               	scvtf	d2, x4
               	fmadd	d0, d0, d1, d2
               	ldr	d1, [x2]
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x28
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<twice>:
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
               	sub	sp, sp, #0x70
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x60
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x60
               	str	x9, [sp, #-0x10]!
               	ldr	x9, [x2]
               	str	x9, [x1]
               	ldr	x9, [x2, #0x8]
               	str	x9, [x1, #0x8]
               	ldr	x9, [x2, #0x10]
               	str	x9, [x1, #0x10]
               	ldr	x9, [x2, #0x18]
               	str	x9, [x1, #0x18]
               	ldr	x9, [sp], #0x10
               	movi	d0, #0000000000000000
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x20
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x1]
               	ldr	x17, [x9, #0x10]
               	str	x17, [x1, #0x8]
               	mov	x16, x1
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	ldr	d2, [x1]
               	fmov	d3, #10.00000000
               	fmul	d2, d2, d3
               	fmadd	d0, d0, d1, d2
               	ldr	d1, [x1, #0x8]
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	movi	d1, #0000000000000000
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x20
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x2]
               	ldr	x17, [x9, #0x10]
               	str	x17, [x2, #0x8]
               	mov	x16, x2
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d2, x16
               	ldr	d3, [x1]
               	fmov	d4, #10.00000000
               	fmul	d3, d3, d4
               	fmadd	d1, d1, d2, d3
               	ldr	d2, [x1, #0x8]
               	fadd	d1, d1, d2
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	sub	x0, x29, #0x60
               	fcmp	d0, d1
               	b.ne	<addr>
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret
               	fmov	d0, #-1.00000000
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	sub	x7, x29, #0x98
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x0, x29, #0x88
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x68
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xd0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xa8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	mov	x0, #0x1                // =1
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	bl	<addr>
               	fmov	d1, #12.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	sub	x7, x29, #0x98
               	sub	x1, x29, #0x88
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x1]
               	ldr	d3, [x1, #0x8]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x108]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sub	x7, x29, #0x98
               	sub	x1, x29, #0x88
               	sub	x2, x29, #0x78
               	sub	x3, x29, #0x68
               	sub	x4, x29, #0x58
               	sub	sp, sp, #0x10
               	mov	x16, x4
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x1]
               	ldr	d3, [x1, #0x8]
               	ldr	d4, [x2]
               	ldr	d5, [x2, #0x8]
               	ldr	d6, [x3]
               	ldr	d7, [x3, #0x8]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x110]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x7, x29, #0x40
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	ldr	s2, [x7, #0x8]
               	ldr	s3, [x7, #0xc]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x108]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	sub	x7, x29, #0x40
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x10
               	sub	sp, sp, #0x10
               	mov	x16, x2
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	ldr	s2, [x7, #0x8]
               	ldr	s3, [x7, #0xc]
               	ldr	s4, [x1]
               	ldr	s5, [x1, #0x4]
               	ldr	s6, [x1, #0x8]
               	ldr	s7, [x1, #0xc]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x118]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x7, #0x10]
               	sub	x1, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x2, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x2, #0x10]
               	mov	x0, #0x3                // =3
               	fmov	d0, #0.50000000
               	fmov	d1, #2.00000000
               	sub	sp, sp, #0x20
               	str	d1, [sp, #0x18]
               	mov	x16, x2
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	ldr	x17, [x16, #0x10]
               	str	x17, [sp, #0x10]
               	ldr	d1, [x7]
               	ldr	d2, [x7, #0x8]
               	ldr	d3, [x7, #0x10]
               	ldr	d4, [x1]
               	ldr	d5, [x1, #0x8]
               	ldr	d6, [x1, #0x10]
               	bl	<addr>
               	add	sp, sp, #0x20
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x120]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	sub	x7, x29, #0xd0
               	sub	x1, x29, #0xc0
               	ldr	q0, [x7]
               	ldr	q1, [x1]
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x10]
               	ldur	x10, [x29, #-0x8]
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
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
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
               	asr	x15, x13, #63
               	bic	x13, x13, x15
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
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
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
               	add	sp, sp, #0x40
               	fmov	d1, #7.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	sub	x7, x29, #0xd0
               	sub	x1, x29, #0xc0
               	sub	sp, sp, #0x10
               	mov	x16, x1
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	ldr	q0, [x7]
               	ldr	q1, [x7]
               	ldr	q2, [x7]
               	ldr	q3, [x7]
               	ldr	q4, [x7]
               	ldr	q5, [x7]
               	ldr	q6, [x7]
               	ldr	q7, [x7]
               	bl	<addr>
               	add	sp, sp, #0x10
               	stur	q0, [x29, #-0x10]
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x10]
               	ldur	x10, [x29, #-0x8]
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
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
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
               	asr	x15, x13, #63
               	bic	x13, x13, x15
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
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
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
               	add	sp, sp, #0x40
               	fmov	d1, #7.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	sub	x7, x29, #0xa8
               	sub	x2, x29, #0xa0
               	ldr	d0, [x7]
               	ldr	d1, [x2]
               	mov	x2, x0
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x128]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sub	x7, x29, #0x98
               	sub	x1, x29, #0x88
               	sub	x2, x29, #0x78
               	sub	x3, x29, #0x68
               	sub	x4, x29, #0x58
               	sub	sp, sp, #0x10
               	mov	x16, x4
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x1]
               	ldr	d3, [x1, #0x8]
               	ldr	d4, [x2]
               	ldr	d5, [x2, #0x8]
               	ldr	d6, [x3]
               	ldr	d7, [x3, #0x8]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x110]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
