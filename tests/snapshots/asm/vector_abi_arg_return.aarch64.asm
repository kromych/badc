
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	sub	x0, x29, #0x10
               	ldurb	w1, [x29, #-0x20]
               	ldurb	w2, [x29, #-0x30]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x10]
               	ldurb	w1, [x29, #-0x1f]
               	ldurb	w2, [x29, #-0x2f]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0xf]
               	ldurb	w1, [x29, #-0x1e]
               	ldurb	w2, [x29, #-0x2e]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0xe]
               	ldurb	w1, [x29, #-0x1d]
               	ldurb	w2, [x29, #-0x2d]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0xd]
               	ldurb	w1, [x29, #-0x1c]
               	ldurb	w2, [x29, #-0x2c]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0xc]
               	ldurb	w1, [x29, #-0x1b]
               	ldurb	w2, [x29, #-0x2b]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0xb]
               	ldurb	w1, [x29, #-0x1a]
               	ldurb	w2, [x29, #-0x2a]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0xa]
               	ldurb	w1, [x29, #-0x19]
               	ldurb	w2, [x29, #-0x29]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x9]
               	ldurb	w1, [x29, #-0x18]
               	ldurb	w2, [x29, #-0x28]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x17]
               	ldurb	w2, [x29, #-0x27]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x7]
               	ldurb	w1, [x29, #-0x16]
               	ldurb	w2, [x29, #-0x26]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x6]
               	ldurb	w1, [x29, #-0x15]
               	ldurb	w2, [x29, #-0x25]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x5]
               	ldurb	w1, [x29, #-0x14]
               	ldurb	w2, [x29, #-0x24]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x4]
               	ldurb	w1, [x29, #-0x13]
               	ldurb	w2, [x29, #-0x23]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x3]
               	ldurb	w1, [x29, #-0x12]
               	ldurb	w2, [x29, #-0x22]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x2]
               	ldurb	w1, [x29, #-0x11]
               	ldurb	w2, [x29, #-0x21]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x1]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<vec8_sub>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	d0, [x29, #-0x8]
               	stur	d1, [x29, #-0x10]
               	sub	x0, x29, #0x18
               	ldurb	w1, [x29, #-0x10]
               	ldurb	w2, [x29, #-0x8]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x18]
               	ldurb	w1, [x29, #-0xf]
               	ldurb	w2, [x29, #-0x7]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x17]
               	ldurb	w1, [x29, #-0xe]
               	ldurb	w2, [x29, #-0x6]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x16]
               	ldurb	w1, [x29, #-0xd]
               	ldurb	w2, [x29, #-0x5]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x15]
               	ldurb	w1, [x29, #-0xc]
               	ldurb	w2, [x29, #-0x4]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x14]
               	ldurb	w1, [x29, #-0xb]
               	ldurb	w2, [x29, #-0x3]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x13]
               	ldurb	w1, [x29, #-0xa]
               	ldurb	w2, [x29, #-0x2]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x12]
               	ldurb	w1, [x29, #-0x9]
               	ldurb	w2, [x29, #-0x1]
               	sub	x1, x1, x2
               	sturb	w1, [x29, #-0x11]
               	mov	x16, x0
               	ldr	d0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<vecf_add>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	sub	x0, x29, #0x10
               	ldur	s0, [x29, #-0x30]
               	ldur	s1, [x29, #-0x20]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x2c]
               	ldur	s1, [x29, #-0x1c]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0x28]
               	ldur	s1, [x29, #-0x18]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x24]
               	ldur	s1, [x29, #-0x14]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x4]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<wrap_double>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	q0, [x29, #-0x30]
               	sub	x0, x29, #0x20
               	sub	x2, x29, #0x10
               	ldurb	w1, [x29, #-0x30]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x10]
               	ldurb	w1, [x29, #-0x2f]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0xf]
               	ldurb	w1, [x29, #-0x2e]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0xe]
               	ldurb	w1, [x29, #-0x2d]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0xd]
               	ldurb	w1, [x29, #-0x2c]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0xc]
               	ldurb	w1, [x29, #-0x2b]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0xb]
               	ldurb	w1, [x29, #-0x2a]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0xa]
               	ldurb	w1, [x29, #-0x29]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x9]
               	ldurb	w1, [x29, #-0x28]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x27]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x7]
               	ldurb	w1, [x29, #-0x26]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x6]
               	ldurb	w1, [x29, #-0x25]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x5]
               	ldurb	w1, [x29, #-0x24]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x4]
               	ldurb	w1, [x29, #-0x23]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x3]
               	ldurb	w1, [x29, #-0x22]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x2]
               	ldurb	w1, [x29, #-0x21]
               	add	x1, x1, x1
               	sturb	w1, [x29, #-0x1]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<nine>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	stur	q0, [x29, #-0xa0]
               	stur	q1, [x29, #-0x90]
               	stur	q2, [x29, #-0x80]
               	stur	q3, [x29, #-0x70]
               	stur	q4, [x29, #-0x60]
               	stur	q5, [x29, #-0x50]
               	stur	q6, [x29, #-0x40]
               	stur	q7, [x29, #-0x30]
               	sub	x16, x29, #0x20
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16, #0x8]
               	ldurb	w0, [x29, #-0xa0]
               	ldurb	w1, [x29, #-0x90]
               	add	x0, x0, x1
               	ldurb	w1, [x29, #-0x9f]
               	ldurb	w2, [x29, #-0x8f]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0x9e]
               	ldurb	w3, [x29, #-0x8e]
               	add	x2, x2, x3
               	ldurb	w3, [x29, #-0x9d]
               	ldurb	w4, [x29, #-0x8d]
               	add	x3, x3, x4
               	ldurb	w4, [x29, #-0x9c]
               	ldurb	w5, [x29, #-0x8c]
               	add	x4, x4, x5
               	ldurb	w5, [x29, #-0x9b]
               	ldurb	w6, [x29, #-0x8b]
               	add	x5, x5, x6
               	ldurb	w6, [x29, #-0x9a]
               	ldurb	w7, [x29, #-0x8a]
               	add	x6, x6, x7
               	ldurb	w7, [x29, #-0x99]
               	ldurb	w8, [x29, #-0x89]
               	add	x7, x7, x8
               	ldurb	w8, [x29, #-0x98]
               	ldurb	w9, [x29, #-0x88]
               	add	x8, x8, x9
               	ldurb	w9, [x29, #-0x97]
               	ldurb	w10, [x29, #-0x87]
               	add	x9, x9, x10
               	ldurb	w10, [x29, #-0x96]
               	ldurb	w11, [x29, #-0x86]
               	add	x10, x10, x11
               	ldurb	w11, [x29, #-0x95]
               	ldurb	w12, [x29, #-0x85]
               	add	x11, x11, x12
               	ldurb	w12, [x29, #-0x94]
               	ldurb	w13, [x29, #-0x84]
               	add	x12, x12, x13
               	ldurb	w13, [x29, #-0x93]
               	ldurb	w14, [x29, #-0x83]
               	add	x13, x13, x14
               	ldurb	w14, [x29, #-0x92]
               	ldurb	w15, [x29, #-0x82]
               	add	x14, x14, x15
               	ldurb	w15, [x29, #-0x91]
               	ldurb	w20, [x29, #-0x81]
               	add	x15, x15, x20
               	and	x0, x0, #0xff
               	ldurb	w20, [x29, #-0x80]
               	add	x0, x0, x20
               	and	x1, x1, #0xff
               	ldurb	w20, [x29, #-0x7f]
               	add	x1, x1, x20
               	and	x2, x2, #0xff
               	ldurb	w20, [x29, #-0x7e]
               	add	x2, x2, x20
               	and	x3, x3, #0xff
               	ldurb	w20, [x29, #-0x7d]
               	add	x3, x3, x20
               	and	x4, x4, #0xff
               	ldurb	w20, [x29, #-0x7c]
               	add	x4, x4, x20
               	and	x5, x5, #0xff
               	ldurb	w20, [x29, #-0x7b]
               	add	x5, x5, x20
               	and	x6, x6, #0xff
               	ldurb	w20, [x29, #-0x7a]
               	add	x6, x6, x20
               	and	x7, x7, #0xff
               	ldurb	w20, [x29, #-0x79]
               	add	x7, x7, x20
               	and	x8, x8, #0xff
               	ldurb	w20, [x29, #-0x78]
               	add	x8, x8, x20
               	and	x9, x9, #0xff
               	ldurb	w20, [x29, #-0x77]
               	add	x9, x9, x20
               	and	x10, x10, #0xff
               	ldurb	w20, [x29, #-0x76]
               	add	x10, x10, x20
               	and	x11, x11, #0xff
               	ldurb	w20, [x29, #-0x75]
               	add	x11, x11, x20
               	and	x12, x12, #0xff
               	ldurb	w20, [x29, #-0x74]
               	add	x12, x12, x20
               	and	x13, x13, #0xff
               	ldurb	w20, [x29, #-0x73]
               	add	x13, x13, x20
               	and	x14, x14, #0xff
               	ldurb	w20, [x29, #-0x72]
               	add	x14, x14, x20
               	and	x15, x15, #0xff
               	ldurb	w20, [x29, #-0x71]
               	add	x15, x15, x20
               	and	x0, x0, #0xff
               	ldurb	w20, [x29, #-0x70]
               	add	x0, x0, x20
               	and	x1, x1, #0xff
               	ldurb	w20, [x29, #-0x6f]
               	add	x1, x1, x20
               	and	x2, x2, #0xff
               	ldurb	w20, [x29, #-0x6e]
               	add	x2, x2, x20
               	and	x3, x3, #0xff
               	ldurb	w20, [x29, #-0x6d]
               	add	x3, x3, x20
               	and	x4, x4, #0xff
               	ldurb	w20, [x29, #-0x6c]
               	add	x4, x4, x20
               	and	x5, x5, #0xff
               	ldurb	w20, [x29, #-0x6b]
               	add	x5, x5, x20
               	and	x6, x6, #0xff
               	ldurb	w20, [x29, #-0x6a]
               	add	x6, x6, x20
               	and	x7, x7, #0xff
               	ldurb	w20, [x29, #-0x69]
               	add	x7, x7, x20
               	and	x8, x8, #0xff
               	ldurb	w20, [x29, #-0x68]
               	add	x8, x8, x20
               	and	x9, x9, #0xff
               	ldurb	w20, [x29, #-0x67]
               	add	x9, x9, x20
               	and	x10, x10, #0xff
               	ldurb	w20, [x29, #-0x66]
               	add	x10, x10, x20
               	and	x11, x11, #0xff
               	ldurb	w20, [x29, #-0x65]
               	add	x11, x11, x20
               	and	x12, x12, #0xff
               	ldurb	w20, [x29, #-0x64]
               	add	x12, x12, x20
               	and	x13, x13, #0xff
               	ldurb	w20, [x29, #-0x63]
               	add	x13, x13, x20
               	and	x14, x14, #0xff
               	ldurb	w20, [x29, #-0x62]
               	add	x14, x14, x20
               	and	x15, x15, #0xff
               	ldurb	w20, [x29, #-0x61]
               	add	x15, x15, x20
               	and	x0, x0, #0xff
               	ldurb	w20, [x29, #-0x60]
               	add	x0, x0, x20
               	and	x1, x1, #0xff
               	ldurb	w20, [x29, #-0x5f]
               	add	x1, x1, x20
               	and	x2, x2, #0xff
               	ldurb	w20, [x29, #-0x5e]
               	add	x2, x2, x20
               	and	x3, x3, #0xff
               	ldurb	w20, [x29, #-0x5d]
               	add	x3, x3, x20
               	and	x4, x4, #0xff
               	ldurb	w20, [x29, #-0x5c]
               	add	x4, x4, x20
               	and	x5, x5, #0xff
               	ldurb	w20, [x29, #-0x5b]
               	add	x5, x5, x20
               	and	x6, x6, #0xff
               	ldurb	w20, [x29, #-0x5a]
               	add	x6, x6, x20
               	and	x7, x7, #0xff
               	ldurb	w20, [x29, #-0x59]
               	add	x7, x7, x20
               	and	x8, x8, #0xff
               	ldurb	w20, [x29, #-0x58]
               	add	x8, x8, x20
               	and	x9, x9, #0xff
               	ldurb	w20, [x29, #-0x57]
               	add	x9, x9, x20
               	and	x10, x10, #0xff
               	ldurb	w20, [x29, #-0x56]
               	add	x10, x10, x20
               	and	x11, x11, #0xff
               	ldurb	w20, [x29, #-0x55]
               	add	x11, x11, x20
               	and	x12, x12, #0xff
               	ldurb	w20, [x29, #-0x54]
               	add	x12, x12, x20
               	and	x13, x13, #0xff
               	ldurb	w20, [x29, #-0x53]
               	add	x13, x13, x20
               	and	x14, x14, #0xff
               	ldurb	w20, [x29, #-0x52]
               	add	x14, x14, x20
               	and	x15, x15, #0xff
               	ldurb	w20, [x29, #-0x51]
               	add	x15, x15, x20
               	and	x0, x0, #0xff
               	ldurb	w20, [x29, #-0x50]
               	add	x0, x0, x20
               	and	x1, x1, #0xff
               	ldurb	w20, [x29, #-0x4f]
               	add	x1, x1, x20
               	and	x2, x2, #0xff
               	ldurb	w20, [x29, #-0x4e]
               	add	x2, x2, x20
               	and	x3, x3, #0xff
               	ldurb	w20, [x29, #-0x4d]
               	add	x3, x3, x20
               	and	x4, x4, #0xff
               	ldurb	w20, [x29, #-0x4c]
               	add	x4, x4, x20
               	and	x5, x5, #0xff
               	ldurb	w20, [x29, #-0x4b]
               	add	x5, x5, x20
               	and	x6, x6, #0xff
               	ldurb	w20, [x29, #-0x4a]
               	add	x6, x6, x20
               	and	x7, x7, #0xff
               	ldurb	w20, [x29, #-0x49]
               	add	x7, x7, x20
               	and	x8, x8, #0xff
               	ldurb	w20, [x29, #-0x48]
               	add	x8, x8, x20
               	and	x9, x9, #0xff
               	ldurb	w20, [x29, #-0x47]
               	add	x9, x9, x20
               	and	x10, x10, #0xff
               	ldurb	w20, [x29, #-0x46]
               	add	x10, x10, x20
               	and	x11, x11, #0xff
               	ldurb	w20, [x29, #-0x45]
               	add	x11, x11, x20
               	and	x12, x12, #0xff
               	ldurb	w20, [x29, #-0x44]
               	add	x12, x12, x20
               	and	x13, x13, #0xff
               	ldurb	w20, [x29, #-0x43]
               	add	x13, x13, x20
               	and	x14, x14, #0xff
               	ldurb	w20, [x29, #-0x42]
               	add	x14, x14, x20
               	and	x15, x15, #0xff
               	ldurb	w20, [x29, #-0x41]
               	add	x15, x15, x20
               	and	x0, x0, #0xff
               	ldurb	w20, [x29, #-0x40]
               	add	x0, x0, x20
               	and	x1, x1, #0xff
               	ldurb	w20, [x29, #-0x3f]
               	add	x1, x1, x20
               	and	x2, x2, #0xff
               	ldurb	w20, [x29, #-0x3e]
               	add	x2, x2, x20
               	and	x3, x3, #0xff
               	ldurb	w20, [x29, #-0x3d]
               	add	x3, x3, x20
               	and	x4, x4, #0xff
               	ldurb	w20, [x29, #-0x3c]
               	add	x4, x4, x20
               	and	x5, x5, #0xff
               	ldurb	w20, [x29, #-0x3b]
               	add	x5, x5, x20
               	and	x6, x6, #0xff
               	ldurb	w20, [x29, #-0x3a]
               	add	x6, x6, x20
               	and	x7, x7, #0xff
               	ldurb	w20, [x29, #-0x39]
               	add	x7, x7, x20
               	and	x8, x8, #0xff
               	ldurb	w20, [x29, #-0x38]
               	add	x8, x8, x20
               	and	x9, x9, #0xff
               	ldurb	w20, [x29, #-0x37]
               	add	x9, x9, x20
               	and	x10, x10, #0xff
               	ldurb	w20, [x29, #-0x36]
               	add	x10, x10, x20
               	and	x11, x11, #0xff
               	ldurb	w20, [x29, #-0x35]
               	add	x11, x11, x20
               	and	x12, x12, #0xff
               	ldurb	w20, [x29, #-0x34]
               	add	x12, x12, x20
               	and	x13, x13, #0xff
               	ldurb	w20, [x29, #-0x33]
               	add	x13, x13, x20
               	and	x14, x14, #0xff
               	ldurb	w20, [x29, #-0x32]
               	add	x14, x14, x20
               	and	x15, x15, #0xff
               	ldurb	w20, [x29, #-0x31]
               	add	x15, x15, x20
               	and	x0, x0, #0xff
               	ldurb	w20, [x29, #-0x30]
               	add	x0, x0, x20
               	and	x1, x1, #0xff
               	ldurb	w20, [x29, #-0x2f]
               	add	x1, x1, x20
               	and	x2, x2, #0xff
               	ldurb	w20, [x29, #-0x2e]
               	add	x2, x2, x20
               	and	x3, x3, #0xff
               	ldurb	w20, [x29, #-0x2d]
               	add	x3, x3, x20
               	and	x4, x4, #0xff
               	ldurb	w20, [x29, #-0x2c]
               	add	x4, x4, x20
               	and	x5, x5, #0xff
               	ldurb	w20, [x29, #-0x2b]
               	add	x5, x5, x20
               	and	x6, x6, #0xff
               	ldurb	w20, [x29, #-0x2a]
               	add	x6, x6, x20
               	and	x7, x7, #0xff
               	ldurb	w20, [x29, #-0x29]
               	add	x7, x7, x20
               	and	x8, x8, #0xff
               	ldurb	w20, [x29, #-0x28]
               	add	x8, x8, x20
               	and	x9, x9, #0xff
               	ldurb	w20, [x29, #-0x27]
               	add	x9, x9, x20
               	and	x10, x10, #0xff
               	ldurb	w20, [x29, #-0x26]
               	add	x10, x10, x20
               	and	x11, x11, #0xff
               	ldurb	w20, [x29, #-0x25]
               	add	x11, x11, x20
               	and	x12, x12, #0xff
               	ldurb	w20, [x29, #-0x24]
               	add	x12, x12, x20
               	and	x13, x13, #0xff
               	ldurb	w20, [x29, #-0x23]
               	add	x13, x13, x20
               	and	x14, x14, #0xff
               	ldurb	w20, [x29, #-0x22]
               	add	x14, x14, x20
               	and	x15, x15, #0xff
               	ldurb	w20, [x29, #-0x21]
               	add	x15, x15, x20
               	sub	x20, x29, #0x10
               	and	x0, x0, #0xff
               	ldurb	w21, [x29, #-0x20]
               	add	x0, x0, x21
               	sturb	w0, [x29, #-0x10]
               	and	x0, x1, #0xff
               	ldurb	w1, [x29, #-0x1f]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0xf]
               	and	x0, x2, #0xff
               	ldurb	w1, [x29, #-0x1e]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0xe]
               	and	x0, x3, #0xff
               	ldurb	w1, [x29, #-0x1d]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0xd]
               	and	x0, x4, #0xff
               	ldurb	w1, [x29, #-0x1c]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0xc]
               	and	x0, x5, #0xff
               	ldurb	w1, [x29, #-0x1b]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0xb]
               	and	x0, x6, #0xff
               	ldurb	w1, [x29, #-0x1a]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0xa]
               	and	x0, x7, #0xff
               	ldurb	w1, [x29, #-0x19]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x9]
               	and	x0, x8, #0xff
               	ldurb	w1, [x29, #-0x18]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x8]
               	and	x0, x9, #0xff
               	ldurb	w1, [x29, #-0x17]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x7]
               	and	x0, x10, #0xff
               	ldurb	w1, [x29, #-0x16]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x6]
               	and	x0, x11, #0xff
               	ldurb	w1, [x29, #-0x15]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x5]
               	and	x0, x12, #0xff
               	ldurb	w1, [x29, #-0x14]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x4]
               	and	x0, x13, #0xff
               	ldurb	w1, [x29, #-0x13]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x3]
               	and	x0, x14, #0xff
               	ldurb	w1, [x29, #-0x12]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x2]
               	and	x0, x15, #0xff
               	ldurb	w1, [x29, #-0x11]
               	add	x0, x0, x1
               	sturb	w0, [x29, #-0x1]
               	mov	x16, x20
               	ldr	q0, [x16]
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
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
               	sub	x2, x29, #0x10
               	add	x3, x1, #0xa
               	and	x3, x3, #0xff
               	sturb	w3, [x29, #-0x6]
               	add	x1, x1, #0xb
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x5]
               	and	x1, x0, #0xff
               	add	x0, x1, #0xc
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x4]
               	add	x0, x1, #0xd
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x3]
               	add	x0, x1, #0xe
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x2]
               	add	x0, x1, #0xf
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x1]
               	mov	x16, x2
               	ldr	q0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	sub	x0, x29, #0x70
               	sub	x7, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x0, x29, #0xa0
               	ldr	q0, [x0]
               	ldr	q1, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	ldurb	w0, [x29, #-0x70]
               	ldurb	w1, [x29, #-0x6f]
               	ldurb	w2, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x6d]
               	ldurb	w4, [x29, #-0x6c]
               	ldurb	w5, [x29, #-0x6b]
               	ldurb	w6, [x29, #-0x6a]
               	ldurb	w7, [x29, #-0x69]
               	ldurb	w8, [x29, #-0x68]
               	ldurb	w9, [x29, #-0x67]
               	ldurb	w10, [x29, #-0x66]
               	ldurb	w11, [x29, #-0x65]
               	ldurb	w12, [x29, #-0x64]
               	ldurb	w13, [x29, #-0x63]
               	ldurb	w14, [x29, #-0x62]
               	ldurb	w15, [x29, #-0x61]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x63              // =99
               	eor	x0, x1, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x2, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x3, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x4, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x5, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x6, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x7, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x8, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x9, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x10, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x11, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x12, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x13, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x14, x17
               	cbnz	w0, <addr>
               	mov	x17, #0x63              // =99
               	eor	x0, x15, x17
               	cbnz	w0, <addr>
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
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x7]
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x6]
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x5]
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x4]
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x3]
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x2]
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x1]
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x70
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	s0, [x29, #-0xa0]
               	ldur	s1, [x29, #-0x90]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x70]
               	ldur	s0, [x29, #-0x9c]
               	ldur	s1, [x29, #-0x8c]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x6c]
               	ldur	s0, [x29, #-0x98]
               	ldur	s1, [x29, #-0x88]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x68]
               	ldur	s0, [x29, #-0x94]
               	ldur	s1, [x29, #-0x84]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x64]
               	ldur	q0, [x29, #-0x70]
               	stur	q0, [x29, #-0x70]
               	ldur	s0, [x29, #-0x70]
               	fmov	s1, #11.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x6c]
               	fmov	s1, #22.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x68]
               	mov	x16, #0x42040000        // =1107558400
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x64]
               	mov	x16, #0x42300000        // =1110441984
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x7, x29, #0x90
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	ldurb	w0, [x29, #-0x70]
               	ldurb	w1, [x29, #-0x6f]
               	ldurb	w2, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x6d]
               	ldurb	w4, [x29, #-0x6c]
               	ldurb	w5, [x29, #-0x6b]
               	ldurb	w6, [x29, #-0x6a]
               	ldurb	w7, [x29, #-0x69]
               	ldurb	w8, [x29, #-0x68]
               	ldurb	w9, [x29, #-0x67]
               	ldurb	w10, [x29, #-0x66]
               	ldurb	w11, [x29, #-0x65]
               	ldurb	w12, [x29, #-0x64]
               	ldurb	w13, [x29, #-0x63]
               	ldurb	w14, [x29, #-0x62]
               	ldurb	w15, [x29, #-0x61]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w1, #0x6
               	b.ne	<addr>
               	cmp	w2, #0x8
               	b.ne	<addr>
               	cmp	w3, #0xa
               	b.ne	<addr>
               	cmp	w4, #0xc
               	b.ne	<addr>
               	cmp	w5, #0xe
               	b.ne	<addr>
               	cmp	w6, #0x10
               	b.ne	<addr>
               	cmp	w7, #0x12
               	b.ne	<addr>
               	cmp	w8, #0x14
               	b.ne	<addr>
               	cmp	w9, #0x16
               	b.ne	<addr>
               	cmp	w10, #0x18
               	b.ne	<addr>
               	cmp	w11, #0x1a
               	b.ne	<addr>
               	cmp	w12, #0x1c
               	b.ne	<addr>
               	cmp	w13, #0x1e
               	b.ne	<addr>
               	cmp	w14, #0x20
               	b.ne	<addr>
               	cmp	w15, #0x22
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	sub	x0, x29, #0x70
               	sub	x7, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	mov	x16, x7
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
               	stur	q0, [x29, #-0x70]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
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
               	stur	q0, [x29, #-0x90]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	fmov	d0, #4.00000000
               	ldurb	w0, [x29, #-0x90]
               	ldurb	w1, [x29, #-0x70]
               	sub	x0, x0, x1
               	scvtf	d1, x0
               	fmov	d2, #3.00000000
               	fmadd	d0, d2, d0, d1
               	mov	x16, #0x404a000000000000 // =4632515166703976448
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x90
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	sub	x2, x29, #0x70
               	add	x3, x0, #0x46
               	strb	w3, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x70
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
               	sub	x8, x29, #0x70
               	bl	<addr>
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x45               // =69
               	ldrb	w3, [x1, x0]
               	eor	x3, x3, x2
               	cbnz	w3, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
