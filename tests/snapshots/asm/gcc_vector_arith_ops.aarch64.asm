
gcc_vector_arith_ops.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x1b0
               	sub	x1, x29, #0x1b0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x1a0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x190
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x180
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x170
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x160
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x150
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x140
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x130
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x120
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x110
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x100
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xf0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xe0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xd0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xc0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x38
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x16, [x3]
               	str	x16, [x0]
               	sub	x0, x29, #0x30
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x16, [x3]
               	str	x16, [x0]
               	sub	x0, x29, #0xb0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x3, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x90
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x3, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	add	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x10
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	add	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sub	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	sub	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	mul	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	mul	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	ldrb	w3, [sp, #0x10]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	ldrb	w3, [sp, #0x11]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	ldrb	w3, [sp, #0x12]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	ldrb	w3, [sp, #0x13]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	ldrb	w3, [sp, #0x14]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	ldrb	w3, [sp, #0x15]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	ldrb	w3, [sp, #0x16]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	ldrb	w3, [sp, #0x17]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	ldrb	w3, [sp, #0x18]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	ldrb	w3, [sp, #0x19]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	ldrb	w3, [sp, #0x1a]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	ldrb	w3, [sp, #0x1b]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	ldrb	w3, [sp, #0x1c]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	ldrb	w3, [sp, #0x1d]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	ldrb	w3, [sp, #0x1e]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	ldrb	w3, [sp, #0x1f]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	sdiv	w2, w2, w3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	ldrb	w3, [sp, #0x10]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	ldrb	w3, [sp, #0x11]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	ldrb	w3, [sp, #0x12]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	ldrb	w3, [sp, #0x13]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	ldrb	w3, [sp, #0x14]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	ldrb	w3, [sp, #0x15]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	ldrb	w3, [sp, #0x16]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	ldrb	w3, [sp, #0x17]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	ldrb	w3, [sp, #0x18]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	ldrb	w3, [sp, #0x19]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	ldrb	w3, [sp, #0x1a]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	ldrb	w3, [sp, #0x1b]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	ldrb	w3, [sp, #0x1c]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	ldrb	w3, [sp, #0x1d]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	ldrb	w3, [sp, #0x1e]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	ldrb	w3, [sp, #0x1f]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	sdiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	and	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	and	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	orr	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	orr	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	eor	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	eor	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x190
               	sub	x5, x29, #0x180
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	add	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	add	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x190
               	sub	x5, x29, #0x180
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	sub	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	sub	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x190
               	sub	x5, x29, #0x180
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	mul	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	mul	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x190
               	sub	x5, x29, #0x180
               	sub	x0, x29, #0x70
               	ldrsb	x2, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldrsb	x2, [sp, #0x21]
               	ldrsb	x3, [sp, #0x31]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldrsb	x2, [sp, #0x22]
               	ldrsb	x3, [sp, #0x32]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldrsb	x2, [sp, #0x23]
               	ldrsb	x3, [sp, #0x33]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldrsb	x2, [sp, #0x24]
               	ldrsb	x3, [sp, #0x34]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldrsb	x2, [sp, #0x25]
               	ldrsb	x3, [sp, #0x35]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldrsb	x2, [sp, #0x26]
               	ldrsb	x3, [sp, #0x36]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldrsb	x2, [sp, #0x27]
               	ldrsb	x3, [sp, #0x37]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldrsb	x2, [sp, #0x28]
               	ldrsb	x3, [sp, #0x38]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldrsb	x2, [sp, #0x29]
               	ldrsb	x3, [sp, #0x39]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldrsb	x2, [sp, #0x2a]
               	ldrsb	x3, [sp, #0x3a]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldrsb	x2, [sp, #0x2b]
               	ldrsb	x3, [sp, #0x3b]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldrsb	x2, [sp, #0x2c]
               	ldrsb	x3, [sp, #0x3c]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldrsb	x2, [sp, #0x2d]
               	ldrsb	x3, [sp, #0x3d]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldrsb	x2, [sp, #0x2e]
               	ldrsb	x3, [sp, #0x3e]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldrsb	x2, [sp, #0x2f]
               	ldrsb	x3, [sp, #0x3f]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	sdiv	w2, w2, w3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x190
               	sub	x5, x29, #0x180
               	sub	x0, x29, #0x70
               	ldrsb	x2, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x70]
               	ldrsb	x2, [sp, #0x21]
               	ldrsb	x3, [sp, #0x31]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6f]
               	ldrsb	x2, [sp, #0x22]
               	ldrsb	x3, [sp, #0x32]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6e]
               	ldrsb	x2, [sp, #0x23]
               	ldrsb	x3, [sp, #0x33]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6d]
               	ldrsb	x2, [sp, #0x24]
               	ldrsb	x3, [sp, #0x34]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6c]
               	ldrsb	x2, [sp, #0x25]
               	ldrsb	x3, [sp, #0x35]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6b]
               	ldrsb	x2, [sp, #0x26]
               	ldrsb	x3, [sp, #0x36]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6a]
               	ldrsb	x2, [sp, #0x27]
               	ldrsb	x3, [sp, #0x37]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x69]
               	ldrsb	x2, [sp, #0x28]
               	ldrsb	x3, [sp, #0x38]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x68]
               	ldrsb	x2, [sp, #0x29]
               	ldrsb	x3, [sp, #0x39]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x67]
               	ldrsb	x2, [sp, #0x2a]
               	ldrsb	x3, [sp, #0x3a]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x66]
               	ldrsb	x2, [sp, #0x2b]
               	ldrsb	x3, [sp, #0x3b]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x65]
               	ldrsb	x2, [sp, #0x2c]
               	ldrsb	x3, [sp, #0x3c]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x64]
               	ldrsb	x2, [sp, #0x2d]
               	ldrsb	x3, [sp, #0x3d]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x63]
               	ldrsb	x2, [sp, #0x2e]
               	ldrsb	x3, [sp, #0x3e]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x62]
               	ldrsb	x2, [sp, #0x2f]
               	ldrsb	x3, [sp, #0x3f]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	sdiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x190
               	sub	x5, x29, #0x180
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	and	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	and	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x170
               	sub	x6, x29, #0x160
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	add	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrh	w4, [x4]
               	add	x1, x6, x1
               	ldrh	w1, [x1]
               	add	x1, x4, x1
               	and	x1, x1, #0xffff
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x170
               	sub	x6, x29, #0x160
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	sub	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrh	w4, [x4]
               	add	x1, x6, x1
               	ldrh	w1, [x1]
               	sub	x1, x4, x1
               	and	x1, x1, #0xffff
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x170
               	sub	x6, x29, #0x160
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	mul	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrh	w4, [x4]
               	add	x1, x6, x1
               	ldrh	w1, [x1]
               	mul	x1, x4, x1
               	and	x1, x1, #0xffff
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x170
               	sub	x6, x29, #0x160
               	ldrh	w0, [sp, #0x40]
               	ldrh	w1, [sp, #0x50]
               	udiv	w0, w0, w1
               	ldrh	w1, [sp, #0x42]
               	ldrh	w3, [sp, #0x52]
               	udiv	w1, w1, w3
               	ldrh	w3, [sp, #0x44]
               	ldrh	w4, [sp, #0x54]
               	udiv	w3, w3, w4
               	ldrh	w4, [sp, #0x46]
               	ldrh	w7, [sp, #0x56]
               	udiv	w4, w4, w7
               	ldrh	w7, [sp, #0x48]
               	ldrh	w8, [sp, #0x58]
               	udiv	w7, w7, w8
               	ldrh	w8, [sp, #0x4a]
               	ldrh	w9, [sp, #0x5a]
               	udiv	w8, w8, w9
               	ldrh	w9, [sp, #0x4c]
               	ldrh	w10, [sp, #0x5c]
               	udiv	w9, w9, w10
               	ldrh	w10, [sp, #0x4e]
               	ldrh	w11, [sp, #0x5e]
               	udiv	w10, w10, w11
               	sturh	w0, [x29, #-0x70]
               	sturh	w1, [x29, #-0x6e]
               	sturh	w3, [x29, #-0x6c]
               	sturh	w4, [x29, #-0x6a]
               	sturh	w7, [x29, #-0x68]
               	sturh	w8, [x29, #-0x66]
               	sturh	w9, [x29, #-0x64]
               	sturh	w10, [x29, #-0x62]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrh	w4, [x4]
               	add	x1, x6, x1
               	ldrh	w1, [x1]
               	sdiv	w1, w4, w1
               	and	x1, x1, #0xffff
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x170
               	sub	x6, x29, #0x160
               	ldrh	w0, [sp, #0x40]
               	ldrh	w1, [sp, #0x50]
               	udiv	w17, w0, w1
               	msub	w0, w17, w1, w0
               	ldrh	w1, [sp, #0x42]
               	ldrh	w3, [sp, #0x52]
               	udiv	w17, w1, w3
               	msub	w1, w17, w3, w1
               	ldrh	w3, [sp, #0x44]
               	ldrh	w4, [sp, #0x54]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	ldrh	w4, [sp, #0x46]
               	ldrh	w7, [sp, #0x56]
               	udiv	w17, w4, w7
               	msub	w4, w17, w7, w4
               	ldrh	w7, [sp, #0x48]
               	ldrh	w8, [sp, #0x58]
               	udiv	w17, w7, w8
               	msub	w7, w17, w8, w7
               	ldrh	w8, [sp, #0x4a]
               	ldrh	w9, [sp, #0x5a]
               	udiv	w17, w8, w9
               	msub	w8, w17, w9, w8
               	ldrh	w9, [sp, #0x4c]
               	ldrh	w10, [sp, #0x5c]
               	udiv	w17, w9, w10
               	msub	w9, w17, w10, w9
               	ldrh	w10, [sp, #0x4e]
               	ldrh	w11, [sp, #0x5e]
               	udiv	w17, w10, w11
               	msub	w10, w17, w11, w10
               	sturh	w0, [x29, #-0x70]
               	sturh	w1, [x29, #-0x6e]
               	sturh	w3, [x29, #-0x6c]
               	sturh	w4, [x29, #-0x6a]
               	sturh	w7, [x29, #-0x68]
               	sturh	w8, [x29, #-0x66]
               	sturh	w9, [x29, #-0x64]
               	sturh	w10, [x29, #-0x62]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrh	w4, [x4]
               	add	x1, x6, x1
               	ldrh	w1, [x1]
               	sdiv	w17, w4, w1
               	msub	w1, w17, w1, w4
               	and	x1, x1, #0xffff
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x6, x29, #0x140
               	ldr	q0, [sp, #0x60]
               	ldr	q1, [sp, #0x70]
               	add	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	add	x1, x4, x1
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x6, x29, #0x140
               	ldr	q0, [sp, #0x60]
               	ldr	q1, [sp, #0x70]
               	sub	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	sub	x1, x4, x1
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x6, x29, #0x140
               	ldr	q0, [sp, #0x60]
               	ldr	q1, [sp, #0x70]
               	mul	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	mul	x1, x4, x1
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x6, x29, #0x140
               	ldrsh	x0, [sp, #0x60]
               	ldrsh	x1, [sp, #0x70]
               	sdiv	x0, x0, x1
               	ldrsh	x1, [sp, #0x62]
               	ldrsh	x3, [sp, #0x72]
               	sdiv	x1, x1, x3
               	ldrsh	x3, [sp, #0x64]
               	ldrsh	x4, [sp, #0x74]
               	sdiv	x3, x3, x4
               	ldrsh	x4, [sp, #0x66]
               	ldrsh	x7, [sp, #0x76]
               	sdiv	x4, x4, x7
               	ldrsh	x7, [sp, #0x68]
               	ldrsh	x8, [sp, #0x78]
               	sdiv	x7, x7, x8
               	ldrsh	x8, [sp, #0x6a]
               	ldrsh	x9, [sp, #0x7a]
               	sdiv	x8, x8, x9
               	ldrsh	x9, [sp, #0x6c]
               	ldrsh	x10, [sp, #0x7c]
               	sdiv	x9, x9, x10
               	ldrsh	x10, [sp, #0x6e]
               	ldrsh	x11, [sp, #0x7e]
               	sdiv	x10, x10, x11
               	and	x0, x0, #0xffff
               	sturh	w0, [x29, #-0x70]
               	and	x0, x1, #0xffff
               	sturh	w0, [x29, #-0x6e]
               	and	x0, x3, #0xffff
               	sturh	w0, [x29, #-0x6c]
               	and	x0, x4, #0xffff
               	sturh	w0, [x29, #-0x6a]
               	and	x0, x7, #0xffff
               	sturh	w0, [x29, #-0x68]
               	and	x0, x8, #0xffff
               	sturh	w0, [x29, #-0x66]
               	and	x0, x9, #0xffff
               	sturh	w0, [x29, #-0x64]
               	and	x0, x10, #0xffff
               	sturh	w0, [x29, #-0x62]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	sdiv	w1, w4, w1
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x6, x29, #0x140
               	ldrsh	x0, [sp, #0x60]
               	ldrsh	x1, [sp, #0x70]
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ldrsh	x1, [sp, #0x62]
               	ldrsh	x3, [sp, #0x72]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	ldrsh	x3, [sp, #0x64]
               	ldrsh	x4, [sp, #0x74]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	ldrsh	x4, [sp, #0x66]
               	ldrsh	x7, [sp, #0x76]
               	sdiv	x17, x4, x7
               	msub	x4, x17, x7, x4
               	ldrsh	x7, [sp, #0x68]
               	ldrsh	x8, [sp, #0x78]
               	sdiv	x17, x7, x8
               	msub	x7, x17, x8, x7
               	ldrsh	x8, [sp, #0x6a]
               	ldrsh	x9, [sp, #0x7a]
               	sdiv	x17, x8, x9
               	msub	x8, x17, x9, x8
               	ldrsh	x9, [sp, #0x6c]
               	ldrsh	x10, [sp, #0x7c]
               	sdiv	x17, x9, x10
               	msub	x9, x17, x10, x9
               	ldrsh	x10, [sp, #0x6e]
               	ldrsh	x11, [sp, #0x7e]
               	sdiv	x17, x10, x11
               	msub	x10, x17, x11, x10
               	and	x0, x0, #0xffff
               	sturh	w0, [x29, #-0x70]
               	and	x0, x1, #0xffff
               	sturh	w0, [x29, #-0x6e]
               	and	x0, x3, #0xffff
               	sturh	w0, [x29, #-0x6c]
               	and	x0, x4, #0xffff
               	sturh	w0, [x29, #-0x6a]
               	and	x0, x7, #0xffff
               	sturh	w0, [x29, #-0x68]
               	and	x0, x8, #0xffff
               	sturh	w0, [x29, #-0x66]
               	and	x0, x9, #0xffff
               	sturh	w0, [x29, #-0x64]
               	and	x0, x10, #0xffff
               	sturh	w0, [x29, #-0x62]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	sdiv	w17, w4, w1
               	msub	w1, w17, w1, w4
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x130
               	sub	x6, x29, #0x120
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
               	add	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	w4, [x4]
               	add	x1, x6, x1
               	ldr	w1, [x1]
               	add	x1, x4, x1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x130
               	sub	x6, x29, #0x120
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
               	sub	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	w4, [x4]
               	add	x1, x6, x1
               	ldr	w1, [x1]
               	sub	x1, x4, x1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x130
               	sub	x6, x29, #0x120
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
               	mul	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	w4, [x4]
               	add	x1, x6, x1
               	ldr	w1, [x1]
               	mul	x1, x4, x1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x130
               	sub	x6, x29, #0x120
               	ldr	w0, [sp, #0x80]
               	ldr	w1, [sp, #0x90]
               	udiv	w0, w0, w1
               	ldr	w1, [sp, #0x84]
               	ldr	w3, [sp, #0x94]
               	udiv	w1, w1, w3
               	ldr	w3, [sp, #0x88]
               	ldr	w4, [sp, #0x98]
               	udiv	w3, w3, w4
               	ldr	w4, [sp, #0x8c]
               	ldr	w7, [sp, #0x9c]
               	udiv	w4, w4, w7
               	stur	w0, [x29, #-0x70]
               	stur	w1, [x29, #-0x6c]
               	stur	w3, [x29, #-0x68]
               	stur	w4, [x29, #-0x64]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	w4, [x4]
               	add	x1, x6, x1
               	ldr	w1, [x1]
               	udiv	w1, w4, w1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x130
               	sub	x6, x29, #0x120
               	ldr	w0, [sp, #0x80]
               	ldr	w1, [sp, #0x90]
               	udiv	w17, w0, w1
               	msub	w0, w17, w1, w0
               	ldr	w1, [sp, #0x84]
               	ldr	w3, [sp, #0x94]
               	udiv	w17, w1, w3
               	msub	w1, w17, w3, w1
               	ldr	w3, [sp, #0x88]
               	ldr	w4, [sp, #0x98]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	ldr	w4, [sp, #0x8c]
               	ldr	w7, [sp, #0x9c]
               	udiv	w17, w4, w7
               	msub	w4, w17, w7, w4
               	stur	w0, [x29, #-0x70]
               	stur	w1, [x29, #-0x6c]
               	stur	w3, [x29, #-0x68]
               	stur	w4, [x29, #-0x64]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	w4, [x4]
               	add	x1, x6, x1
               	ldr	w1, [x1]
               	udiv	w17, w4, w1
               	msub	w1, w17, w1, w4
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x110
               	sub	x6, x29, #0x100
               	ldr	q0, [sp, #0xa0]
               	ldur	q1, [x29, #-0x100]
               	add	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsw	x4, [x4]
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	add	x1, x4, x1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x110
               	sub	x6, x29, #0x100
               	ldr	q0, [sp, #0xa0]
               	ldur	q1, [x29, #-0x100]
               	sub	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsw	x4, [x4]
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	sub	x1, x4, x1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x110
               	sub	x6, x29, #0x100
               	ldr	q0, [sp, #0xa0]
               	ldur	q1, [x29, #-0x100]
               	mul	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsw	x4, [x4]
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	mul	x1, x4, x1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x110
               	sub	x6, x29, #0x100
               	ldrsw	x0, [sp, #0xa0]
               	ldursw	x1, [x29, #-0x100]
               	sdiv	x0, x0, x1
               	ldrsw	x1, [sp, #0xa4]
               	ldursw	x3, [x29, #-0xfc]
               	sdiv	x1, x1, x3
               	ldrsw	x3, [sp, #0xa8]
               	ldursw	x4, [x29, #-0xf8]
               	sdiv	x3, x3, x4
               	ldrsw	x4, [sp, #0xac]
               	ldursw	x7, [x29, #-0xf4]
               	sdiv	x4, x4, x7
               	stur	w0, [x29, #-0x70]
               	stur	w1, [x29, #-0x6c]
               	stur	w3, [x29, #-0x68]
               	stur	w4, [x29, #-0x64]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsw	x4, [x4]
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	sdiv	w1, w4, w1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x110
               	sub	x6, x29, #0x100
               	ldrsw	x0, [sp, #0xa0]
               	ldursw	x1, [x29, #-0x100]
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ldrsw	x1, [sp, #0xa4]
               	ldursw	x3, [x29, #-0xfc]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	ldrsw	x3, [sp, #0xa8]
               	ldursw	x4, [x29, #-0xf8]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	ldrsw	x4, [sp, #0xac]
               	ldursw	x7, [x29, #-0xf4]
               	sdiv	x17, x4, x7
               	msub	x4, x17, x7, x4
               	stur	w0, [x29, #-0x70]
               	stur	w1, [x29, #-0x6c]
               	stur	w3, [x29, #-0x68]
               	stur	w4, [x29, #-0x64]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsw	x4, [x4]
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	sdiv	w17, w4, w1
               	msub	w1, w17, w1, w4
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xf0
               	sub	x6, x29, #0xe0
               	ldur	q0, [x29, #-0xf0]
               	ldur	q1, [x29, #-0xe0]
               	add	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	add	x1, x4, x1
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xf0
               	sub	x6, x29, #0xe0
               	ldur	q0, [x29, #-0xf0]
               	ldur	q1, [x29, #-0xe0]
               	sub	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	sub	x1, x4, x1
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xf0
               	sub	x6, x29, #0xe0
               	ldur	x0, [x29, #-0xf0]
               	ldur	x1, [x29, #-0xe0]
               	mul	x0, x0, x1
               	ldur	x1, [x29, #-0xe8]
               	ldur	x3, [x29, #-0xd8]
               	mul	x1, x1, x3
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	mul	x1, x4, x1
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xf0
               	sub	x6, x29, #0xe0
               	ldur	x0, [x29, #-0xf0]
               	ldur	x1, [x29, #-0xe0]
               	udiv	x0, x0, x1
               	ldur	x1, [x29, #-0xe8]
               	ldur	x3, [x29, #-0xd8]
               	udiv	x1, x1, x3
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	udiv	x1, x4, x1
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xf0
               	sub	x6, x29, #0xe0
               	ldur	x0, [x29, #-0xf0]
               	ldur	x1, [x29, #-0xe0]
               	udiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ldur	x1, [x29, #-0xe8]
               	ldur	x3, [x29, #-0xd8]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	udiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xd0
               	sub	x6, x29, #0xc0
               	ldur	q0, [x29, #-0xd0]
               	ldur	q1, [x29, #-0xc0]
               	add	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	add	x1, x4, x1
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xd0
               	sub	x6, x29, #0xc0
               	ldur	q0, [x29, #-0xd0]
               	ldur	q1, [x29, #-0xc0]
               	sub	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	sub	x1, x4, x1
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xd0
               	sub	x6, x29, #0xc0
               	ldur	x0, [x29, #-0xd0]
               	ldur	x1, [x29, #-0xc0]
               	mul	x0, x0, x1
               	ldur	x1, [x29, #-0xc8]
               	ldur	x3, [x29, #-0xb8]
               	mul	x1, x1, x3
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	mul	x1, x4, x1
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xd0
               	sub	x6, x29, #0xc0
               	ldur	x0, [x29, #-0xd0]
               	ldur	x1, [x29, #-0xc0]
               	sdiv	x0, x0, x1
               	ldur	x1, [x29, #-0xc8]
               	ldur	x3, [x29, #-0xb8]
               	sdiv	x1, x1, x3
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	sdiv	x1, x4, x1
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xd0
               	sub	x6, x29, #0xc0
               	ldur	x0, [x29, #-0xd0]
               	ldur	x1, [x29, #-0xc0]
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ldur	x1, [x29, #-0xc8]
               	ldur	x3, [x29, #-0xb8]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	sdiv	x17, x4, x1
               	msub	x1, x17, x1, x4
               	str	x1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x38
               	sub	x5, x29, #0x30
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x30]
               	add	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x28]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x8
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	add	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x28
               	sub	x1, x29, #0x8
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x4, x29, #0x38
               	sub	x5, x29, #0x30
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x30]
               	mul	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x28]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	mul	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x8
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x4, x29, #0xb0
               	sub	x5, x29, #0x90
               	ldur	w0, [x29, #-0xb0]
               	ldur	w1, [x29, #-0x90]
               	add	x0, x0, x1
               	ldur	w1, [x29, #-0xac]
               	ldur	w2, [x29, #-0x8c]
               	add	x1, x1, x2
               	ldur	w2, [x29, #-0xa8]
               	ldur	w3, [x29, #-0x88]
               	add	x2, x2, x3
               	ldur	w3, [x29, #-0xa4]
               	ldur	w6, [x29, #-0x84]
               	add	x3, x3, x6
               	ldur	w6, [x29, #-0xa0]
               	ldur	w7, [x29, #-0x80]
               	add	x6, x6, x7
               	ldur	w7, [x29, #-0x9c]
               	ldur	w8, [x29, #-0x7c]
               	add	x7, x7, x8
               	ldur	w8, [x29, #-0x98]
               	ldur	w9, [x29, #-0x78]
               	add	x8, x8, x9
               	ldur	w9, [x29, #-0x94]
               	ldur	w10, [x29, #-0x74]
               	add	x9, x9, x10
               	stur	w0, [x29, #-0x70]
               	stur	w1, [x29, #-0x6c]
               	stur	w2, [x29, #-0x68]
               	stur	w3, [x29, #-0x64]
               	stur	w6, [x29, #-0x60]
               	stur	w7, [x29, #-0x5c]
               	stur	w8, [x29, #-0x58]
               	stur	w9, [x29, #-0x54]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	lsl	x1, x0, #2
               	add	x2, x2, x1
               	add	x3, x4, x1
               	ldr	w3, [x3]
               	add	x1, x5, x1
               	ldr	w1, [x1]
               	add	x1, x3, x1
               	str	w1, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x20
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x5, x29, #0xb0
               	sub	x6, x29, #0x90
               	ldur	w0, [x29, #-0xb0]
               	ldur	w1, [x29, #-0x90]
               	sub	x0, x0, x1
               	ldur	w1, [x29, #-0xac]
               	ldur	w3, [x29, #-0x8c]
               	sub	x1, x1, x3
               	ldur	w3, [x29, #-0xa8]
               	ldur	w4, [x29, #-0x88]
               	sub	x3, x3, x4
               	ldur	w4, [x29, #-0xa4]
               	ldur	w7, [x29, #-0x84]
               	sub	x4, x4, x7
               	ldur	w7, [x29, #-0xa0]
               	ldur	w8, [x29, #-0x80]
               	sub	x7, x7, x8
               	ldur	w8, [x29, #-0x9c]
               	ldur	w9, [x29, #-0x7c]
               	sub	x8, x8, x9
               	ldur	w9, [x29, #-0x98]
               	ldur	w10, [x29, #-0x78]
               	sub	x9, x9, x10
               	ldur	w10, [x29, #-0x94]
               	ldur	w11, [x29, #-0x74]
               	sub	x10, x10, x11
               	stur	w0, [x29, #-0x70]
               	stur	w1, [x29, #-0x6c]
               	stur	w3, [x29, #-0x68]
               	stur	w4, [x29, #-0x64]
               	stur	w7, [x29, #-0x60]
               	stur	w8, [x29, #-0x5c]
               	stur	w9, [x29, #-0x58]
               	stur	w10, [x29, #-0x54]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	w4, [x4]
               	add	x1, x6, x1
               	ldr	w1, [x1]
               	sub	x1, x4, x1
               	str	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x20
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x1, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0xb0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x5, x29, #0x1b0
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	lsl	x2, x2, #1
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	lsl	x2, x2, #3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	lsl	x2, x2, #4
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	lsl	x2, x2, #5
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	lsl	x2, x2, #6
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	lsl	x2, x2, #7
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	lsl	x2, x2, #1
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	lsl	x2, x2, #3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	lsl	x2, x2, #4
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	lsl	x2, x2, #5
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	lsl	x2, x2, #6
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	lsl	x2, x2, #7
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x10
               	ldrb	w3, [x5, x0]
               	ldrb	w4, [x1, x0]
               	lsl	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x50
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	ldurb	w3, [x29, #-0x50]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	ldurb	w3, [x29, #-0x4f]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	ldurb	w3, [x29, #-0x4e]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	ldurb	w3, [x29, #-0x4d]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	ldurb	w3, [x29, #-0x4c]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	ldurb	w3, [x29, #-0x4b]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	ldurb	w3, [x29, #-0x4a]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	ldurb	w3, [x29, #-0x49]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	ldurb	w3, [x29, #-0x48]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	ldurb	w3, [x29, #-0x47]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	ldurb	w3, [x29, #-0x46]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	ldurb	w3, [x29, #-0x45]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	ldurb	w3, [x29, #-0x44]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	ldurb	w3, [x29, #-0x43]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	ldurb	w3, [x29, #-0x42]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	ldurb	w3, [x29, #-0x41]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	lsr	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x6, x29, #0xb0
               	ldrsh	x0, [sp, #0x60]
               	ldursh	x1, [x29, #-0xb0]
               	asr	x0, x0, x1
               	ldrsh	x1, [sp, #0x62]
               	ldursh	x3, [x29, #-0xae]
               	asr	x1, x1, x3
               	ldrsh	x3, [sp, #0x64]
               	ldursh	x4, [x29, #-0xac]
               	asr	x3, x3, x4
               	ldrsh	x4, [sp, #0x66]
               	ldursh	x7, [x29, #-0xaa]
               	asr	x4, x4, x7
               	ldrsh	x7, [sp, #0x68]
               	ldursh	x8, [x29, #-0xa8]
               	asr	x7, x7, x8
               	ldrsh	x8, [sp, #0x6a]
               	ldursh	x9, [x29, #-0xa6]
               	asr	x8, x8, x9
               	ldrsh	x9, [sp, #0x6c]
               	ldursh	x10, [x29, #-0xa4]
               	asr	x9, x9, x10
               	ldrsh	x10, [sp, #0x6e]
               	ldursh	x11, [x29, #-0xa2]
               	asr	x10, x10, x11
               	and	x0, x0, #0xffff
               	sturh	w0, [x29, #-0x70]
               	and	x0, x1, #0xffff
               	sturh	w0, [x29, #-0x6e]
               	and	x0, x3, #0xffff
               	sturh	w0, [x29, #-0x6c]
               	and	x0, x4, #0xffff
               	sturh	w0, [x29, #-0x6a]
               	and	x0, x7, #0xffff
               	sturh	w0, [x29, #-0x68]
               	and	x0, x8, #0xffff
               	sturh	w0, [x29, #-0x66]
               	and	x0, x9, #0xffff
               	sturh	w0, [x29, #-0x64]
               	and	x0, x10, #0xffff
               	sturh	w0, [x29, #-0x62]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	asr	x1, x4, x1
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x6, x29, #0xb0
               	ldrsh	x0, [sp, #0x60]
               	ldursh	x1, [x29, #-0xb0]
               	lsl	x0, x0, x1
               	ldrsh	x1, [sp, #0x62]
               	ldursh	x3, [x29, #-0xae]
               	lsl	x1, x1, x3
               	ldrsh	x3, [sp, #0x64]
               	ldursh	x4, [x29, #-0xac]
               	lsl	x3, x3, x4
               	ldrsh	x4, [sp, #0x66]
               	ldursh	x7, [x29, #-0xaa]
               	lsl	x4, x4, x7
               	ldrsh	x7, [sp, #0x68]
               	ldursh	x8, [x29, #-0xa8]
               	lsl	x7, x7, x8
               	ldrsh	x8, [sp, #0x6a]
               	ldursh	x9, [x29, #-0xa6]
               	lsl	x8, x8, x9
               	ldrsh	x9, [sp, #0x6c]
               	ldursh	x10, [x29, #-0xa4]
               	lsl	x9, x9, x10
               	ldrsh	x10, [sp, #0x6e]
               	ldursh	x11, [x29, #-0xa2]
               	lsl	x10, x10, x11
               	and	x0, x0, #0xffff
               	sturh	w0, [x29, #-0x70]
               	and	x0, x1, #0xffff
               	sturh	w0, [x29, #-0x6e]
               	and	x0, x3, #0xffff
               	sturh	w0, [x29, #-0x6c]
               	and	x0, x4, #0xffff
               	sturh	w0, [x29, #-0x6a]
               	and	x0, x7, #0xffff
               	sturh	w0, [x29, #-0x68]
               	and	x0, x8, #0xffff
               	sturh	w0, [x29, #-0x66]
               	and	x0, x9, #0xffff
               	sturh	w0, [x29, #-0x64]
               	and	x0, x10, #0xffff
               	sturh	w0, [x29, #-0x62]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	lsl	x1, x4, x1
               	strh	w1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x110
               	ldr	q0, [sp, #0xa0]
               	sshr	v0.4s, v0.4s, #0x3
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	add	x2, x4, x2
               	ldrsw	x2, [x2]
               	asr	x2, x2, #3
               	str	w2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x130
               	ldr	q0, [sp, #0x80]
               	ushr	v0.4s, v0.4s, #0x3
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	add	x2, x4, x2
               	ldr	w2, [x2]
               	lsr	x2, x2, #3
               	str	w2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x190
               	ldr	q0, [sp, #0x20]
               	shl	v0.16b, v0.16b, #0x2
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x3, x0]
               	lsl	x2, x2, #2
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x3, x0]
               	sub	x2, x2, #0x40
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x3, x0]
               	add	x2, x2, #0x64
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	mov	x0, #0x7                // =7
               	sub	x2, x29, #0x70
               	ldrb	w4, [sp]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x1]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x2]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x3]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x4]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x5]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x6]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x7]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x8]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x9]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0xa]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0xb]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0xc]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0xd]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0xe]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0xf]
               	mul	x0, x4, x0
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x7                // =7
               	ldrb	w2, [x3, x0]
               	mul	x2, x2, x4
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	ldrb	w2, [x3, x0]
               	mul	x2, x2, x4
               	lsr	x2, x2, #32
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x2, x29, #0x70
               	ldrb	w0, [sp]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x70]
               	ldrb	w0, [sp, #0x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6f]
               	ldrb	w0, [sp, #0x2]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6e]
               	ldrb	w0, [sp, #0x3]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6d]
               	ldrb	w0, [sp, #0x4]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6c]
               	ldrb	w0, [sp, #0x5]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6b]
               	ldrb	w0, [sp, #0x6]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6a]
               	ldrb	w0, [sp, #0x7]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x69]
               	ldrb	w0, [sp, #0x8]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x68]
               	ldrb	w0, [sp, #0x9]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x67]
               	ldrb	w0, [sp, #0xa]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x66]
               	ldrb	w0, [sp, #0xb]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x65]
               	ldrb	w0, [sp, #0xc]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x64]
               	ldrb	w0, [sp, #0xd]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x63]
               	ldrb	w0, [sp, #0xe]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x62]
               	ldrb	w0, [sp, #0xf]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x7                // =7
               	mov	x6, #0x4925             // =18725
               	movk	x6, #0x2492, lsl #16
               	ldrb	w2, [x4, x0]
               	mul	x3, x2, x6
               	lsr	x3, x3, #32
               	mul	x3, x3, x5
               	sub	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	mov	x0, #0xf                // =15
               	sub	x2, x29, #0x70
               	ldrb	w4, [sp]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x1]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x2]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x3]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x4]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x5]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x6]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x7]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x8]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x9]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0xa]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0xb]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0xc]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0xd]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0xe]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0xf]
               	and	x0, x4, x0
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x3, x0]
               	and	x2, x2, #0xf
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	mov	x0, #0xf0               // =240
               	sub	x2, x29, #0x70
               	ldrb	w4, [sp]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x1]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x2]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x3]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x4]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x5]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x6]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x7]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x8]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x9]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0xa]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0xb]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0xc]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0xd]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0xe]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0xf]
               	orr	x0, x4, x0
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x3, x0]
               	orr	x2, x2, #0xf0
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	mov	x0, #0x55               // =85
               	sub	x2, x29, #0x70
               	ldrb	w4, [sp]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x1]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x2]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x3]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x4]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x5]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x6]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x7]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x8]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x9]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0xa]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0xb]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0xc]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0xd]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0xe]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0xf]
               	eor	x0, x4, x0
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x55               // =85
               	ldrb	w2, [x3, x0]
               	eor	x2, x2, x4
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x190
               	sub	x0, x29, #0x70
               	ldrsb	x2, [sp, #0x20]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x70]
               	ldrsb	x2, [sp, #0x21]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6f]
               	ldrsb	x2, [sp, #0x22]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6e]
               	ldrsb	x2, [sp, #0x23]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6d]
               	ldrsb	x2, [sp, #0x24]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6c]
               	ldrsb	x2, [sp, #0x25]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6b]
               	ldrsb	x2, [sp, #0x26]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6a]
               	ldrsb	x2, [sp, #0x27]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x69]
               	ldrsb	x2, [sp, #0x28]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x68]
               	ldrsb	x2, [sp, #0x29]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x67]
               	ldrsb	x2, [sp, #0x2a]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x66]
               	ldrsb	x2, [sp, #0x2b]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x65]
               	ldrsb	x2, [sp, #0x2c]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x64]
               	ldrsb	x2, [sp, #0x2d]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x63]
               	ldrsb	x2, [sp, #0x2e]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x62]
               	ldrsb	x2, [sp, #0x2f]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x3, x0]
               	sub	x2, x2, #0x64
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x190
               	sub	x2, x29, #0x70
               	ldrsb	x0, [sp, #0x20]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x70]
               	ldrsb	x0, [sp, #0x21]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6f]
               	ldrsb	x0, [sp, #0x22]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6e]
               	ldrsb	x0, [sp, #0x23]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6d]
               	ldrsb	x0, [sp, #0x24]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6c]
               	ldrsb	x0, [sp, #0x25]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6b]
               	ldrsb	x0, [sp, #0x26]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6a]
               	ldrsb	x0, [sp, #0x27]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x69]
               	ldrsb	x0, [sp, #0x28]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x68]
               	ldrsb	x0, [sp, #0x29]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x67]
               	ldrsb	x0, [sp, #0x2a]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x66]
               	ldrsb	x0, [sp, #0x2b]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x65]
               	ldrsb	x0, [sp, #0x2c]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x64]
               	ldrsb	x0, [sp, #0x2d]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x63]
               	ldrsb	x0, [sp, #0x2e]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x62]
               	ldrsb	x0, [sp, #0x2f]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	ldrsb	x2, [x3, x0]
               	mul	x2, x2, x4
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x190
               	sub	x3, x29, #0x70
               	ldrsb	x0, [sp, #0x20]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x70]
               	ldrsb	x0, [sp, #0x21]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6f]
               	ldrsb	x0, [sp, #0x22]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6e]
               	ldrsb	x0, [sp, #0x23]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6d]
               	ldrsb	x0, [sp, #0x24]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6c]
               	ldrsb	x0, [sp, #0x25]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6b]
               	ldrsb	x0, [sp, #0x26]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6a]
               	ldrsb	x0, [sp, #0x27]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x69]
               	ldrsb	x0, [sp, #0x28]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x68]
               	ldrsb	x0, [sp, #0x29]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x67]
               	ldrsb	x0, [sp, #0x2a]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x66]
               	ldrsb	x0, [sp, #0x2b]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x65]
               	ldrsb	x0, [sp, #0x2c]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x64]
               	ldrsb	x0, [sp, #0x2d]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x63]
               	ldrsb	x0, [sp, #0x2e]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x62]
               	ldrsb	x0, [sp, #0x2f]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #1
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	ldrsb	x2, [x4, x0]
               	mul	x3, x2, x5
               	asr	x3, x3, #32
               	add	x3, x3, x3, lsr #63
               	add	x3, x3, x3, lsl #1
               	sub	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x170
               	mov	x0, #0x3e8              // =1000
               	ldrh	w2, [sp, #0x40]
               	mul	x2, x2, x0
               	ldrh	w3, [sp, #0x42]
               	mul	x3, x3, x0
               	ldrh	w5, [sp, #0x44]
               	mul	x5, x5, x0
               	ldrh	w6, [sp, #0x46]
               	mul	x6, x6, x0
               	ldrh	w7, [sp, #0x48]
               	mul	x7, x7, x0
               	ldrh	w8, [sp, #0x4a]
               	mul	x8, x8, x0
               	ldrh	w9, [sp, #0x4c]
               	mul	x9, x9, x0
               	ldrh	w10, [sp, #0x4e]
               	mul	x0, x10, x0
               	and	x2, x2, #0xffff
               	sturh	w2, [x29, #-0x70]
               	and	x2, x3, #0xffff
               	sturh	w2, [x29, #-0x6e]
               	and	x2, x5, #0xffff
               	sturh	w2, [x29, #-0x6c]
               	and	x2, x6, #0xffff
               	sturh	w2, [x29, #-0x6a]
               	and	x2, x7, #0xffff
               	sturh	w2, [x29, #-0x68]
               	and	x2, x8, #0xffff
               	sturh	w2, [x29, #-0x66]
               	and	x2, x9, #0xffff
               	sturh	w2, [x29, #-0x64]
               	and	x0, x0, #0xffff
               	sturh	w0, [x29, #-0x62]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x3e8              // =1000
               	lsl	x2, x0, #1
               	add	x3, x1, x2
               	add	x2, x4, x2
               	ldrh	w2, [x2]
               	mul	x2, x2, x5
               	and	x2, x2, #0xffff
               	strh	w2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xd0
               	mov	x0, #0x7                // =7
               	ldur	x2, [x29, #-0xd0]
               	mul	x2, x2, x0
               	ldur	x3, [x29, #-0xc8]
               	mul	x0, x3, x0
               	stur	x2, [x29, #-0x70]
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x7                // =7
               	lsl	x2, x0, #3
               	add	x3, x1, x2
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	mul	x2, x2, x5
               	str	x2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x40               // =64
               	sub	x4, x29, #0x1b0
               	sub	x2, x29, #0x70
               	ldrb	w3, [sp]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x70]
               	ldrb	w3, [sp, #0x1]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6f]
               	ldrb	w3, [sp, #0x2]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6e]
               	ldrb	w3, [sp, #0x3]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6d]
               	ldrb	w3, [sp, #0x4]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6c]
               	ldrb	w3, [sp, #0x5]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6b]
               	ldrb	w3, [sp, #0x6]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6a]
               	ldrb	w3, [sp, #0x7]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x69]
               	ldrb	w3, [sp, #0x8]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x68]
               	ldrb	w3, [sp, #0x9]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x67]
               	ldrb	w3, [sp, #0xa]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x66]
               	ldrb	w3, [sp, #0xb]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x65]
               	ldrb	w3, [sp, #0xc]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x64]
               	ldrb	w3, [sp, #0xd]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x63]
               	ldrb	w3, [sp, #0xe]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x62]
               	ldrb	w3, [sp, #0xf]
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x40               // =64
               	ldrb	w3, [x4, x0]
               	sub	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x64               // =100
               	sub	x4, x29, #0x190
               	sub	x2, x29, #0x70
               	ldrsb	x3, [sp, #0x20]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x70]
               	ldrsb	x3, [sp, #0x21]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6f]
               	ldrsb	x3, [sp, #0x22]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6e]
               	ldrsb	x3, [sp, #0x23]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6d]
               	ldrsb	x3, [sp, #0x24]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6c]
               	ldrsb	x3, [sp, #0x25]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6b]
               	ldrsb	x3, [sp, #0x26]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6a]
               	ldrsb	x3, [sp, #0x27]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x69]
               	ldrsb	x3, [sp, #0x28]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x68]
               	ldrsb	x3, [sp, #0x29]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x67]
               	ldrsb	x3, [sp, #0x2a]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x66]
               	ldrsb	x3, [sp, #0x2b]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x65]
               	ldrsb	x3, [sp, #0x2c]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x64]
               	ldrsb	x3, [sp, #0x2d]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x63]
               	ldrsb	x3, [sp, #0x2e]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x62]
               	ldrsb	x3, [sp, #0x2f]
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x64               // =100
               	ldrsb	x3, [x4, x0]
               	sub	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0xfa               // =250
               	sub	x4, x29, #0x1a0
               	sub	x2, x29, #0x70
               	ldrb	w3, [sp, #0x10]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x70]
               	ldrb	w3, [sp, #0x11]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6f]
               	ldrb	w3, [sp, #0x12]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6e]
               	ldrb	w3, [sp, #0x13]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6d]
               	ldrb	w3, [sp, #0x14]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6c]
               	ldrb	w3, [sp, #0x15]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6b]
               	ldrb	w3, [sp, #0x16]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6a]
               	ldrb	w3, [sp, #0x17]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x69]
               	ldrb	w3, [sp, #0x18]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x68]
               	ldrb	w3, [sp, #0x19]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x67]
               	ldrb	w3, [sp, #0x1a]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x66]
               	ldrb	w3, [sp, #0x1b]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x65]
               	ldrb	w3, [sp, #0x1c]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x64]
               	ldrb	w3, [sp, #0x1d]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x63]
               	ldrb	w3, [sp, #0x1e]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x62]
               	ldrb	w3, [sp, #0x1f]
               	udiv	w0, w0, w3
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xfa               // =250
               	ldrb	w3, [x4, x0]
               	sdiv	w2, w2, w3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0xfa               // =250
               	sub	x4, x29, #0x1a0
               	sub	x2, x29, #0x70
               	ldrb	w3, [sp, #0x10]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x70]
               	ldrb	w3, [sp, #0x11]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6f]
               	ldrb	w3, [sp, #0x12]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6e]
               	ldrb	w3, [sp, #0x13]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6d]
               	ldrb	w3, [sp, #0x14]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6c]
               	ldrb	w3, [sp, #0x15]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6b]
               	ldrb	w3, [sp, #0x16]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6a]
               	ldrb	w3, [sp, #0x17]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x69]
               	ldrb	w3, [sp, #0x18]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x68]
               	ldrb	w3, [sp, #0x19]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x67]
               	ldrb	w3, [sp, #0x1a]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x66]
               	ldrb	w3, [sp, #0x1b]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x65]
               	ldrb	w3, [sp, #0x1c]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x64]
               	ldrb	w3, [sp, #0x1d]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x63]
               	ldrb	w3, [sp, #0x1e]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x62]
               	ldrb	w3, [sp, #0x1f]
               	udiv	w17, w0, w3
               	msub	w0, w17, w3, w0
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xfa               // =250
               	ldrb	w3, [x4, x0]
               	sdiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0xf                // =15
               	sub	x3, x29, #0x1a0
               	sub	x2, x29, #0x70
               	ldrb	w4, [sp, #0x10]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x11]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x12]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x13]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x14]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x15]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x16]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x17]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x18]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x19]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0x1a]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0x1b]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0x1c]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0x1d]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0x1e]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0x1f]
               	and	x0, x0, x4
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x3, x0]
               	and	x2, x2, #0xf
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x3                // =3
               	sub	x4, x29, #0x50
               	sub	x2, x29, #0x70
               	ldurb	w3, [x29, #-0x50]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x4f]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x4e]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x4d]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x4c]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x4b]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x4a]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x49]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x48]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x47]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x46]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x45]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x44]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x43]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x42]
               	lsl	x3, x0, x3
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x41]
               	lsl	x0, x0, x3
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	ldrb	w3, [x4, x0]
               	lsl	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x80               // =128
               	sub	x4, x29, #0x50
               	sub	x2, x29, #0x70
               	ldurb	w3, [x29, #-0x50]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x4f]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x4e]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x4d]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x4c]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x4b]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x4a]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x49]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x48]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x47]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x46]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x45]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x44]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x43]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x42]
               	lsr	x3, x0, x3
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x41]
               	lsr	x0, x0, x3
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	ldrb	w3, [x4, x0]
               	lsr	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #-0x7               // =-7
               	sub	x5, x29, #0x100
               	ldursw	x2, [x29, #-0x100]
               	sdiv	x2, x0, x2
               	ldursw	x3, [x29, #-0xfc]
               	sdiv	x3, x0, x3
               	ldursw	x4, [x29, #-0xf8]
               	sdiv	x4, x0, x4
               	ldursw	x6, [x29, #-0xf4]
               	sdiv	x0, x0, x6
               	stur	w2, [x29, #-0x70]
               	stur	w3, [x29, #-0x6c]
               	stur	w4, [x29, #-0x68]
               	stur	w0, [x29, #-0x64]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	mov	x4, #-0x7               // =-7
               	add	x2, x5, x2
               	ldrsw	x2, [x2]
               	sdiv	w2, w4, w2
               	str	w2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #-0x7               // =-7
               	sub	x5, x29, #0x100
               	ldursw	x2, [x29, #-0x100]
               	sdiv	x17, x0, x2
               	msub	x2, x17, x2, x0
               	ldursw	x3, [x29, #-0xfc]
               	sdiv	x17, x0, x3
               	msub	x3, x17, x3, x0
               	ldursw	x4, [x29, #-0xf8]
               	sdiv	x17, x0, x4
               	msub	x4, x17, x4, x0
               	ldursw	x6, [x29, #-0xf4]
               	sdiv	x17, x0, x6
               	msub	x0, x17, x6, x0
               	stur	w2, [x29, #-0x70]
               	stur	w3, [x29, #-0x6c]
               	stur	w4, [x29, #-0x68]
               	stur	w0, [x29, #-0x64]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	mov	x4, #-0x7               // =-7
               	add	x2, x5, x2
               	ldrsw	x2, [x2]
               	sdiv	w17, w4, w2
               	msub	w2, w17, w2, w4
               	str	w2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	ldrb	w2, [x3, x0]
               	mul	x2, x2, x4
               	lsr	x2, x2, #32
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x110
               	ldrsw	x0, [sp, #0xa0]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	add	x2, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xa4]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	add	x3, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xa8]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	add	x5, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xac]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	add	x0, x0, x0, lsr #63
               	stur	w2, [x29, #-0x70]
               	stur	w3, [x29, #-0x6c]
               	stur	w5, [x29, #-0x68]
               	stur	w0, [x29, #-0x64]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x2493             // =9363
               	movk	x5, #0x9249, lsl #16
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	add	x2, x4, x2
               	ldrsw	x2, [x2]
               	mul	x2, x2, x5
               	asr	x2, x2, #34
               	add	x2, x2, x2, lsr #63
               	str	w2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	ldr	q0, [sp]
               	neg	v0.16b, v0.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x3, x0]
               	neg	x2, x2
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x190
               	ldr	q0, [sp, #0x20]
               	neg	v0.16b, v0.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x3, x0]
               	neg	x2, x2
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x110
               	ldr	q0, [sp, #0xa0]
               	neg	v0.4s, v0.4s
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	add	x2, x4, x2
               	ldrsw	x2, [x2]
               	neg	x2, x2
               	str	w2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	ldr	q0, [sp]
               	mvn	v0.16b, v0.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x3, x0]
               	mvn	x2, x2
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xd0
               	ldur	q0, [x29, #-0xd0]
               	mvn	v0.16b, v0.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #3
               	add	x3, x1, x2
               	add	x2, x4, x2
               	ldr	x2, [x2]
               	mvn	x2, x2
               	str	x2, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	add	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	add	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sub	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	sub	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	mul	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	mul	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	sub	x1, x29, #0x70
               	ldrb	w2, [sp]
               	ldrb	w3, [sp, #0x10]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	ldrb	w3, [sp, #0x11]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	ldrb	w3, [sp, #0x12]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	ldrb	w3, [sp, #0x13]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	ldrb	w3, [sp, #0x14]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	ldrb	w3, [sp, #0x15]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	ldrb	w3, [sp, #0x16]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	ldrb	w3, [sp, #0x17]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	ldrb	w3, [sp, #0x18]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	ldrb	w3, [sp, #0x19]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	ldrb	w3, [sp, #0x1a]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	ldrb	w3, [sp, #0x1b]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	ldrb	w3, [sp, #0x1c]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	ldrb	w3, [sp, #0x1d]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	ldrb	w3, [sp, #0x1e]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	ldrb	w3, [sp, #0x1f]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x70
               	ldrb	w3, [sp]
               	ldrb	w4, [sp, #0x10]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	ldrb	w4, [sp, #0x11]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	ldrb	w4, [sp, #0x12]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	ldrb	w4, [sp, #0x13]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	ldrb	w4, [sp, #0x14]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	ldrb	w4, [sp, #0x15]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	ldrb	w4, [sp, #0x16]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	ldrb	w4, [sp, #0x17]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	ldrb	w4, [sp, #0x18]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	ldrb	w4, [sp, #0x19]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	ldrb	w4, [sp, #0x1a]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	ldrb	w4, [sp, #0x1b]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	ldrb	w4, [sp, #0x1c]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	ldrb	w4, [sp, #0x1d]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	ldrb	w4, [sp, #0x1e]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	ldrb	w4, [sp, #0x1f]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x61]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	sub	x1, x29, #0x70
               	ldrb	w2, [sp]
               	ldrb	w3, [sp, #0x10]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	ldrb	w3, [sp, #0x11]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	ldrb	w3, [sp, #0x12]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	ldrb	w3, [sp, #0x13]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	ldrb	w3, [sp, #0x14]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	ldrb	w3, [sp, #0x15]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	ldrb	w3, [sp, #0x16]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	ldrb	w3, [sp, #0x17]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	ldrb	w3, [sp, #0x18]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	ldrb	w3, [sp, #0x19]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	ldrb	w3, [sp, #0x1a]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	ldrb	w3, [sp, #0x1b]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	ldrb	w3, [sp, #0x1c]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	ldrb	w3, [sp, #0x1d]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	ldrb	w3, [sp, #0x1e]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	ldrb	w3, [sp, #0x1f]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x70
               	ldrb	w3, [sp]
               	ldrb	w4, [sp, #0x10]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	ldrb	w4, [sp, #0x11]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	ldrb	w4, [sp, #0x12]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	ldrb	w4, [sp, #0x13]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	ldrb	w4, [sp, #0x14]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	ldrb	w4, [sp, #0x15]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	ldrb	w4, [sp, #0x16]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	ldrb	w4, [sp, #0x17]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	ldrb	w4, [sp, #0x18]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	ldrb	w4, [sp, #0x19]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	ldrb	w4, [sp, #0x1a]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	ldrb	w4, [sp, #0x1b]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	ldrb	w4, [sp, #0x1c]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	ldrb	w4, [sp, #0x1d]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	ldrb	w4, [sp, #0x1e]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	ldrb	w4, [sp, #0x1f]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x61]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	and	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	and	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	orr	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	orr	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	eor	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	sub	x1, x29, #0x70
               	ldrb	w2, [sp]
               	ldurb	w3, [x29, #-0x50]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	ldurb	w3, [x29, #-0x4f]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	ldurb	w3, [x29, #-0x4e]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	ldurb	w3, [x29, #-0x4d]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	ldurb	w3, [x29, #-0x4c]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	ldurb	w3, [x29, #-0x4b]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	ldurb	w3, [x29, #-0x4a]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	ldurb	w3, [x29, #-0x49]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	ldurb	w3, [x29, #-0x48]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	ldurb	w3, [x29, #-0x47]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	ldurb	w3, [x29, #-0x46]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	ldurb	w3, [x29, #-0x45]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	ldurb	w3, [x29, #-0x44]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	ldurb	w3, [x29, #-0x43]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	ldurb	w3, [x29, #-0x42]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	ldurb	w3, [x29, #-0x41]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x70
               	ldrb	w3, [sp]
               	ldurb	w4, [x29, #-0x50]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	ldurb	w4, [x29, #-0x4f]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	ldurb	w4, [x29, #-0x4e]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	ldurb	w4, [x29, #-0x4d]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	ldurb	w4, [x29, #-0x4c]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	ldurb	w4, [x29, #-0x4b]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	ldurb	w4, [x29, #-0x4a]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	ldurb	w4, [x29, #-0x49]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	ldurb	w4, [x29, #-0x48]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	ldurb	w4, [x29, #-0x47]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	ldurb	w4, [x29, #-0x46]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	ldurb	w4, [x29, #-0x45]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	ldurb	w4, [x29, #-0x44]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	ldurb	w4, [x29, #-0x43]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	ldurb	w4, [x29, #-0x42]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	ldurb	w4, [x29, #-0x41]
               	lsl	x3, x3, x4
               	sturb	w3, [x29, #-0x61]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	sub	x1, x29, #0x70
               	ldrb	w2, [sp]
               	ldurb	w3, [x29, #-0x50]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	ldurb	w3, [x29, #-0x4f]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	ldurb	w3, [x29, #-0x4e]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	ldurb	w3, [x29, #-0x4d]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	ldurb	w3, [x29, #-0x4c]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	ldurb	w3, [x29, #-0x4b]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	ldurb	w3, [x29, #-0x4a]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	ldurb	w3, [x29, #-0x49]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	ldurb	w3, [x29, #-0x48]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	ldurb	w3, [x29, #-0x47]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	ldurb	w3, [x29, #-0x46]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	ldurb	w3, [x29, #-0x45]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	ldurb	w3, [x29, #-0x44]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	ldurb	w3, [x29, #-0x43]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	ldurb	w3, [x29, #-0x42]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	ldurb	w3, [x29, #-0x41]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x70
               	ldrb	w3, [sp]
               	ldurb	w4, [x29, #-0x50]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	ldurb	w4, [x29, #-0x4f]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	ldurb	w4, [x29, #-0x4e]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	ldurb	w4, [x29, #-0x4d]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	ldurb	w4, [x29, #-0x4c]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	ldurb	w4, [x29, #-0x4b]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	ldurb	w4, [x29, #-0x4a]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	ldurb	w4, [x29, #-0x49]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	ldurb	w4, [x29, #-0x48]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	ldurb	w4, [x29, #-0x47]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	ldurb	w4, [x29, #-0x46]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	ldurb	w4, [x29, #-0x45]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	ldurb	w4, [x29, #-0x44]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	ldurb	w4, [x29, #-0x43]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	ldurb	w4, [x29, #-0x42]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	ldurb	w4, [x29, #-0x41]
               	lsr	x3, x3, x4
               	sturb	w3, [x29, #-0x61]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x150
               	ldrsh	x1, [sp, #0x60]
               	ldrsh	x2, [sp, #0x70]
               	sdiv	x1, x1, x2
               	ldrsh	x2, [sp, #0x62]
               	ldrsh	x3, [sp, #0x72]
               	sdiv	x3, x2, x3
               	ldrsh	x2, [sp, #0x64]
               	ldrsh	x4, [sp, #0x74]
               	sdiv	x4, x2, x4
               	ldrsh	x2, [sp, #0x66]
               	ldrsh	x5, [sp, #0x76]
               	sdiv	x5, x2, x5
               	ldrsh	x2, [sp, #0x68]
               	ldrsh	x6, [sp, #0x78]
               	sdiv	x6, x2, x6
               	ldrsh	x2, [sp, #0x6a]
               	ldrsh	x7, [sp, #0x7a]
               	sdiv	x7, x2, x7
               	ldrsh	x2, [sp, #0x6c]
               	ldrsh	x8, [sp, #0x7c]
               	sdiv	x8, x2, x8
               	ldrsh	x2, [sp, #0x6e]
               	ldrsh	x9, [sp, #0x7e]
               	sdiv	x9, x2, x9
               	sub	x2, x29, #0x90
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x90]
               	and	x1, x3, #0xffff
               	sturh	w1, [x29, #-0x8e]
               	and	x1, x4, #0xffff
               	sturh	w1, [x29, #-0x8c]
               	and	x1, x5, #0xffff
               	sturh	w1, [x29, #-0x8a]
               	and	x1, x6, #0xffff
               	sturh	w1, [x29, #-0x88]
               	and	x1, x7, #0xffff
               	sturh	w1, [x29, #-0x86]
               	and	x1, x8, #0xffff
               	sturh	w1, [x29, #-0x84]
               	and	x1, x9, #0xffff
               	sturh	w1, [x29, #-0x82]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldrsh	x0, [sp, #0x60]
               	ldrsh	x3, [sp, #0x70]
               	sdiv	x0, x0, x3
               	ldrsh	x3, [sp, #0x62]
               	ldrsh	x4, [sp, #0x72]
               	sdiv	x3, x3, x4
               	ldrsh	x4, [sp, #0x64]
               	ldrsh	x5, [sp, #0x74]
               	sdiv	x4, x4, x5
               	ldrsh	x5, [sp, #0x66]
               	ldrsh	x6, [sp, #0x76]
               	sdiv	x5, x5, x6
               	ldrsh	x6, [sp, #0x68]
               	ldrsh	x7, [sp, #0x78]
               	sdiv	x6, x6, x7
               	ldrsh	x7, [sp, #0x6a]
               	ldrsh	x8, [sp, #0x7a]
               	sdiv	x7, x7, x8
               	ldrsh	x8, [sp, #0x6c]
               	ldrsh	x9, [sp, #0x7c]
               	sdiv	x8, x8, x9
               	ldrsh	x9, [sp, #0x6e]
               	ldrsh	x10, [sp, #0x7e]
               	sdiv	x9, x9, x10
               	and	x0, x0, #0xffff
               	sturh	w0, [x29, #-0x70]
               	and	x0, x3, #0xffff
               	sturh	w0, [x29, #-0x6e]
               	and	x0, x4, #0xffff
               	sturh	w0, [x29, #-0x6c]
               	and	x0, x5, #0xffff
               	sturh	w0, [x29, #-0x6a]
               	and	x0, x6, #0xffff
               	sturh	w0, [x29, #-0x68]
               	and	x0, x7, #0xffff
               	sturh	w0, [x29, #-0x66]
               	and	x0, x8, #0xffff
               	sturh	w0, [x29, #-0x64]
               	and	x0, x9, #0xffff
               	sturh	w0, [x29, #-0x62]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd0
               	ldur	x1, [x29, #-0xd0]
               	ldur	x2, [x29, #-0xc0]
               	mul	x1, x1, x2
               	ldur	x2, [x29, #-0xc8]
               	ldur	x3, [x29, #-0xb8]
               	mul	x3, x2, x3
               	sub	x2, x29, #0x90
               	stur	x1, [x29, #-0x90]
               	stur	x3, [x29, #-0x88]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	x0, [x29, #-0xd0]
               	ldur	x3, [x29, #-0xc0]
               	mul	x0, x0, x3
               	ldur	x3, [x29, #-0xc8]
               	ldur	x4, [x29, #-0xb8]
               	mul	x3, x3, x4
               	stur	x0, [x29, #-0x70]
               	stur	x3, [x29, #-0x68]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	sub	x1, x29, #0xb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x70]
               	ldurb	w2, [x29, #-0xaf]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6f]
               	ldurb	w2, [x29, #-0xae]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6e]
               	ldurb	w2, [x29, #-0xad]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6d]
               	ldurb	w2, [x29, #-0xac]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6c]
               	ldurb	w2, [x29, #-0xab]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6b]
               	ldurb	w2, [x29, #-0xaa]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6a]
               	ldurb	w2, [x29, #-0xa9]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x69]
               	ldurb	w2, [x29, #-0xa8]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x68]
               	ldurb	w2, [x29, #-0xa7]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x67]
               	ldurb	w2, [x29, #-0xa6]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x66]
               	ldurb	w2, [x29, #-0xa5]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x65]
               	ldurb	w2, [x29, #-0xa4]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x64]
               	ldurb	w2, [x29, #-0xa3]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x63]
               	ldurb	w2, [x29, #-0xa2]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x62]
               	ldurb	w2, [x29, #-0xa1]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x61]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x1]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x2]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x3]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x4]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x5]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x6]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x7]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x8]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x9]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0xa]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0xb]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0xc]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0xd]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0xe]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0xf]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x2, x29, #0x70
               	ldrb	w3, [sp]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x61]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x2, x29, #0x70
               	ldurb	w3, [x29, #-0x70]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x61]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x2, x29, #0x70
               	ldurb	w3, [x29, #-0x70]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	sub	x3, x3, #0x40
               	sturb	w3, [x29, #-0x61]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x10
               	ldrb	w3, [x1, x0]
               	sub	x3, x3, #0xc0
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	add	v0.16b, v0.16b, v1.16b
               	mov	x0, #0x3                // =3
               	umov	w2, v0.b[0]
               	mul	x2, x2, x0
               	mov	x3, #0x0                // =0
               	fmov	d1, x3
               	mov	v1.b[0], w2
               	umov	w2, v0.b[1]
               	mul	x2, x2, x0
               	mov	v1.b[1], w2
               	umov	w2, v0.b[2]
               	mul	x2, x2, x0
               	mov	v1.b[2], w2
               	umov	w2, v0.b[3]
               	mul	x2, x2, x0
               	mov	v1.b[3], w2
               	umov	w2, v0.b[4]
               	mul	x2, x2, x0
               	mov	v1.b[4], w2
               	umov	w2, v0.b[5]
               	mul	x2, x2, x0
               	mov	v1.b[5], w2
               	umov	w2, v0.b[6]
               	mul	x2, x2, x0
               	mov	v1.b[6], w2
               	umov	w2, v0.b[7]
               	mul	x2, x2, x0
               	mov	v1.b[7], w2
               	umov	w2, v0.b[8]
               	mul	x2, x2, x0
               	mov	v1.b[8], w2
               	umov	w2, v0.b[9]
               	mul	x2, x2, x0
               	mov	v1.b[9], w2
               	umov	w2, v0.b[10]
               	mul	x2, x2, x0
               	mov	v1.b[10], w2
               	umov	w2, v0.b[11]
               	mul	x2, x2, x0
               	mov	v1.b[11], w2
               	umov	w2, v0.b[12]
               	mul	x2, x2, x0
               	mov	v1.b[12], w2
               	umov	w2, v0.b[13]
               	mul	x2, x2, x0
               	mov	v1.b[13], w2
               	umov	w2, v0.b[14]
               	mul	x2, x2, x0
               	mov	v1.b[14], w2
               	umov	w2, v0.b[15]
               	mul	x0, x2, x0
               	mov	v0.16b, v1.16b
               	mov	v0.b[15], w0
               	ldr	q1, [sp]
               	sub	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	add	x3, x2, x3
               	and	x3, x3, #0xff
               	add	x3, x3, x3, lsl #1
               	and	x3, x3, #0xff
               	sub	x2, x3, x2
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x110
               	ldrsw	x0, [sp, #0xa0]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	mov	x1, #0x0                // =0
               	fmov	s0, w0
               	ldrsw	x0, [sp, #0xa4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	mov	v0.s[1], w0
               	ldrsw	x0, [sp, #0xa8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	mov	v0.s[2], w0
               	ldrsw	x0, [sp, #0xac]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	mov	v0.s[3], w0
               	neg	v0.4s, v0.4s
               	sub	x6, x29, #0x100
               	ldur	q1, [x29, #-0x100]
               	add	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	lsl	x1, x0, #2
               	add	x4, x2, x1
               	add	x3, x5, x1
               	ldrsw	x3, [x3]
               	mul	x3, x3, x7
               	asr	x3, x3, #32
               	add	x3, x3, x3, lsr #63
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	sub	x1, x1, x3
               	str	w1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x1b0
               	ldr	q0, [sp]
               	shl	v1.16b, v0.16b, #0x1
               	sshr	v0.16b, v0.16b, #0x7
               	mov	x0, #0x1b               // =27
               	smov	x2, v0.b[0]
               	and	x2, x2, x0
               	mov	x3, #0x0                // =0
               	fmov	d2, x3
               	mov	v2.b[0], w2
               	smov	x2, v0.b[1]
               	and	x2, x2, x0
               	mov	v2.b[1], w2
               	smov	x2, v0.b[2]
               	and	x2, x2, x0
               	mov	v2.b[2], w2
               	smov	x2, v0.b[3]
               	and	x2, x2, x0
               	mov	v2.b[3], w2
               	smov	x2, v0.b[4]
               	and	x2, x2, x0
               	mov	v2.b[4], w2
               	smov	x2, v0.b[5]
               	and	x2, x2, x0
               	mov	v2.b[5], w2
               	smov	x2, v0.b[6]
               	and	x2, x2, x0
               	mov	v2.b[6], w2
               	smov	x2, v0.b[7]
               	and	x2, x2, x0
               	mov	v2.b[7], w2
               	smov	x2, v0.b[8]
               	and	x2, x2, x0
               	mov	v2.b[8], w2
               	smov	x2, v0.b[9]
               	and	x2, x2, x0
               	mov	v2.b[9], w2
               	smov	x2, v0.b[10]
               	and	x2, x2, x0
               	mov	v2.b[10], w2
               	smov	x2, v0.b[11]
               	and	x2, x2, x0
               	mov	v2.b[11], w2
               	smov	x2, v0.b[12]
               	and	x2, x2, x0
               	mov	v2.b[12], w2
               	smov	x2, v0.b[13]
               	and	x2, x2, x0
               	mov	v2.b[13], w2
               	smov	x2, v0.b[14]
               	and	x2, x2, x0
               	mov	v2.b[14], w2
               	smov	x2, v0.b[15]
               	and	x0, x2, x0
               	mov	v0.16b, v2.16b
               	mov	v0.b[15], w0
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x5, x0]
               	sxtb	x3, w2
               	mov	x4, #0x1b               // =27
               	and	x3, x4, x3, asr #7
               	lsl	x2, x2, #1
               	and	x2, x2, #0xff
               	eor	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x190
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x20]
               	add	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	add	x2, x2, x3
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0xb0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x4, x29, #0x70
               	mov	x0, #0x42               // =66
               	sturb	w0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x6f]
               	mov	x5, #0x28               // =40
               	sturb	w5, [x29, #-0x6e]
               	sturb	w0, [x29, #-0x6d]
               	mov	x5, #0x1d               // =29
               	sturb	w5, [x29, #-0x6c]
               	sturb	w0, [x29, #-0x6b]
               	mov	x5, #0x16               // =22
               	sturb	w5, [x29, #-0x6a]
               	sturb	w0, [x29, #-0x69]
               	mov	x5, #0x1                // =1
               	sturb	w5, [x29, #-0x68]
               	mov	x5, #0x2                // =2
               	sturb	w5, [x29, #-0x67]
               	mov	x5, #0x3                // =3
               	sturb	w5, [x29, #-0x66]
               	mov	x5, #0x4                // =4
               	sturb	w5, [x29, #-0x65]
               	mov	x5, #0x5                // =5
               	sturb	w5, [x29, #-0x64]
               	mov	x5, #0x6                // =6
               	sturb	w5, [x29, #-0x63]
               	mov	x5, #0x7                // =7
               	sturb	w5, [x29, #-0x62]
               	mov	x5, #0x8                // =8
               	sturb	w5, [x29, #-0x61]
               	sub	x5, x29, #0x90
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x5]
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	sdiv	w4, w4, w5
               	and	x4, x4, #0xff
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x90
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x50
               	sub	x5, x29, #0xb0
               	sub	x0, x29, #0x70
               	ldursb	x2, [x29, #-0x50]
               	ldursb	x3, [x29, #-0xb0]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldursb	x2, [x29, #-0x4f]
               	ldursb	x3, [x29, #-0xaf]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldursb	x2, [x29, #-0x4e]
               	ldursb	x3, [x29, #-0xae]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldursb	x2, [x29, #-0x4d]
               	ldursb	x3, [x29, #-0xad]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldursb	x2, [x29, #-0x4c]
               	ldursb	x3, [x29, #-0xac]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldursb	x2, [x29, #-0x4b]
               	ldursb	x3, [x29, #-0xab]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldursb	x2, [x29, #-0x4a]
               	ldursb	x3, [x29, #-0xaa]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldursb	x2, [x29, #-0x49]
               	ldursb	x3, [x29, #-0xa9]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldursb	x2, [x29, #-0x48]
               	ldursb	x3, [x29, #-0xa8]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldursb	x2, [x29, #-0x47]
               	ldursb	x3, [x29, #-0xa7]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldursb	x2, [x29, #-0x46]
               	ldursb	x3, [x29, #-0xa6]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldursb	x2, [x29, #-0x45]
               	ldursb	x3, [x29, #-0xa5]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldursb	x2, [x29, #-0x44]
               	ldursb	x3, [x29, #-0xa4]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldursb	x2, [x29, #-0x43]
               	ldursb	x3, [x29, #-0xa3]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldursb	x2, [x29, #-0x42]
               	ldursb	x3, [x29, #-0xa2]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldursb	x2, [x29, #-0x41]
               	ldursb	x3, [x29, #-0xa1]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	sdiv	w2, w2, w3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5f               // =95
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5e               // =94
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5d               // =93
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5c               // =92
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5b               // =91
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5a               // =90
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x59               // =89
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x58               // =88
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x57               // =87
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x56               // =86
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x55               // =85
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x54               // =84
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x53               // =83
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x52               // =82
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x51               // =81
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x50               // =80
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4f               // =79
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4e               // =78
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4d               // =77
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4c               // =76
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4b               // =75
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4a               // =74
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x49               // =73
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x60               // =96
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x48               // =72
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x66               // =102
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x63               // =99
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x62               // =98
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x61               // =97
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x47               // =71
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x46               // =70
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x45               // =69
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x44               // =68
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x43               // =67
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x42               // =66
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41               // =65
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40               // =64
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f               // =63
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3e               // =62
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3d               // =61
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3c               // =60
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3b               // =59
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3a               // =58
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x39               // =57
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x38               // =56
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x37               // =55
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x36               // =54
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x35               // =53
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x34               // =52
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x33               // =51
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x32               // =50
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x31               // =49
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
