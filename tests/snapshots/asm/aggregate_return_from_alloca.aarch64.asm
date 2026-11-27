
aggregate_return_from_alloca.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	adrp	x1, <page>
               	str	x0, [x1, #0x50]
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
               	add	x22, x21, x21, lsl #1
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	add	x0, x20, x1, lsl #4
               	add	x2, x1, x22
               	scvtf	d0, x2
               	add	x16, x0, #0x0
               	fmov	x17, d0
               	bl	<addr>
               	add	x1, x1, #0x1
               	cmp	x1, x21
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x22, x21
               	add	x16, x20, #0x0
               	bl	<addr>
               	fmov	d0, x16
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	add	x16, x20, #0x0
               	fmov	x17, d0
               	bl	<addr>
               	mov	x16, x20
               	ldr	q0, [x16]
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldp	x9, x10, [x16]
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
               	mov	x16, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	add	sp, sp, #0x40
               	ret
               	sub	sp, sp, #0x30
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	mov	x9, x17
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
               	stp	x9, x10, [x16]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
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
               	add	x22, x21, x21, lsl #1
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	add	x2, x20, x1, lsl #3
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
               	mov	x20, x0
               	lsl	x0, x20, #3
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
               	add	x22, x20, x20, lsl #1
               	mov	x1, #0x0                // =0
               	cmp	x1, x20
               	b.ge	<addr>
               	add	x0, x1, x22
               	str	x0, [x21, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	x1, x20
               	b.lt	<addr>
               	mov	x0, x21
               	bl	<addr>
               	add	x0, x22, x20
               	ldr	x1, [x21]
               	add	x0, x1, x0
               	str	x0, [x21]
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
               	add	x22, x21, x21, lsl #1
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	add	x2, x20, x1, lsl #3
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
               	ldr	x0, [x20]
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
               	add	x22, x21, x21, lsl #1
               	mov	x1, #0x0                // =0
               	cmp	x1, x21
               	b.ge	<addr>
               	add	x2, x20, x1, lsl #4
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
               	fmov	x1, d0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
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
               	add	x21, x22, x22, lsl #1
               	mov	x1, #0x0                // =0
               	mov	x5, #0xc                // =12
               	cmp	x1, x22
               	b.ge	<addr>
               	mul	x4, x1, x5
               	add	x2, x1, x21
               	and	x0, x2, #0xff
               	strb	w0, [x20, x4]
               	add	x3, x20, x4
               	add	x0, x2, #0x1
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x1]
               	add	x0, x2, #0x2
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x2]
               	add	x0, x2, #0x3
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x3]
               	add	x0, x2, #0x4
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x4]
               	add	x0, x2, #0x5
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x5]
               	add	x0, x2, #0x6
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x6]
               	add	x3, x20, x4
               	add	x2, x1, x21
               	add	x0, x2, #0x7
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x7]
               	add	x0, x2, #0x8
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x8]
               	mul	x0, x1, x5
               	add	x3, x20, x0
               	add	x0, x2, #0x9
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x9]
               	add	x0, x2, #0xa
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0xa]
               	add	x0, x2, #0xb
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0xb]
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
               	orr	x0, x0, x1, lsl #8
               	ldrb	w1, [x20, #0x2]
               	orr	x0, x0, x1, lsl #16
               	ldrb	w1, [x20, #0x3]
               	orr	x0, x0, x1, lsl #24
               	ldrb	w1, [x20, #0x4]
               	orr	x0, x0, x1, lsl #32
               	ldrb	w1, [x20, #0x5]
               	orr	x0, x0, x1, lsl #40
               	ldrb	w1, [x20, #0x6]
               	orr	x0, x0, x1, lsl #48
               	ldrb	w1, [x20, #0x7]
               	orr	x0, x0, x1, lsl #56
               	ldrb	w1, [x20, #0x8]
               	ldrb	w2, [x20, #0x9]
               	orr	x1, x1, x2, lsl #8
               	ldrb	w2, [x20, #0xa]
               	orr	x1, x1, x2, lsl #16
               	ldrb	w2, [x20, #0xb]
               	orr	x1, x1, x2, lsl #24
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	stp	x20, x21, [sp, #0x40]
               	stp	x22, x23, [sp, #0x50]
               	stp	x24, x25, [sp, #0x60]
               	adrp	x0, <page>
               	ldr	x20, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mul	x22, x20, x1
               	ldr	x1, [x0, #0x8]
               	mul	x23, x20, x1
               	ldr	x1, [x0, #0x10]
               	mul	x24, x20, x1
               	ldr	x0, [x0, #0x18]
               	mul	x25, x20, x0
               	mov	x17, #0x7               // =7
               	mul	x21, x20, x17
               	mov	x0, x20
               	bl	<addr>
               	stur	q0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x16, sp, #0x70
               	bl	<addr>
               	fmov	d0, x16
               	scvtf	d1, x21
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	scvtf	s2, x21
               	fcmp	s0, s2
               	b.ne	<addr>
               	add	x0, x21, #0x1
               	scvtf	s0, x0
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, x21
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	scvtf	s1, x21
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x4]
               	add	x1, x21, #0x1
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	fmov	d0, x0
               	scvtf	d1, x21
               	fcmp	d0, d1
               	b.ne	<addr>
               	add	x0, x21, #0x2
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	lsr	x2, x0, #56
               	and	x3, x0, #0xff
               	ubfx	x4, x0, #8, #8
               	ubfx	x5, x0, #16, #8
               	ubfx	x6, x0, #24, #8
               	ubfx	x7, x0, #32, #8
               	ubfx	x8, x0, #40, #8
               	ubfx	x0, x0, #48, #8
               	and	x9, x1, #0xff
               	ubfx	x10, x1, #8, #8
               	ubfx	x11, x1, #16, #8
               	ubfx	x1, x1, #24, #8
               	and	x12, x21, #0xff
               	cmp	w3, w12
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x3, x21, #0x1
               	and	x3, x3, #0xff
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x21, #0x2
               	and	x3, x3, #0xff
               	cmp	w5, w3
               	b.ne	<addr>
               	add	x3, x21, #0x3
               	and	x3, x3, #0xff
               	cmp	w6, w3
               	b.ne	<addr>
               	add	x3, x21, #0x4
               	and	x3, x3, #0xff
               	cmp	w7, w3
               	b.ne	<addr>
               	add	x3, x21, #0x5
               	and	x3, x3, #0xff
               	cmp	w8, w3
               	b.ne	<addr>
               	add	x3, x21, #0x6
               	and	x3, x3, #0xff
               	cmp	w0, w3
               	b.ne	<addr>
               	add	x0, x21, #0x7
               	and	x0, x0, #0xff
               	cmp	w2, w0
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	and	x0, x0, #0xff
               	cmp	w9, w0
               	b.ne	<addr>
               	add	x0, x21, #0x9
               	and	x0, x0, #0xff
               	cmp	w10, w0
               	b.ne	<addr>
               	add	x0, x21, #0xa
               	and	x0, x0, #0xff
               	cmp	w11, w0
               	b.ne	<addr>
               	add	x0, x21, #0xb
               	and	x0, x0, #0xff
               	cmp	w1, w0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mul	x1, x20, x1
               	cmp	x22, x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	mul	x1, x20, x1
               	cmp	x23, x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	mul	x1, x20, x1
               	cmp	x24, x1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x18]
               	mul	x0, x20, x0
               	cmp	x25, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x24, x25, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldp	x9, x10, [x16]
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
               	mov	x16, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	ret
