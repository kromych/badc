
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	d0, [x29, #-0x8]
               	stur	d1, [x29, #-0x10]
               	ldurb	w0, [x29, #-0x10]
               	ldurb	w1, [x29, #-0x8]
               	sub	x0, x0, x1
               	sturb	w0, [x29, #-0x18]
               	ldurb	w0, [x29, #-0xf]
               	ldurb	w1, [x29, #-0x7]
               	sub	x0, x0, x1
               	sturb	w0, [x29, #-0x17]
               	ldurb	w0, [x29, #-0xe]
               	ldurb	w1, [x29, #-0x6]
               	sub	x0, x0, x1
               	sturb	w0, [x29, #-0x16]
               	ldurb	w0, [x29, #-0xd]
               	ldurb	w1, [x29, #-0x5]
               	sub	x0, x0, x1
               	sturb	w0, [x29, #-0x15]
               	ldurb	w0, [x29, #-0xc]
               	ldurb	w1, [x29, #-0x4]
               	sub	x0, x0, x1
               	sturb	w0, [x29, #-0x14]
               	ldurb	w0, [x29, #-0xb]
               	ldurb	w1, [x29, #-0x3]
               	sub	x0, x0, x1
               	sturb	w0, [x29, #-0x13]
               	ldurb	w0, [x29, #-0xa]
               	ldurb	w1, [x29, #-0x2]
               	sub	x0, x0, x1
               	sturb	w0, [x29, #-0x12]
               	ldurb	w0, [x29, #-0x9]
               	ldurb	w1, [x29, #-0x1]
               	sub	x0, x0, x1
               	sturb	w0, [x29, #-0x11]
               	ldur	d0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	q0, [x29, #-0x20]
               	stur	q2, [x29, #-0x10]
               	ldurb	w0, [x29, #-0x20]
               	ldurb	w1, [x29, #-0x10]
               	sub	x0, x0, x1
               	scvtf	d0, x0
               	fmadd	d0, d1, d3, d0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<wide_sub>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	sub	x0, x29, #0x90
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x70
               	ldur	x1, [x29, #-0x20]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x50
               	ldurb	w1, [x29, #-0x70]
               	ldurb	w2, [x29, #-0x90]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x50]
               	ldurb	w1, [x29, #-0x6f]
               	ldurb	w2, [x29, #-0x8f]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x4f]
               	ldurb	w1, [x29, #-0x6e]
               	ldurb	w2, [x29, #-0x8e]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x4e]
               	ldurb	w1, [x29, #-0x6d]
               	ldurb	w2, [x29, #-0x8d]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x4d]
               	ldurb	w1, [x29, #-0x6c]
               	ldurb	w2, [x29, #-0x8c]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x4c]
               	ldurb	w1, [x29, #-0x6b]
               	ldurb	w2, [x29, #-0x8b]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x4b]
               	ldurb	w1, [x29, #-0x6a]
               	ldurb	w2, [x29, #-0x8a]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x4a]
               	ldurb	w1, [x29, #-0x69]
               	ldurb	w2, [x29, #-0x89]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x49]
               	ldurb	w1, [x29, #-0x68]
               	ldurb	w2, [x29, #-0x88]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x48]
               	ldurb	w1, [x29, #-0x67]
               	ldurb	w2, [x29, #-0x87]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x47]
               	ldurb	w1, [x29, #-0x66]
               	ldurb	w2, [x29, #-0x86]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x46]
               	ldurb	w1, [x29, #-0x65]
               	ldurb	w2, [x29, #-0x85]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x45]
               	ldurb	w1, [x29, #-0x64]
               	ldurb	w2, [x29, #-0x84]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x44]
               	ldurb	w1, [x29, #-0x63]
               	ldurb	w2, [x29, #-0x83]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x43]
               	ldurb	w1, [x29, #-0x62]
               	ldurb	w2, [x29, #-0x82]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x42]
               	ldurb	w1, [x29, #-0x61]
               	ldurb	w2, [x29, #-0x81]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x41]
               	ldurb	w1, [x29, #-0x60]
               	ldurb	w2, [x29, #-0x80]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x40]
               	ldurb	w1, [x29, #-0x5f]
               	ldurb	w2, [x29, #-0x7f]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x3f]
               	ldurb	w1, [x29, #-0x5e]
               	ldurb	w2, [x29, #-0x7e]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x3e]
               	ldurb	w1, [x29, #-0x5d]
               	ldurb	w2, [x29, #-0x7d]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x3d]
               	ldurb	w1, [x29, #-0x5c]
               	ldurb	w2, [x29, #-0x7c]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x3c]
               	ldurb	w1, [x29, #-0x5b]
               	ldurb	w2, [x29, #-0x7b]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x3b]
               	ldurb	w1, [x29, #-0x5a]
               	ldurb	w2, [x29, #-0x7a]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x3a]
               	ldurb	w1, [x29, #-0x59]
               	ldurb	w2, [x29, #-0x79]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x39]
               	ldurb	w1, [x29, #-0x58]
               	ldurb	w2, [x29, #-0x78]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x38]
               	ldurb	w1, [x29, #-0x57]
               	ldurb	w2, [x29, #-0x77]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x37]
               	ldurb	w1, [x29, #-0x56]
               	ldurb	w2, [x29, #-0x76]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x36]
               	ldurb	w1, [x29, #-0x55]
               	ldurb	w2, [x29, #-0x75]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x35]
               	ldurb	w1, [x29, #-0x54]
               	ldurb	w2, [x29, #-0x74]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x34]
               	ldurb	w1, [x29, #-0x53]
               	ldurb	w2, [x29, #-0x73]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x33]
               	ldurb	w1, [x29, #-0x52]
               	ldurb	w2, [x29, #-0x72]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x32]
               	ldurb	w1, [x29, #-0x51]
               	ldurb	w2, [x29, #-0x71]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x31]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret

<ramp>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	and	x1, x0, #0xff
               	sturb	w1, [x29, #-0x10]
               	add	x2, x1, #0x1
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xf]
               	add	x2, x1, #0x2
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xe]
               	add	x2, x1, #0x3
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xd]
               	add	x2, x1, #0x4
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xc]
               	add	x2, x1, #0x5
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xb]
               	add	x2, x1, #0x6
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xa]
               	add	x2, x1, #0x7
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0x9]
               	add	x2, x1, #0x8
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0x8]
               	add	x2, x1, #0x9
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0x7]
               	add	x2, x1, #0xa
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0x6]
               	add	x1, x1, #0xb
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x5]
               	and	x0, x0, #0xff
               	add	x1, x0, #0xc
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x4]
               	add	x1, x0, #0xd
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x3]
               	add	x1, x0, #0xe
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x2]
               	add	x0, x0, #0xf
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x1]
               	ldur	q0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	str	q0, [sp, #0x80]
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	ldr	q17, [sp, #0x80]
               	sub	v0.16b, v0.16b, v17.16b
               	stur	q0, [x29, #-0xa0]
               	ldurb	w0, [x29, #-0xa0]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x9f]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9e]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9d]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9c]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9b]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9a]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x99]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x98]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x97]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x96]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x95]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x94]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x93]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x92]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x91]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	mov	x0, #0x27               // =39
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x7]
               	sturb	w0, [x29, #-0x6]
               	sturb	w0, [x29, #-0x5]
               	sturb	w0, [x29, #-0x4]
               	sturb	w0, [x29, #-0x3]
               	sturb	w0, [x29, #-0x2]
               	sturb	w0, [x29, #-0x1]
               	ldur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	ldurb	w0, [x29, #-0x8]
               	cmp	w0, #0x27
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x7]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x6]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x5]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x4]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x3]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x1]
               	cmp	w0, #0x27
               	b.ne	<addr>
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0xa0]
               	fadd	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0xa0]
               	ldur	s0, [x29, #-0xa0]
               	fmov	s1, #11.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fmov	s1, #22.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	mov	x16, #0x42040000        // =1107558400
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	mov	x16, #0x42300000        // =1110441984
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	add	v0.16b, v0.16b, v0.16b
               	stur	q0, [x29, #-0xa0]
               	ldurb	w0, [x29, #-0xa0]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x9f]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9e]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9d]
               	cmp	w0, #0xa
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9c]
               	cmp	w0, #0xc
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9b]
               	cmp	w0, #0xe
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x9a]
               	cmp	w0, #0x10
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x99]
               	cmp	w0, #0x12
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x98]
               	cmp	w0, #0x14
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x97]
               	cmp	w0, #0x16
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x96]
               	cmp	w0, #0x18
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x95]
               	cmp	w0, #0x1a
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x94]
               	cmp	w0, #0x1c
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x93]
               	cmp	w0, #0x1e
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x92]
               	cmp	w0, #0x20
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x91]
               	cmp	w0, #0x22
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
               	sub	x1, x29, #0xa0
               	stur	q0, [x29, #-0xa0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x9                // =9
               	ldrb	w3, [x1, x0]
               	add	x4, x0, #0x1
               	mul	x4, x4, x2
               	and	x4, x4, #0xff
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	stur	q0, [x29, #-0x80]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	stur	q0, [x29, #-0xa0]
               	ldurb	w0, [x29, #-0x80]
               	ldurb	w1, [x29, #-0xa0]
               	sub	x0, x0, x1
               	scvtf	d0, x0
               	fmov	d1, #12.00000000
               	fadd	d0, d0, d1
               	mov	x16, #0x404a000000000000 // =4632515166703976448
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x80
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	sub	x2, x29, #0xa0
               	add	x3, x0, #0x46
               	strb	w3, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0xa0
               	sub	x0, x29, #0x60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0xa0
               	bl	<addr>
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x80
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
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
