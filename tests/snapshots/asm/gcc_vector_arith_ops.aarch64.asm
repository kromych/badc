
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
               	stp	x20, x21, [sp, #-0x1e0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x1d0]
               	add	x29, sp, #0x1d0
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
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
               	ldrb	w2, [sp, #0x20]
               	ldrb	w3, [sp, #0x30]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	ldrb	w3, [sp, #0x31]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	ldrb	w3, [sp, #0x32]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	ldrb	w3, [sp, #0x33]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	ldrb	w3, [sp, #0x34]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	ldrb	w3, [sp, #0x35]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	ldrb	w3, [sp, #0x36]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	ldrb	w3, [sp, #0x37]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	ldrb	w3, [sp, #0x38]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	ldrb	w3, [sp, #0x39]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	ldrb	w3, [sp, #0x3a]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	ldrb	w3, [sp, #0x3b]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	ldrb	w3, [sp, #0x3c]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	ldrb	w3, [sp, #0x3d]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	ldrb	w3, [sp, #0x3e]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
               	ldrb	w3, [sp, #0x3f]
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
               	ldrb	w2, [sp, #0x20]
               	ldrb	w3, [sp, #0x30]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	ldrb	w3, [sp, #0x31]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	ldrb	w3, [sp, #0x32]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	ldrb	w3, [sp, #0x33]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	ldrb	w3, [sp, #0x34]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	ldrb	w3, [sp, #0x35]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	ldrb	w3, [sp, #0x36]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	ldrb	w3, [sp, #0x37]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	ldrb	w3, [sp, #0x38]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	ldrb	w3, [sp, #0x39]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	ldrb	w3, [sp, #0x3a]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	ldrb	w3, [sp, #0x3b]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	ldrb	w3, [sp, #0x3c]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	ldrb	w3, [sp, #0x3d]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	ldrb	w3, [sp, #0x3e]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
               	ldrb	w3, [sp, #0x3f]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
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
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
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
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
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
               	ldrsb	x2, [sp, #0x40]
               	ldrsb	x3, [sp, #0x50]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldrsb	x2, [sp, #0x41]
               	ldrsb	x3, [sp, #0x51]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldrsb	x2, [sp, #0x42]
               	ldrsb	x3, [sp, #0x52]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldrsb	x2, [sp, #0x43]
               	ldrsb	x3, [sp, #0x53]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldrsb	x2, [sp, #0x44]
               	ldrsb	x3, [sp, #0x54]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldrsb	x2, [sp, #0x45]
               	ldrsb	x3, [sp, #0x55]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldrsb	x2, [sp, #0x46]
               	ldrsb	x3, [sp, #0x56]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldrsb	x2, [sp, #0x47]
               	ldrsb	x3, [sp, #0x57]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldrsb	x2, [sp, #0x48]
               	ldrsb	x3, [sp, #0x58]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldrsb	x2, [sp, #0x49]
               	ldrsb	x3, [sp, #0x59]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldrsb	x2, [sp, #0x4a]
               	ldrsb	x3, [sp, #0x5a]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldrsb	x2, [sp, #0x4b]
               	ldrsb	x3, [sp, #0x5b]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldrsb	x2, [sp, #0x4c]
               	ldrsb	x3, [sp, #0x5c]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldrsb	x2, [sp, #0x4d]
               	ldrsb	x3, [sp, #0x5d]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldrsb	x2, [sp, #0x4e]
               	ldrsb	x3, [sp, #0x5e]
               	sdiv	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldrsb	x2, [sp, #0x4f]
               	ldrsb	x3, [sp, #0x5f]
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
               	ldrsb	x2, [sp, #0x40]
               	ldrsb	x3, [sp, #0x50]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x70]
               	ldrsb	x2, [sp, #0x41]
               	ldrsb	x3, [sp, #0x51]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6f]
               	ldrsb	x2, [sp, #0x42]
               	ldrsb	x3, [sp, #0x52]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6e]
               	ldrsb	x2, [sp, #0x43]
               	ldrsb	x3, [sp, #0x53]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6d]
               	ldrsb	x2, [sp, #0x44]
               	ldrsb	x3, [sp, #0x54]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6c]
               	ldrsb	x2, [sp, #0x45]
               	ldrsb	x3, [sp, #0x55]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6b]
               	ldrsb	x2, [sp, #0x46]
               	ldrsb	x3, [sp, #0x56]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x6a]
               	ldrsb	x2, [sp, #0x47]
               	ldrsb	x3, [sp, #0x57]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x69]
               	ldrsb	x2, [sp, #0x48]
               	ldrsb	x3, [sp, #0x58]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x68]
               	ldrsb	x2, [sp, #0x49]
               	ldrsb	x3, [sp, #0x59]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x67]
               	ldrsb	x2, [sp, #0x4a]
               	ldrsb	x3, [sp, #0x5a]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x66]
               	ldrsb	x2, [sp, #0x4b]
               	ldrsb	x3, [sp, #0x5b]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x65]
               	ldrsb	x2, [sp, #0x4c]
               	ldrsb	x3, [sp, #0x5c]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x64]
               	ldrsb	x2, [sp, #0x4d]
               	ldrsb	x3, [sp, #0x5d]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x63]
               	ldrsb	x2, [sp, #0x4e]
               	ldrsb	x3, [sp, #0x5e]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	sturb	w2, [x29, #-0x62]
               	ldrsb	x2, [sp, #0x4f]
               	ldrsb	x3, [sp, #0x5f]
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
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
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
               	ldr	q0, [sp, #0x60]
               	ldr	q1, [sp, #0x70]
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
               	ldr	q0, [sp, #0x60]
               	ldr	q1, [sp, #0x70]
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
               	ldr	q0, [sp, #0x60]
               	ldr	q1, [sp, #0x70]
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
               	ldrh	w0, [sp, #0x60]
               	ldrh	w1, [sp, #0x70]
               	udiv	w0, w0, w1
               	ldrh	w1, [sp, #0x62]
               	ldrh	w3, [sp, #0x72]
               	udiv	w1, w1, w3
               	ldrh	w3, [sp, #0x64]
               	ldrh	w4, [sp, #0x74]
               	udiv	w3, w3, w4
               	ldrh	w4, [sp, #0x66]
               	ldrh	w7, [sp, #0x76]
               	udiv	w4, w4, w7
               	ldrh	w7, [sp, #0x68]
               	ldrh	w8, [sp, #0x78]
               	udiv	w7, w7, w8
               	ldrh	w8, [sp, #0x6a]
               	ldrh	w9, [sp, #0x7a]
               	udiv	w8, w8, w9
               	ldrh	w9, [sp, #0x6c]
               	ldrh	w10, [sp, #0x7c]
               	udiv	w9, w9, w10
               	ldrh	w10, [sp, #0x6e]
               	ldrh	w11, [sp, #0x7e]
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
               	ldrh	w0, [sp, #0x60]
               	ldrh	w1, [sp, #0x70]
               	udiv	w17, w0, w1
               	msub	w0, w17, w1, w0
               	ldrh	w1, [sp, #0x62]
               	ldrh	w3, [sp, #0x72]
               	udiv	w17, w1, w3
               	msub	w1, w17, w3, w1
               	ldrh	w3, [sp, #0x64]
               	ldrh	w4, [sp, #0x74]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	ldrh	w4, [sp, #0x66]
               	ldrh	w7, [sp, #0x76]
               	udiv	w17, w4, w7
               	msub	w4, w17, w7, w4
               	ldrh	w7, [sp, #0x68]
               	ldrh	w8, [sp, #0x78]
               	udiv	w17, w7, w8
               	msub	w7, w17, w8, w7
               	ldrh	w8, [sp, #0x6a]
               	ldrh	w9, [sp, #0x7a]
               	udiv	w17, w8, w9
               	msub	w8, w17, w9, w8
               	ldrh	w9, [sp, #0x6c]
               	ldrh	w10, [sp, #0x7c]
               	udiv	w17, w9, w10
               	msub	w9, w17, w10, w9
               	ldrh	w10, [sp, #0x6e]
               	ldrh	w11, [sp, #0x7e]
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
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
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
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
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
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
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
               	ldrsh	x0, [sp, #0x80]
               	ldrsh	x1, [sp, #0x90]
               	sdiv	x0, x0, x1
               	ldrsh	x1, [sp, #0x82]
               	ldrsh	x3, [sp, #0x92]
               	sdiv	x1, x1, x3
               	ldrsh	x3, [sp, #0x84]
               	ldrsh	x4, [sp, #0x94]
               	sdiv	x3, x3, x4
               	ldrsh	x4, [sp, #0x86]
               	ldrsh	x7, [sp, #0x96]
               	sdiv	x4, x4, x7
               	ldrsh	x7, [sp, #0x88]
               	ldrsh	x8, [sp, #0x98]
               	sdiv	x7, x7, x8
               	ldrsh	x8, [sp, #0x8a]
               	ldrsh	x9, [sp, #0x9a]
               	sdiv	x8, x8, x9
               	ldrsh	x9, [sp, #0x8c]
               	ldrsh	x10, [sp, #0x9c]
               	sdiv	x9, x9, x10
               	ldrsh	x10, [sp, #0x8e]
               	ldrsh	x11, [sp, #0x9e]
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
               	ldrsh	x0, [sp, #0x80]
               	ldrsh	x1, [sp, #0x90]
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ldrsh	x1, [sp, #0x82]
               	ldrsh	x3, [sp, #0x92]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	ldrsh	x3, [sp, #0x84]
               	ldrsh	x4, [sp, #0x94]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	ldrsh	x4, [sp, #0x86]
               	ldrsh	x7, [sp, #0x96]
               	sdiv	x17, x4, x7
               	msub	x4, x17, x7, x4
               	ldrsh	x7, [sp, #0x88]
               	ldrsh	x8, [sp, #0x98]
               	sdiv	x17, x7, x8
               	msub	x7, x17, x8, x7
               	ldrsh	x8, [sp, #0x8a]
               	ldrsh	x9, [sp, #0x9a]
               	sdiv	x17, x8, x9
               	msub	x8, x17, x9, x8
               	ldrsh	x9, [sp, #0x8c]
               	ldrsh	x10, [sp, #0x9c]
               	sdiv	x17, x9, x10
               	msub	x9, x17, x10, x9
               	ldrsh	x10, [sp, #0x8e]
               	ldrsh	x11, [sp, #0x9e]
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
               	ldr	q0, [sp, #0xa0]
               	ldr	q1, [sp, #0xb0]
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
               	ldr	q0, [sp, #0xa0]
               	ldr	q1, [sp, #0xb0]
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
               	ldr	q0, [sp, #0xa0]
               	ldr	q1, [sp, #0xb0]
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
               	ldr	w0, [sp, #0xa0]
               	ldr	w1, [sp, #0xb0]
               	udiv	w0, w0, w1
               	ldr	w1, [sp, #0xa4]
               	ldr	w3, [sp, #0xb4]
               	udiv	w1, w1, w3
               	ldr	w3, [sp, #0xa8]
               	ldr	w4, [sp, #0xb8]
               	udiv	w3, w3, w4
               	ldr	w4, [sp, #0xac]
               	ldr	w7, [sp, #0xbc]
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
               	ldr	w0, [sp, #0xa0]
               	ldr	w1, [sp, #0xb0]
               	udiv	w17, w0, w1
               	msub	w0, w17, w1, w0
               	ldr	w1, [sp, #0xa4]
               	ldr	w3, [sp, #0xb4]
               	udiv	w17, w1, w3
               	msub	w1, w17, w3, w1
               	ldr	w3, [sp, #0xa8]
               	ldr	w4, [sp, #0xb8]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	ldr	w4, [sp, #0xac]
               	ldr	w7, [sp, #0xbc]
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
               	ldr	q0, [sp, #0xc0]
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
               	ldr	q0, [sp, #0xc0]
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
               	ldr	q0, [sp, #0xc0]
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
               	ldrsw	x0, [sp, #0xc0]
               	ldursw	x1, [x29, #-0x100]
               	sdiv	x0, x0, x1
               	ldrsw	x1, [sp, #0xc4]
               	ldursw	x3, [x29, #-0xfc]
               	sdiv	x1, x1, x3
               	ldrsw	x3, [sp, #0xc8]
               	ldursw	x4, [x29, #-0xf8]
               	sdiv	x3, x3, x4
               	ldrsw	x4, [sp, #0xcc]
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
               	ldrsw	x0, [sp, #0xc0]
               	ldursw	x1, [x29, #-0x100]
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ldrsw	x1, [sp, #0xc4]
               	ldursw	x3, [x29, #-0xfc]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	ldrsw	x3, [sp, #0xc8]
               	ldursw	x4, [x29, #-0xf8]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	ldrsw	x4, [sp, #0xcc]
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
               	ldrb	w2, [sp, #0x20]
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	lsl	x2, x2, #1
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	lsl	x2, x2, #3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	lsl	x2, x2, #4
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	lsl	x2, x2, #5
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	lsl	x2, x2, #6
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	lsl	x2, x2, #7
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	lsl	x2, x2, #1
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	lsl	x2, x2, #3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	lsl	x2, x2, #4
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	lsl	x2, x2, #5
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	lsl	x2, x2, #6
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldrb	w2, [sp, #0x20]
               	ldurb	w3, [x29, #-0x50]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	ldurb	w3, [x29, #-0x4f]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	ldurb	w3, [x29, #-0x4e]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	ldurb	w3, [x29, #-0x4d]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	ldurb	w3, [x29, #-0x4c]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	ldurb	w3, [x29, #-0x4b]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	ldurb	w3, [x29, #-0x4a]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	ldurb	w3, [x29, #-0x49]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	ldurb	w3, [x29, #-0x48]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	ldurb	w3, [x29, #-0x47]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	ldurb	w3, [x29, #-0x46]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	ldurb	w3, [x29, #-0x45]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	ldurb	w3, [x29, #-0x44]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	ldurb	w3, [x29, #-0x43]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	ldurb	w3, [x29, #-0x42]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldrsh	x0, [sp, #0x80]
               	ldursh	x1, [x29, #-0xb0]
               	asr	x0, x0, x1
               	ldrsh	x1, [sp, #0x82]
               	ldursh	x3, [x29, #-0xae]
               	asr	x1, x1, x3
               	ldrsh	x3, [sp, #0x84]
               	ldursh	x4, [x29, #-0xac]
               	asr	x3, x3, x4
               	ldrsh	x4, [sp, #0x86]
               	ldursh	x7, [x29, #-0xaa]
               	asr	x4, x4, x7
               	ldrsh	x7, [sp, #0x88]
               	ldursh	x8, [x29, #-0xa8]
               	asr	x7, x7, x8
               	ldrsh	x8, [sp, #0x8a]
               	ldursh	x9, [x29, #-0xa6]
               	asr	x8, x8, x9
               	ldrsh	x9, [sp, #0x8c]
               	ldursh	x10, [x29, #-0xa4]
               	asr	x9, x9, x10
               	ldrsh	x10, [sp, #0x8e]
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
               	ldrsh	x0, [sp, #0x80]
               	ldursh	x1, [x29, #-0xb0]
               	lsl	x0, x0, x1
               	ldrsh	x1, [sp, #0x82]
               	ldursh	x3, [x29, #-0xae]
               	lsl	x1, x1, x3
               	ldrsh	x3, [sp, #0x84]
               	ldursh	x4, [x29, #-0xac]
               	lsl	x3, x3, x4
               	ldrsh	x4, [sp, #0x86]
               	ldursh	x7, [x29, #-0xaa]
               	lsl	x4, x4, x7
               	ldrsh	x7, [sp, #0x88]
               	ldursh	x8, [x29, #-0xa8]
               	lsl	x7, x7, x8
               	ldrsh	x8, [sp, #0x8a]
               	ldursh	x9, [x29, #-0xa6]
               	lsl	x8, x8, x9
               	ldrsh	x9, [sp, #0x8c]
               	ldursh	x10, [x29, #-0xa4]
               	lsl	x9, x9, x10
               	ldrsh	x10, [sp, #0x8e]
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
               	ldrsw	x0, [sp, #0xc0]
               	asr	x0, x0, #3
               	ldrsw	x2, [sp, #0xc4]
               	asr	x2, x2, #3
               	ldrsw	x3, [sp, #0xc8]
               	asr	x3, x3, #3
               	ldrsw	x5, [sp, #0xcc]
               	asr	x5, x5, #3
               	stur	w0, [x29, #-0x70]
               	stur	w2, [x29, #-0x6c]
               	stur	w3, [x29, #-0x68]
               	stur	w5, [x29, #-0x64]
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
               	ldr	w0, [sp, #0xa0]
               	lsr	x0, x0, #3
               	ldr	w2, [sp, #0xa4]
               	lsr	x2, x2, #3
               	ldr	w3, [sp, #0xa8]
               	lsr	x3, x3, #3
               	ldr	w5, [sp, #0xac]
               	lsr	x5, x5, #3
               	stur	w0, [x29, #-0x70]
               	stur	w2, [x29, #-0x6c]
               	stur	w3, [x29, #-0x68]
               	stur	w5, [x29, #-0x64]
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
               	sub	x0, x29, #0x70
               	ldrsb	x2, [sp, #0x40]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x70]
               	ldrsb	x2, [sp, #0x41]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x6f]
               	ldrsb	x2, [sp, #0x42]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x6e]
               	ldrsb	x2, [sp, #0x43]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x6d]
               	ldrsb	x2, [sp, #0x44]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x6c]
               	ldrsb	x2, [sp, #0x45]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x6b]
               	ldrsb	x2, [sp, #0x46]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x6a]
               	ldrsb	x2, [sp, #0x47]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x69]
               	ldrsb	x2, [sp, #0x48]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x68]
               	ldrsb	x2, [sp, #0x49]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x67]
               	ldrsb	x2, [sp, #0x4a]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x66]
               	ldrsb	x2, [sp, #0x4b]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x65]
               	ldrsb	x2, [sp, #0x4c]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x64]
               	ldrsb	x2, [sp, #0x4d]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x63]
               	ldrsb	x2, [sp, #0x4e]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x62]
               	ldrsb	x2, [sp, #0x4f]
               	lsl	x2, x2, #2
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x3, x0]
               	lsl	x2, x2, #2
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
               	ldrb	w2, [sp, #0x20]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldrb	w2, [sp, #0x20]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	add	x2, x2, #0x64
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldrb	w4, [sp, #0x20]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x21]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x22]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x23]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x24]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x25]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x26]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x27]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x28]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x29]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0x2a]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0x2b]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0x2c]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0x2d]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0x2e]
               	mul	x4, x4, x0
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0x2f]
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
               	ldrb	w2, [sp, #0x20]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldrb	w0, [sp, #0x20]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x70]
               	ldrb	w0, [sp, #0x21]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6f]
               	ldrb	w0, [sp, #0x22]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6e]
               	ldrb	w0, [sp, #0x23]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6d]
               	ldrb	w0, [sp, #0x24]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6c]
               	ldrb	w0, [sp, #0x25]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6b]
               	ldrb	w0, [sp, #0x26]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x6a]
               	ldrb	w0, [sp, #0x27]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x69]
               	ldrb	w0, [sp, #0x28]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x68]
               	ldrb	w0, [sp, #0x29]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x67]
               	ldrb	w0, [sp, #0x2a]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x66]
               	ldrb	w0, [sp, #0x2b]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x65]
               	ldrb	w0, [sp, #0x2c]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x64]
               	ldrb	w0, [sp, #0x2d]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x63]
               	ldrb	w0, [sp, #0x2e]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sturb	w0, [x29, #-0x62]
               	ldrb	w0, [sp, #0x2f]
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
               	ldrb	w4, [sp, #0x20]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x21]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x22]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x23]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x24]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x25]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x26]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x27]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x28]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x29]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0x2a]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0x2b]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0x2c]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0x2d]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0x2e]
               	and	x4, x4, x0
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0x2f]
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
               	ldrb	w4, [sp, #0x20]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x21]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x22]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x23]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x24]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x25]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x26]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x27]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x28]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x29]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0x2a]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0x2b]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0x2c]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0x2d]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0x2e]
               	orr	x4, x4, x0
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0x2f]
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
               	ldrb	w4, [sp, #0x20]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x21]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x22]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x23]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x24]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x25]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x26]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x27]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x28]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x29]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0x2a]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0x2b]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0x2c]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0x2d]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0x2e]
               	eor	x4, x4, x0
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0x2f]
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
               	ldrsb	x2, [sp, #0x40]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x70]
               	ldrsb	x2, [sp, #0x41]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6f]
               	ldrsb	x2, [sp, #0x42]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6e]
               	ldrsb	x2, [sp, #0x43]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6d]
               	ldrsb	x2, [sp, #0x44]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6c]
               	ldrsb	x2, [sp, #0x45]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6b]
               	ldrsb	x2, [sp, #0x46]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x6a]
               	ldrsb	x2, [sp, #0x47]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x69]
               	ldrsb	x2, [sp, #0x48]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x68]
               	ldrsb	x2, [sp, #0x49]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x67]
               	ldrsb	x2, [sp, #0x4a]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x66]
               	ldrsb	x2, [sp, #0x4b]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x65]
               	ldrsb	x2, [sp, #0x4c]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x64]
               	ldrsb	x2, [sp, #0x4d]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x63]
               	ldrsb	x2, [sp, #0x4e]
               	sub	x2, x2, #0x64
               	sturb	w2, [x29, #-0x62]
               	ldrsb	x2, [sp, #0x4f]
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
               	ldrsb	x0, [sp, #0x40]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x70]
               	ldrsb	x0, [sp, #0x41]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6f]
               	ldrsb	x0, [sp, #0x42]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6e]
               	ldrsb	x0, [sp, #0x43]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6d]
               	ldrsb	x0, [sp, #0x44]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6c]
               	ldrsb	x0, [sp, #0x45]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6b]
               	ldrsb	x0, [sp, #0x46]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x6a]
               	ldrsb	x0, [sp, #0x47]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x69]
               	ldrsb	x0, [sp, #0x48]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x68]
               	ldrsb	x0, [sp, #0x49]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x67]
               	ldrsb	x0, [sp, #0x4a]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x66]
               	ldrsb	x0, [sp, #0x4b]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x65]
               	ldrsb	x0, [sp, #0x4c]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x64]
               	ldrsb	x0, [sp, #0x4d]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x63]
               	ldrsb	x0, [sp, #0x4e]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x0, x0, x0, lsr #63
               	sturb	w0, [x29, #-0x62]
               	ldrsb	x0, [sp, #0x4f]
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
               	ldrsb	x0, [sp, #0x40]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x70]
               	ldrsb	x0, [sp, #0x41]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6f]
               	ldrsb	x0, [sp, #0x42]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6e]
               	ldrsb	x0, [sp, #0x43]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6d]
               	ldrsb	x0, [sp, #0x44]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6c]
               	ldrsb	x0, [sp, #0x45]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6b]
               	ldrsb	x0, [sp, #0x46]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x6a]
               	ldrsb	x0, [sp, #0x47]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x69]
               	ldrsb	x0, [sp, #0x48]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x68]
               	ldrsb	x0, [sp, #0x49]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x67]
               	ldrsb	x0, [sp, #0x4a]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x66]
               	ldrsb	x0, [sp, #0x4b]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x65]
               	ldrsb	x0, [sp, #0x4c]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x64]
               	ldrsb	x0, [sp, #0x4d]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x63]
               	ldrsb	x0, [sp, #0x4e]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x62]
               	ldrsb	x0, [sp, #0x4f]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	sturb	w0, [x29, #-0x61]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x3                // =3
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	ldrsb	x2, [x4, x0]
               	mul	x3, x2, x6
               	asr	x3, x3, #32
               	add	x3, x3, x3, lsr #63
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
               	sub	x4, x29, #0x170
               	mov	x0, #0x3e8              // =1000
               	ldrh	w2, [sp, #0x60]
               	mul	x2, x2, x0
               	ldrh	w3, [sp, #0x62]
               	mul	x3, x3, x0
               	ldrh	w5, [sp, #0x64]
               	mul	x5, x5, x0
               	ldrh	w6, [sp, #0x66]
               	mul	x6, x6, x0
               	ldrh	w7, [sp, #0x68]
               	mul	x7, x7, x0
               	ldrh	w8, [sp, #0x6a]
               	mul	x8, x8, x0
               	ldrh	w9, [sp, #0x6c]
               	mul	x9, x9, x0
               	ldrh	w10, [sp, #0x6e]
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
               	ldrb	w3, [sp, #0x20]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x70]
               	ldrb	w3, [sp, #0x21]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6f]
               	ldrb	w3, [sp, #0x22]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6e]
               	ldrb	w3, [sp, #0x23]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6d]
               	ldrb	w3, [sp, #0x24]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6c]
               	ldrb	w3, [sp, #0x25]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6b]
               	ldrb	w3, [sp, #0x26]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6a]
               	ldrb	w3, [sp, #0x27]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x69]
               	ldrb	w3, [sp, #0x28]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x68]
               	ldrb	w3, [sp, #0x29]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x67]
               	ldrb	w3, [sp, #0x2a]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x66]
               	ldrb	w3, [sp, #0x2b]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x65]
               	ldrb	w3, [sp, #0x2c]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x64]
               	ldrb	w3, [sp, #0x2d]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x63]
               	ldrb	w3, [sp, #0x2e]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x62]
               	ldrb	w3, [sp, #0x2f]
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
               	ldrsb	x3, [sp, #0x40]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x70]
               	ldrsb	x3, [sp, #0x41]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6f]
               	ldrsb	x3, [sp, #0x42]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6e]
               	ldrsb	x3, [sp, #0x43]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6d]
               	ldrsb	x3, [sp, #0x44]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6c]
               	ldrsb	x3, [sp, #0x45]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6b]
               	ldrsb	x3, [sp, #0x46]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x6a]
               	ldrsb	x3, [sp, #0x47]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x69]
               	ldrsb	x3, [sp, #0x48]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x68]
               	ldrsb	x3, [sp, #0x49]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x67]
               	ldrsb	x3, [sp, #0x4a]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x66]
               	ldrsb	x3, [sp, #0x4b]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x65]
               	ldrsb	x3, [sp, #0x4c]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x64]
               	ldrsb	x3, [sp, #0x4d]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x63]
               	ldrsb	x3, [sp, #0x4e]
               	sub	x3, x0, x3
               	sturb	w3, [x29, #-0x62]
               	ldrsb	x3, [sp, #0x4f]
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
               	ldrb	w3, [sp, #0x30]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x70]
               	ldrb	w3, [sp, #0x31]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6f]
               	ldrb	w3, [sp, #0x32]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6e]
               	ldrb	w3, [sp, #0x33]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6d]
               	ldrb	w3, [sp, #0x34]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6c]
               	ldrb	w3, [sp, #0x35]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6b]
               	ldrb	w3, [sp, #0x36]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x6a]
               	ldrb	w3, [sp, #0x37]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x69]
               	ldrb	w3, [sp, #0x38]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x68]
               	ldrb	w3, [sp, #0x39]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x67]
               	ldrb	w3, [sp, #0x3a]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x66]
               	ldrb	w3, [sp, #0x3b]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x65]
               	ldrb	w3, [sp, #0x3c]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x64]
               	ldrb	w3, [sp, #0x3d]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x63]
               	ldrb	w3, [sp, #0x3e]
               	udiv	w3, w0, w3
               	sturb	w3, [x29, #-0x62]
               	ldrb	w3, [sp, #0x3f]
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
               	ldrb	w3, [sp, #0x30]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x70]
               	ldrb	w3, [sp, #0x31]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6f]
               	ldrb	w3, [sp, #0x32]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6e]
               	ldrb	w3, [sp, #0x33]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6d]
               	ldrb	w3, [sp, #0x34]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6c]
               	ldrb	w3, [sp, #0x35]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6b]
               	ldrb	w3, [sp, #0x36]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x6a]
               	ldrb	w3, [sp, #0x37]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x69]
               	ldrb	w3, [sp, #0x38]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x68]
               	ldrb	w3, [sp, #0x39]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x67]
               	ldrb	w3, [sp, #0x3a]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x66]
               	ldrb	w3, [sp, #0x3b]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x65]
               	ldrb	w3, [sp, #0x3c]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x64]
               	ldrb	w3, [sp, #0x3d]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x63]
               	ldrb	w3, [sp, #0x3e]
               	udiv	w17, w0, w3
               	msub	w3, w17, w3, w0
               	sturb	w3, [x29, #-0x62]
               	ldrb	w3, [sp, #0x3f]
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
               	ldrb	w4, [sp, #0x30]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x31]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x32]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x33]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x34]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x35]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x36]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x37]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x38]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x39]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0x3a]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0x3b]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0x3c]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0x3d]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0x3e]
               	and	x4, x0, x4
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0x3f]
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
               	ldrb	w2, [sp, #0x20]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldrsw	x0, [sp, #0xc0]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	add	x2, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xc4]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	add	x3, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xc8]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	add	x5, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xcc]
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
               	sub	x2, x29, #0x70
               	ldrb	w4, [sp, #0x20]
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x70]
               	ldrb	w4, [sp, #0x21]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6f]
               	ldrb	w4, [sp, #0x22]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6e]
               	ldrb	w4, [sp, #0x23]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6d]
               	ldrb	w4, [sp, #0x24]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6c]
               	ldrb	w4, [sp, #0x25]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6b]
               	ldrb	w4, [sp, #0x26]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6a]
               	ldrb	w4, [sp, #0x27]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x69]
               	ldrb	w4, [sp, #0x28]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x68]
               	ldrb	w4, [sp, #0x29]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x67]
               	ldrb	w4, [sp, #0x2a]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x66]
               	ldrb	w4, [sp, #0x2b]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x65]
               	ldrb	w4, [sp, #0x2c]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x64]
               	ldrb	w4, [sp, #0x2d]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x63]
               	ldrb	w4, [sp, #0x2e]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x62]
               	ldrb	w4, [sp, #0x2f]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x61]
               	sub	x4, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	ldrb	w2, [x3, x0]
               	neg	x2, x2
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
               	sub	x3, x29, #0x190
               	sub	x2, x29, #0x70
               	ldrsb	x4, [sp, #0x40]
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x70]
               	ldrsb	x4, [sp, #0x41]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6f]
               	ldrsb	x4, [sp, #0x42]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6e]
               	ldrsb	x4, [sp, #0x43]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6d]
               	ldrsb	x4, [sp, #0x44]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6c]
               	ldrsb	x4, [sp, #0x45]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6b]
               	ldrsb	x4, [sp, #0x46]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x6a]
               	ldrsb	x4, [sp, #0x47]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x69]
               	ldrsb	x4, [sp, #0x48]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x68]
               	ldrsb	x4, [sp, #0x49]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x67]
               	ldrsb	x4, [sp, #0x4a]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x66]
               	ldrsb	x4, [sp, #0x4b]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x65]
               	ldrsb	x4, [sp, #0x4c]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x64]
               	ldrsb	x4, [sp, #0x4d]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x63]
               	ldrsb	x4, [sp, #0x4e]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x62]
               	ldrsb	x4, [sp, #0x4f]
               	neg	x4, x4
               	sturb	w4, [x29, #-0x61]
               	sub	x4, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	ldrsb	x2, [x3, x0]
               	neg	x2, x2
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
               	ldrsw	x2, [sp, #0xc0]
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldrsw	x3, [sp, #0xc4]
               	neg	x3, x3
               	ldrsw	x5, [sp, #0xc8]
               	neg	x5, x5
               	ldrsw	x6, [sp, #0xcc]
               	neg	x6, x6
               	stur	w2, [x29, #-0x70]
               	stur	w3, [x29, #-0x6c]
               	stur	w5, [x29, #-0x68]
               	stur	w6, [x29, #-0x64]
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
               	sub	x0, x29, #0x70
               	ldrb	w2, [sp, #0x20]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
               	mvn	x2, x2
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x3, x0]
               	mvn	x2, x2
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
               	sub	x4, x29, #0xd0
               	ldur	x0, [x29, #-0xd0]
               	mvn	x0, x0
               	ldur	x2, [x29, #-0xc8]
               	mvn	x2, x2
               	stur	x0, [x29, #-0x70]
               	stur	x2, [x29, #-0x68]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	add	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q0, [x29, #-0x70]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	sub	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q0, [x29, #-0x70]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	mul	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q0, [x29, #-0x70]
               	ldr	q1, [sp, #0x30]
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
               	ldrb	w2, [sp, #0x20]
               	ldrb	w3, [sp, #0x30]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	ldrb	w3, [sp, #0x31]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	ldrb	w3, [sp, #0x32]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	ldrb	w3, [sp, #0x33]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	ldrb	w3, [sp, #0x34]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	ldrb	w3, [sp, #0x35]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	ldrb	w3, [sp, #0x36]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	ldrb	w3, [sp, #0x37]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	ldrb	w3, [sp, #0x38]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	ldrb	w3, [sp, #0x39]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	ldrb	w3, [sp, #0x3a]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	ldrb	w3, [sp, #0x3b]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	ldrb	w3, [sp, #0x3c]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	ldrb	w3, [sp, #0x3d]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	ldrb	w3, [sp, #0x3e]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
               	ldrb	w3, [sp, #0x3f]
               	udiv	w2, w2, w3
               	sturb	w2, [x29, #-0x61]
               	sub	x2, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x70
               	ldurb	w3, [x29, #-0x90]
               	ldrb	w4, [sp, #0x30]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	ldrb	w4, [sp, #0x31]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	ldrb	w4, [sp, #0x32]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	ldrb	w4, [sp, #0x33]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	ldrb	w4, [sp, #0x34]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	ldrb	w4, [sp, #0x35]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	ldrb	w4, [sp, #0x36]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	ldrb	w4, [sp, #0x37]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	ldrb	w4, [sp, #0x38]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	ldrb	w4, [sp, #0x39]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	ldrb	w4, [sp, #0x3a]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	ldrb	w4, [sp, #0x3b]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	ldrb	w4, [sp, #0x3c]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	ldrb	w4, [sp, #0x3d]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	ldrb	w4, [sp, #0x3e]
               	udiv	w3, w3, w4
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	ldrb	w4, [sp, #0x3f]
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
               	ldrb	w2, [sp, #0x20]
               	ldrb	w3, [sp, #0x30]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	ldrb	w3, [sp, #0x31]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	ldrb	w3, [sp, #0x32]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	ldrb	w3, [sp, #0x33]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	ldrb	w3, [sp, #0x34]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	ldrb	w3, [sp, #0x35]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	ldrb	w3, [sp, #0x36]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	ldrb	w3, [sp, #0x37]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	ldrb	w3, [sp, #0x38]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	ldrb	w3, [sp, #0x39]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	ldrb	w3, [sp, #0x3a]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	ldrb	w3, [sp, #0x3b]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	ldrb	w3, [sp, #0x3c]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	ldrb	w3, [sp, #0x3d]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	ldrb	w3, [sp, #0x3e]
               	udiv	w17, w2, w3
               	msub	w2, w17, w3, w2
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
               	ldrb	w3, [sp, #0x3f]
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
               	ldurb	w3, [x29, #-0x90]
               	ldrb	w4, [sp, #0x30]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x70]
               	ldurb	w3, [x29, #-0x8f]
               	ldrb	w4, [sp, #0x31]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6f]
               	ldurb	w3, [x29, #-0x8e]
               	ldrb	w4, [sp, #0x32]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6e]
               	ldurb	w3, [x29, #-0x8d]
               	ldrb	w4, [sp, #0x33]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6d]
               	ldurb	w3, [x29, #-0x8c]
               	ldrb	w4, [sp, #0x34]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6c]
               	ldurb	w3, [x29, #-0x8b]
               	ldrb	w4, [sp, #0x35]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6b]
               	ldurb	w3, [x29, #-0x8a]
               	ldrb	w4, [sp, #0x36]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x6a]
               	ldurb	w3, [x29, #-0x89]
               	ldrb	w4, [sp, #0x37]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x69]
               	ldurb	w3, [x29, #-0x88]
               	ldrb	w4, [sp, #0x38]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x68]
               	ldurb	w3, [x29, #-0x87]
               	ldrb	w4, [sp, #0x39]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x67]
               	ldurb	w3, [x29, #-0x86]
               	ldrb	w4, [sp, #0x3a]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x66]
               	ldurb	w3, [x29, #-0x85]
               	ldrb	w4, [sp, #0x3b]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x65]
               	ldurb	w3, [x29, #-0x84]
               	ldrb	w4, [sp, #0x3c]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x64]
               	ldurb	w3, [x29, #-0x83]
               	ldrb	w4, [sp, #0x3d]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x63]
               	ldurb	w3, [x29, #-0x82]
               	ldrb	w4, [sp, #0x3e]
               	udiv	w17, w3, w4
               	msub	w3, w17, w4, w3
               	sturb	w3, [x29, #-0x62]
               	ldurb	w3, [x29, #-0x81]
               	ldrb	w4, [sp, #0x3f]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	and	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q0, [x29, #-0x70]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	orr	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q0, [x29, #-0x70]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x2, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q0, [x29, #-0x70]
               	ldr	q1, [sp, #0x30]
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
               	ldrb	w2, [sp, #0x20]
               	ldurb	w3, [x29, #-0x50]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	ldurb	w3, [x29, #-0x4f]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	ldurb	w3, [x29, #-0x4e]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	ldurb	w3, [x29, #-0x4d]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	ldurb	w3, [x29, #-0x4c]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	ldurb	w3, [x29, #-0x4b]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	ldurb	w3, [x29, #-0x4a]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	ldurb	w3, [x29, #-0x49]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	ldurb	w3, [x29, #-0x48]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	ldurb	w3, [x29, #-0x47]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	ldurb	w3, [x29, #-0x46]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	ldurb	w3, [x29, #-0x45]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	ldurb	w3, [x29, #-0x44]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	ldurb	w3, [x29, #-0x43]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	ldurb	w3, [x29, #-0x42]
               	lsl	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldurb	w3, [x29, #-0x90]
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
               	ldrb	w2, [sp, #0x20]
               	ldurb	w3, [x29, #-0x50]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	ldurb	w3, [x29, #-0x4f]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	ldurb	w3, [x29, #-0x4e]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	ldurb	w3, [x29, #-0x4d]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	ldurb	w3, [x29, #-0x4c]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	ldurb	w3, [x29, #-0x4b]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	ldurb	w3, [x29, #-0x4a]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	ldurb	w3, [x29, #-0x49]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	ldurb	w3, [x29, #-0x48]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	ldurb	w3, [x29, #-0x47]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	ldurb	w3, [x29, #-0x46]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	ldurb	w3, [x29, #-0x45]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	ldurb	w3, [x29, #-0x44]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	ldurb	w3, [x29, #-0x43]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	ldurb	w3, [x29, #-0x42]
               	lsr	x2, x2, x3
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldurb	w3, [x29, #-0x90]
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
               	ldrsh	x1, [sp, #0x80]
               	ldrsh	x2, [sp, #0x90]
               	sdiv	x1, x1, x2
               	ldrsh	x2, [sp, #0x82]
               	ldrsh	x3, [sp, #0x92]
               	sdiv	x3, x2, x3
               	ldrsh	x2, [sp, #0x84]
               	ldrsh	x4, [sp, #0x94]
               	sdiv	x4, x2, x4
               	ldrsh	x2, [sp, #0x86]
               	ldrsh	x5, [sp, #0x96]
               	sdiv	x5, x2, x5
               	ldrsh	x2, [sp, #0x88]
               	ldrsh	x6, [sp, #0x98]
               	sdiv	x6, x2, x6
               	ldrsh	x2, [sp, #0x8a]
               	ldrsh	x7, [sp, #0x9a]
               	sdiv	x7, x2, x7
               	ldrsh	x2, [sp, #0x8c]
               	ldrsh	x8, [sp, #0x9c]
               	sdiv	x8, x2, x8
               	ldrsh	x2, [sp, #0x8e]
               	ldrsh	x9, [sp, #0x9e]
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
               	ldursh	x0, [x29, #-0x70]
               	ldrsh	x3, [sp, #0x90]
               	sdiv	x0, x0, x3
               	ldursh	x3, [x29, #-0x6e]
               	ldrsh	x4, [sp, #0x92]
               	sdiv	x3, x3, x4
               	ldursh	x4, [x29, #-0x6c]
               	ldrsh	x5, [sp, #0x94]
               	sdiv	x4, x4, x5
               	ldursh	x5, [x29, #-0x6a]
               	ldrsh	x6, [sp, #0x96]
               	sdiv	x5, x5, x6
               	ldursh	x6, [x29, #-0x68]
               	ldrsh	x7, [sp, #0x98]
               	sdiv	x6, x6, x7
               	ldursh	x7, [x29, #-0x66]
               	ldrsh	x8, [sp, #0x9a]
               	sdiv	x7, x7, x8
               	ldursh	x8, [x29, #-0x64]
               	ldrsh	x9, [sp, #0x9c]
               	sdiv	x8, x8, x9
               	ldursh	x9, [x29, #-0x62]
               	ldrsh	x10, [sp, #0x9e]
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
               	ldur	x0, [x29, #-0x70]
               	ldur	x3, [x29, #-0xc0]
               	mul	x0, x0, x3
               	ldur	x3, [x29, #-0x68]
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
               	ldurb	w2, [x29, #-0xb0]
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
               	ldrb	w2, [sp, #0x20]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x70]
               	ldrb	w2, [sp, #0x21]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6f]
               	ldrb	w2, [sp, #0x22]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6e]
               	ldrb	w2, [sp, #0x23]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6d]
               	ldrb	w2, [sp, #0x24]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6c]
               	ldrb	w2, [sp, #0x25]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6b]
               	ldrb	w2, [sp, #0x26]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x6a]
               	ldrb	w2, [sp, #0x27]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x69]
               	ldrb	w2, [sp, #0x28]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x68]
               	ldrb	w2, [sp, #0x29]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x67]
               	ldrb	w2, [sp, #0x2a]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x66]
               	ldrb	w2, [sp, #0x2b]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x65]
               	ldrb	w2, [sp, #0x2c]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x64]
               	ldrb	w2, [sp, #0x2d]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x63]
               	ldrb	w2, [sp, #0x2e]
               	sub	x2, x2, #0x40
               	sturb	w2, [x29, #-0x62]
               	ldrb	w2, [sp, #0x2f]
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
               	ldurb	w3, [x29, #-0x90]
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
               	ldurb	w3, [x29, #-0x90]
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
               	ldurb	w3, [x29, #-0x90]
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
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
               	ldr	q1, [sp, #0x20]
               	sub	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x3                // =3
               	ldrb	w2, [x4, x0]
               	ldrb	w3, [x5, x0]
               	add	x3, x2, x3
               	and	x3, x3, #0xff
               	mul	x3, x3, x6
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
               	ldrsw	x0, [sp, #0xc0]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x1, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xc4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x3, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xc8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x4, x0, x0, lsr #63
               	ldrsw	x0, [sp, #0xcc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	add	x6, x0, x0, lsr #63
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	mov	x7, #0x0                // =0
               	fmov	s0, w1
               	neg	x1, x3
               	mov	v0.s[1], w1
               	neg	x1, x4
               	mov	v0.s[2], w1
               	neg	x1, x6
               	mov	v0.s[3], w1
               	sub	x6, x29, #0x100
               	ldur	q1, [x29, #-0x100]
               	add	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
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
               	ldrb	w0, [sp, #0x20]
               	ldrb	w2, [sp, #0x21]
               	ldrb	w3, [sp, #0x22]
               	ldrb	w4, [sp, #0x23]
               	ldrb	w5, [sp, #0x24]
               	ldrb	w6, [sp, #0x25]
               	ldrb	w7, [sp, #0x26]
               	ldrb	w8, [sp, #0x27]
               	ldrb	w9, [sp, #0x28]
               	ldrb	w10, [sp, #0x29]
               	ldrb	w11, [sp, #0x2a]
               	ldrb	w12, [sp, #0x2b]
               	ldrb	w13, [sp, #0x2c]
               	ldrb	w14, [sp, #0x2d]
               	ldrb	w15, [sp, #0x2e]
               	ldrb	w20, [sp, #0x2f]
               	lsl	x21, x0, #1
               	mov	x22, #0x0               // =0
               	fmov	d0, x22
               	mov	v0.b[0], w21
               	lsl	x21, x2, #1
               	mov	v0.b[1], w21
               	lsl	x21, x3, #1
               	mov	v0.b[2], w21
               	lsl	x21, x4, #1
               	mov	v0.b[3], w21
               	lsl	x21, x5, #1
               	mov	v0.b[4], w21
               	lsl	x21, x6, #1
               	mov	v0.b[5], w21
               	lsl	x21, x7, #1
               	mov	v0.b[6], w21
               	lsl	x21, x8, #1
               	mov	v0.b[7], w21
               	lsl	x21, x9, #1
               	mov	v0.b[8], w21
               	lsl	x21, x10, #1
               	mov	v0.b[9], w21
               	lsl	x21, x11, #1
               	mov	v0.b[10], w21
               	lsl	x21, x12, #1
               	mov	v0.b[11], w21
               	lsl	x21, x13, #1
               	mov	v0.b[12], w21
               	lsl	x21, x14, #1
               	mov	v0.b[13], w21
               	lsl	x21, x15, #1
               	mov	v0.b[14], w21
               	lsl	x21, x20, #1
               	mov	v0.b[15], w21
               	sxtb	x21, w0
               	sxtb	x2, w2
               	sxtb	x3, w3
               	sxtb	x4, w4
               	sxtb	x5, w5
               	sxtb	x6, w6
               	sxtb	x7, w7
               	sxtb	x8, w8
               	sxtb	x9, w9
               	sxtb	x10, w10
               	sxtb	x11, w11
               	sxtb	x12, w12
               	sxtb	x13, w13
               	sxtb	x14, w14
               	sxtb	x15, w15
               	sxtb	x20, w20
               	mov	x0, #0x1b               // =27
               	and	x21, x0, x21, asr #7
               	mov	x22, #0x0               // =0
               	fmov	d1, x22
               	mov	v1.b[0], w21
               	and	x2, x0, x2, asr #7
               	mov	v1.b[1], w2
               	and	x2, x0, x3, asr #7
               	mov	v1.b[2], w2
               	and	x2, x0, x4, asr #7
               	mov	v1.b[3], w2
               	and	x2, x0, x5, asr #7
               	mov	v1.b[4], w2
               	and	x2, x0, x6, asr #7
               	mov	v1.b[5], w2
               	and	x2, x0, x7, asr #7
               	mov	v1.b[6], w2
               	and	x2, x0, x8, asr #7
               	mov	v1.b[7], w2
               	and	x2, x0, x9, asr #7
               	mov	v1.b[8], w2
               	and	x2, x0, x10, asr #7
               	mov	v1.b[9], w2
               	and	x2, x0, x11, asr #7
               	mov	v1.b[10], w2
               	and	x2, x0, x12, asr #7
               	mov	v1.b[11], w2
               	and	x2, x0, x13, asr #7
               	mov	v1.b[12], w2
               	and	x2, x0, x14, asr #7
               	mov	v1.b[13], w2
               	and	x2, x0, x15, asr #7
               	mov	v1.b[14], w2
               	and	x0, x0, x20, asr #7
               	mov	v1.b[15], w0
               	eor	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	sub	x5, x29, #0x1b0
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
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x40]
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
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x68               // =104
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x67               // =103
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x5f               // =95
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x5e               // =94
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x5d               // =93
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x5c               // =92
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x5b               // =91
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x5a               // =90
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x59               // =89
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x58               // =88
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x57               // =87
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x56               // =86
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x55               // =85
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x54               // =84
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x53               // =83
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x52               // =82
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x51               // =81
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x50               // =80
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x4f               // =79
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x4e               // =78
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x4d               // =77
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x4c               // =76
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x4b               // =75
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x4a               // =74
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x49               // =73
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x60               // =96
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x48               // =72
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x66               // =102
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x65               // =101
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x64               // =100
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x63               // =99
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x62               // =98
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x61               // =97
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x47               // =71
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x46               // =70
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x45               // =69
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x44               // =68
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x43               // =67
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x42               // =66
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x41               // =65
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x40               // =64
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x3f               // =63
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x3e               // =62
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x3d               // =61
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x3c               // =60
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x3b               // =59
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x3a               // =58
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x39               // =57
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x38               // =56
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x37               // =55
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x36               // =54
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x35               // =53
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x34               // =52
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x33               // =51
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x32               // =50
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x31               // =49
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x30               // =48
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x2f               // =47
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x2e               // =46
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x2d               // =45
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x2c               // =44
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x2b               // =43
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x28               // =40
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x27               // =39
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x26               // =38
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x25               // =37
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x24               // =36
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x1c               // =28
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x1d0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
