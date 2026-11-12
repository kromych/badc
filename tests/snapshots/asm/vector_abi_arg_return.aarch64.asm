
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
               	sub	x2, x29, #0x30
               	ldrb	w3, [x1]
               	ldrb	w4, [x0]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x30]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x0, #0x1]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x2f]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x0, #0x2]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x2e]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x0, #0x3]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x2d]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x0, #0x4]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x2c]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x0, #0x5]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x2b]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x0, #0x6]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x2a]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x0, #0x7]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x29]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x0, #0x8]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x28]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x0, #0x9]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x27]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x0, #0xa]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x26]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x0, #0xb]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x25]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x0, #0xc]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x24]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x0, #0xd]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x23]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x0, #0xe]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x22]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x0, #0xf]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x21]
               	ldrb	w3, [x1, #0x10]
               	ldrb	w4, [x0, #0x10]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x20]
               	ldrb	w3, [x1, #0x11]
               	ldrb	w4, [x0, #0x11]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x1f]
               	ldrb	w3, [x1, #0x12]
               	ldrb	w4, [x0, #0x12]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x1e]
               	ldrb	w3, [x1, #0x13]
               	ldrb	w4, [x0, #0x13]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x1d]
               	ldrb	w3, [x1, #0x14]
               	ldrb	w4, [x0, #0x14]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x1c]
               	ldrb	w3, [x1, #0x15]
               	ldrb	w4, [x0, #0x15]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x1b]
               	ldrb	w3, [x1, #0x16]
               	ldrb	w4, [x0, #0x16]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x1a]
               	ldrb	w3, [x1, #0x17]
               	ldrb	w4, [x0, #0x17]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x19]
               	ldrb	w3, [x1, #0x18]
               	ldrb	w4, [x0, #0x18]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x18]
               	ldrb	w3, [x1, #0x19]
               	ldrb	w4, [x0, #0x19]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x17]
               	ldrb	w3, [x1, #0x1a]
               	ldrb	w4, [x0, #0x1a]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x16]
               	ldrb	w3, [x1, #0x1b]
               	ldrb	w4, [x0, #0x1b]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x15]
               	ldrb	w3, [x1, #0x1c]
               	ldrb	w4, [x0, #0x1c]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x14]
               	ldrb	w3, [x1, #0x1d]
               	ldrb	w4, [x0, #0x1d]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x13]
               	ldrb	w3, [x1, #0x1e]
               	ldrb	w4, [x0, #0x1e]
               	sub	x3, x3, x4
               	sturb	w3, [x29, #-0x12]
               	ldrb	w1, [x1, #0x1f]
               	ldrb	w0, [x0, #0x1f]
               	sub	x0, x1, x0
               	sturb	w0, [x29, #-0x11]
               	mov	x16, x2
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
               	mov	x1, #0x0                // =0
               	fmov	d0, x1
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
               	sub	sp, sp, #0x90
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	str	q0, [sp, #0x80]
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	ldr	q17, [sp, #0x80]
               	sub	v0.16b, v0.16b, v17.16b
               	umov	w0, v0.b[0]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
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
               	add	sp, sp, #0x90
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
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	add	v0.16b, v0.16b, v0.16b
               	umov	w0, v0.b[0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
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
               	sub	x1, x29, #0x90
               	stur	q0, [x29, #-0x90]
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
               	str	q0, [sp, #0x80]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	ldr	q16, [sp, #0x80]
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
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x70
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	sub	x2, x29, #0x90
               	add	x3, x0, #0x46
               	strb	w3, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x90
               	sub	x0, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x90
               	bl	<addr>
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0x45
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
