
far_frame_slots.aarch64:	file format elf64-littleaarch64

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

<fill>:
               	mov	x3, #0x0                // =0
               	cmp	x3, x1
               	b.hs	<addr>
               	add	x4, x2, x3
               	and	x4, x4, #0xff
               	strb	w4, [x0, x3]
               	add	x3, x3, #0x1
               	cmp	x3, x1
               	b.lo	<addr>
               	ret

<bump>:
               	ldr	x1, [x0]
               	add	x1, x1, #0xb
               	str	x1, [x0]
               	ret

<make>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x30]
               	mov	x8, x0
               	sub	x0, x29, #0x28
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	str	xzr, [x0, #0x20]
               	add	x1, x8, x1
               	str	x1, [x0]
               	add	x1, x2, x3
               	str	x1, [x0, #0x8]
               	add	x1, x4, x5
               	str	x1, [x0, #0x10]
               	add	x1, x6, x7
               	str	x1, [x0, #0x18]
               	ldr	x1, [x29, #0x10]
               	ldr	x2, [x29, #0x18]
               	add	x1, x1, x2
               	str	x1, [x0, #0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x30]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldr	x0, [x16, #0x20]
               	str	x0, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<pair>:
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	ret

<fixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	sxtw	x20, w0
               	sub	x0, x20, #0x64
               	sxtb	x0, w0
               	strb	w0, [sp, #0x28]
               	mov	x17, #-0x12c            // =-300
               	mul	x0, x20, x17
               	sxth	x0, w0
               	strh	w0, [sp, #0x30]
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x20, x17
               	str	w0, [sp, #0x38]
               	mov	x17, #0x100000001       // =4294967297
               	mul	x0, x20, x17
               	str	x0, [sp, #0x40]
               	scvtf	s0, x20
               	fmov	s1, #0.50000000
               	fmul	s0, s0, s1
               	str	s0, [sp, #0x48]
               	scvtf	d0, x20
               	fmov	d1, #0.25000000
               	fmul	d1, d0, d1
               	str	d1, [sp, #0x50]
               	fmov	d1, #1.50000000
               	fmul	d0, d0, d1
               	add	x17, sp, #0x10
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
               	str	x9, [x17]
               	str	x10, [x17, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	stur	x20, [x29, #-0x8]
               	add	x0, sp, #0x58
               	mov	x1, #0x1000             // =4096
               	mov	x2, x20
               	bl	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	ldrsb	x0, [sp, #0x28]
               	add	x0, x0, #0x1
               	strb	w0, [sp, #0x28]
               	ldrsh	x0, [sp, #0x30]
               	sub	x0, x0, #0x2
               	strh	w0, [sp, #0x30]
               	ldrsw	x0, [sp, #0x38]
               	mov	x17, #0x55              // =85
               	eor	x0, x0, x17
               	str	w0, [sp, #0x38]
               	ldr	x0, [sp, #0x40]
               	add	x1, sp, #0x58
               	add	x1, x1, #0x740
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	add	x2, x2, x3
               	ldr	x3, [x1, #0x10]
               	add	x2, x2, x3
               	ldr	x3, [x1, #0x18]
               	add	x2, x2, x3
               	ldr	x3, [x1, #0x20]
               	add	x2, x2, x3
               	ldr	x3, [x1, #0x28]
               	add	x2, x2, x3
               	ldr	x3, [x1, #0x30]
               	add	x2, x2, x3
               	ldr	x3, [x1, #0x38]
               	add	x2, x2, x3
               	add	x0, x0, x2
               	str	x0, [sp, #0x40]
               	ldr	s0, [sp, #0x48]
               	fmov	s1, #1.00000000
               	fadd	s0, s0, s1
               	str	s0, [sp, #0x48]
               	ldr	d0, [sp, #0x50]
               	fmov	d1, #3.00000000
               	fmul	d0, d0, d1
               	str	d0, [sp, #0x50]
               	add	x16, sp, #0x10
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x16]
               	ldr	x10, [x16, #0x8]
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
               	fmov	d1, #0.50000000
               	fsub	d0, d0, d1
               	add	x17, sp, #0x10
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
               	str	x9, [x17]
               	str	x10, [x17, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldrsb	x0, [sp, #0x28]
               	sub	x2, x20, #0x63
               	sxtb	x2, w2
               	cmp	w0, w2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsh	x0, [sp, #0x30]
               	mov	x17, #-0x12c            // =-300
               	mul	x2, x20, x17
               	sub	x2, x2, #0x2
               	sxth	x2, w2
               	cmp	w0, w2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [sp, #0x38]
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x2, x20, x17
               	sxtw	x2, w2
               	mov	x17, #0x55              // =85
               	eor	x2, x2, x17
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	lsl	x2, x3, #3
               	add	x0, x2, #0x7
               	ldrb	w0, [x1, x0]
               	lsl	x0, x0, #8
               	add	x5, x2, #0x6
               	ldrb	w5, [x1, x5]
               	orr	x0, x0, x5
               	lsl	x0, x0, #8
               	add	x5, x2, #0x5
               	ldrb	w5, [x1, x5]
               	orr	x0, x0, x5
               	lsl	x0, x0, #8
               	add	x5, x2, #0x4
               	ldrb	w5, [x1, x5]
               	orr	x0, x0, x5
               	lsl	x0, x0, #8
               	add	x5, x2, #0x3
               	ldrb	w5, [x1, x5]
               	orr	x0, x0, x5
               	lsl	x0, x0, #8
               	add	x5, x2, #0x2
               	ldrb	w5, [x1, x5]
               	orr	x0, x0, x5
               	lsl	x0, x0, #8
               	add	x5, x2, #0x1
               	ldrb	w5, [x1, x5]
               	orr	x0, x0, x5
               	lsl	x0, x0, #8
               	ldrb	w2, [x1, x2]
               	orr	x0, x0, x2
               	add	x4, x4, x0
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lt	<addr>
               	ldr	x0, [sp, #0x40]
               	mov	x17, #0x100000001       // =4294967297
               	mul	x1, x20, x17
               	add	x1, x1, x4
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	s0, [sp, #0x48]
               	scvtf	s1, x20
               	fmov	s2, #0.50000000
               	fmov	s3, #1.00000000
               	fmadd	s1, s1, s2, s3
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d1, [sp, #0x50]
               	scvtf	d0, x20
               	fmov	d2, #0.75000000
               	fmul	d2, d0, d2
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	add	x1, x20, #0xb
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x16, sp, #0x10
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x16]
               	ldr	x10, [x16, #0x8]
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
               	fmov	d1, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	add	sp, sp, #0x40
               	fmov	d2, #1.50000000
               	fmov	d3, #0.50000000
               	fnmsub	d0, d0, d2, d3
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<moving>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x40
               	stp	x20, x21, [sp]
               	sxtw	x20, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x20, x17
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	w0, [x17, #-0x28]
               	lsl	x0, x20, #40
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x0, [x17, #-0x20]
               	scvtf	d0, x20
               	fmov	d1, #4.00000000
               	fdiv	d0, d0, d1
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	d0, [x17, #-0x18]
               	lsl	x0, x20, #1
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x8]
               	lsl	x0, x20, #4
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x21, sp
               	sub	x21, x21, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x21
               	lsl	x1, x20, #4
               	mov	x0, x21
               	mov	x2, x20
               	bl	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x8
               	mov	x1, #0x1000             // =4096
               	add	x2, x20, #0x1
               	bl	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldursw	x0, [x16, #-0x28]
               	ldrb	w1, [x21, #0x3]
               	add	x0, x0, x1
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	w0, [x17, #-0x28]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x1, [x16, #-0x20]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x8
               	ldr	x2, [x0, #0xff8]
               	sub	x1, x1, x2
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x1, [x17, #-0x20]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	d1, [x16, #-0x18]
               	fmov	d0, #2.00000000
               	fadd	d1, d1, d0
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	d1, [x17, #-0x18]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldursw	x1, [x16, #-0x28]
               	mov	x17, #0x3               // =3
               	mul	x2, x20, x17
               	add	x3, x20, #0x3
               	and	x3, x3, #0xff
               	add	x2, x2, x3
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	sub	x16, x16, #0x40
               	mov	sp, x16
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x1, [x16, #-0x20]
               	lsl	x2, x20, #40
               	ldr	x0, [x0, #0xff8]
               	sub	x0, x2, x0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	sub	x16, x16, #0x40
               	mov	sp, x16
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	d1, [x16, #-0x18]
               	scvtf	d2, x20
               	fmov	d3, #4.00000000
               	fdiv	d2, d2, d3
               	fadd	d0, d2, d0
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	sub	x16, x16, #0x40
               	mov	sp, x16
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	lsl	x1, x20, #1
               	add	x1, x1, #0xb
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	sub	x16, x16, #0x40
               	mov	sp, x16
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	sub	x16, x16, #0x40
               	mov	sp, x16
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<wide>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x16, #0x19              // =25
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x16, x16, #0x1
               	b.ne	<addr>
               	sub	sp, sp, #0xd60
               	str	x20, [sp]
               	sxtw	x20, w0
               	sub	x17, x29, #0x10, lsl #12 // =0x10000
               	stur	x20, [x17, #-0x100]
               	neg	x0, x20
               	sub	x17, x29, #0x10, lsl #12 // =0x10000
               	stur	w0, [x17, #-0xf8]
               	scvtf	s0, x20
               	sub	x17, x29, #0x10, lsl #12 // =0x10000
               	stur	s0, [x17, #-0xf0]
               	scvtf	d0, x20
               	fmov	d1, #8.00000000
               	fdiv	d0, d0, d1
               	add	x17, sp, #0x10
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
               	str	x9, [x17]
               	str	x10, [x17, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	sub	x0, x29, #0x10, lsl #12 // =0x10000
               	sub	x0, x0, #0xe8
               	mov	x1, #0x80e8             // =33000
               	mov	x2, x20
               	bl	<addr>
               	add	x0, sp, #0x20
               	mov	x1, #0x9c40             // =40000
               	add	x2, x20, #0x1
               	bl	<addr>
               	sub	x0, x29, #0x8, lsl #12  // =0x8000
               	mov	x1, #0x8000             // =32768
               	add	x2, x20, #0x2
               	bl	<addr>
               	sub	x16, x29, #0x10, lsl #12 // =0x10000
               	ldur	x0, [x16, #-0x100]
               	sub	x1, x29, #0x10, lsl #12 // =0x10000
               	sub	x1, x1, #0xe8
               	mov	x17, #0x80e7            // =32999
               	add	x1, x1, x17
               	ldrb	w1, [x1]
               	mul	x0, x0, x1
               	sub	x17, x29, #0x10, lsl #12 // =0x10000
               	stur	x0, [x17, #-0x100]
               	sub	x16, x29, #0x10, lsl #12 // =0x10000
               	ldursw	x0, [x16, #-0xf8]
               	add	x1, sp, #0x20
               	mov	x17, #0x3039            // =12345
               	add	x1, x1, x17
               	ldrb	w1, [x1]
               	sub	x0, x0, x1
               	sub	x17, x29, #0x10, lsl #12 // =0x10000
               	stur	w0, [x17, #-0xf8]
               	sub	x16, x29, #0x10, lsl #12 // =0x10000
               	ldur	s1, [x16, #-0xf0]
               	fmov	s0, #2.00000000
               	fmul	s1, s1, s0
               	sub	x17, x29, #0x10, lsl #12 // =0x10000
               	stur	s1, [x17, #-0xf0]
               	add	x16, sp, #0x10
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x16]
               	ldr	x10, [x16, #0x8]
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
               	fmov	d2, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	add	sp, sp, #0x40
               	fmov	d1, #1.00000000
               	fadd	d2, d2, d1
               	add	x17, sp, #0x10
               	sub	sp, sp, #0x30
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d2
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
               	str	x9, [x17]
               	str	x10, [x17, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	sub	x16, x29, #0x10, lsl #12 // =0x10000
               	ldur	x0, [x16, #-0x100]
               	mov	x17, #0x80e7            // =32999
               	add	x1, x20, x17
               	and	x1, x1, #0xff
               	mul	x1, x20, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	add	sp, sp, #0x19, lsl #12  // =0x19000
               	add	sp, sp, #0xd60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10, lsl #12 // =0x10000
               	ldursw	x0, [x16, #-0xf8]
               	neg	x1, x20
               	add	x2, x20, #0x1
               	mov	x17, #0x3039            // =12345
               	add	x2, x2, x17
               	and	x2, x2, #0xff
               	sub	x1, x1, x2
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	add	sp, sp, #0x19, lsl #12  // =0x19000
               	add	sp, sp, #0xd60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10, lsl #12 // =0x10000
               	ldur	s2, [x16, #-0xf0]
               	scvtf	s3, x20
               	fmul	s0, s3, s0
               	fcmp	s2, s0
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	add	sp, sp, #0x19, lsl #12  // =0x19000
               	add	sp, sp, #0xd60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x16, sp, #0x10
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x16]
               	ldr	x10, [x16, #0x8]
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
               	scvtf	d2, x20
               	fmov	d3, #8.00000000
               	fdiv	d2, d2, d3
               	fadd	d1, d2, d1
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldr	x20, [sp]
               	add	sp, sp, #0x19, lsl #12  // =0x19000
               	add	sp, sp, #0xd60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8, lsl #12  // =0x8000
               	mov	x17, #0x6458            // =25688
               	add	x1, x0, x17
               	ldrb	w2, [x1]
               	add	x3, x20, #0x2
               	sub	x0, x1, x0
               	add	x0, x3, x0
               	and	x0, x0, #0xff
               	cmp	w2, w0
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldr	x20, [sp]
               	add	sp, sp, #0x19, lsl #12  // =0x19000
               	add	sp, sp, #0xd60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x19, lsl #12  // =0x19000
               	add	sp, sp, #0xd60
               	ldp	x29, x30, [sp], #0x10
               	ret

<results>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x60
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	sxtw	x20, w0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	mov	x1, #0x1000             // =4096
               	mov	x2, x20
               	bl	<addr>
               	add	x1, x20, #0x1
               	add	x2, x20, #0x2
               	add	x3, x20, #0x3
               	add	x4, x20, #0x4
               	add	x5, x20, #0x5
               	add	x6, x20, #0x6
               	add	x7, x20, #0x7
               	add	x0, x20, #0x8
               	add	x8, x20, #0x9
               	sub	sp, sp, #0x10
               	str	x0, [sp]
               	str	x8, [sp, #0x8]
               	mov	x0, x20
               	add	x8, sp, #0x48
               	bl	<addr>
               	add	sp, sp, #0x10
               	add	x0, sp, #0x38
               	ldr	x21, [x0]
               	ldr	x22, [x0, #0x8]
               	ldr	x23, [x0, #0x10]
               	ldr	x24, [x0, #0x18]
               	ldr	x25, [x0, #0x20]
               	ldr	x0, [sp, #0x60]
               	add	x0, x20, x0
               	bl	<addr>
               	str	x0, [sp, #0x50]
               	add	x0, sp, #0x50
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	lsl	x0, x20, #1
               	add	x3, x0, #0x1
               	cmp	x21, x3
               	b.ne	<addr>
               	add	x3, x0, #0x5
               	cmp	x22, x3
               	b.ne	<addr>
               	add	x3, x0, #0x9
               	cmp	x23, x3
               	b.ne	<addr>
               	add	x3, x0, #0xd
               	cmp	x24, x3
               	b.ne	<addr>
               	add	x0, x0, #0x11
               	cmp	x25, x0
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	ldr	x3, [x0]
               	add	x3, x20, x3
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x0, [x0]
               	add	x0, x20, x0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
