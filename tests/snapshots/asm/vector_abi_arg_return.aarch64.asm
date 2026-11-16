
vector_abi_arg_return.aarch64:	file format elf64-littleaarch64

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

<vec_sub>:
               	sub	v0.16b, v1.16b, v0.16b
               	ret

<vec8_sub>:
               	sub	v0.8b, v1.8b, v0.8b
               	ret

<vecf_add>:
               	fadd	v0.4s, v0.4s, v1.4s
               	ret

<wrap_double>:
               	add	v0.16b, v0.16b, v0.16b
               	ret

<nine>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16, #0x8]
               	add	v0.16b, v0.16b, v1.16b
               	add	v0.16b, v0.16b, v2.16b
               	add	v0.16b, v0.16b, v3.16b
               	add	v0.16b, v0.16b, v4.16b
               	add	v0.16b, v0.16b, v5.16b
               	add	v0.16b, v0.16b, v6.16b
               	add	v0.16b, v0.16b, v7.16b
               	ldur	q1, [x29, #-0x10]
               	add	v0.16b, v0.16b, v1.16b
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mixed>:
               	umov	w0, v0.b[0]
               	umov	w1, v2.b[0]
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	scvtf	d0, x0
               	fmadd	d0, d1, d3, d0
               	ret

<wide_sub>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	ldr	q0, [x1]
               	ldr	q1, [x0]
               	sub	v0.16b, v0.16b, v1.16b
               	ldr	q1, [x1, #0x10]
               	ldr	q2, [x0, #0x10]
               	sub	v1.16b, v1.16b, v2.16b
               	sub	x0, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<ramp>:
               	and	x0, x0, #0xff
               	mov	v0.b[0], w0
               	add	x1, x0, #0x1
               	and	x1, x1, #0xff
               	mov	v0.b[1], w1
               	add	x1, x0, #0x2
               	and	x1, x1, #0xff
               	mov	v0.b[2], w1
               	add	x1, x0, #0x3
               	and	x1, x1, #0xff
               	mov	v0.b[3], w1
               	add	x1, x0, #0x4
               	and	x1, x1, #0xff
               	mov	v0.b[4], w1
               	add	x1, x0, #0x5
               	and	x1, x1, #0xff
               	mov	v0.b[5], w1
               	add	x1, x0, #0x6
               	and	x1, x1, #0xff
               	mov	v0.b[6], w1
               	add	x1, x0, #0x7
               	and	x1, x1, #0xff
               	mov	v0.b[7], w1
               	add	x1, x0, #0x8
               	and	x1, x1, #0xff
               	mov	v0.b[8], w1
               	add	x1, x0, #0x9
               	and	x1, x1, #0xff
               	mov	v0.b[9], w1
               	add	x1, x0, #0xa
               	and	x1, x1, #0xff
               	mov	v0.b[10], w1
               	add	x1, x0, #0xb
               	and	x1, x1, #0xff
               	mov	v0.b[11], w1
               	add	x1, x0, #0xc
               	and	x1, x1, #0xff
               	mov	v0.b[12], w1
               	add	x1, x0, #0xd
               	and	x1, x1, #0xff
               	mov	v0.b[13], w1
               	add	x1, x0, #0xe
               	and	x1, x1, #0xff
               	mov	v0.b[14], w1
               	add	x0, x0, #0xf
               	and	x0, x0, #0xff
               	mov	v0.b[15], w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	str	q0, [sp, #0xd0]
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	ldr	q17, [sp, #0xd0]
               	sub	v0.16b, v0.16b, v17.16b
               	umov	w0, v0.b[0]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	umov	w0, v0.b[1]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[2]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[3]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[4]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[5]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[6]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[7]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[8]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[9]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[10]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[11]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[12]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[13]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[14]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	umov	w0, v0.b[15]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	mov	x16, #0x201             // =513
               	movk	x16, #0x403, lsl #16
               	movk	x16, #0x605, lsl #32
               	movk	x16, #0x807, lsl #48
               	fmov	d0, x16
               	mov	x16, #0x2928            // =10536
               	movk	x16, #0x2b2a, lsl #16
               	movk	x16, #0x2d2c, lsl #32
               	movk	x16, #0x2f2e, lsl #48
               	fmov	d1, x16
               	sub	v0.8b, v1.8b, v0.8b
               	umov	w0, v0.b[0]
               	cmp	w0, #0x27
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	umov	w0, v0.b[1]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	umov	w0, v0.b[2]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	umov	w0, v0.b[3]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	umov	w0, v0.b[4]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	umov	w0, v0.b[5]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	umov	w0, v0.b[6]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	umov	w0, v0.b[7]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	fadd	v0.4s, v0.4s, v1.4s
               	mov	s1, v0.s[0]
               	fmov	s2, #11.00000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s1, v0.s[1]
               	fmov	s2, #22.00000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s1, v0.s[2]
               	mov	x16, #0x42040000        // =1107558400
               	fmov	s2, w16
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s0, v0.s[3]
               	mov	x16, #0x42300000        // =1110441984
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	add	v0.16b, v0.16b, v0.16b
               	umov	w0, v0.b[0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	umov	w0, v0.b[1]
               	cmp	x0, #0x6
               	b.ne	<addr>
               	umov	w0, v0.b[2]
               	cmp	x0, #0x8
               	b.ne	<addr>
               	umov	w0, v0.b[3]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	umov	w0, v0.b[4]
               	cmp	x0, #0xc
               	b.ne	<addr>
               	umov	w0, v0.b[5]
               	cmp	x0, #0xe
               	b.ne	<addr>
               	umov	w0, v0.b[6]
               	cmp	x0, #0x10
               	b.ne	<addr>
               	umov	w0, v0.b[7]
               	cmp	x0, #0x12
               	b.ne	<addr>
               	umov	w0, v0.b[8]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	umov	w0, v0.b[9]
               	cmp	x0, #0x16
               	b.ne	<addr>
               	umov	w0, v0.b[10]
               	cmp	x0, #0x18
               	b.ne	<addr>
               	umov	w0, v0.b[11]
               	cmp	x0, #0x1a
               	b.ne	<addr>
               	umov	w0, v0.b[12]
               	cmp	x0, #0x1c
               	b.ne	<addr>
               	umov	w0, v0.b[13]
               	cmp	x0, #0x1e
               	b.ne	<addr>
               	umov	w0, v0.b[14]
               	cmp	x0, #0x20
               	b.ne	<addr>
               	umov	w0, v0.b[15]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	add	v1.16b, v0.16b, v0.16b
               	add	v1.16b, v1.16b, v0.16b
               	add	v1.16b, v1.16b, v0.16b
               	add	v1.16b, v1.16b, v0.16b
               	add	v1.16b, v1.16b, v0.16b
               	add	v1.16b, v1.16b, v0.16b
               	add	v1.16b, v1.16b, v0.16b
               	add	v0.16b, v1.16b, v0.16b
               	sub	x1, x29, #0xe0
               	stur	q0, [x29, #-0xe0]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	add	x3, x0, #0x1
               	add	x3, x3, x3, lsl #3
               	and	x3, x3, #0xff
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	str	q0, [sp, #0xd0]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	ldr	q16, [sp, #0xd0]
               	umov	w0, v16.b[0]
               	umov	w1, v0.b[0]
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	scvtf	d0, x0
               	fmov	d1, #12.00000000
               	fadd	d0, d0, d1
               	mov	x16, #0x404a000000000000 // =4632515166703976448
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xe0
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	sub	x2, x29, #0xc0
               	add	x3, x0, #0x46
               	strb	w3, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0xc0
               	sub	x2, x29, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x0, x29, #0xe0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldur	q0, [x29, #-0xc0]
               	ldur	q1, [x29, #-0xa0]
               	sub	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0xb0]
               	ldur	q2, [x29, #-0x90]
               	sub	v1.16b, v1.16b, v2.16b
               	stur	q0, [x29, #-0xe0]
               	stur	q1, [x29, #-0xd0]
               	umov	w0, v0.b[0]
               	umov	w1, v0.b[1]
               	umov	w2, v0.b[2]
               	umov	w3, v0.b[3]
               	umov	w4, v0.b[4]
               	umov	w5, v0.b[5]
               	umov	w6, v0.b[6]
               	umov	w7, v0.b[7]
               	umov	w8, v0.b[8]
               	umov	w9, v0.b[9]
               	umov	w10, v0.b[10]
               	umov	w11, v0.b[11]
               	umov	w12, v0.b[12]
               	umov	w13, v0.b[13]
               	umov	w14, v0.b[14]
               	ldurb	w15, [x29, #-0xd1]
               	ldurb	w17, [x29, #-0xd0]
               	str	x17, [sp, #0xd8]
               	ldurb	w17, [x29, #-0xcf]
               	str	x17, [sp, #0xd0]
               	ldurb	w17, [x29, #-0xce]
               	str	x17, [sp, #0xc8]
               	ldurb	w17, [x29, #-0xcd]
               	str	x17, [sp, #0xc0]
               	ldurb	w17, [x29, #-0xcc]
               	str	x17, [sp, #0xb8]
               	ldurb	w17, [x29, #-0xcb]
               	str	x17, [sp, #0xb0]
               	ldurb	w17, [x29, #-0xca]
               	str	x17, [sp, #0xa8]
               	ldurb	w17, [x29, #-0xc9]
               	str	x17, [sp, #0xa0]
               	ldurb	w17, [x29, #-0xc8]
               	str	x17, [sp, #0x98]
               	ldurb	w17, [x29, #-0xc7]
               	str	x17, [sp, #0x90]
               	ldurb	w17, [x29, #-0xc6]
               	str	x17, [sp, #0x88]
               	ldurb	w17, [x29, #-0xc5]
               	str	x17, [sp, #0x80]
               	ldurb	w17, [x29, #-0xc4]
               	str	x17, [sp, #0x78]
               	ldurb	w17, [x29, #-0xc3]
               	str	x17, [sp, #0x70]
               	ldurb	w17, [x29, #-0xc2]
               	str	x17, [sp, #0x68]
               	ldurb	w17, [x29, #-0xc1]
               	str	x17, [sp, #0x60]
               	sturb	w0, [x29, #-0xa0]
               	sturb	w1, [x29, #-0x9f]
               	sturb	w2, [x29, #-0x9e]
               	sturb	w3, [x29, #-0x9d]
               	sturb	w4, [x29, #-0x9c]
               	sturb	w5, [x29, #-0x9b]
               	sturb	w6, [x29, #-0x9a]
               	sturb	w7, [x29, #-0x99]
               	sturb	w8, [x29, #-0x98]
               	sturb	w9, [x29, #-0x97]
               	sturb	w10, [x29, #-0x96]
               	sturb	w11, [x29, #-0x95]
               	sturb	w12, [x29, #-0x94]
               	sturb	w13, [x29, #-0x93]
               	sturb	w14, [x29, #-0x92]
               	sturb	w15, [x29, #-0x91]
               	ldr	x16, [sp, #0xd8]
               	sturb	w16, [x29, #-0x90]
               	ldr	x16, [sp, #0xd0]
               	sturb	w16, [x29, #-0x8f]
               	ldr	x16, [sp, #0xc8]
               	sturb	w16, [x29, #-0x8e]
               	ldr	x16, [sp, #0xc0]
               	sturb	w16, [x29, #-0x8d]
               	ldr	x16, [sp, #0xb8]
               	sturb	w16, [x29, #-0x8c]
               	ldr	x16, [sp, #0xb0]
               	sturb	w16, [x29, #-0x8b]
               	ldr	x16, [sp, #0xa8]
               	sturb	w16, [x29, #-0x8a]
               	ldr	x16, [sp, #0xa0]
               	sturb	w16, [x29, #-0x89]
               	ldr	x16, [sp, #0x98]
               	sturb	w16, [x29, #-0x88]
               	ldr	x16, [sp, #0x90]
               	sturb	w16, [x29, #-0x87]
               	ldr	x16, [sp, #0x88]
               	sturb	w16, [x29, #-0x86]
               	ldr	x16, [sp, #0x80]
               	sturb	w16, [x29, #-0x85]
               	ldr	x16, [sp, #0x78]
               	sturb	w16, [x29, #-0x84]
               	ldr	x16, [sp, #0x70]
               	sturb	w16, [x29, #-0x83]
               	ldr	x16, [sp, #0x68]
               	sturb	w16, [x29, #-0x82]
               	ldr	x16, [sp, #0x60]
               	sturb	w16, [x29, #-0x81]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xa0
               	ldrb	w1, [x1, x0]
               	cmp	w1, #0x45
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
