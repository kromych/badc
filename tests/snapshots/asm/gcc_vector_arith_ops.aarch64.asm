
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
               	stp	x20, x21, [sp, #-0x1f0]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x1e0]
               	add	x29, sp, #0x1e0
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
               	sub	x0, x29, #0x60
               	mov	x3, #0x1                // =1
               	strb	w3, [x0]
               	mov	x3, #0x3                // =3
               	strb	w3, [x0, #0x1]
               	mov	x3, #0x5                // =5
               	strb	w3, [x0, #0x2]
               	mov	x3, #0x7                // =7
               	strb	w3, [x0, #0x3]
               	mov	x4, #0x12c              // =300
               	strb	w4, [x0, #0x4]
               	mov	x3, #0x100              // =256
               	strb	w3, [x0, #0x5]
               	strb	w3, [x0, #0x6]
               	strb	w4, [x0, #0x7]
               	strb	w3, [x0, #0x8]
               	mov	x3, #0x8                // =8
               	strb	w3, [x0, #0x9]
               	mov	x3, #0xd                // =13
               	strb	w3, [x0, #0xa]
               	mov	x3, #0x10               // =16
               	strb	w3, [x0, #0xb]
               	mov	x3, #0x13               // =19
               	strb	w3, [x0, #0xc]
               	mov	x3, #0x16               // =22
               	strb	w3, [x0, #0xd]
               	mov	x3, #0x1b               // =27
               	strb	w3, [x0, #0xe]
               	mov	x3, #0x1e               // =30
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
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
               	sub	x1, x29, #0x70
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x2, x29, #0x1a0
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	sub	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	sub	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x2, x29, #0x1a0
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	mul	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	mul	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x2, x29, #0x1a0
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	udiv	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	udiv	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	sdiv	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x2, x29, #0x1a0
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
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
               	sub	x2, x29, #0x1b0
               	sub	x3, x29, #0x1a0
               	ldr	x0, [x2]
               	ldr	x4, [x3]
               	and	x4, x0, x4
               	ldr	x0, [x2, #0x8]
               	ldr	x5, [x3, #0x8]
               	and	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x2, x29, #0x60
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x3, x29, #0x1a0
               	ldr	x0, [x2]
               	ldr	x4, [x3]
               	orr	x4, x0, x4
               	ldr	x0, [x2, #0x8]
               	ldr	x5, [x3, #0x8]
               	orr	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x2, x29, #0x60
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x3, x29, #0x1a0
               	ldr	x0, [x2]
               	ldr	x4, [x3]
               	eor	x4, x0, x4
               	ldr	x0, [x2, #0x8]
               	ldr	x5, [x3, #0x8]
               	eor	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x190
               	sub	x2, x29, #0x180
               	sub	x0, x29, #0x60
               	ldrsb	x4, [x1]
               	ldrsb	x5, [x2]
               	add	x4, x4, x5
               	strb	w4, [x0]
               	ldrsb	x4, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	add	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x190
               	sub	x2, x29, #0x180
               	sub	x0, x29, #0x60
               	ldrsb	x4, [x1]
               	ldrsb	x5, [x2]
               	sub	x4, x4, x5
               	strb	w4, [x0]
               	ldrsb	x4, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	sub	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	sub	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x190
               	sub	x2, x29, #0x180
               	sub	x0, x29, #0x60
               	ldrsb	x4, [x1]
               	ldrsb	x5, [x2]
               	mul	x4, x4, x5
               	strb	w4, [x0]
               	ldrsb	x4, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	mul	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	mul	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x190
               	sub	x2, x29, #0x180
               	sub	x0, x29, #0x60
               	ldrsb	x4, [x1]
               	ldrsb	x5, [x2]
               	sdiv	x4, x4, x5
               	strb	w4, [x0]
               	ldrsb	x4, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	sdiv	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x190
               	sub	x2, x29, #0x180
               	sub	x0, x29, #0x60
               	ldrsb	x4, [x1]
               	ldrsb	x5, [x2]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0]
               	ldrsb	x4, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	sdiv	x17, x4, x5
               	msub	x4, x17, x5, x4
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
               	sub	x2, x29, #0x190
               	sub	x3, x29, #0x180
               	ldr	x0, [x2]
               	ldr	x4, [x3]
               	and	x4, x0, x4
               	ldr	x0, [x2, #0x8]
               	ldr	x5, [x3, #0x8]
               	and	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x170
               	sub	x4, x29, #0x160
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x170
               	sub	x4, x29, #0x160
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x170
               	sub	x4, x29, #0x160
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x170
               	sub	x4, x29, #0x160
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x170
               	sub	x4, x29, #0x160
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x4, x29, #0x140
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x4, x29, #0x140
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x4, x29, #0x140
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x4, x29, #0x140
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x4, x29, #0x140
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x130
               	sub	x4, x29, #0x120
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x130
               	sub	x4, x29, #0x120
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x130
               	sub	x4, x29, #0x120
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x130
               	sub	x4, x29, #0x120
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x130
               	sub	x4, x29, #0x120
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xf0
               	sub	x4, x29, #0xe0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	add	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	add	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xf0
               	sub	x4, x29, #0xe0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	sub	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	sub	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xf0
               	sub	x4, x29, #0xe0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	mul	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	mul	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xf0
               	sub	x4, x29, #0xe0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	udiv	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	udiv	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xf0
               	sub	x4, x29, #0xe0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	udiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	udiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xd0
               	sub	x4, x29, #0xc0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	add	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	add	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xd0
               	sub	x4, x29, #0xc0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	sub	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	sub	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xd0
               	sub	x4, x29, #0xc0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	mul	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	mul	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xd0
               	sub	x4, x29, #0xc0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	sdiv	x1, x0, x1
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	sdiv	x5, x0, x5
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xd0
               	sub	x4, x29, #0xc0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	sdiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	sdiv	x17, x0, x5
               	msub	x5, x17, x5, x0
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x38
               	sub	x2, x29, #0x30
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
               	sub	x0, x29, #0x28
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
               	sub	x3, x29, #0x8
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	add	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
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
               	sub	x2, x29, #0x38
               	sub	x3, x29, #0x30
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
               	sub	x0, x29, #0x28
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
               	sub	x2, x29, #0xb0
               	sub	x3, x29, #0x90
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
               	sub	x0, x29, #0x60
               	str	w1, [x0]
               	str	w4, [x0, #0x4]
               	str	w5, [x0, #0x8]
               	str	w6, [x0, #0xc]
               	str	w7, [x0, #0x10]
               	str	w8, [x0, #0x14]
               	str	w9, [x0, #0x18]
               	str	w10, [x0, #0x1c]
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0x20
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x20
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x3, x29, #0xb0
               	sub	x4, x29, #0x90
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x20
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x2, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0xb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x60
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
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x10
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	lsl	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x90
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x2, x29, #0x70
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	lsr	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	lsr	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	lsr	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
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
               	sub	x3, x29, #0x150
               	sub	x4, x29, #0xb0
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x4, x29, #0xb0
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
               	sub	x0, x29, #0x60
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
               	sub	x2, x29, #0x60
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	ldrsw	x0, [x3]
               	asr	x2, x0, #3
               	ldrsw	x0, [x3, #0x4]
               	asr	x4, x0, #3
               	ldrsw	x0, [x3, #0x8]
               	asr	x5, x0, #3
               	ldrsw	x0, [x3, #0xc]
               	asr	x6, x0, #3
               	sub	x0, x29, #0x60
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
               	sub	x2, x29, #0x60
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x130
               	ldr	w0, [x3]
               	lsr	x2, x0, #3
               	ldr	w0, [x3, #0x4]
               	lsr	x4, x0, #3
               	ldr	w0, [x3, #0x8]
               	lsr	x5, x0, #3
               	ldr	w0, [x3, #0xc]
               	lsr	x6, x0, #3
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x190
               	sub	x0, x29, #0x60
               	ldrsb	x3, [x1]
               	lsl	x3, x3, #2
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	lsl	x3, x3, #2
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrsb	x3, [x1, x0]
               	lsl	x3, x3, #2
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x60
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
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	sub	x3, x3, #0x40
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x60
               	ldrb	w3, [x1]
               	add	x3, x3, #0x64
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	add	x3, x3, #0x64
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	add	x3, x3, #0x64
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x1b0
               	mov	x3, #0x7                // =7
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	mul	x4, x4, x3
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	mul	x4, x4, x3
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	mul	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x7                // =7
               	ldrb	w3, [x1, x0]
               	mul	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x60
               	ldrb	w3, [x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	ldrb	w3, [x1, x0]
               	mul	x3, x3, x4
               	lsr	x3, x3, #32
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x60
               	ldrb	w3, [x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #32
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x7                // =7
               	mov	x6, #0x4925             // =18725
               	movk	x6, #0x2492, lsl #16
               	ldrb	w3, [x1, x0]
               	mul	x4, x3, x6
               	lsr	x4, x4, #32
               	mul	x4, x4, x5
               	sub	x3, x3, x4
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x1b0
               	mov	x3, #0xf                // =15
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	and	x4, x4, x3
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	and	x4, x4, x3
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	and	x4, x4, x3
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	and	x4, x4, x3
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	and	x4, x4, x3
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	and	x4, x4, x3
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	and	x4, x4, x3
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	and	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	and	x3, x3, #0xf
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x1b0
               	mov	x3, #0xf0               // =240
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	orr	x4, x4, x3
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	orr	x4, x4, x3
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	orr	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	orr	x3, x3, #0xf0
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x1b0
               	mov	x3, #0x55               // =85
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	eor	x4, x4, x3
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	eor	x4, x4, x3
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	eor	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x55               // =85
               	ldrb	w3, [x1, x0]
               	eor	x3, x3, x4
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x190
               	sub	x0, x29, #0x60
               	ldrsb	x3, [x1]
               	sub	x3, x3, #0x64
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	sub	x3, x3, #0x64
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrsb	x3, [x1, x0]
               	sub	x3, x3, #0x64
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x190
               	sub	x0, x29, #0x60
               	ldrsb	x3, [x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	ldrsb	x3, [x1, x0]
               	mul	x3, x3, x5
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x190
               	sub	x0, x29, #0x60
               	ldrsb	x3, [x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x4, x3, x17
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	ldrsb	x3, [x1, x0]
               	mul	x4, x3, x7
               	asr	x4, x4, #32
               	lsr	x5, x4, #63
               	add	x4, x4, x5
               	mul	x4, x4, x6
               	sub	x3, x3, x4
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
               	sub	x3, x29, #0x170
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
               	sub	x0, x29, #0x60
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
               	sub	x2, x29, #0x60
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xd0
               	mov	x0, #0x7                // =7
               	ldr	x2, [x3]
               	mul	x2, x2, x0
               	ldr	x4, [x3, #0x8]
               	mul	x4, x4, x0
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x3, #0x40               // =64
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	sub	x4, x3, x4
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x40               // =64
               	ldrb	w4, [x1, x0]
               	sub	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
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
               	mov	x3, #0x64               // =100
               	sub	x1, x29, #0x190
               	sub	x0, x29, #0x60
               	ldrsb	x4, [x1]
               	sub	x4, x3, x4
               	strb	w4, [x0]
               	ldrsb	x4, [x1, #0x1]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	sub	x4, x3, x4
               	strb	w4, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x64               // =100
               	ldrsb	x4, [x1, x0]
               	sub	x3, x3, x4
               	strb	w3, [x2, x0]
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
               	mov	x3, #0xfa               // =250
               	sub	x1, x29, #0x1a0
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	udiv	x4, x3, x4
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	udiv	x4, x3, x4
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	udiv	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xfa               // =250
               	ldrb	w4, [x1, x0]
               	sdiv	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
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
               	mov	x3, #0xfa               // =250
               	sub	x1, x29, #0x1a0
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	udiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xfa               // =250
               	ldrb	w4, [x1, x0]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
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
               	mov	x3, #0xf                // =15
               	sub	x1, x29, #0x1a0
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	and	x4, x3, x4
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	and	x4, x3, x4
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	and	x4, x3, x4
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	and	x4, x3, x4
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	and	x4, x3, x4
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	and	x4, x3, x4
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	and	x4, x3, x4
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	and	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	and	x3, x3, #0xf
               	strb	w3, [x2, x0]
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
               	mov	x3, #0x3                // =3
               	sub	x1, x29, #0x70
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	lsl	x4, x3, x4
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	lsl	x4, x3, x4
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	lsl	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	ldrb	w4, [x1, x0]
               	lsl	x3, x3, x4
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
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
               	mov	x3, #0x80               // =128
               	sub	x1, x29, #0x70
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	lsr	x4, x3, x4
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	lsr	x4, x3, x4
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	lsr	x3, x3, x4
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x80               // =128
               	ldrb	w4, [x1, x0]
               	lsr	x3, x3, x4
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
               	mov	x0, #-0x7               // =-7
               	sub	x3, x29, #0x100
               	ldrsw	x2, [x3]
               	sdiv	x2, x0, x2
               	ldrsw	x4, [x3, #0x4]
               	sdiv	x4, x0, x4
               	ldrsw	x5, [x3, #0x8]
               	sdiv	x5, x0, x5
               	ldrsw	x6, [x3, #0xc]
               	sdiv	x6, x0, x6
               	sub	x0, x29, #0x60
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
               	sub	x2, x29, #0x60
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
               	sub	x3, x29, #0x100
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x60
               	ldrb	w3, [x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	ldrb	w3, [x1, x0]
               	mul	x3, x3, x4
               	lsr	x3, x3, #32
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
               	sub	x3, x29, #0x110
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
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x3, x29, #0x60
               	ldrb	w4, [x1]
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	strb	w4, [x3]
               	ldrb	w4, [x1, #0x1]
               	neg	x4, x4
               	strb	w4, [x3, #0x1]
               	ldrb	w4, [x1, #0x2]
               	neg	x4, x4
               	strb	w4, [x3, #0x2]
               	ldrb	w4, [x1, #0x3]
               	neg	x4, x4
               	strb	w4, [x3, #0x3]
               	ldrb	w4, [x1, #0x4]
               	neg	x4, x4
               	strb	w4, [x3, #0x4]
               	ldrb	w4, [x1, #0x5]
               	neg	x4, x4
               	strb	w4, [x3, #0x5]
               	ldrb	w4, [x1, #0x6]
               	neg	x4, x4
               	strb	w4, [x3, #0x6]
               	ldrb	w4, [x1, #0x7]
               	neg	x4, x4
               	strb	w4, [x3, #0x7]
               	ldrb	w4, [x1, #0x8]
               	neg	x4, x4
               	strb	w4, [x3, #0x8]
               	ldrb	w4, [x1, #0x9]
               	neg	x4, x4
               	strb	w4, [x3, #0x9]
               	ldrb	w4, [x1, #0xa]
               	neg	x4, x4
               	strb	w4, [x3, #0xa]
               	ldrb	w4, [x1, #0xb]
               	neg	x4, x4
               	strb	w4, [x3, #0xb]
               	ldrb	w4, [x1, #0xc]
               	neg	x4, x4
               	strb	w4, [x3, #0xc]
               	ldrb	w4, [x1, #0xd]
               	neg	x4, x4
               	strb	w4, [x3, #0xd]
               	ldrb	w4, [x1, #0xe]
               	neg	x4, x4
               	strb	w4, [x3, #0xe]
               	ldrb	w4, [x1, #0xf]
               	neg	x4, x4
               	strb	w4, [x3, #0xf]
               	sub	x4, x29, #0x90
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x4]
               	ldrb	w3, [x1, x0]
               	neg	x3, x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
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
               	sub	x1, x29, #0x190
               	sub	x3, x29, #0x60
               	ldrsb	x4, [x1]
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	strb	w4, [x3]
               	ldrsb	x4, [x1, #0x1]
               	neg	x4, x4
               	strb	w4, [x3, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	neg	x4, x4
               	strb	w4, [x3, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	neg	x4, x4
               	strb	w4, [x3, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	neg	x4, x4
               	strb	w4, [x3, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	neg	x4, x4
               	strb	w4, [x3, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	neg	x4, x4
               	strb	w4, [x3, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	neg	x4, x4
               	strb	w4, [x3, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	neg	x4, x4
               	strb	w4, [x3, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	neg	x4, x4
               	strb	w4, [x3, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	neg	x4, x4
               	strb	w4, [x3, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	neg	x4, x4
               	strb	w4, [x3, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	neg	x4, x4
               	strb	w4, [x3, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	neg	x4, x4
               	strb	w4, [x3, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	neg	x4, x4
               	strb	w4, [x3, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	neg	x4, x4
               	strb	w4, [x3, #0xf]
               	sub	x4, x29, #0x90
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x4]
               	ldrsb	x3, [x1, x0]
               	neg	x3, x3
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
               	sub	x3, x29, #0x110
               	ldrsw	x2, [x3]
               	mov	x0, #0x0                // =0
               	neg	x4, x2
               	ldrsw	x2, [x3, #0x4]
               	neg	x5, x2
               	ldrsw	x2, [x3, #0x8]
               	neg	x6, x2
               	ldrsw	x2, [x3, #0xc]
               	neg	x7, x2
               	sub	x2, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x60
               	ldrb	w3, [x1]
               	mvn	x3, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	mvn	x3, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	mvn	x3, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	mvn	x3, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	mvn	x3, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	mvn	x3, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	mvn	x3, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	mvn	x3, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	mvn	x3, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	mvn	x3, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	mvn	x3, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	mvn	x3, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	mvn	x3, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	mvn	x3, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	mvn	x3, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	mvn	x3, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	mvn	x3, x3
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
               	sub	x3, x29, #0xd0
               	ldr	x0, [x3]
               	mvn	x2, x0
               	ldr	x0, [x3, #0x8]
               	mvn	x4, x0
               	sub	x0, x29, #0x60
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
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x60
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	add	x3, x3, x4
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w4, [x0, #0x1]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w4, [x0, #0x2]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w4, [x0, #0x3]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w4, [x0, #0x5]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w4, [x0, #0x6]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w4, [x0, #0x7]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w4, [x0, #0x9]
               	add	x3, x3, x4
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w4, [x0, #0xa]
               	add	x3, x3, x4
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w4, [x0, #0xb]
               	add	x3, x3, x4
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w4, [x0, #0xc]
               	add	x3, x3, x4
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w4, [x0, #0xd]
               	add	x3, x3, x4
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w4, [x0, #0xe]
               	add	x3, x3, x4
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w4, [x0, #0xf]
               	add	x3, x3, x4
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x0]
               	add	x4, x4, x5
               	strb	w4, [x2]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x0, #0x1]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x0, #0x2]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x0, #0x3]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x0, #0x4]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x0, #0x5]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x0, #0x6]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x0, #0x7]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x0, #0x8]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x0, #0x9]
               	add	x4, x4, x5
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x0, #0xa]
               	add	x4, x4, x5
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x0, #0xb]
               	add	x4, x4, x5
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x0, #0xc]
               	add	x4, x4, x5
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x0, #0xd]
               	add	x4, x4, x5
               	strb	w4, [x2, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x0, #0xe]
               	add	x4, x4, x5
               	strb	w4, [x2, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	add	x0, x4, x0
               	strb	w0, [x2, #0xf]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x60
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	sub	x3, x3, x4
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w4, [x0, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w4, [x0, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w4, [x0, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w4, [x0, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w4, [x0, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w4, [x0, #0x7]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w4, [x0, #0x9]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w4, [x0, #0xa]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w4, [x0, #0xb]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w4, [x0, #0xc]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w4, [x0, #0xd]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w4, [x0, #0xe]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w4, [x0, #0xf]
               	sub	x3, x3, x4
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x0]
               	sub	x4, x4, x5
               	strb	w4, [x2]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x0, #0x1]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x0, #0x2]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x0, #0x3]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x0, #0x4]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x0, #0x5]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x0, #0x6]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x0, #0x7]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x0, #0x8]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x0, #0x9]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x0, #0xa]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x0, #0xb]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x0, #0xc]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x0, #0xd]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x0, #0xe]
               	sub	x4, x4, x5
               	strb	w4, [x2, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	sub	x0, x4, x0
               	strb	w0, [x2, #0xf]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x60
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	mul	x3, x3, x4
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w4, [x0, #0x1]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w4, [x0, #0x2]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w4, [x0, #0x3]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w4, [x0, #0x5]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w4, [x0, #0x6]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w4, [x0, #0x7]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w4, [x0, #0x9]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w4, [x0, #0xa]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w4, [x0, #0xb]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w4, [x0, #0xc]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w4, [x0, #0xd]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w4, [x0, #0xe]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w4, [x0, #0xf]
               	mul	x3, x3, x4
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x0]
               	mul	x4, x4, x5
               	strb	w4, [x2]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x0, #0x1]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x0, #0x2]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x0, #0x3]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x0, #0x4]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x0, #0x5]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x0, #0x6]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x0, #0x7]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x0, #0x8]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x0, #0x9]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x0, #0xa]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x0, #0xb]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x0, #0xc]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x0, #0xd]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x0, #0xe]
               	mul	x4, x4, x5
               	strb	w4, [x2, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	mul	x0, x4, x0
               	strb	w0, [x2, #0xf]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x60
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	udiv	x3, x3, x4
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w4, [x0, #0x1]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w4, [x0, #0x2]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w4, [x0, #0x3]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w4, [x0, #0x5]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w4, [x0, #0x6]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w4, [x0, #0x7]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w4, [x0, #0x9]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w4, [x0, #0xa]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w4, [x0, #0xb]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w4, [x0, #0xc]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w4, [x0, #0xd]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w4, [x0, #0xe]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w4, [x0, #0xf]
               	udiv	x3, x3, x4
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x0]
               	udiv	x4, x4, x5
               	strb	w4, [x2]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x0, #0x1]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x0, #0x2]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x0, #0x3]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x0, #0x4]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x0, #0x5]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x0, #0x6]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x0, #0x7]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x0, #0x8]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x0, #0x9]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x0, #0xa]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x0, #0xb]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x0, #0xc]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x0, #0xd]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x0, #0xe]
               	udiv	x4, x4, x5
               	strb	w4, [x2, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	udiv	x0, x4, x0
               	strb	w0, [x2, #0xf]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x60
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w4, [x0, #0x1]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w4, [x0, #0x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w4, [x0, #0x3]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w4, [x0, #0x5]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w4, [x0, #0x6]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w4, [x0, #0x7]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w4, [x0, #0x9]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w4, [x0, #0xa]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w4, [x0, #0xb]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w4, [x0, #0xc]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w4, [x0, #0xd]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w4, [x0, #0xe]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w4, [x0, #0xf]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x0]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x0, #0x1]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x0, #0x2]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x0, #0x3]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x0, #0x4]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x0, #0x5]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x0, #0x6]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x0, #0x7]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x0, #0x8]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x0, #0x9]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x0, #0xa]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x0, #0xb]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x0, #0xc]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x0, #0xd]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x0, #0xe]
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	strb	w4, [x2, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	udiv	x17, x4, x0
               	msub	x0, x17, x0, x4
               	strb	w0, [x2, #0xf]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	ldr	x1, [x3]
               	ldr	x2, [x0]
               	and	x1, x1, x2
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x0, #0x8]
               	and	x4, x2, x4
               	sub	x2, x29, #0x90
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	sub	x1, x29, #0x60
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
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	ldr	x1, [x3]
               	ldr	x2, [x0]
               	orr	x1, x1, x2
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x0, #0x8]
               	orr	x4, x2, x4
               	sub	x2, x29, #0x90
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	sub	x1, x29, #0x60
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
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	ldr	x1, [x3]
               	ldr	x2, [x0]
               	eor	x1, x1, x2
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x0, #0x8]
               	eor	x4, x2, x4
               	sub	x2, x29, #0x90
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	sub	x1, x29, #0x60
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
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x60
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	lsl	x3, x3, x4
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w4, [x0, #0x1]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w4, [x0, #0x2]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w4, [x0, #0x3]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w4, [x0, #0x5]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w4, [x0, #0x6]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w4, [x0, #0x7]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w4, [x0, #0x9]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w4, [x0, #0xa]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w4, [x0, #0xb]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w4, [x0, #0xc]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w4, [x0, #0xd]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w4, [x0, #0xe]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w4, [x0, #0xf]
               	lsl	x3, x3, x4
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x0]
               	lsl	x4, x4, x5
               	strb	w4, [x2]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x0, #0x1]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x0, #0x2]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x0, #0x3]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x0, #0x4]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x0, #0x5]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x0, #0x6]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x0, #0x7]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x0, #0x8]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x0, #0x9]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x0, #0xa]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x0, #0xb]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x0, #0xc]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x0, #0xd]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x0, #0xe]
               	lsl	x4, x4, x5
               	strb	w4, [x2, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	lsl	x0, x4, x0
               	strb	w0, [x2, #0xf]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x60
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	lsr	x3, x3, x4
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	ldrb	w4, [x0, #0x1]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	ldrb	w4, [x0, #0x2]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	ldrb	w4, [x0, #0x3]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	ldrb	w4, [x0, #0x5]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w4, [x0, #0x6]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w4, [x0, #0x7]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w4, [x0, #0x9]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w4, [x0, #0xa]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	ldrb	w4, [x0, #0xb]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	ldrb	w4, [x0, #0xc]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	ldrb	w4, [x0, #0xd]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	ldrb	w4, [x0, #0xe]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	ldrb	w4, [x0, #0xf]
               	lsr	x3, x3, x4
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x0]
               	lsr	x4, x4, x5
               	strb	w4, [x2]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x0, #0x1]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x0, #0x2]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x0, #0x3]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x0, #0x4]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x0, #0x5]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x0, #0x6]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x0, #0x7]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x0, #0x8]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x0, #0x9]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x0, #0xa]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x0, #0xb]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x0, #0xc]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x0, #0xd]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x0, #0xe]
               	lsr	x4, x4, x5
               	strb	w4, [x2, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	lsr	x0, x4, x0
               	strb	w0, [x2, #0xf]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x0, x29, #0x140
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
               	sub	x2, x29, #0x90
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
               	sub	x1, x29, #0x60
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
               	sub	x3, x29, #0xd0
               	sub	x0, x29, #0xc0
               	ldr	x1, [x3]
               	ldr	x2, [x0]
               	mul	x1, x1, x2
               	ldr	x2, [x3, #0x8]
               	ldr	x4, [x0, #0x8]
               	mul	x4, x2, x4
               	sub	x2, x29, #0x90
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	sub	x1, x29, #0x60
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
               	sub	x0, x29, #0x1b0
               	sub	x1, x29, #0xb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w3, [x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x2]
               	ldrb	w3, [x1, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x1]
               	ldrb	w3, [x1, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x2]
               	ldrb	w3, [x1, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x3]
               	ldrb	w3, [x1, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x4]
               	ldrb	w3, [x1, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x5]
               	ldrb	w3, [x1, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x6]
               	ldrb	w3, [x1, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x7]
               	ldrb	w3, [x1, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x8]
               	ldrb	w3, [x1, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x9]
               	ldrb	w3, [x1, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xa]
               	ldrb	w3, [x1, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xb]
               	ldrb	w3, [x1, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xc]
               	ldrb	w3, [x1, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xd]
               	ldrb	w3, [x1, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xe]
               	ldrb	w3, [x1, #0xf]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xf]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x60
               	ldrb	w3, [x0]
               	sub	x3, x3, #0x40
               	strb	w3, [x2]
               	ldrb	w3, [x0, #0x1]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x1]
               	ldrb	w3, [x0, #0x2]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x2]
               	ldrb	w3, [x0, #0x3]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x3]
               	ldrb	w3, [x0, #0x4]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x4]
               	ldrb	w3, [x0, #0x5]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x5]
               	ldrb	w3, [x0, #0x6]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x6]
               	ldrb	w3, [x0, #0x7]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x7]
               	ldrb	w3, [x0, #0x8]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x8]
               	ldrb	w3, [x0, #0x9]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0x9]
               	ldrb	w3, [x0, #0xa]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xa]
               	ldrb	w3, [x0, #0xb]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xb]
               	ldrb	w3, [x0, #0xc]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xc]
               	ldrb	w3, [x0, #0xd]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xd]
               	ldrb	w3, [x0, #0xe]
               	sub	x3, x3, #0x40
               	strb	w3, [x2, #0xe]
               	ldrb	w0, [x0, #0xf]
               	sub	x0, x0, #0x40
               	strb	w0, [x2, #0xf]
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x60
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
               	sub	x1, x29, #0x60
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
               	sub	x1, x29, #0x60
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
               	sub	x1, x29, #0x10
               	ldrb	w3, [x2, x0]
               	sub	x3, x3, #0xc0
               	and	x3, x3, #0xff
               	strb	w3, [x1, x0]
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
               	sub	x0, x29, #0x1b0
               	sub	x2, x29, #0x1a0
               	ldrb	w3, [x0]
               	ldrb	w4, [x2]
               	add	x3, x3, x4
               	ldrb	w4, [x0, #0x1]
               	ldrb	w5, [x2, #0x1]
               	add	x4, x4, x5
               	ldrb	w5, [x0, #0x2]
               	ldrb	w6, [x2, #0x2]
               	add	x5, x5, x6
               	ldrb	w6, [x0, #0x3]
               	ldrb	w7, [x2, #0x3]
               	add	x6, x6, x7
               	ldrb	w7, [x0, #0x4]
               	ldrb	w8, [x2, #0x4]
               	add	x7, x7, x8
               	ldrb	w8, [x0, #0x5]
               	ldrb	w9, [x2, #0x5]
               	add	x8, x8, x9
               	ldrb	w9, [x0, #0x6]
               	ldrb	w10, [x2, #0x6]
               	add	x9, x9, x10
               	ldrb	w10, [x0, #0x7]
               	ldrb	w11, [x2, #0x7]
               	add	x10, x10, x11
               	ldrb	w11, [x0, #0x8]
               	ldrb	w12, [x2, #0x8]
               	add	x11, x11, x12
               	ldrb	w12, [x0, #0x9]
               	ldrb	w13, [x2, #0x9]
               	add	x12, x12, x13
               	ldrb	w13, [x0, #0xa]
               	ldrb	w14, [x2, #0xa]
               	add	x13, x13, x14
               	ldrb	w14, [x0, #0xb]
               	ldrb	w15, [x2, #0xb]
               	add	x14, x14, x15
               	ldrb	w15, [x0, #0xc]
               	ldrb	w20, [x2, #0xc]
               	add	x15, x15, x20
               	ldrb	w20, [x0, #0xd]
               	ldrb	w21, [x2, #0xd]
               	add	x20, x20, x21
               	ldrb	w21, [x0, #0xe]
               	ldrb	w22, [x2, #0xe]
               	add	x21, x21, x22
               	ldrb	w22, [x0, #0xf]
               	ldrb	w2, [x2, #0xf]
               	add	x22, x22, x2
               	mov	x2, #0x3                // =3
               	and	x3, x3, #0xff
               	mul	x3, x3, x2
               	and	x4, x4, #0xff
               	mul	x4, x4, x2
               	and	x5, x5, #0xff
               	mul	x5, x5, x2
               	and	x6, x6, #0xff
               	mul	x6, x6, x2
               	and	x7, x7, #0xff
               	mul	x7, x7, x2
               	and	x8, x8, #0xff
               	mul	x8, x8, x2
               	and	x9, x9, #0xff
               	mul	x9, x9, x2
               	and	x10, x10, #0xff
               	mul	x10, x10, x2
               	and	x11, x11, #0xff
               	mul	x11, x11, x2
               	and	x12, x12, #0xff
               	mul	x12, x12, x2
               	and	x13, x13, #0xff
               	mul	x13, x13, x2
               	and	x14, x14, #0xff
               	mul	x14, x14, x2
               	and	x15, x15, #0xff
               	mul	x15, x15, x2
               	and	x20, x20, #0xff
               	mul	x20, x20, x2
               	and	x21, x21, #0xff
               	mul	x21, x21, x2
               	and	x22, x22, #0xff
               	mul	x22, x22, x2
               	sub	x2, x29, #0x60
               	and	x3, x3, #0xff
               	ldrb	w23, [x0]
               	sub	x3, x3, x23
               	strb	w3, [x2]
               	and	x3, x4, #0xff
               	ldrb	w4, [x0, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x1]
               	and	x3, x5, #0xff
               	ldrb	w4, [x0, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x2]
               	and	x3, x6, #0xff
               	ldrb	w4, [x0, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x3]
               	and	x3, x7, #0xff
               	ldrb	w4, [x0, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x4]
               	and	x3, x8, #0xff
               	ldrb	w4, [x0, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x5]
               	and	x3, x9, #0xff
               	ldrb	w4, [x0, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x6]
               	and	x3, x10, #0xff
               	ldrb	w4, [x0, #0x7]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x7]
               	and	x3, x11, #0xff
               	ldrb	w4, [x0, #0x8]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x8]
               	and	x3, x12, #0xff
               	ldrb	w4, [x0, #0x9]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x9]
               	and	x3, x13, #0xff
               	ldrb	w4, [x0, #0xa]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xa]
               	and	x3, x14, #0xff
               	ldrb	w4, [x0, #0xb]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xb]
               	and	x3, x15, #0xff
               	ldrb	w4, [x0, #0xc]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xc]
               	and	x3, x20, #0xff
               	ldrb	w4, [x0, #0xd]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xd]
               	and	x3, x21, #0xff
               	ldrb	w4, [x0, #0xe]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xe]
               	and	x3, x22, #0xff
               	ldrb	w0, [x0, #0xf]
               	sub	x0, x3, x0
               	strb	w0, [x2, #0xf]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x4, x29, #0x1b0
               	sub	x5, x29, #0x1a0
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
               	sub	x4, x29, #0x110
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
               	sub	x5, x29, #0x100
               	ldrsw	x8, [x5]
               	add	x8, x1, x8
               	ldrsw	x1, [x5, #0x4]
               	add	x3, x3, x1
               	ldrsw	x1, [x5, #0x8]
               	add	x7, x7, x1
               	ldrsw	x1, [x5, #0xc]
               	add	x6, x6, x1
               	sub	x1, x29, #0x60
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
               	sub	x2, x29, #0x60
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	ldrb	w2, [x0]
               	ldrb	w3, [x0, #0x1]
               	ldrb	w4, [x0, #0x2]
               	ldrb	w5, [x0, #0x3]
               	ldrb	w6, [x0, #0x4]
               	ldrb	w7, [x0, #0x5]
               	ldrb	w8, [x0, #0x6]
               	ldrb	w9, [x0, #0x7]
               	ldrb	w10, [x0, #0x8]
               	ldrb	w11, [x0, #0x9]
               	ldrb	w12, [x0, #0xa]
               	ldrb	w13, [x0, #0xb]
               	ldrb	w14, [x0, #0xc]
               	ldrb	w15, [x0, #0xd]
               	ldrb	w20, [x0, #0xe]
               	ldrb	w21, [x0, #0xf]
               	sub	x0, x29, #0x90
               	lsl	x22, x2, #1
               	strb	w22, [x0]
               	lsl	x22, x3, #1
               	strb	w22, [x0, #0x1]
               	lsl	x22, x4, #1
               	strb	w22, [x0, #0x2]
               	lsl	x22, x5, #1
               	strb	w22, [x0, #0x3]
               	lsl	x22, x6, #1
               	strb	w22, [x0, #0x4]
               	lsl	x22, x7, #1
               	strb	w22, [x0, #0x5]
               	lsl	x22, x8, #1
               	strb	w22, [x0, #0x6]
               	lsl	x22, x9, #1
               	strb	w22, [x0, #0x7]
               	lsl	x23, x10, #1
               	add	x22, x0, #0x8
               	strb	w23, [x22]
               	lsl	x23, x11, #1
               	strb	w23, [x0, #0x9]
               	lsl	x23, x12, #1
               	strb	w23, [x0, #0xa]
               	lsl	x23, x13, #1
               	strb	w23, [x0, #0xb]
               	lsl	x23, x14, #1
               	strb	w23, [x0, #0xc]
               	lsl	x23, x15, #1
               	strb	w23, [x0, #0xd]
               	lsl	x23, x20, #1
               	strb	w23, [x0, #0xe]
               	lsl	x23, x21, #1
               	strb	w23, [x0, #0xf]
               	sxtb	x2, w2
               	asr	x23, x2, #7
               	sxtb	x2, w3
               	asr	x24, x2, #7
               	sxtb	x2, w4
               	asr	x4, x2, #7
               	sxtb	x2, w5
               	asr	x5, x2, #7
               	sxtb	x2, w6
               	asr	x6, x2, #7
               	sxtb	x2, w7
               	asr	x7, x2, #7
               	sxtb	x2, w8
               	asr	x8, x2, #7
               	sxtb	x2, w9
               	asr	x9, x2, #7
               	sxtb	x2, w10
               	asr	x10, x2, #7
               	sxtb	x2, w11
               	asr	x11, x2, #7
               	sxtb	x2, w12
               	asr	x12, x2, #7
               	sxtb	x2, w13
               	asr	x13, x2, #7
               	sxtb	x2, w14
               	asr	x14, x2, #7
               	sxtb	x2, w15
               	asr	x15, x2, #7
               	sxtb	x2, w20
               	asr	x20, x2, #7
               	sxtb	x2, w21
               	asr	x21, x2, #7
               	mov	x3, #0x1b               // =27
               	sub	x2, x29, #0x60
               	and	x23, x23, x3
               	strb	w23, [x2]
               	and	x23, x24, x3
               	strb	w23, [x2, #0x1]
               	and	x4, x4, x3
               	strb	w4, [x2, #0x2]
               	and	x4, x5, x3
               	strb	w4, [x2, #0x3]
               	and	x4, x6, x3
               	strb	w4, [x2, #0x4]
               	and	x4, x7, x3
               	strb	w4, [x2, #0x5]
               	and	x4, x8, x3
               	strb	w4, [x2, #0x6]
               	and	x4, x9, x3
               	strb	w4, [x2, #0x7]
               	and	x5, x10, x3
               	add	x4, x2, #0x8
               	strb	w5, [x4]
               	and	x5, x11, x3
               	strb	w5, [x2, #0x9]
               	and	x5, x12, x3
               	strb	w5, [x2, #0xa]
               	and	x5, x13, x3
               	strb	w5, [x2, #0xb]
               	and	x5, x14, x3
               	strb	w5, [x2, #0xc]
               	and	x5, x15, x3
               	strb	w5, [x2, #0xd]
               	and	x5, x20, x3
               	strb	w5, [x2, #0xe]
               	and	x3, x21, x3
               	strb	w3, [x2, #0xf]
               	ldr	x0, [x0]
               	ldr	x2, [x2]
               	eor	x2, x0, x2
               	ldr	x0, [x22]
               	ldr	x3, [x4]
               	eor	x3, x0, x3
               	sub	x0, x29, #0x60
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x4, x29, #0x1b0
               	mov	x0, #0x0                // =0
               	mov	x5, #0x1b               // =27
               	ldrb	w2, [x4, x0]
               	sxtb	x3, w2
               	asr	x3, x3, #7
               	and	x3, x3, x5
               	lsl	x2, x2, #1
               	and	x2, x2, #0xff
               	eor	x2, x2, x3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x60
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1b0
               	sub	x2, x29, #0x190
               	sub	x0, x29, #0x60
               	ldrb	w4, [x1]
               	ldrb	w5, [x2]
               	add	x4, x4, x5
               	strb	w4, [x0]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrb	w4, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrb	w4, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrb	w4, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrb	w4, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrb	w4, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrb	w4, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrb	w4, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	add	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrb	w4, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrb	w4, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrb	w4, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrb	w4, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrb	w4, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	add	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	add	x4, x4, x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
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
               	sub	x3, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x4, x29, #0xb0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	sub	x2, x29, #0x60
               	mov	x0, #0x42               // =66
               	strb	w0, [x2]
               	mov	x0, #0x0                // =0
               	strb	w0, [x2, #0x1]
               	mov	x5, #0x28               // =40
               	strb	w5, [x2, #0x2]
               	strb	w0, [x2, #0x3]
               	mov	x5, #0x1d               // =29
               	strb	w5, [x2, #0x4]
               	strb	w0, [x2, #0x5]
               	mov	x5, #0x16               // =22
               	strb	w5, [x2, #0x6]
               	strb	w0, [x2, #0x7]
               	mov	x5, #0x1                // =1
               	strb	w5, [x2, #0x8]
               	mov	x5, #0x2                // =2
               	strb	w5, [x2, #0x9]
               	mov	x5, #0x3                // =3
               	strb	w5, [x2, #0xa]
               	mov	x5, #0x4                // =4
               	strb	w5, [x2, #0xb]
               	mov	x5, #0x5                // =5
               	strb	w5, [x2, #0xc]
               	mov	x5, #0x6                // =6
               	strb	w5, [x2, #0xd]
               	mov	x5, #0x7                // =7
               	strb	w5, [x2, #0xe]
               	mov	x5, #0x8                // =8
               	strb	w5, [x2, #0xf]
               	sub	x5, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x5]
               	ldrb	w2, [x3, x0]
               	ldrb	w5, [x4, x0]
               	sdiv	x2, x2, x5
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x90
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x60
               	ldrsb	x4, [x1]
               	ldrsb	x5, [x2]
               	sdiv	x4, x4, x5
               	strb	w4, [x0]
               	ldrsb	x4, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	sdiv	x4, x4, x5
               	strb	w4, [x0, #0xf]
               	sub	x4, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	mov	x0, #0x0                // =0
               	ldrsb	x4, [x1, x0]
               	ldrsb	x5, [x2, x0]
               	sdiv	x4, x4, x5
               	strb	w4, [x3, x0]
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
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x68               // =104
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x67               // =103
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x5f               // =95
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x5e               // =94
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x5d               // =93
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x5c               // =92
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x5b               // =91
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x5a               // =90
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x59               // =89
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x58               // =88
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x57               // =87
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x56               // =86
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x55               // =85
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x54               // =84
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x53               // =83
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x52               // =82
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x51               // =81
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x50               // =80
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x4f               // =79
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x4e               // =78
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x4d               // =77
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x4c               // =76
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x4b               // =75
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x4a               // =74
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x49               // =73
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x60               // =96
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x48               // =72
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x66               // =102
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x65               // =101
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x64               // =100
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x63               // =99
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x62               // =98
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x61               // =97
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x47               // =71
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x46               // =70
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x45               // =69
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x44               // =68
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x43               // =67
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x42               // =66
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x41               // =65
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x40               // =64
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x3f               // =63
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x3e               // =62
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x3d               // =61
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x3c               // =60
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x3b               // =59
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x3a               // =58
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x39               // =57
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x38               // =56
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x37               // =55
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x36               // =54
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x35               // =53
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x34               // =52
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x33               // =51
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x32               // =50
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x31               // =49
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x30               // =48
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x2f               // =47
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x2e               // =46
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x2d               // =45
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x2c               // =44
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x2b               // =43
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x28               // =40
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x27               // =39
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x26               // =38
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x25               // =37
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x24               // =36
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x1c               // =28
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
