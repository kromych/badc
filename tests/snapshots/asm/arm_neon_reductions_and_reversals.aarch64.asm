
arm_neon_reductions_and_reversals.aarch64:	file format elf64-littleaarch64

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

<check_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	q0, [x0]
               	sub	x3, x29, #0x8
               	ldr	x16, [x0]
               	str	x16, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x80               // =128
               	mov	x2, x1
               	mov	x4, x0
               	ldrb	w5, [x3, x0]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrb	w2, [x3, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldur	d1, [x29, #-0x18]
               	addv	b1, v1.8b
               	umov	w0, v1.b[0]
               	and	x0, x0, #0xff
               	and	x3, x4, #0xff
               	cmp	w0, w3
               	b.ne	<addr>
               	ldur	d1, [x29, #-0x18]
               	umaxv	b2, v1.8b
               	umov	w0, v2.b[0]
               	and	x0, x0, #0xff
               	cmp	w0, w2
               	b.ne	<addr>
               	uminv	b1, v1.8b
               	umov	w0, v1.b[0]
               	and	x0, x0, #0xff
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d1, [x29, #-0x18]
               	uaddlv	h1, v1.8b
               	smov	x0, v1.h[0]
               	and	x0, x0, #0xffff
               	and	x1, x4, #0xffff
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x80               // =128
               	mov	x2, x1
               	mov	x4, x0
               	ldrb	w5, [x3, x0]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrb	w2, [x3, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	addv	b1, v0.16b
               	umov	w0, v1.b[0]
               	and	x0, x0, #0xff
               	and	x3, x4, #0xff
               	cmp	w0, w3
               	b.ne	<addr>
               	umaxv	b1, v0.16b
               	umov	w0, v1.b[0]
               	and	x0, x0, #0xff
               	cmp	w0, w2
               	b.ne	<addr>
               	uminv	b1, v0.16b
               	umov	w0, v1.b[0]
               	and	x0, x0, #0xff
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	uaddlv	h0, v0.16b
               	smov	x0, v0.h[0]
               	and	x0, x0, #0xffff
               	and	x1, x4, #0xffff
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	q0, [x0]
               	sub	x3, x29, #0x8
               	ldr	x16, [x0]
               	str	x16, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7f80             // =32640
               	mov	x2, x1
               	mov	x4, x0
               	ldrsh	x5, [x3, x0, lsl #1]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrsh	x2, [x3, x0, lsl #1]
               	ldrsh	x5, [x3, x0, lsl #1]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldur	d1, [x29, #-0x18]
               	addv	h1, v1.4h
               	smov	x0, v1.h[0]
               	sxth	x0, w0
               	sxth	x3, w4
               	cmp	w0, w3
               	b.ne	<addr>
               	ldur	d1, [x29, #-0x18]
               	smaxv	h2, v1.4h
               	smov	x0, v2.h[0]
               	sxth	x0, w0
               	cmp	w0, w2
               	b.ne	<addr>
               	sminv	h1, v1.4h
               	smov	x0, v1.h[0]
               	sxth	x0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d1, [x29, #-0x18]
               	saddlv	s1, v1.4h
               	smov	x0, v1.s[0]
               	cmp	w0, w4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7f80             // =32640
               	mov	x2, x1
               	mov	x4, x0
               	ldrsh	x5, [x3, x0, lsl #1]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrsh	x2, [x3, x0, lsl #1]
               	ldrsh	x5, [x3, x0, lsl #1]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	addv	h1, v0.8h
               	smov	x0, v1.h[0]
               	sxth	x0, w0
               	sxth	x3, w4
               	cmp	w0, w3
               	b.ne	<addr>
               	smaxv	h1, v0.8h
               	smov	x0, v1.h[0]
               	sxth	x0, w0
               	cmp	w0, w2
               	b.ne	<addr>
               	sminv	h1, v0.8h
               	smov	x0, v1.h[0]
               	sxth	x0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	saddlv	s0, v0.8h
               	smov	x0, v0.s[0]
               	cmp	w0, w4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	q0, [x0]
               	sub	x3, x29, #0x8
               	ldr	x16, [x0]
               	str	x16, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7f80             // =32640
               	mov	x2, x1
               	mov	x4, x0
               	ldrh	w5, [x3, x0, lsl #1]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrh	w2, [x3, x0, lsl #1]
               	ldrh	w5, [x3, x0, lsl #1]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldur	d1, [x29, #-0x18]
               	addv	h1, v1.4h
               	smov	x0, v1.h[0]
               	and	x0, x0, #0xffff
               	and	x3, x4, #0xffff
               	cmp	w0, w3
               	b.ne	<addr>
               	ldur	d1, [x29, #-0x18]
               	umaxv	h2, v1.4h
               	smov	x0, v2.h[0]
               	and	x0, x0, #0xffff
               	cmp	w0, w2
               	b.ne	<addr>
               	uminv	h1, v1.4h
               	smov	x0, v1.h[0]
               	and	x0, x0, #0xffff
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d1, [x29, #-0x18]
               	uaddlv	s1, v1.4h
               	smov	x0, v1.s[0]
               	cmp	w0, w4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7f80             // =32640
               	mov	x2, x1
               	mov	x4, x0
               	ldrh	w5, [x3, x0, lsl #1]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrh	w2, [x3, x0, lsl #1]
               	ldrh	w5, [x3, x0, lsl #1]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	addv	h1, v0.8h
               	smov	x0, v1.h[0]
               	and	x0, x0, #0xffff
               	and	x3, x4, #0xffff
               	cmp	w0, w3
               	b.ne	<addr>
               	umaxv	h1, v0.8h
               	smov	x0, v1.h[0]
               	and	x0, x0, #0xffff
               	cmp	w0, w2
               	b.ne	<addr>
               	uminv	h1, v0.8h
               	smov	x0, v1.h[0]
               	and	x0, x0, #0xffff
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	uaddlv	s0, v0.8h
               	smov	x0, v0.s[0]
               	cmp	w0, w4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	q0, [x0]
               	sub	x3, x29, #0x8
               	ldr	x16, [x0]
               	str	x16, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7f80             // =32640
               	movk	x1, #0x1ff, lsl #16
               	mov	x2, x1
               	mov	x4, x0
               	ldrsw	x5, [x3, x0, lsl #2]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrsw	x2, [x3, x0, lsl #2]
               	ldrsw	x5, [x3, x0, lsl #2]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldur	d1, [x29, #-0x18]
               	addp	v1.2s, v1.2s, v1.2s
               	smov	x0, v1.s[0]
               	cmp	w0, w4
               	b.ne	<addr>
               	ldur	d1, [x29, #-0x18]
               	smaxp	v2.2s, v1.2s, v1.2s
               	smov	x0, v2.s[0]
               	cmp	w0, w2
               	b.ne	<addr>
               	sminp	v1.2s, v1.2s, v1.2s
               	smov	x0, v1.s[0]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d1, [x29, #-0x18]
               	saddlp	v1.1d, v1.2s
               	mov	x0, v1.d[0]
               	cmp	x0, x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7f80             // =32640
               	movk	x1, #0x1ff, lsl #16
               	mov	x2, x1
               	mov	x4, x0
               	ldrsw	x5, [x3, x0, lsl #2]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrsw	x2, [x3, x0, lsl #2]
               	ldrsw	x5, [x3, x0, lsl #2]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	addv	s1, v0.4s
               	smov	x0, v1.s[0]
               	cmp	w0, w4
               	b.ne	<addr>
               	smaxv	s1, v0.4s
               	smov	x0, v1.s[0]
               	cmp	w0, w2
               	b.ne	<addr>
               	sminv	s1, v0.4s
               	smov	x0, v1.s[0]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	saddlv	d0, v0.4s
               	mov	x0, v0.d[0]
               	cmp	x0, x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	q0, [x0]
               	sub	x3, x29, #0x8
               	ldr	x16, [x0]
               	str	x16, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7f80             // =32640
               	movk	x1, #0x1ff, lsl #16
               	mov	x2, x1
               	mov	x4, x0
               	ldr	w5, [x3, x0, lsl #2]
               	add	x4, x4, x5
               	cmp	x5, x2
               	b.le	<addr>
               	ldr	w2, [x3, x0, lsl #2]
               	ldr	w5, [x3, x0, lsl #2]
               	cmp	x5, x1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldur	d1, [x29, #-0x18]
               	addp	v1.2s, v1.2s, v1.2s
               	smov	x0, v1.s[0]
               	cmp	w0, w4
               	b.ne	<addr>
               	ldur	d1, [x29, #-0x18]
               	umaxp	v2.2s, v1.2s, v1.2s
               	smov	x0, v2.s[0]
               	cmp	w0, w2
               	b.ne	<addr>
               	uminp	v1.2s, v1.2s, v1.2s
               	smov	x0, v1.s[0]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d1, [x29, #-0x18]
               	uaddlp	v1.1d, v1.2s
               	mov	x0, v1.d[0]
               	cmp	x0, x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7f80             // =32640
               	movk	x1, #0x1ff, lsl #16
               	mov	x2, x1
               	mov	x4, x0
               	ldr	w5, [x3, x0, lsl #2]
               	add	x4, x4, x5
               	cmp	x5, x2
               	b.le	<addr>
               	ldr	w2, [x3, x0, lsl #2]
               	ldr	w5, [x3, x0, lsl #2]
               	cmp	x5, x1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	addv	s1, v0.4s
               	smov	x0, v1.s[0]
               	cmp	w0, w4
               	b.ne	<addr>
               	umaxv	s1, v0.4s
               	smov	x0, v1.s[0]
               	cmp	w0, w2
               	b.ne	<addr>
               	uminv	s1, v0.4s
               	smov	x0, v1.s[0]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	uaddlv	d0, v0.4s
               	mov	x0, v0.d[0]
               	cmp	x0, x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_pairs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x2, x29, #0x30
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x3, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x5, x29, #0x8
               	ldr	x16, [x0]
               	str	x16, [x5]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	ldr	q0, [x0]
               	sub	x1, x29, #0x28
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	q1, [x0]
               	ldur	d2, [x29, #-0x8]
               	saddlp	v2.4h, v2.8b
               	stur	d2, [x29, #-0x8]
               	uaddlp	v0.4s, v0.8h
               	sub	x6, x29, #0x40
               	stur	q0, [x29, #-0x40]
               	ldur	d0, [x29, #-0x28]
               	saddlp	v2.1d, v0.2s
               	uaddlp	v0.2d, v1.4s
               	mov	x0, #0x0                // =0
               	ldrsh	x7, [x5, x0, lsl #1]
               	lsl	x1, x0, #1
               	ldrsb	x8, [x2, x1]
               	add	x4, x1, #0x1
               	ldrsb	x9, [x2, x4]
               	add	x8, x8, x9
               	cmp	w7, w8
               	b.ne	<addr>
               	ldr	w7, [x6, x0, lsl #2]
               	ldrh	w1, [x3, x1, lsl #1]
               	ldrh	w4, [x3, x4, lsl #1]
               	add	x1, x1, x4
               	cmp	w7, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, v2.d[0]
               	mov	x17, #0xd480            // =54400
               	movk	x17, #0x14a9, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v0.d[0]
               	mov	x17, #0xd480            // =54400
               	movk	x17, #0x14a9, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v0.d[1]
               	mov	x17, #0xfb36            // =64310
               	movk	x17, #0x3ec2, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_rev>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x1, x29, #0x70
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x10
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x3, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	q0, [x29, #-0x70]
               	rev16	v1.16b, v0.16b
               	sub	x4, x29, #0x50
               	stur	q1, [x29, #-0x50]
               	rev32	v0.16b, v0.16b
               	sub	x5, x29, #0x40
               	stur	q0, [x29, #-0x40]
               	ldur	q0, [x29, #-0x70]
               	rev64	v0.16b, v0.16b
               	sub	x6, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	ldur	d0, [x29, #-0x10]
               	rev32	v0.4h, v0.4h
               	sub	x7, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	ldur	q0, [x29, #-0x60]
               	rev64	v0.4s, v0.4s
               	sub	x8, x29, #0x20
               	stur	q0, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	ldrsb	x9, [x4, x0]
               	eor	x10, x0, #0x1
               	ldrsb	x10, [x1, x10]
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x5, x0]
               	eor	x10, x0, #0x3
               	ldrsb	x10, [x1, x10]
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x6, x0]
               	eor	x10, x0, #0x7
               	ldrsb	x10, [x1, x10]
               	cmp	w9, w10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldrsh	x4, [x7, x0, lsl #1]
               	eor	x1, x0, #0x1
               	ldrsh	x5, [x2, x1, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrsw	x4, [x8, x0, lsl #2]
               	ldrsw	x1, [x3, x1, lsl #2]
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x1, x29, #0x18
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	q0, [x0]
               	sub	x3, x29, #0x8
               	ldr	x16, [x0]
               	str	x16, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #-0x80              // =-128
               	mov	x2, x1
               	mov	x4, x0
               	ldrsb	x5, [x3, x0]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrsb	x2, [x3, x0]
               	ldrsb	x5, [x3, x0]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldur	d1, [x29, #-0x18]
               	addv	b1, v1.8b
               	umov	w0, v1.b[0]
               	sxtb	x0, w0
               	sxtb	x3, w4
               	cmp	w0, w3
               	b.ne	<addr>
               	ldur	d1, [x29, #-0x18]
               	smaxv	b2, v1.8b
               	umov	w0, v2.b[0]
               	sxtb	x0, w0
               	cmp	w0, w2
               	b.ne	<addr>
               	sminv	b1, v1.8b
               	umov	w0, v1.b[0]
               	sxtb	x0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	bl	<addr>
               	orr	x20, x20, x0, lsl #1
               	bl	<addr>
               	orr	x20, x20, x0, lsl #2
               	bl	<addr>
               	orr	x20, x20, x0, lsl #3
               	bl	<addr>
               	orr	x20, x20, x0, lsl #4
               	bl	<addr>
               	orr	x2, x20, x0, lsl #5
               	sub	x1, x29, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	q0, [x0]
               	addp	v1.2d, v0.2d, v0.2d
               	mov	x0, v1.d[0]
               	mov	x17, #0x7db4            // =32180
               	movk	x17, #0x8081, lsl #16
               	movk	x17, #0x5202, lsl #32
               	movk	x17, #0xd2eb, lsl #48
               	cmp	x0, x17
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	addp	v0.2d, v0.2d, v0.2d
               	mov	x0, v0.d[0]
               	mov	x17, #0x7db4            // =32180
               	movk	x17, #0x8081, lsl #16
               	movk	x17, #0x5202, lsl #32
               	movk	x17, #0xd2eb, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	orr	x20, x2, x0, lsl #6
               	bl	<addr>
               	orr	x20, x20, x0, lsl #7
               	bl	<addr>
               	orr	x0, x20, x0, lsl #8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	ldur	d1, [x29, #-0x18]
               	saddlv	h1, v1.8b
               	smov	x0, v1.h[0]
               	sxth	x0, w0
               	sxth	x1, w4
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	b	<addr>
               	sub	x3, x29, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x1, #-0x80              // =-128
               	mov	x2, x1
               	mov	x4, x0
               	ldrsb	x5, [x3, x0]
               	add	x4, x4, x5
               	cmp	w5, w2
               	b.le	<addr>
               	ldrsb	x2, [x3, x0]
               	ldrsb	x5, [x3, x0]
               	cmp	w5, w1
               	csel	x1, x5, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	addv	b1, v0.16b
               	umov	w0, v1.b[0]
               	sxtb	x0, w0
               	sxtb	x3, w4
               	cmp	w0, w3
               	b.ne	<addr>
               	smaxv	b1, v0.16b
               	umov	w0, v1.b[0]
               	sxtb	x0, w0
               	cmp	w0, w2
               	b.ne	<addr>
               	sminv	b1, v0.16b
               	umov	w0, v1.b[0]
               	sxtb	x0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	b	<addr>
               	saddlv	h0, v0.16b
               	smov	x0, v0.h[0]
               	sxth	x0, w0
               	sxth	x1, w4
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
