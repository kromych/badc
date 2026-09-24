
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
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x210
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1f0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1e0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1d0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1c0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1b0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x190
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x180
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x170
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x160
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x150
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x140
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x130
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x120
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x110
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x910
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x908
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xf0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xd0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x1                // =1
               	strb	w0, [x1]
               	mov	x0, #0x3                // =3
               	strb	w0, [x1, #0x1]
               	mov	x0, #0x5                // =5
               	strb	w0, [x1, #0x2]
               	mov	x0, #0x7                // =7
               	strb	w0, [x1, #0x3]
               	mov	x4, #0x12c              // =300
               	strb	w4, [x1, #0x4]
               	mov	x0, #0x100              // =256
               	strb	w0, [x1, #0x5]
               	strb	w0, [x1, #0x6]
               	strb	w4, [x1, #0x7]
               	strb	w0, [x1, #0x8]
               	mov	x0, #0x8                // =8
               	strb	w0, [x1, #0x9]
               	mov	x0, #0xd                // =13
               	strb	w0, [x1, #0xa]
               	mov	x0, #0x10               // =16
               	strb	w0, [x1, #0xb]
               	mov	x0, #0x13               // =19
               	strb	w0, [x1, #0xc]
               	mov	x0, #0x16               // =22
               	strb	w0, [x1, #0xd]
               	mov	x0, #0x1b               // =27
               	strb	w0, [x1, #0xe]
               	mov	x0, #0x1e               // =30
               	strb	w0, [x1, #0xf]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	add	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xb0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	sub	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	sub	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xa0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	mul	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	mul	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x90
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	udiv	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	sdiv	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x80
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x70
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1f0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1e0
               	ldr	x0, [x2]
               	ldr	x4, [x3]
               	and	x4, x0, x4
               	ldr	x0, [x2, #0x8]
               	ldr	x5, [x3, #0x8]
               	and	x5, x0, x5
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x60
               	str	x4, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	and	x4, x4, x5
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x60
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1f0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1e0
               	ldr	x0, [x2]
               	ldr	x4, [x3]
               	orr	x4, x0, x4
               	ldr	x0, [x2, #0x8]
               	ldr	x5, [x3, #0x8]
               	orr	x5, x0, x5
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x50
               	str	x4, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	orr	x4, x4, x5
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x50
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1f0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1e0
               	ldr	x0, [x2]
               	ldr	x4, [x3]
               	eor	x4, x0, x4
               	ldr	x0, [x2, #0x8]
               	ldr	x5, [x3, #0x8]
               	eor	x5, x0, x5
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x40
               	str	x4, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	eor	x4, x4, x5
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x40
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1c0
               	sub	x0, x29, #0x8e0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	add	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	add	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x30
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1c0
               	sub	x0, x29, #0x8e0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	sub	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	sub	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x20
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1c0
               	sub	x0, x29, #0x8e0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	mul	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	mul	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	mul	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x10
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1c0
               	sub	x0, x29, #0x8e0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	sdiv	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	sdiv	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1c0
               	sub	x0, x29, #0x8e0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0xff0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0xff0
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1d0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1c0
               	ldr	x0, [x2]
               	ldr	x4, [x3]
               	and	x4, x0, x4
               	ldr	x0, [x2, #0x8]
               	ldr	x5, [x3, #0x8]
               	and	x5, x0, x5
               	sub	x0, x29, #0xfe0
               	str	x4, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ldrsb	x4, [x2, x0]
               	ldrsb	x5, [x3, x0]
               	and	x4, x4, x5
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xfe0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x1a0
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	add	x1, x0, x1
               	ldrh	w0, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	add	x5, x0, x5
               	ldrh	w0, [x3, #0x4]
               	ldrh	w6, [x4, #0x4]
               	add	x6, x0, x6
               	ldrh	w0, [x3, #0x6]
               	ldrh	w7, [x4, #0x6]
               	add	x7, x0, x7
               	ldrh	w0, [x3, #0x8]
               	ldrh	w8, [x4, #0x8]
               	add	x8, x0, x8
               	ldrh	w0, [x3, #0xa]
               	ldrh	w9, [x4, #0xa]
               	add	x9, x0, x9
               	ldrh	w0, [x3, #0xc]
               	ldrh	w10, [x4, #0xc]
               	add	x10, x0, x10
               	ldrh	w0, [x3, #0xe]
               	ldrh	w11, [x4, #0xe]
               	add	x11, x0, x11
               	sub	x0, x29, #0xfd0
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	add	x1, x6, x1
               	and	x1, x1, #0xffff
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xfd0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x1a0
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	sub	x1, x0, x1
               	ldrh	w0, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	sub	x5, x0, x5
               	ldrh	w0, [x3, #0x4]
               	ldrh	w6, [x4, #0x4]
               	sub	x6, x0, x6
               	ldrh	w0, [x3, #0x6]
               	ldrh	w7, [x4, #0x6]
               	sub	x7, x0, x7
               	ldrh	w0, [x3, #0x8]
               	ldrh	w8, [x4, #0x8]
               	sub	x8, x0, x8
               	ldrh	w0, [x3, #0xa]
               	ldrh	w9, [x4, #0xa]
               	sub	x9, x0, x9
               	ldrh	w0, [x3, #0xc]
               	ldrh	w10, [x4, #0xc]
               	sub	x10, x0, x10
               	ldrh	w0, [x3, #0xe]
               	ldrh	w11, [x4, #0xe]
               	sub	x11, x0, x11
               	sub	x0, x29, #0xfc0
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	sub	x1, x6, x1
               	and	x1, x1, #0xffff
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xfc0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x1a0
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	mul	x1, x0, x1
               	ldrh	w0, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	mul	x5, x0, x5
               	ldrh	w0, [x3, #0x4]
               	ldrh	w6, [x4, #0x4]
               	mul	x6, x0, x6
               	ldrh	w0, [x3, #0x6]
               	ldrh	w7, [x4, #0x6]
               	mul	x7, x0, x7
               	ldrh	w0, [x3, #0x8]
               	ldrh	w8, [x4, #0x8]
               	mul	x8, x0, x8
               	ldrh	w0, [x3, #0xa]
               	ldrh	w9, [x4, #0xa]
               	mul	x9, x0, x9
               	ldrh	w0, [x3, #0xc]
               	ldrh	w10, [x4, #0xc]
               	mul	x10, x0, x10
               	ldrh	w0, [x3, #0xe]
               	ldrh	w11, [x4, #0xe]
               	mul	x11, x0, x11
               	sub	x0, x29, #0xfb0
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	mul	x1, x6, x1
               	and	x1, x1, #0xffff
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xfb0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x1a0
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	udiv	x1, x0, x1
               	ldrh	w0, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	udiv	x5, x0, x5
               	ldrh	w0, [x3, #0x4]
               	ldrh	w6, [x4, #0x4]
               	udiv	x6, x0, x6
               	ldrh	w0, [x3, #0x6]
               	ldrh	w7, [x4, #0x6]
               	udiv	x7, x0, x7
               	ldrh	w0, [x3, #0x8]
               	ldrh	w8, [x4, #0x8]
               	udiv	x8, x0, x8
               	ldrh	w0, [x3, #0xa]
               	ldrh	w9, [x4, #0xa]
               	udiv	x9, x0, x9
               	ldrh	w0, [x3, #0xc]
               	ldrh	w10, [x4, #0xc]
               	udiv	x10, x0, x10
               	ldrh	w0, [x3, #0xe]
               	ldrh	w11, [x4, #0xe]
               	udiv	x11, x0, x11
               	sub	x0, x29, #0xfa0
               	strh	w1, [x0]
               	strh	w5, [x0, #0x2]
               	strh	w6, [x0, #0x4]
               	strh	w7, [x0, #0x6]
               	strh	w8, [x0, #0x8]
               	strh	w9, [x0, #0xa]
               	strh	w10, [x0, #0xc]
               	strh	w11, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	sdiv	x1, x6, x1
               	and	x1, x1, #0xffff
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xfa0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1b0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x1a0
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	udiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	ldrh	w0, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	udiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	ldrh	w0, [x3, #0x4]
               	ldrh	w6, [x4, #0x4]
               	udiv	x17, x0, x6
               	msub	x6, x17, x6, x0
               	ldrh	w0, [x3, #0x6]
               	ldrh	w7, [x4, #0x6]
               	udiv	x17, x0, x7
               	msub	x7, x17, x7, x0
               	ldrh	w0, [x3, #0x8]
               	ldrh	w8, [x4, #0x8]
               	udiv	x17, x0, x8
               	msub	x8, x17, x8, x0
               	ldrh	w0, [x3, #0xa]
               	ldrh	w9, [x4, #0xa]
               	udiv	x17, x0, x9
               	msub	x9, x17, x9, x0
               	ldrh	w0, [x3, #0xc]
               	ldrh	w10, [x4, #0xc]
               	udiv	x17, x0, x10
               	msub	x10, x17, x10, x0
               	ldrh	w0, [x3, #0xe]
               	ldrh	w11, [x4, #0xe]
               	udiv	x17, x0, x11
               	msub	x11, x17, x11, x0
               	sub	x0, x29, #0xf90
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	sdiv	x17, x6, x1
               	msub	x1, x17, x1, x6
               	and	x1, x1, #0xffff
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xf90
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x190
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x180
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	add	x1, x0, x1
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	add	x5, x0, x5
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	add	x6, x0, x6
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	add	x7, x0, x7
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	add	x8, x0, x8
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	add	x9, x0, x9
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	add	x10, x0, x10
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	add	x11, x0, x11
               	sub	x0, x29, #0xf80
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	add	x1, x6, x1
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xf80
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x190
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x180
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	sub	x1, x0, x1
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	sub	x5, x0, x5
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	sub	x6, x0, x6
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	sub	x7, x0, x7
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	sub	x8, x0, x8
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	sub	x9, x0, x9
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	sub	x10, x0, x10
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	sub	x11, x0, x11
               	sub	x0, x29, #0xf70
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	sub	x1, x6, x1
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xf70
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x190
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x180
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	mul	x1, x0, x1
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	mul	x5, x0, x5
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	mul	x6, x0, x6
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	mul	x7, x0, x7
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	mul	x8, x0, x8
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	mul	x9, x0, x9
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	mul	x10, x0, x10
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	mul	x11, x0, x11
               	sub	x0, x29, #0xf60
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	mul	x1, x6, x1
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xf60
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x190
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x180
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	sdiv	x1, x0, x1
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	sdiv	x5, x0, x5
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	sdiv	x6, x0, x6
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	sdiv	x7, x0, x7
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	sdiv	x8, x0, x8
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	sdiv	x9, x0, x9
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	sdiv	x10, x0, x10
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	sdiv	x11, x0, x11
               	sub	x0, x29, #0xf50
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	sdiv	x1, x6, x1
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xf50
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x190
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x180
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	sdiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	sdiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	sdiv	x17, x0, x6
               	msub	x6, x17, x6, x0
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	sdiv	x17, x0, x7
               	msub	x7, x17, x7, x0
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	sdiv	x17, x0, x8
               	msub	x8, x17, x8, x0
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	sdiv	x17, x0, x9
               	msub	x9, x17, x9, x0
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	sdiv	x17, x0, x10
               	msub	x10, x17, x10, x0
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	sdiv	x17, x0, x11
               	msub	x11, x17, x11, x0
               	sub	x0, x29, #0xf40
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	sdiv	x17, x6, x1
               	msub	x1, x17, x1, x6
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xf40
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x170
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x160
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	add	x1, x0, x1
               	ldr	w0, [x3, #0x4]
               	ldr	w5, [x4, #0x4]
               	add	x5, x0, x5
               	ldr	w0, [x3, #0x8]
               	ldr	w6, [x4, #0x8]
               	add	x6, x0, x6
               	ldr	w0, [x3, #0xc]
               	ldr	w7, [x4, #0xc]
               	add	x7, x0, x7
               	sub	x0, x29, #0xf30
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	add	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xf30
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x170
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x160
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	sub	x1, x0, x1
               	ldr	w0, [x3, #0x4]
               	ldr	w5, [x4, #0x4]
               	sub	x5, x0, x5
               	ldr	w0, [x3, #0x8]
               	ldr	w6, [x4, #0x8]
               	sub	x6, x0, x6
               	ldr	w0, [x3, #0xc]
               	ldr	w7, [x4, #0xc]
               	sub	x7, x0, x7
               	sub	x0, x29, #0xf20
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	sub	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xf20
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x170
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x160
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	mul	x1, x0, x1
               	ldr	w0, [x3, #0x4]
               	ldr	w5, [x4, #0x4]
               	mul	x5, x0, x5
               	ldr	w0, [x3, #0x8]
               	ldr	w6, [x4, #0x8]
               	mul	x6, x0, x6
               	ldr	w0, [x3, #0xc]
               	ldr	w7, [x4, #0xc]
               	mul	x7, x0, x7
               	sub	x0, x29, #0xf10
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	mul	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xf10
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x170
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x160
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	udiv	x1, x0, x1
               	ldr	w0, [x3, #0x4]
               	ldr	w5, [x4, #0x4]
               	udiv	x5, x0, x5
               	ldr	w0, [x3, #0x8]
               	ldr	w6, [x4, #0x8]
               	udiv	x6, x0, x6
               	ldr	w0, [x3, #0xc]
               	ldr	w7, [x4, #0xc]
               	udiv	x7, x0, x7
               	sub	x0, x29, #0xf00
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	udiv	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xf00
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x170
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x160
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	udiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	ldr	w0, [x3, #0x4]
               	ldr	w5, [x4, #0x4]
               	udiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	ldr	w0, [x3, #0x8]
               	ldr	w6, [x4, #0x8]
               	udiv	x17, x0, x6
               	msub	x6, x17, x6, x0
               	ldr	w0, [x3, #0xc]
               	ldr	w7, [x4, #0xc]
               	udiv	x17, x0, x7
               	msub	x7, x17, x7, x0
               	sub	x0, x29, #0xef0
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	udiv	x17, x6, x1
               	msub	x1, x17, x1, x6
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xef0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x150
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x140
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	add	x1, x0, x1
               	ldrsw	x0, [x3, #0x4]
               	ldrsw	x5, [x4, #0x4]
               	add	x5, x0, x5
               	ldrsw	x0, [x3, #0x8]
               	ldrsw	x6, [x4, #0x8]
               	add	x6, x0, x6
               	ldrsw	x0, [x3, #0xc]
               	ldrsw	x7, [x4, #0xc]
               	add	x7, x0, x7
               	sub	x0, x29, #0xee0
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	add	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xee0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x150
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x140
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	sub	x1, x0, x1
               	ldrsw	x0, [x3, #0x4]
               	ldrsw	x5, [x4, #0x4]
               	sub	x5, x0, x5
               	ldrsw	x0, [x3, #0x8]
               	ldrsw	x6, [x4, #0x8]
               	sub	x6, x0, x6
               	ldrsw	x0, [x3, #0xc]
               	ldrsw	x7, [x4, #0xc]
               	sub	x7, x0, x7
               	sub	x0, x29, #0xed0
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	sub	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xed0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x150
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x140
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	mul	x1, x0, x1
               	ldrsw	x0, [x3, #0x4]
               	ldrsw	x5, [x4, #0x4]
               	mul	x5, x0, x5
               	ldrsw	x0, [x3, #0x8]
               	ldrsw	x6, [x4, #0x8]
               	mul	x6, x0, x6
               	ldrsw	x0, [x3, #0xc]
               	ldrsw	x7, [x4, #0xc]
               	mul	x7, x0, x7
               	sub	x0, x29, #0xec0
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	mul	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xec0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x150
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x140
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	sdiv	x1, x0, x1
               	ldrsw	x0, [x3, #0x4]
               	ldrsw	x5, [x4, #0x4]
               	sdiv	x5, x0, x5
               	ldrsw	x0, [x3, #0x8]
               	ldrsw	x6, [x4, #0x8]
               	sdiv	x6, x0, x6
               	ldrsw	x0, [x3, #0xc]
               	ldrsw	x7, [x4, #0xc]
               	sdiv	x7, x0, x7
               	sub	x0, x29, #0xeb0
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	sdiv	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xeb0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x150
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x140
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	sdiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	ldrsw	x0, [x3, #0x4]
               	ldrsw	x5, [x4, #0x4]
               	sdiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	ldrsw	x0, [x3, #0x8]
               	ldrsw	x6, [x4, #0x8]
               	sdiv	x17, x0, x6
               	msub	x6, x17, x6, x0
               	ldrsw	x0, [x3, #0xc]
               	ldrsw	x7, [x4, #0xc]
               	sdiv	x17, x0, x7
               	msub	x7, x17, x7, x0
               	sub	x0, x29, #0xea0
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	sdiv	x17, x6, x1
               	msub	x1, x17, x1, x6
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xea0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x130
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x120
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	add	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	add	x5, x0, x5
               	sub	x0, x29, #0xe90
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	add	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe90
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x130
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x120
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	sub	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	sub	x5, x0, x5
               	sub	x0, x29, #0xe80
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	sub	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe80
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x130
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x120
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	mul	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	mul	x5, x0, x5
               	sub	x0, x29, #0xe70
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	mul	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe70
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x130
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x120
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	udiv	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	udiv	x5, x0, x5
               	sub	x0, x29, #0xe60
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	udiv	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe60
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x130
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x120
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	udiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	udiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	sub	x0, x29, #0xe50
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	udiv	x17, x6, x1
               	msub	x1, x17, x1, x6
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe50
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x110
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x100
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	add	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	add	x5, x0, x5
               	sub	x0, x29, #0xe40
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	add	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe40
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x110
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x100
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	sub	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	sub	x5, x0, x5
               	sub	x0, x29, #0xe30
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	sub	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe30
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x110
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x100
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	mul	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	mul	x5, x0, x5
               	sub	x0, x29, #0xe20
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	mul	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe20
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x110
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x100
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	sdiv	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	sdiv	x5, x0, x5
               	sub	x0, x29, #0xe10
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	sdiv	x1, x6, x1
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe10
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x110
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x100
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	sdiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	sdiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	sub	x0, x29, #0xe00
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	sdiv	x17, x6, x1
               	msub	x1, x17, x1, x6
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xe00
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x910
               	sub	x2, x29, #0x908
               	ldrb	w0, [x1]
               	ldrb	w3, [x2]
               	add	x3, x0, x3
               	ldrb	w0, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	add	x4, x0, x4
               	ldrb	w0, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	add	x5, x0, x5
               	ldrb	w0, [x1, #0x3]
               	ldrb	w6, [x2, #0x3]
               	add	x6, x0, x6
               	ldrb	w0, [x1, #0x4]
               	ldrb	w7, [x2, #0x4]
               	add	x7, x0, x7
               	ldrb	w0, [x1, #0x5]
               	ldrb	w8, [x2, #0x5]
               	add	x8, x0, x8
               	ldrb	w0, [x1, #0x6]
               	ldrb	w9, [x2, #0x6]
               	add	x9, x0, x9
               	ldrb	w0, [x1, #0x7]
               	ldrb	w10, [x2, #0x7]
               	add	x10, x0, x10
               	sub	x0, x29, #0x8f8
               	and	x3, x3, #0xff
               	strb	w3, [x0]
               	and	x3, x4, #0xff
               	strb	w3, [x0, #0x1]
               	and	x3, x5, #0xff
               	strb	w3, [x0, #0x2]
               	and	x3, x6, #0xff
               	strb	w3, [x0, #0x3]
               	and	x3, x7, #0xff
               	strb	w3, [x0, #0x4]
               	and	x3, x8, #0xff
               	strb	w3, [x0, #0x5]
               	and	x3, x9, #0xff
               	strb	w3, [x0, #0x6]
               	and	x3, x10, #0xff
               	strb	w3, [x0, #0x7]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8d8
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	add	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x8f8
               	sub	x1, x29, #0x8d8
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x910
               	sub	x3, x29, #0x908
               	ldrb	w0, [x2]
               	ldrb	w4, [x3]
               	mul	x4, x0, x4
               	ldrb	w0, [x2, #0x1]
               	ldrb	w5, [x3, #0x1]
               	mul	x5, x0, x5
               	ldrb	w0, [x2, #0x2]
               	ldrb	w6, [x3, #0x2]
               	mul	x6, x0, x6
               	ldrb	w0, [x2, #0x3]
               	ldrb	w7, [x3, #0x3]
               	mul	x7, x0, x7
               	ldrb	w0, [x2, #0x4]
               	ldrb	w8, [x3, #0x4]
               	mul	x8, x0, x8
               	ldrb	w0, [x2, #0x5]
               	ldrb	w9, [x3, #0x5]
               	mul	x9, x0, x9
               	ldrb	w0, [x2, #0x6]
               	ldrb	w10, [x3, #0x6]
               	mul	x10, x0, x10
               	ldrb	w0, [x2, #0x7]
               	ldrb	w11, [x3, #0x7]
               	mul	x11, x0, x11
               	sub	x0, x29, #0x8f8
               	and	x4, x4, #0xff
               	strb	w4, [x0]
               	and	x4, x5, #0xff
               	strb	w4, [x0, #0x1]
               	and	x4, x6, #0xff
               	strb	w4, [x0, #0x2]
               	and	x4, x7, #0xff
               	strb	w4, [x0, #0x3]
               	and	x4, x8, #0xff
               	strb	w4, [x0, #0x4]
               	and	x4, x9, #0xff
               	strb	w4, [x0, #0x5]
               	and	x4, x10, #0xff
               	strb	w4, [x0, #0x6]
               	and	x4, x11, #0xff
               	strb	w4, [x0, #0x7]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	mul	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x8f8
               	sub	x2, x29, #0x8d8
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xf0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0xd0
               	ldr	w0, [x2]
               	ldr	w1, [x3]
               	add	x1, x0, x1
               	ldr	w0, [x2, #0x4]
               	ldr	w4, [x3, #0x4]
               	add	x4, x0, x4
               	ldr	w0, [x2, #0x8]
               	ldr	w5, [x3, #0x8]
               	add	x5, x0, x5
               	ldr	w0, [x2, #0xc]
               	ldr	w6, [x3, #0xc]
               	add	x6, x0, x6
               	ldr	w0, [x2, #0x10]
               	ldr	w7, [x3, #0x10]
               	add	x7, x0, x7
               	ldr	w0, [x2, #0x14]
               	ldr	w8, [x3, #0x14]
               	add	x8, x0, x8
               	ldr	w0, [x2, #0x18]
               	ldr	w9, [x3, #0x18]
               	add	x9, x0, x9
               	ldr	w0, [x2, #0x1c]
               	ldr	w10, [x3, #0x1c]
               	add	x10, x0, x10
               	sub	x0, x29, #0xdf0
               	str	w1, [x0]
               	str	w4, [x0, #0x4]
               	str	w5, [x0, #0x8]
               	str	w6, [x0, #0xc]
               	str	w7, [x0, #0x10]
               	str	w8, [x0, #0x14]
               	str	w9, [x0, #0x18]
               	str	w10, [x0, #0x1c]
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0x8f0
               	lsl	x1, x0, #2
               	add	x4, x4, x1
               	add	x5, x2, x1
               	ldr	w5, [x5]
               	add	x1, x3, x1
               	ldr	w1, [x1]
               	add	x1, x5, x1
               	str	w1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xdf0
               	sub	x2, x29, #0x8f0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0xf0
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0xd0
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	sub	x1, x0, x1
               	ldr	w0, [x3, #0x4]
               	ldr	w5, [x4, #0x4]
               	sub	x5, x0, x5
               	ldr	w0, [x3, #0x8]
               	ldr	w6, [x4, #0x8]
               	sub	x6, x0, x6
               	ldr	w0, [x3, #0xc]
               	ldr	w7, [x4, #0xc]
               	sub	x7, x0, x7
               	ldr	w0, [x3, #0x10]
               	ldr	w8, [x4, #0x10]
               	sub	x8, x0, x8
               	ldr	w0, [x3, #0x14]
               	ldr	w9, [x4, #0x14]
               	sub	x9, x0, x9
               	ldr	w0, [x3, #0x18]
               	ldr	w10, [x4, #0x18]
               	sub	x10, x0, x10
               	ldr	w0, [x3, #0x1c]
               	ldr	w11, [x4, #0x1c]
               	sub	x11, x0, x11
               	sub	x0, x29, #0xdd0
               	str	w1, [x0]
               	str	w5, [x0, #0x4]
               	str	w6, [x0, #0x8]
               	str	w7, [x0, #0xc]
               	str	w8, [x0, #0x10]
               	str	w9, [x0, #0x14]
               	str	w10, [x0, #0x18]
               	str	w11, [x0, #0x1c]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	sub	x1, x6, x1
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xdd0
               	sub	x2, x29, #0x8f0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x2, x29, #0xdb0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0xda0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	lsl	x3, x3, #1
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	lsl	x3, x3, #3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	lsl	x3, x3, #4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	lsl	x3, x3, #5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	lsl	x3, x3, #6
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	lsl	x3, x3, #7
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	lsl	x3, x3, #1
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	lsl	x3, x3, #3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	lsl	x3, x3, #4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	lsl	x3, x3, #5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	lsl	x3, x3, #6
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	lsl	x3, x3, #7
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0xd90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	lsl	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xd90
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x2, x29, #0xdb0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	lsr	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0xd80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	lsr	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xd80
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x190
               	sub	x4, x29, #0xda0
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	asr	x1, x0, x1
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	asr	x5, x0, x5
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	asr	x6, x0, x6
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	asr	x7, x0, x7
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	asr	x8, x0, x8
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	asr	x9, x0, x9
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	asr	x10, x0, x10
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	asr	x11, x0, x11
               	sub	x0, x29, #0xd70
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	asr	x1, x6, x1
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0xd70
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x190
               	sub	x4, x29, #0xda0
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	lsl	x1, x0, x1
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	lsl	x5, x0, x5
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	lsl	x6, x0, x6
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	lsl	x7, x0, x7
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	lsl	x8, x0, x8
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	lsl	x9, x0, x9
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	lsl	x10, x0, x10
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	lsl	x11, x0, x11
               	sub	x0, x29, #0xd60
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	lsl	x1, x6, x1
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0xd60
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x150
               	ldrsw	x0, [x3]
               	asr	x2, x0, #3
               	ldrsw	x0, [x3, #0x4]
               	asr	x4, x0, #3
               	ldrsw	x0, [x3, #0x8]
               	asr	x5, x0, #3
               	ldrsw	x0, [x3, #0xc]
               	asr	x6, x0, #3
               	sub	x0, x29, #0xd50
               	str	w2, [x0]
               	str	w4, [x0, #0x4]
               	str	w5, [x0, #0x8]
               	str	w6, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x4, x1, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	asr	x2, x2, #3
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0xd50
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x170
               	ldr	w0, [x3]
               	lsr	x2, x0, #3
               	ldr	w0, [x3, #0x4]
               	lsr	x4, x0, #3
               	ldr	w0, [x3, #0x8]
               	lsr	x5, x0, #3
               	ldr	w0, [x3, #0xc]
               	lsr	x6, x0, #3
               	sub	x0, x29, #0xd40
               	str	w2, [x0]
               	str	w4, [x0, #0x4]
               	str	w5, [x0, #0x8]
               	str	w6, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x4, x1, x2
               	add	x2, x3, x2
               	ldr	w2, [x2]
               	lsr	x2, x2, #3
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xd40
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x0, x29, #0x8e0
               	ldrsb	x2, [x1]
               	lsl	x2, x2, #2
               	strb	w2, [x0]
               	ldrsb	x2, [x1, #0x1]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x1]
               	ldrsb	x2, [x1, #0x2]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x2]
               	ldrsb	x2, [x1, #0x3]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x3]
               	ldrsb	x2, [x1, #0x4]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x4]
               	ldrsb	x2, [x1, #0x5]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x5]
               	ldrsb	x2, [x1, #0x6]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x6]
               	ldrsb	x2, [x1, #0x7]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x7]
               	ldrsb	x2, [x1, #0x8]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x8]
               	ldrsb	x2, [x1, #0x9]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0x9]
               	ldrsb	x2, [x1, #0xa]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xa]
               	ldrsb	x2, [x1, #0xb]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xb]
               	ldrsb	x2, [x1, #0xc]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xc]
               	ldrsb	x2, [x1, #0xd]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xd]
               	ldrsb	x2, [x1, #0xe]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xe]
               	ldrsb	x2, [x1, #0xf]
               	lsl	x2, x2, #2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xd30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	ldrsb	x3, [x1, x0]
               	lsl	x3, x3, #2
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xd30
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x1]
               	sub	x2, x2, #0x40
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xd20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	sub	x3, x3, #0x40
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xd20
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x1]
               	add	x2, x2, #0x64
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	add	x2, x2, #0x64
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xd10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	add	x3, x3, #0x64
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xd10
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	mul	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	mul	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	mul	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xd00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x7                // =7
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	mul	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xd00
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xcf0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	mul	x3, x3, x4
               	lsr	x3, x3, #32
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xcf0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xce0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x7                // =7
               	mov	x6, #0x4925             // =18725
               	movk	x6, #0x2492, lsl #16
               	sub	x3, x29, #0x8e0
               	ldrb	w2, [x1, x0]
               	mul	x4, x2, x6
               	lsr	x4, x4, #32
               	mul	x4, x4, x5
               	sub	x2, x2, x4
               	strb	w2, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xce0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	mov	x2, #0xf                // =15
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	and	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	and	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	and	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	and	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xcd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	and	x3, x3, #0xf
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xcd0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	mov	x2, #0xf0               // =240
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	orr	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	orr	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	orr	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xcc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	orr	x3, x3, #0xf0
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xcc0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	mov	x2, #0x55               // =85
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	eor	x3, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	eor	x3, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	eor	x2, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xcb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x55               // =85
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	eor	x3, x3, x4
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xcb0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x0, x29, #0x8e0
               	ldrsb	x2, [x1]
               	sub	x2, x2, #0x64
               	strb	w2, [x0]
               	ldrsb	x2, [x1, #0x1]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x1]
               	ldrsb	x2, [x1, #0x2]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x2]
               	ldrsb	x2, [x1, #0x3]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x3]
               	ldrsb	x2, [x1, #0x4]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x4]
               	ldrsb	x2, [x1, #0x5]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x5]
               	ldrsb	x2, [x1, #0x6]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x6]
               	ldrsb	x2, [x1, #0x7]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x7]
               	ldrsb	x2, [x1, #0x8]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x8]
               	ldrsb	x2, [x1, #0x9]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0x9]
               	ldrsb	x2, [x1, #0xa]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xa]
               	ldrsb	x2, [x1, #0xb]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xb]
               	ldrsb	x2, [x1, #0xc]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xc]
               	ldrsb	x2, [x1, #0xd]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xd]
               	ldrsb	x2, [x1, #0xe]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xe]
               	ldrsb	x2, [x1, #0xf]
               	sub	x2, x2, #0x64
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xca0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	ldrsb	x3, [x1, x0]
               	sub	x3, x3, #0x64
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xca0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x0, x29, #0x8e0
               	ldrsb	x2, [x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0]
               	ldrsb	x2, [x1, #0x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x1]
               	ldrsb	x2, [x1, #0x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x2]
               	ldrsb	x2, [x1, #0x3]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x3]
               	ldrsb	x2, [x1, #0x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x4]
               	ldrsb	x2, [x1, #0x5]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x5]
               	ldrsb	x2, [x1, #0x6]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x6]
               	ldrsb	x2, [x1, #0x7]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x7]
               	ldrsb	x2, [x1, #0x8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x8]
               	ldrsb	x2, [x1, #0x9]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0x9]
               	ldrsb	x2, [x1, #0xa]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0xa]
               	ldrsb	x2, [x1, #0xb]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0xb]
               	ldrsb	x2, [x1, #0xc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0xc]
               	ldrsb	x2, [x1, #0xd]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0xd]
               	ldrsb	x2, [x1, #0xe]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0xe]
               	ldrsb	x2, [x1, #0xf]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xc90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	sub	x3, x29, #0x8e0
               	ldrsb	x2, [x1, x0]
               	mul	x2, x2, x5
               	asr	x2, x2, #32
               	lsr	x4, x2, #63
               	add	x2, x2, x4
               	strb	w2, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xc90
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x0, x29, #0x8e0
               	ldrsb	x2, [x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0]
               	ldrsb	x2, [x1, #0x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x1]
               	ldrsb	x2, [x1, #0x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x2]
               	ldrsb	x2, [x1, #0x3]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x3]
               	ldrsb	x2, [x1, #0x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x4]
               	ldrsb	x2, [x1, #0x5]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x5]
               	ldrsb	x2, [x1, #0x6]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x6]
               	ldrsb	x2, [x1, #0x7]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x7]
               	ldrsb	x2, [x1, #0x8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x8]
               	ldrsb	x2, [x1, #0x9]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0x9]
               	ldrsb	x2, [x1, #0xa]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xa]
               	ldrsb	x2, [x1, #0xb]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xb]
               	ldrsb	x2, [x1, #0xc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xc]
               	ldrsb	x2, [x1, #0xd]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xd]
               	ldrsb	x2, [x1, #0xe]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xe]
               	ldrsb	x2, [x1, #0xf]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xc80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	sub	x4, x29, #0x8e0
               	ldrsb	x2, [x1, x0]
               	mul	x3, x2, x7
               	asr	x3, x3, #32
               	lsr	x5, x3, #63
               	add	x3, x3, x5
               	mul	x3, x3, x6
               	sub	x2, x2, x3
               	strb	w2, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0xc80
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1b0
               	mov	x0, #0x3e8              // =1000
               	ldrh	w2, [x3]
               	mul	x2, x2, x0
               	ldrh	w4, [x3, #0x2]
               	mul	x4, x4, x0
               	ldrh	w5, [x3, #0x4]
               	mul	x5, x5, x0
               	ldrh	w6, [x3, #0x6]
               	mul	x6, x6, x0
               	ldrh	w7, [x3, #0x8]
               	mul	x7, x7, x0
               	ldrh	w8, [x3, #0xa]
               	mul	x8, x8, x0
               	ldrh	w9, [x3, #0xc]
               	mul	x9, x9, x0
               	ldrh	w10, [x3, #0xe]
               	mul	x10, x10, x0
               	sub	x0, x29, #0xc70
               	and	x2, x2, #0xffff
               	strh	w2, [x0]
               	and	x2, x4, #0xffff
               	strh	w2, [x0, #0x2]
               	and	x2, x5, #0xffff
               	strh	w2, [x0, #0x4]
               	and	x2, x6, #0xffff
               	strh	w2, [x0, #0x6]
               	and	x2, x7, #0xffff
               	strh	w2, [x0, #0x8]
               	and	x2, x8, #0xffff
               	strh	w2, [x0, #0xa]
               	and	x2, x9, #0xffff
               	strh	w2, [x0, #0xc]
               	and	x2, x10, #0xffff
               	strh	w2, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x3e8              // =1000
               	lsl	x2, x0, #1
               	add	x4, x1, x2
               	add	x2, x3, x2
               	ldrh	w2, [x2]
               	mul	x2, x2, x5
               	and	x2, x2, #0xffff
               	strh	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0xc70
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x110
               	mov	x0, #0x7                // =7
               	ldr	x2, [x3]
               	mul	x2, x2, x0
               	ldr	x4, [x3, #0x8]
               	mul	x4, x4, x0
               	sub	x0, x29, #0xc60
               	str	x2, [x0]
               	str	x4, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x7                // =7
               	lsl	x2, x0, #3
               	add	x4, x1, x2
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	mul	x2, x2, x5
               	str	x2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xc60
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x2, #0x40               // =64
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	sub	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xc50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	mov	x3, #0x40               // =64
               	ldrb	w4, [x1, x0]
               	sub	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xc50
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x2, #0x64               // =100
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x0, x29, #0x8e0
               	ldrsb	x3, [x1]
               	sub	x3, x2, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	sub	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xc40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	mov	x3, #0x64               // =100
               	ldrsb	x4, [x1, x0]
               	sub	x3, x3, x4
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xc40
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x2, #0xfa               // =250
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	udiv	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	udiv	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	udiv	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xc30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	mov	x3, #0xfa               // =250
               	ldrb	w4, [x1, x0]
               	sdiv	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xc30
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x2, #0xfa               // =250
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	udiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xc20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	mov	x3, #0xfa               // =250
               	ldrb	w4, [x1, x0]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xc20
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x2, #0xf                // =15
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	and	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	and	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	and	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	and	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xc10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	and	x3, x3, #0xf
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xc10
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x2, #0x3                // =3
               	sub	x1, x29, #0xdb0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	lsl	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	lsl	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	lsl	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xc00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	mov	x3, #0x3                // =3
               	ldrb	w4, [x1, x0]
               	lsl	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xc00
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x2, #0x80               // =128
               	sub	x1, x29, #0xdb0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	lsr	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	lsr	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	lsr	x2, x2, x3
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xbf0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	mov	x3, #0x80               // =128
               	ldrb	w4, [x1, x0]
               	lsr	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0xbf0
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #-0x7               // =-7
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x140
               	ldrsw	x2, [x3]
               	sdiv	x2, x0, x2
               	ldrsw	x4, [x3, #0x4]
               	sdiv	x4, x0, x4
               	ldrsw	x5, [x3, #0x8]
               	sdiv	x5, x0, x5
               	ldrsw	x6, [x3, #0xc]
               	sdiv	x6, x0, x6
               	sub	x0, x29, #0xbe0
               	str	w2, [x0]
               	str	w4, [x0, #0x4]
               	str	w5, [x0, #0x8]
               	str	w6, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x4, x1, x2
               	mov	x5, #-0x7               // =-7
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	sdiv	x2, x5, x2
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0xbe0
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #-0x7               // =-7
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x140
               	ldrsw	x2, [x3]
               	sdiv	x17, x0, x2
               	msub	x2, x17, x2, x0
               	ldrsw	x4, [x3, #0x4]
               	sdiv	x17, x0, x4
               	msub	x4, x17, x4, x0
               	ldrsw	x5, [x3, #0x8]
               	sdiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	ldrsw	x6, [x3, #0xc]
               	sdiv	x17, x0, x6
               	msub	x6, x17, x6, x0
               	sub	x0, x29, #0xbd0
               	str	w2, [x0]
               	str	w4, [x0, #0x4]
               	str	w5, [x0, #0x8]
               	str	w6, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #2
               	add	x4, x1, x2
               	mov	x5, #-0x7               // =-7
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	sdiv	x17, x5, x2
               	msub	x2, x17, x2, x5
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xbd0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #32
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xbc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	mul	x3, x3, x4
               	lsr	x3, x3, #32
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0xbc0
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x150
               	ldrsw	x0, [x3]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	lsr	x2, x0, #63
               	add	x2, x0, x2
               	ldrsw	x0, [x3, #0x4]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	lsr	x4, x0, #63
               	add	x4, x0, x4
               	ldrsw	x0, [x3, #0x8]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	lsr	x5, x0, #63
               	add	x5, x0, x5
               	ldrsw	x0, [x3, #0xc]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	lsr	x6, x0, #63
               	add	x6, x0, x6
               	sub	x0, x29, #0xbb0
               	str	w2, [x0]
               	str	w4, [x0, #0x4]
               	str	w5, [x0, #0x8]
               	str	w6, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x2493             // =9363
               	movk	x6, #0x9249, lsl #16
               	lsl	x2, x0, #2
               	add	x4, x1, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	mul	x2, x2, x6
               	asr	x2, x2, #34
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xbb0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1]
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	strb	w3, [x2]
               	ldrb	w3, [x1, #0x1]
               	neg	x3, x3
               	strb	w3, [x2, #0x1]
               	ldrb	w3, [x1, #0x2]
               	neg	x3, x3
               	strb	w3, [x2, #0x2]
               	ldrb	w3, [x1, #0x3]
               	neg	x3, x3
               	strb	w3, [x2, #0x3]
               	ldrb	w3, [x1, #0x4]
               	neg	x3, x3
               	strb	w3, [x2, #0x4]
               	ldrb	w3, [x1, #0x5]
               	neg	x3, x3
               	strb	w3, [x2, #0x5]
               	ldrb	w3, [x1, #0x6]
               	neg	x3, x3
               	strb	w3, [x2, #0x6]
               	ldrb	w3, [x1, #0x7]
               	neg	x3, x3
               	strb	w3, [x2, #0x7]
               	ldrb	w3, [x1, #0x8]
               	neg	x3, x3
               	strb	w3, [x2, #0x8]
               	ldrb	w3, [x1, #0x9]
               	neg	x3, x3
               	strb	w3, [x2, #0x9]
               	ldrb	w3, [x1, #0xa]
               	neg	x3, x3
               	strb	w3, [x2, #0xa]
               	ldrb	w3, [x1, #0xb]
               	neg	x3, x3
               	strb	w3, [x2, #0xb]
               	ldrb	w3, [x1, #0xc]
               	neg	x3, x3
               	strb	w3, [x2, #0xc]
               	ldrb	w3, [x1, #0xd]
               	neg	x3, x3
               	strb	w3, [x2, #0xd]
               	ldrb	w3, [x1, #0xe]
               	neg	x3, x3
               	strb	w3, [x2, #0xe]
               	ldrb	w3, [x1, #0xf]
               	neg	x3, x3
               	strb	w3, [x2, #0xf]
               	sub	x3, x29, #0xba0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	neg	x3, x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xba0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1d0
               	sub	x2, x29, #0x8e0
               	ldrsb	x3, [x1]
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	strb	w3, [x2]
               	ldrsb	x3, [x1, #0x1]
               	neg	x3, x3
               	strb	w3, [x2, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	neg	x3, x3
               	strb	w3, [x2, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	neg	x3, x3
               	strb	w3, [x2, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	neg	x3, x3
               	strb	w3, [x2, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	neg	x3, x3
               	strb	w3, [x2, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	neg	x3, x3
               	strb	w3, [x2, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	neg	x3, x3
               	strb	w3, [x2, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	neg	x3, x3
               	strb	w3, [x2, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	neg	x3, x3
               	strb	w3, [x2, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	neg	x3, x3
               	strb	w3, [x2, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	neg	x3, x3
               	strb	w3, [x2, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	neg	x3, x3
               	strb	w3, [x2, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	neg	x3, x3
               	strb	w3, [x2, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	neg	x3, x3
               	strb	w3, [x2, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	neg	x3, x3
               	strb	w3, [x2, #0xf]
               	sub	x3, x29, #0xb90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	sub	x2, x29, #0x8e0
               	ldrsb	x3, [x1, x0]
               	neg	x3, x3
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0xb90
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x150
               	ldrsw	x2, [x3]
               	mov	x0, #0x0                // =0
               	neg	x4, x2
               	ldrsw	x2, [x3, #0x4]
               	neg	x5, x2
               	ldrsw	x2, [x3, #0x8]
               	neg	x6, x2
               	ldrsw	x2, [x3, #0xc]
               	neg	x7, x2
               	sub	x2, x29, #0xb80
               	str	w4, [x2]
               	str	w5, [x2, #0x4]
               	str	w6, [x2, #0x8]
               	str	w7, [x2, #0xc]
               	lsl	x2, x0, #2
               	add	x4, x1, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	neg	x2, x2
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0xb80
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x1]
               	mvn	x2, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	mvn	x2, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	mvn	x2, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	mvn	x2, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	mvn	x2, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	mvn	x2, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	mvn	x2, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	mvn	x2, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	mvn	x2, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	mvn	x2, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	mvn	x2, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	mvn	x2, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	mvn	x2, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	mvn	x2, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	mvn	x2, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	mvn	x2, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0xb70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8e0
               	ldrb	w3, [x1, x0]
               	mvn	x3, x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0xb70
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x110
               	ldr	x0, [x3]
               	mvn	x2, x0
               	ldr	x0, [x3, #0x8]
               	mvn	x4, x0
               	sub	x0, x29, #0xb60
               	str	x2, [x0]
               	str	x4, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #3
               	add	x4, x1, x2
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	mvn	x2, x2
               	str	x2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0xb60
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	add	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	add	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	add	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0xb50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	sub	x2, x29, #0xb40
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	add	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	add	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	add	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	add	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x2, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	sub	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	sub	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0xb30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	sub	x2, x29, #0xb20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	sub	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	sub	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	sub	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x2, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	mul	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	mul	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0xb10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	sub	x2, x29, #0xb00
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	mul	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	mul	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	mul	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x2, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	udiv	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	udiv	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0xaf0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	sub	x2, x29, #0xae0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	udiv	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	udiv	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	udiv	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x2, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0xad0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	sub	x2, x29, #0xac0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	strb	w1, [x0, #0xf]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x2, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1e0
               	ldr	x1, [x3]
               	ldr	x2, [x0]
               	and	x1, x1, x2
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x0, #0x8]
               	and	x4, x2, x4
               	sub	x2, x29, #0xab0
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	sub	x1, x29, #0xaa0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldr	x3, [x1]
               	ldr	x4, [x0]
               	and	x3, x3, x4
               	ldr	x4, [x1, #0x8]
               	ldr	x0, [x0, #0x8]
               	and	x0, x4, x0
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1e0
               	ldr	x1, [x3]
               	ldr	x2, [x0]
               	orr	x1, x1, x2
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x0, #0x8]
               	orr	x4, x2, x4
               	sub	x2, x29, #0xa90
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	sub	x1, x29, #0xa80
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldr	x3, [x1]
               	ldr	x4, [x0]
               	orr	x3, x3, x4
               	ldr	x4, [x1, #0x8]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x4, x0
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1e0
               	ldr	x1, [x3]
               	ldr	x2, [x0]
               	eor	x1, x1, x2
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x0, #0x8]
               	eor	x4, x2, x4
               	sub	x2, x29, #0xa70
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	sub	x1, x29, #0xa60
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldr	x3, [x1]
               	ldr	x4, [x0]
               	eor	x3, x3, x4
               	ldr	x4, [x1, #0x8]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x4, x0
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x1, x29, #0xdb0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	lsl	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	lsl	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0xa50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	sub	x2, x29, #0xa40
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	lsl	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	lsl	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	lsl	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x2, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x1f0
               	sub	x1, x29, #0xdb0
               	sub	x0, x29, #0x8e0
               	ldrb	w2, [x3]
               	ldrb	w4, [x1]
               	lsr	x2, x2, x4
               	strb	w2, [x0]
               	ldrb	w2, [x3, #0x1]
               	ldrb	w4, [x1, #0x1]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x3, #0x2]
               	ldrb	w4, [x1, #0x2]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x3, #0x3]
               	ldrb	w4, [x1, #0x3]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x3, #0x4]
               	ldrb	w4, [x1, #0x4]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x3, #0x5]
               	ldrb	w4, [x1, #0x5]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x3, #0x6]
               	ldrb	w4, [x1, #0x6]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x3, #0x7]
               	ldrb	w4, [x1, #0x7]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x3, #0x8]
               	ldrb	w4, [x1, #0x8]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x3, #0x9]
               	ldrb	w4, [x1, #0x9]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x3, #0xa]
               	ldrb	w4, [x1, #0xa]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x3, #0xb]
               	ldrb	w4, [x1, #0xb]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x3, #0xc]
               	ldrb	w4, [x1, #0xc]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x3, #0xd]
               	ldrb	w4, [x1, #0xd]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x3, #0xe]
               	ldrb	w4, [x1, #0xe]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x3, #0xf]
               	ldrb	w4, [x1, #0xf]
               	lsr	x2, x2, x4
               	strb	w2, [x0, #0xf]
               	sub	x4, x29, #0xa30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	sub	x2, x29, #0xa20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	ldrb	w3, [x2]
               	ldrb	w5, [x1]
               	lsr	x3, x3, x5
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w5, [x1, #0x1]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w5, [x1, #0x2]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w5, [x1, #0x3]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w5, [x1, #0x4]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w5, [x1, #0x5]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w5, [x1, #0x6]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w5, [x1, #0x7]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w5, [x1, #0x8]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w5, [x1, #0x9]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w5, [x1, #0xa]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w5, [x1, #0xb]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w5, [x1, #0xc]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w5, [x1, #0xd]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w5, [x1, #0xe]
               	lsr	x3, x3, x5
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w1, [x1, #0xf]
               	lsr	x1, x3, x1
               	strb	w1, [x0, #0xf]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x2, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x190
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x180
               	ldrsh	x1, [x3]
               	ldrsh	x2, [x0]
               	sdiv	x1, x1, x2
               	ldrsh	x2, [x3, #0x2]
               	ldrsh	x4, [x0, #0x2]
               	sdiv	x4, x2, x4
               	ldrsh	x2, [x3, #0x4]
               	ldrsh	x5, [x0, #0x4]
               	sdiv	x5, x2, x5
               	ldrsh	x2, [x3, #0x6]
               	ldrsh	x6, [x0, #0x6]
               	sdiv	x6, x2, x6
               	ldrsh	x2, [x3, #0x8]
               	ldrsh	x7, [x0, #0x8]
               	sdiv	x7, x2, x7
               	ldrsh	x2, [x3, #0xa]
               	ldrsh	x8, [x0, #0xa]
               	sdiv	x8, x2, x8
               	ldrsh	x2, [x3, #0xc]
               	ldrsh	x9, [x0, #0xc]
               	sdiv	x9, x2, x9
               	ldrsh	x2, [x3, #0xe]
               	ldrsh	x10, [x0, #0xe]
               	sdiv	x10, x2, x10
               	sub	x2, x29, #0xa10
               	and	x1, x1, #0xffff
               	strh	w1, [x2]
               	and	x1, x4, #0xffff
               	strh	w1, [x2, #0x2]
               	and	x1, x5, #0xffff
               	strh	w1, [x2, #0x4]
               	and	x1, x6, #0xffff
               	strh	w1, [x2, #0x6]
               	and	x1, x7, #0xffff
               	strh	w1, [x2, #0x8]
               	and	x1, x8, #0xffff
               	strh	w1, [x2, #0xa]
               	and	x1, x9, #0xffff
               	strh	w1, [x2, #0xc]
               	and	x1, x10, #0xffff
               	strh	w1, [x2, #0xe]
               	sub	x1, x29, #0xa00
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldrsh	x3, [x1]
               	ldrsh	x4, [x0]
               	sdiv	x3, x3, x4
               	ldrsh	x4, [x1, #0x2]
               	ldrsh	x5, [x0, #0x2]
               	sdiv	x4, x4, x5
               	ldrsh	x5, [x1, #0x4]
               	ldrsh	x6, [x0, #0x4]
               	sdiv	x5, x5, x6
               	ldrsh	x6, [x1, #0x6]
               	ldrsh	x7, [x0, #0x6]
               	sdiv	x6, x6, x7
               	ldrsh	x7, [x1, #0x8]
               	ldrsh	x8, [x0, #0x8]
               	sdiv	x7, x7, x8
               	ldrsh	x8, [x1, #0xa]
               	ldrsh	x9, [x0, #0xa]
               	sdiv	x8, x8, x9
               	ldrsh	x9, [x1, #0xc]
               	ldrsh	x10, [x0, #0xc]
               	sdiv	x9, x9, x10
               	ldrsh	x10, [x1, #0xe]
               	ldrsh	x0, [x0, #0xe]
               	sdiv	x0, x10, x0
               	and	x3, x3, #0xffff
               	strh	w3, [x1]
               	and	x3, x4, #0xffff
               	strh	w3, [x1, #0x2]
               	and	x3, x5, #0xffff
               	strh	w3, [x1, #0x4]
               	and	x3, x6, #0xffff
               	strh	w3, [x1, #0x6]
               	and	x3, x7, #0xffff
               	strh	w3, [x1, #0x8]
               	and	x3, x8, #0xffff
               	strh	w3, [x1, #0xa]
               	and	x3, x9, #0xffff
               	strh	w3, [x1, #0xc]
               	and	x0, x0, #0xffff
               	strh	w0, [x1, #0xe]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x110
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x100
               	ldr	x1, [x3]
               	ldr	x2, [x0]
               	mul	x1, x1, x2
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x0, #0x8]
               	mul	x4, x2, x4
               	sub	x2, x29, #0x9f0
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	sub	x1, x29, #0x9e0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldr	x3, [x1]
               	ldr	x4, [x0]
               	mul	x3, x3, x4
               	ldr	x4, [x1, #0x8]
               	ldr	x0, [x0, #0x8]
               	mul	x0, x4, x0
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1f0
               	sub	x1, x29, #0x9d0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xf]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldrb	w3, [x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x2, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x0, #0xe]
               	ldrb	w2, [x2, #0xf]
               	sub	x2, x2, #0x40
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x9c0
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1f0
               	sub	x0, x29, #0x9b0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x8e0
               	ldrb	w3, [x0]
               	sub	x3, x3, #0x40
               	strb	w3, [x1]
               	ldrb	w3, [x0, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x0, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x0, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x0, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x0, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x0, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x0, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x0, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x0, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x0, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x0, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x0, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x0, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x0, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x0, #0xf]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xf]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrb	w3, [x0]
               	sub	x3, x3, #0x40
               	strb	w3, [x1]
               	ldrb	w3, [x0, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x0, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x0, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x0, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x0, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x0, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x0, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x0, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x0, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x0, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x0, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x0, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x0, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x0, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x0, #0xf]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xf]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrb	w3, [x0]
               	sub	x3, x3, #0x40
               	strb	w3, [x1]
               	ldrb	w3, [x0, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x0, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x0, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x0, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x0, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x0, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x0, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x0, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x0, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x0, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x0, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x0, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x0, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x0, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x0, #0xf]
               	sub	x3, x3, #0x40
               	strb	w3, [x1, #0xf]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x8e0
               	ldrb	w3, [x2, x0]
               	sub	x3, x3, #0xc0
               	and	x3, x3, #0xff
               	strb	w3, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x9b0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	add	x2, x2, x3
               	ldrb	w3, [x0, #0x1]
               	ldrb	w4, [x1, #0x1]
               	add	x3, x3, x4
               	ldrb	w4, [x0, #0x2]
               	ldrb	w5, [x1, #0x2]
               	add	x4, x4, x5
               	ldrb	w5, [x0, #0x3]
               	ldrb	w6, [x1, #0x3]
               	add	x5, x5, x6
               	ldrb	w6, [x0, #0x4]
               	ldrb	w7, [x1, #0x4]
               	add	x6, x6, x7
               	ldrb	w7, [x0, #0x5]
               	ldrb	w8, [x1, #0x5]
               	add	x7, x7, x8
               	ldrb	w8, [x0, #0x6]
               	ldrb	w9, [x1, #0x6]
               	add	x8, x8, x9
               	ldrb	w9, [x0, #0x7]
               	ldrb	w10, [x1, #0x7]
               	add	x9, x9, x10
               	ldrb	w10, [x0, #0x8]
               	ldrb	w11, [x1, #0x8]
               	add	x10, x10, x11
               	ldrb	w11, [x0, #0x9]
               	ldrb	w12, [x1, #0x9]
               	add	x11, x11, x12
               	ldrb	w12, [x0, #0xa]
               	ldrb	w13, [x1, #0xa]
               	add	x12, x12, x13
               	ldrb	w13, [x0, #0xb]
               	ldrb	w14, [x1, #0xb]
               	add	x13, x13, x14
               	ldrb	w14, [x0, #0xc]
               	ldrb	w15, [x1, #0xc]
               	add	x14, x14, x15
               	ldrb	w15, [x0, #0xd]
               	ldrb	w20, [x1, #0xd]
               	add	x15, x15, x20
               	ldrb	w20, [x0, #0xe]
               	ldrb	w21, [x1, #0xe]
               	add	x20, x20, x21
               	ldrb	w21, [x0, #0xf]
               	ldrb	w1, [x1, #0xf]
               	add	x21, x21, x1
               	mov	x1, #0x3                // =3
               	and	x2, x2, #0xff
               	mul	x2, x2, x1
               	and	x3, x3, #0xff
               	mul	x3, x3, x1
               	and	x4, x4, #0xff
               	mul	x4, x4, x1
               	and	x5, x5, #0xff
               	mul	x5, x5, x1
               	and	x6, x6, #0xff
               	mul	x6, x6, x1
               	and	x7, x7, #0xff
               	mul	x7, x7, x1
               	and	x8, x8, #0xff
               	mul	x8, x8, x1
               	and	x9, x9, #0xff
               	mul	x9, x9, x1
               	and	x10, x10, #0xff
               	mul	x10, x10, x1
               	and	x11, x11, #0xff
               	mul	x11, x11, x1
               	and	x12, x12, #0xff
               	mul	x12, x12, x1
               	and	x13, x13, #0xff
               	mul	x13, x13, x1
               	and	x14, x14, #0xff
               	mul	x14, x14, x1
               	and	x15, x15, #0xff
               	mul	x15, x15, x1
               	and	x20, x20, #0xff
               	mul	x20, x20, x1
               	and	x21, x21, #0xff
               	mul	x21, x21, x1
               	sub	x1, x29, #0x8e0
               	and	x2, x2, #0xff
               	ldrb	w22, [x0]
               	sub	x2, x2, x22
               	strb	w2, [x1]
               	and	x2, x3, #0xff
               	ldrb	w3, [x0, #0x1]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x1]
               	and	x2, x4, #0xff
               	ldrb	w3, [x0, #0x2]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x2]
               	and	x2, x5, #0xff
               	ldrb	w3, [x0, #0x3]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x3]
               	and	x2, x6, #0xff
               	ldrb	w3, [x0, #0x4]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x4]
               	and	x2, x7, #0xff
               	ldrb	w3, [x0, #0x5]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x5]
               	and	x2, x8, #0xff
               	ldrb	w3, [x0, #0x6]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x6]
               	and	x2, x9, #0xff
               	ldrb	w3, [x0, #0x7]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x7]
               	and	x2, x10, #0xff
               	ldrb	w3, [x0, #0x8]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x8]
               	and	x2, x11, #0xff
               	ldrb	w3, [x0, #0x9]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0x9]
               	and	x2, x12, #0xff
               	ldrb	w3, [x0, #0xa]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xa]
               	and	x2, x13, #0xff
               	ldrb	w3, [x0, #0xb]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xb]
               	and	x2, x14, #0xff
               	ldrb	w3, [x0, #0xc]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xc]
               	and	x2, x15, #0xff
               	ldrb	w3, [x0, #0xd]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xd]
               	and	x2, x20, #0xff
               	ldrb	w3, [x0, #0xe]
               	sub	x2, x2, x3
               	strb	w2, [x1, #0xe]
               	and	x2, x21, #0xff
               	ldrb	w0, [x0, #0xf]
               	sub	x0, x2, x0
               	strb	w0, [x1, #0xf]
               	sub	x0, x29, #0x9a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x1f0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x1e0
               	mov	x0, #0x0                // =0
               	mov	x6, #0x3                // =3
               	sub	x2, x29, #0x8e0
               	ldrb	w1, [x4, x0]
               	ldrb	w3, [x5, x0]
               	add	x3, x1, x3
               	and	x3, x3, #0xff
               	mul	x3, x3, x6
               	and	x3, x3, #0xff
               	sub	x1, x3, x1
               	and	x1, x1, #0xff
               	strb	w1, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x9a0
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x150
               	ldrsw	x0, [x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	lsr	x1, x0, #63
               	add	x1, x0, x1
               	ldrsw	x0, [x4, #0x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	lsr	x3, x0, #63
               	add	x3, x0, x3
               	ldrsw	x0, [x4, #0x8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	lsr	x5, x0, #63
               	add	x5, x0, x5
               	ldrsw	x0, [x4, #0xc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #32
               	lsr	x6, x0, #63
               	add	x6, x0, x6
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	neg	x3, x3
               	neg	x7, x5
               	neg	x6, x6
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x140
               	ldrsw	x8, [x5]
               	add	x8, x1, x8
               	ldrsw	x1, [x5, #0x4]
               	add	x3, x3, x1
               	ldrsw	x1, [x5, #0x8]
               	add	x7, x7, x1
               	ldrsw	x1, [x5, #0xc]
               	add	x6, x6, x1
               	sub	x1, x29, #0x990
               	str	w8, [x1]
               	str	w3, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w6, [x1, #0xc]
               	mov	x8, #0x5556             // =21846
               	movk	x8, #0x5555, lsl #16
               	lsl	x1, x0, #2
               	add	x6, x2, x1
               	add	x3, x4, x1
               	ldrsw	x3, [x3]
               	mul	x3, x3, x8
               	asr	x3, x3, #32
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	neg	x3, x3
               	add	x1, x5, x1
               	ldrsw	x1, [x1]
               	add	x1, x3, x1
               	str	w1, [x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x990
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1f0
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w4, [x0, #0x3]
               	ldrb	w5, [x0, #0x4]
               	ldrb	w6, [x0, #0x5]
               	ldrb	w7, [x0, #0x6]
               	ldrb	w8, [x0, #0x7]
               	ldrb	w9, [x0, #0x8]
               	ldrb	w10, [x0, #0x9]
               	ldrb	w11, [x0, #0xa]
               	ldrb	w12, [x0, #0xb]
               	ldrb	w13, [x0, #0xc]
               	ldrb	w14, [x0, #0xd]
               	ldrb	w15, [x0, #0xe]
               	ldrb	w20, [x0, #0xf]
               	sub	x0, x29, #0x900
               	lsl	x21, x1, #1
               	strb	w21, [x0]
               	lsl	x21, x2, #1
               	strb	w21, [x0, #0x1]
               	lsl	x21, x3, #1
               	strb	w21, [x0, #0x2]
               	lsl	x21, x4, #1
               	strb	w21, [x0, #0x3]
               	lsl	x21, x5, #1
               	strb	w21, [x0, #0x4]
               	lsl	x21, x6, #1
               	strb	w21, [x0, #0x5]
               	lsl	x21, x7, #1
               	strb	w21, [x0, #0x6]
               	lsl	x21, x8, #1
               	strb	w21, [x0, #0x7]
               	lsl	x22, x9, #1
               	add	x21, x0, #0x8
               	strb	w22, [x21]
               	lsl	x22, x10, #1
               	strb	w22, [x0, #0x9]
               	lsl	x22, x11, #1
               	strb	w22, [x0, #0xa]
               	lsl	x22, x12, #1
               	strb	w22, [x0, #0xb]
               	lsl	x22, x13, #1
               	strb	w22, [x0, #0xc]
               	lsl	x22, x14, #1
               	strb	w22, [x0, #0xd]
               	lsl	x22, x15, #1
               	strb	w22, [x0, #0xe]
               	lsl	x22, x20, #1
               	strb	w22, [x0, #0xf]
               	sxtb	x1, w1
               	asr	x22, x1, #7
               	sxtb	x1, w2
               	asr	x23, x1, #7
               	sxtb	x1, w3
               	asr	x3, x1, #7
               	sxtb	x1, w4
               	asr	x4, x1, #7
               	sxtb	x1, w5
               	asr	x5, x1, #7
               	sxtb	x1, w6
               	asr	x6, x1, #7
               	sxtb	x1, w7
               	asr	x7, x1, #7
               	sxtb	x1, w8
               	asr	x8, x1, #7
               	sxtb	x1, w9
               	asr	x9, x1, #7
               	sxtb	x1, w10
               	asr	x10, x1, #7
               	sxtb	x1, w11
               	asr	x11, x1, #7
               	sxtb	x1, w12
               	asr	x12, x1, #7
               	sxtb	x1, w13
               	asr	x13, x1, #7
               	sxtb	x1, w14
               	asr	x14, x1, #7
               	sxtb	x1, w15
               	asr	x15, x1, #7
               	sxtb	x1, w20
               	asr	x20, x1, #7
               	mov	x2, #0x1b               // =27
               	sub	x1, x29, #0x8e0
               	and	x22, x22, x2
               	strb	w22, [x1]
               	and	x22, x23, x2
               	strb	w22, [x1, #0x1]
               	and	x3, x3, x2
               	strb	w3, [x1, #0x2]
               	and	x3, x4, x2
               	strb	w3, [x1, #0x3]
               	and	x3, x5, x2
               	strb	w3, [x1, #0x4]
               	and	x3, x6, x2
               	strb	w3, [x1, #0x5]
               	and	x3, x7, x2
               	strb	w3, [x1, #0x6]
               	and	x3, x8, x2
               	strb	w3, [x1, #0x7]
               	and	x4, x9, x2
               	add	x3, x1, #0x8
               	strb	w4, [x3]
               	and	x4, x10, x2
               	strb	w4, [x1, #0x9]
               	and	x4, x11, x2
               	strb	w4, [x1, #0xa]
               	and	x4, x12, x2
               	strb	w4, [x1, #0xb]
               	and	x4, x13, x2
               	strb	w4, [x1, #0xc]
               	and	x4, x14, x2
               	strb	w4, [x1, #0xd]
               	and	x4, x15, x2
               	strb	w4, [x1, #0xe]
               	and	x2, x20, x2
               	strb	w2, [x1, #0xf]
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	eor	x1, x0, x1
               	ldr	x0, [x21]
               	ldr	x2, [x3]
               	eor	x2, x0, x2
               	sub	x0, x29, #0x970
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x4, x29, #0x1, lsl #12  // =0x1000
               	sub	x4, x4, #0x1f0
               	mov	x0, #0x0                // =0
               	mov	x5, #0x1b               // =27
               	ldrb	w1, [x4, x0]
               	sxtb	x2, w1
               	asr	x2, x2, #7
               	and	x2, x2, x5
               	sub	x3, x29, #0x8e0
               	lsl	x1, x1, #1
               	and	x1, x1, #0xff
               	eor	x1, x1, x2
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x970
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1d0
               	sub	x0, x29, #0x8e0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	add	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	add	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x2, #0xf]
               	add	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x960
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	add	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x960
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x950
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x940
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x1, x29, #0x8e0
               	mov	x0, #0x42               // =66
               	strb	w0, [x1]
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, #0x1]
               	mov	x4, #0x28               // =40
               	strb	w4, [x1, #0x2]
               	strb	w0, [x1, #0x3]
               	mov	x4, #0x1d               // =29
               	strb	w4, [x1, #0x4]
               	strb	w0, [x1, #0x5]
               	mov	x4, #0x16               // =22
               	strb	w4, [x1, #0x6]
               	strb	w0, [x1, #0x7]
               	mov	x4, #0x1                // =1
               	strb	w4, [x1, #0x8]
               	mov	x4, #0x2                // =2
               	strb	w4, [x1, #0x9]
               	mov	x4, #0x3                // =3
               	strb	w4, [x1, #0xa]
               	mov	x4, #0x4                // =4
               	strb	w4, [x1, #0xb]
               	mov	x4, #0x5                // =5
               	strb	w4, [x1, #0xc]
               	mov	x4, #0x6                // =6
               	strb	w4, [x1, #0xd]
               	mov	x4, #0x7                // =7
               	strb	w4, [x1, #0xe]
               	mov	x4, #0x8                // =8
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x930
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	sub	x1, x29, #0x8e0
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	sdiv	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x930
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x950
               	sub	x2, x29, #0x940
               	sub	x0, x29, #0x8e0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	sdiv	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x4, [x2, #0x1]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x4, [x2, #0x2]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x4, [x2, #0x3]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x4, [x2, #0x4]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x4, [x2, #0x5]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x4, [x2, #0x6]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x4, [x2, #0x7]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x4, [x2, #0x8]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x4, [x2, #0x9]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x4, [x2, #0xa]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x4, [x2, #0xb]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x4, [x2, #0xc]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x4, [x2, #0xd]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x4, [x2, #0xe]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x4, [x2, #0xf]
               	sdiv	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x920
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x8e0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	sdiv	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x920
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x68               // =104
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x67               // =103
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5f               // =95
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5e               // =94
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5d               // =93
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5c               // =92
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5b               // =91
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5a               // =90
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x59               // =89
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x58               // =88
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x57               // =87
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x56               // =86
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x55               // =85
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x54               // =84
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x53               // =83
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x52               // =82
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x51               // =81
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x50               // =80
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4f               // =79
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4e               // =78
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4d               // =77
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4c               // =76
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4b               // =75
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4a               // =74
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x49               // =73
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x60               // =96
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x48               // =72
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x66               // =102
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x65               // =101
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x63               // =99
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x62               // =98
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x61               // =97
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x47               // =71
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x46               // =70
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x45               // =69
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x44               // =68
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x43               // =67
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x42               // =66
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41               // =65
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40               // =64
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f               // =63
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3e               // =62
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3d               // =61
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3c               // =60
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3b               // =59
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3a               // =58
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x39               // =57
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x38               // =56
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x37               // =55
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x36               // =54
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x35               // =53
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x34               // =52
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x33               // =51
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x32               // =50
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x31               // =49
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x30               // =48
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2f               // =47
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2e               // =46
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2d               // =45
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2c               // =44
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2b               // =43
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x29               // =41
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x27               // =39
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x26               // =38
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x25               // =37
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x24               // =36
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x23               // =35
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x22               // =34
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x21               // =33
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1d               // =29
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1c               // =28
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1b               // =27
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1a               // =26
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x19               // =25
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x18               // =24
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
