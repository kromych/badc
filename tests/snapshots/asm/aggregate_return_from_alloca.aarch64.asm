
aggregate_return_from_alloca.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	ret

<fl>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	lsl	x0, x21, #4
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x17, #0x3               // =3
               	mul	x22, x21, x17
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	lsl	x0, x1, #4
               	add	x0, x20, x0
               	add	x2, x1, x22
               	scvtf	d0, x2
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
               	add	x1, x1, #0x1
               	cmp	x1, x21
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x22, x21
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x20]
               	ldr	x10, [x20, #0x8]
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
               	scvtf	d1, x0
               	fadd	d0, d0, d1
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
               	str	x9, [x20]
               	str	x10, [x20, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	mov	x16, x20
               	ldr	q0, [x16]
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<ff>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	lsl	x0, x21, #3
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x17, #0x3               // =3
               	mul	x22, x21, x17
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	lsl	x0, x1, #3
               	add	x2, x20, x0
               	add	x3, x1, x22
               	scvtf	s0, x3
               	add	x0, x3, #0x1
               	scvtf	s1, x0
               	str	s0, [x2]
               	str	s1, [x2, #0x4]
               	add	x1, x1, #0x1
               	cmp	x1, x21
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x22, x21
               	ldr	s1, [x20]
               	scvtf	s0, x0
               	fadd	s1, s1, s0
               	str	s1, [x20]
               	ldr	s1, [x20]
               	ldr	s2, [x20, #0x4]
               	fadd	s0, s2, s0
               	str	s0, [x20, #0x4]
               	ldr	s0, [x20, #0x4]
               	fmov	d17, d1
               	fmov	d1, d0
               	fmov	d0, d17
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<fu>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	lsl	x0, x21, #3
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x17, #0x3               // =3
               	mul	x22, x21, x17
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	add	x0, x1, x22
               	str	x0, [x20, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	x1, x21
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x22, x21
               	ldr	x1, [x20]
               	add	x0, x1, x0
               	str	x0, [x20]
               	mov	x16, x20
               	ldr	x0, [x16]
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<fi>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	lsl	x0, x21, #3
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x17, #0x3               // =3
               	mul	x22, x21, x17
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	lsl	x0, x1, #3
               	add	x2, x20, x0
               	add	x3, x1, x22
               	scvtf	s0, x3
               	add	x0, x3, #0x1
               	str	s0, [x2]
               	str	w0, [x2, #0x4]
               	add	x1, x1, #0x1
               	cmp	x1, x21
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x22, x21
               	ldr	s0, [x20]
               	scvtf	s1, x0
               	fadd	s0, s0, s1
               	str	s0, [x20]
               	ldrsw	x1, [x20, #0x4]
               	add	x0, x1, x0
               	str	w0, [x20, #0x4]
               	mov	x16, x20
               	ldr	x0, [x16]
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<fm>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	lsl	x0, x21, #4
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x17, #0x3               // =3
               	mul	x22, x21, x17
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	lsl	x0, x1, #4
               	add	x2, x20, x0
               	add	x3, x1, x22
               	scvtf	d0, x3
               	add	x0, x3, #0x2
               	str	d0, [x2]
               	str	x0, [x2, #0x8]
               	add	x1, x1, #0x1
               	cmp	x1, x21
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x22, x21
               	ldr	d0, [x20]
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	str	d0, [x20]
               	ldr	x1, [x20, #0x8]
               	add	x0, x1, x0
               	str	x0, [x20, #0x8]
               	mov	x16, x20
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<fc>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x22, x0
               	mov	x17, #0xc               // =12
               	mul	x0, x22, x17
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x17, #0x3               // =3
               	mul	x21, x22, x17
               	mov	x1, #0x0                // =0
               	mov	x4, #0xc                // =12
               	cmp	x1, x22
               	b.ge	<addr>
               	mul	x5, x1, x4
               	add	x2, x20, x5
               	add	x3, x1, x21
               	and	x0, x3, #0xff
               	strb	w0, [x2]
               	add	x0, x3, #0x1
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x1]
               	add	x0, x3, #0x2
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x2]
               	add	x0, x3, #0x3
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x3]
               	add	x0, x3, #0x4
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x4]
               	add	x0, x3, #0x5
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x5]
               	add	x3, x1, x21
               	add	x0, x3, #0x6
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x6]
               	add	x0, x20, x5
               	add	x2, x3, #0x7
               	and	x2, x2, #0xff
               	strb	w2, [x0, #0x7]
               	mul	x0, x1, x4
               	add	x2, x20, x0
               	add	x0, x3, #0x8
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x8]
               	add	x0, x3, #0x9
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x9]
               	add	x0, x3, #0xa
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0xa]
               	add	x0, x3, #0xb
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0xb]
               	add	x1, x1, #0x1
               	cmp	x1, x22
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x21, x22
               	ldrb	w1, [x20]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20]
               	ldrb	w1, [x20, #0x1]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x1]
               	ldrb	w1, [x20, #0x2]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x2]
               	ldrb	w1, [x20, #0x3]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x3]
               	ldrb	w1, [x20, #0x4]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x4]
               	ldrb	w1, [x20, #0x5]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x5]
               	ldrb	w1, [x20, #0x6]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x6]
               	ldrb	w1, [x20, #0x7]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x7]
               	ldrb	w1, [x20, #0x8]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x8]
               	ldrb	w1, [x20, #0x9]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0x9]
               	ldrb	w1, [x20, #0xa]
               	add	x1, x1, x0
               	and	x1, x1, #0xff
               	strb	w1, [x20, #0xa]
               	ldrb	w1, [x20, #0xb]
               	add	x0, x1, x0
               	and	x0, x0, #0xff
               	strb	w0, [x20, #0xb]
               	ldrb	w0, [x20]
               	ldrb	w1, [x20, #0x1]
               	lsl	x1, x1, #8
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x2]
               	lsl	x1, x1, #16
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x3]
               	lsl	x1, x1, #24
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x4]
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x5]
               	lsl	x1, x1, #40
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x6]
               	lsl	x1, x1, #48
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x7]
               	lsl	x1, x1, #56
               	orr	x0, x0, x1
               	ldrb	w1, [x20, #0x8]
               	ldrb	w2, [x20, #0x9]
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	ldrb	w2, [x20, #0xa]
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	ldrb	w2, [x20, #0xb]
               	lsl	x2, x2, #24
               	orr	x1, x1, x2
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	stp	x20, x21, [sp, #0x40]
               	stp	x22, x23, [sp, #0x50]
               	stp	x24, x25, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mul	x22, x21, x1
               	ldr	x1, [x0, #0x8]
               	mul	x23, x21, x1
               	ldr	x1, [x0, #0x10]
               	mul	x24, x21, x1
               	ldr	x0, [x0, #0x18]
               	mul	x25, x21, x0
               	mov	x17, #0x7               // =7
               	mul	x20, x21, x17
               	mov	x0, x21
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
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
               	scvtf	d1, x20
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	stur	s0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	stur	s1, [x29, #-0x4]
               	sub	x1, x29, #0x18
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x18]
               	scvtf	s1, x20
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x14]
               	add	x0, x20, #0x1
               	scvtf	s1, x0
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	ldur	s0, [x29, #-0x28]
               	scvtf	s1, x20
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x24]
               	add	x1, x20, #0x1
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	ldur	d0, [x29, #-0x20]
               	scvtf	d1, x20
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x18]
               	add	x1, x20, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	w1, [x0, #0x8]
               	ldurb	w0, [x29, #-0x10]
               	ldurb	w1, [x29, #-0xf]
               	ldurb	w2, [x29, #-0xe]
               	ldurb	w3, [x29, #-0xd]
               	ldurb	w4, [x29, #-0xc]
               	ldurb	w5, [x29, #-0xb]
               	ldurb	w6, [x29, #-0xa]
               	ldurb	w7, [x29, #-0x9]
               	ldurb	w8, [x29, #-0x8]
               	ldurb	w9, [x29, #-0x7]
               	ldurb	w10, [x29, #-0x6]
               	ldurb	w11, [x29, #-0x5]
               	and	x12, x20, #0xff
               	cmp	w0, w12
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x1
               	and	x0, x0, #0xff
               	cmp	w1, w0
               	b.ne	<addr>
               	add	x0, x20, #0x2
               	and	x0, x0, #0xff
               	cmp	w2, w0
               	b.ne	<addr>
               	add	x0, x20, #0x3
               	and	x0, x0, #0xff
               	cmp	w3, w0
               	b.ne	<addr>
               	add	x0, x20, #0x4
               	and	x0, x0, #0xff
               	cmp	w4, w0
               	b.ne	<addr>
               	add	x0, x20, #0x5
               	and	x0, x0, #0xff
               	cmp	w5, w0
               	b.ne	<addr>
               	add	x0, x20, #0x6
               	and	x0, x0, #0xff
               	cmp	w6, w0
               	b.ne	<addr>
               	add	x0, x20, #0x7
               	and	x0, x0, #0xff
               	cmp	w7, w0
               	b.ne	<addr>
               	add	x0, x20, #0x8
               	and	x0, x0, #0xff
               	cmp	w8, w0
               	b.ne	<addr>
               	add	x0, x20, #0x9
               	and	x0, x0, #0xff
               	cmp	w9, w0
               	b.ne	<addr>
               	add	x0, x20, #0xa
               	and	x0, x0, #0xff
               	cmp	w10, w0
               	b.ne	<addr>
               	add	x0, x20, #0xb
               	and	x0, x0, #0xff
               	cmp	w11, w0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mul	x1, x21, x1
               	cmp	x22, x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	mul	x1, x21, x1
               	cmp	x23, x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	mul	x1, x21, x1
               	cmp	x24, x1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x18]
               	mul	x0, x21, x0
               	cmp	x25, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
