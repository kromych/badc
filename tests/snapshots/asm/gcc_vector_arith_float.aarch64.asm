
gcc_vector_arith_float.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x490
               	str	d8, [sp]
               	sub	x0, x29, #0x480
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x470
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x460
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x450
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x440
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x420
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [sp], #0x10
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	ldr	s3, [x1, #0x8]
               	fadd	s2, s2, s3
               	ldr	s3, [x0, #0xc]
               	ldr	s4, [x1, #0xc]
               	fadd	s3, s3, s4
               	sub	x3, x29, #0x400
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	add	x5, x1, #0x0
               	ldr	s1, [x5]
               	fadd	s0, s0, s1
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x480
               	sub	x1, x29, #0x470
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fsub	s0, s0, s1
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x1, #0x4]
               	fsub	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	ldr	s3, [x1, #0x8]
               	fsub	s2, s2, s3
               	ldr	s3, [x0, #0xc]
               	ldr	s4, [x1, #0xc]
               	fsub	s3, s3, s4
               	sub	x3, x29, #0x3f0
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	add	x5, x1, #0x0
               	ldr	s1, [x5]
               	fsub	s0, s0, s1
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fsub	s0, s0, s1
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fsub	s0, s0, s1
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fsub	s0, s0, s1
               	str	s0, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x480
               	sub	x1, x29, #0x470
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fmul	s0, s0, s1
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x1, #0x4]
               	fmul	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	ldr	s3, [x1, #0x8]
               	fmul	s2, s2, s3
               	ldr	s3, [x0, #0xc]
               	ldr	s4, [x1, #0xc]
               	fmul	s3, s3, s4
               	sub	x3, x29, #0x3e0
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	add	x5, x1, #0x0
               	ldr	s1, [x5]
               	fmul	s0, s0, s1
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x480
               	sub	x1, x29, #0x470
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fdiv	s0, s0, s1
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x1, #0x4]
               	fdiv	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	ldr	s3, [x1, #0x8]
               	fdiv	s2, s2, s3
               	ldr	s3, [x0, #0xc]
               	ldr	s4, [x1, #0xc]
               	fdiv	s3, s3, s4
               	sub	x3, x29, #0x3d0
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	add	x5, x1, #0x0
               	ldr	s1, [x5]
               	fdiv	s0, s0, s1
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fdiv	s0, s0, s1
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fdiv	s0, s0, s1
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fdiv	s0, s0, s1
               	str	s0, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x460
               	sub	x1, x29, #0x450
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fadd	d0, d0, d1
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x1, #0x8]
               	fadd	d1, d1, d2
               	sub	x3, x29, #0x3c0
               	str	d0, [x3]
               	str	d1, [x3, #0x8]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	d0, [x5]
               	add	x5, x1, #0x0
               	ldr	d1, [x5]
               	fadd	d0, d0, d1
               	str	d0, [x4]
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fadd	d0, d0, d1
               	str	d0, [x2, #0x8]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x460
               	sub	x1, x29, #0x450
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fsub	d0, d0, d1
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x1, #0x8]
               	fsub	d1, d1, d2
               	sub	x3, x29, #0x3b0
               	str	d0, [x3]
               	str	d1, [x3, #0x8]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	d0, [x5]
               	add	x5, x1, #0x0
               	ldr	d1, [x5]
               	fsub	d0, d0, d1
               	str	d0, [x4]
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fsub	d0, d0, d1
               	str	d0, [x2, #0x8]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x460
               	sub	x1, x29, #0x450
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fmul	d0, d0, d1
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x1, #0x8]
               	fmul	d1, d1, d2
               	sub	x3, x29, #0x3a0
               	str	d0, [x3]
               	str	d1, [x3, #0x8]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	d0, [x5]
               	add	x5, x1, #0x0
               	ldr	d1, [x5]
               	fmul	d0, d0, d1
               	str	d0, [x4]
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fmul	d0, d0, d1
               	str	d0, [x2, #0x8]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x460
               	sub	x1, x29, #0x450
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fdiv	d0, d0, d1
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x1, #0x8]
               	fdiv	d1, d1, d2
               	sub	x3, x29, #0x390
               	str	d0, [x3]
               	str	d1, [x3, #0x8]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	d0, [x5]
               	add	x5, x1, #0x0
               	ldr	d1, [x5]
               	fdiv	d0, d0, d1
               	str	d0, [x4]
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fdiv	d0, d0, d1
               	str	d0, [x2, #0x8]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x440
               	sub	x1, x29, #0x420
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x1, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	ldr	s3, [x1, #0x8]
               	fadd	s2, s2, s3
               	ldr	s3, [x0, #0xc]
               	ldr	s4, [x1, #0xc]
               	fadd	s3, s3, s4
               	ldr	s4, [x0, #0x10]
               	ldr	s5, [x1, #0x10]
               	fadd	s4, s4, s5
               	ldr	s5, [x0, #0x14]
               	ldr	s6, [x1, #0x14]
               	fadd	s5, s5, s6
               	ldr	s6, [x0, #0x18]
               	ldr	s7, [x1, #0x18]
               	fadd	s6, s6, s7
               	ldr	s7, [x0, #0x1c]
               	ldr	s8, [x1, #0x1c]
               	fadd	s7, s7, s8
               	sub	x3, x29, #0x380
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	str	s4, [x3, #0x10]
               	str	s5, [x3, #0x14]
               	str	s6, [x3, #0x18]
               	str	s7, [x3, #0x1c]
               	sub	x2, x29, #0x250
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	add	x5, x1, #0x0
               	ldr	s1, [x5]
               	fadd	s0, s0, s1
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0xc]
               	ldr	s0, [x0, #0x10]
               	ldr	s1, [x1, #0x10]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x10]
               	ldr	s0, [x0, #0x14]
               	ldr	s1, [x1, #0x14]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x14]
               	ldr	s0, [x0, #0x18]
               	ldr	s1, [x1, #0x18]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x18]
               	ldr	s0, [x0, #0x1c]
               	ldr	s1, [x1, #0x1c]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x1c]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x0, x29, #0x440
               	sub	x1, x29, #0x420
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fmul	s0, s0, s1
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x1, #0x4]
               	fmul	s1, s1, s2
               	ldr	s2, [x0, #0x8]
               	ldr	s3, [x1, #0x8]
               	fmul	s2, s2, s3
               	ldr	s3, [x0, #0xc]
               	ldr	s4, [x1, #0xc]
               	fmul	s3, s3, s4
               	ldr	s4, [x0, #0x10]
               	ldr	s5, [x1, #0x10]
               	fmul	s4, s4, s5
               	ldr	s5, [x0, #0x14]
               	ldr	s6, [x1, #0x14]
               	fmul	s5, s5, s6
               	ldr	s6, [x0, #0x18]
               	ldr	s7, [x1, #0x18]
               	fmul	s6, s6, s7
               	ldr	s7, [x0, #0x1c]
               	ldr	s8, [x1, #0x1c]
               	fmul	s7, s7, s8
               	sub	x3, x29, #0x360
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	str	s4, [x3, #0x10]
               	str	s5, [x3, #0x14]
               	str	s6, [x3, #0x18]
               	str	s7, [x3, #0x1c]
               	sub	x2, x29, #0x250
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	add	x5, x1, #0x0
               	ldr	s1, [x5]
               	fmul	s0, s0, s1
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0xc]
               	ldr	s0, [x0, #0x10]
               	ldr	s1, [x1, #0x10]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x10]
               	ldr	s0, [x0, #0x14]
               	ldr	s1, [x1, #0x14]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x14]
               	ldr	s0, [x0, #0x18]
               	ldr	s1, [x1, #0x18]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x18]
               	ldr	s0, [x0, #0x1c]
               	ldr	s1, [x1, #0x1c]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x1c]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x0, x29, #0x480
               	mov	x1, #0x40200000         // =1075838976
               	ldr	s0, [x0]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	ldr	s1, [x0, #0x4]
               	fmov	s17, w1
               	fmul	s1, s1, s17
               	ldr	s2, [x0, #0x8]
               	fmov	s17, w1
               	fmul	s2, s2, s17
               	ldr	s3, [x0, #0xc]
               	fmov	s17, w1
               	fmul	s3, s3, s17
               	sub	x3, x29, #0x340
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x480
               	mov	x1, #0x3                // =3
               	scvtf	s0, x1
               	ldr	s1, [x0]
               	fmul	s1, s1, s0
               	ldr	s2, [x0, #0x4]
               	fmul	s2, s2, s0
               	ldr	s3, [x0, #0x8]
               	fmul	s3, s3, s0
               	ldr	s4, [x0, #0xc]
               	fmul	s0, s4, s0
               	sub	x3, x29, #0x330
               	str	s1, [x3]
               	str	s2, [x3, #0x4]
               	str	s3, [x3, #0x8]
               	str	s0, [x3, #0xc]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x1, x0, #0x0
               	ldr	s0, [x1]
               	mov	x1, #0x40400000         // =1077936128
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x460
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	ldr	d0, [x0]
               	fmov	d17, x1
               	fdiv	d0, d0, d17
               	ldr	d1, [x0, #0x8]
               	fmov	d17, x1
               	fdiv	d1, d1, d17
               	sub	x3, x29, #0x320
               	str	d0, [x3]
               	str	d1, [x3, #0x8]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x5, x0, #0x0
               	ldr	d0, [x5]
               	fmov	d17, x1
               	fdiv	d0, d0, d17
               	str	d0, [x4]
               	ldr	d0, [x0, #0x8]
               	fmov	d17, x1
               	fdiv	d0, d0, d17
               	str	d0, [x2, #0x8]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x460
               	mov	x1, #0x3                // =3
               	scvtf	d0, x1
               	ldr	d1, [x0]
               	fadd	d1, d1, d0
               	ldr	d2, [x0, #0x8]
               	fadd	d0, d2, d0
               	sub	x3, x29, #0x310
               	str	d1, [x3]
               	str	d0, [x3, #0x8]
               	sub	x2, x29, #0x240
               	add	x4, x2, #0x0
               	add	x1, x0, #0x0
               	ldr	d0, [x1]
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x4]
               	ldr	d0, [x0, #0x8]
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x2, #0x8]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x480
               	sub	x0, x29, #0x470
               	ldr	s0, [x1]
               	ldr	s1, [x0]
               	fmul	s0, s0, s1
               	ldr	s1, [x1, #0x4]
               	ldr	s2, [x0, #0x4]
               	fmul	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	ldr	s3, [x0, #0x8]
               	fmul	s2, s2, s3
               	ldr	s3, [x1, #0xc]
               	ldr	s4, [x0, #0xc]
               	fmul	s3, s3, s4
               	sub	x3, x29, #0x300
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	sub	x2, x29, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	s0, [x2]
               	ldr	s1, [x0]
               	fmul	s0, s0, s1
               	ldr	s1, [x2, #0x4]
               	ldr	s2, [x0, #0x4]
               	fmul	s1, s1, s2
               	ldr	s2, [x2, #0x8]
               	ldr	s3, [x0, #0x8]
               	fmul	s2, s2, s3
               	ldr	s3, [x2, #0xc]
               	ldr	s4, [x0, #0xc]
               	fmul	s3, s3, s4
               	str	s0, [x2]
               	str	s1, [x2, #0x4]
               	str	s2, [x2, #0x8]
               	str	s3, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x480
               	sub	x0, x29, #0x470
               	ldr	s0, [x1]
               	ldr	s1, [x0]
               	fadd	s0, s0, s1
               	ldr	s1, [x1, #0x4]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x1, #0x8]
               	ldr	s3, [x0, #0x8]
               	fadd	s2, s2, s3
               	ldr	s3, [x1, #0xc]
               	ldr	s4, [x0, #0xc]
               	fadd	s3, s3, s4
               	sub	x3, x29, #0x2e0
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	sub	x2, x29, #0x2d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	s0, [x2]
               	ldr	s1, [x0]
               	fadd	s0, s0, s1
               	ldr	s1, [x2, #0x4]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x2, #0x8]
               	ldr	s3, [x0, #0x8]
               	fadd	s2, s2, s3
               	ldr	s3, [x2, #0xc]
               	ldr	s4, [x0, #0xc]
               	fadd	s3, s3, s4
               	str	s0, [x2]
               	str	s1, [x2, #0x4]
               	str	s2, [x2, #0x8]
               	str	s3, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x460
               	sub	x0, x29, #0x450
               	ldr	d0, [x1]
               	ldr	d1, [x0]
               	fdiv	d0, d0, d1
               	ldr	d1, [x1, #0x8]
               	ldr	d2, [x0, #0x8]
               	fdiv	d1, d1, d2
               	sub	x3, x29, #0x2c0
               	str	d0, [x3]
               	str	d1, [x3, #0x8]
               	sub	x2, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x2]
               	ldr	d1, [x0]
               	fdiv	d0, d0, d1
               	ldr	d1, [x2, #0x8]
               	ldr	d2, [x0, #0x8]
               	fdiv	d1, d1, d2
               	str	d0, [x2]
               	str	d1, [x2, #0x8]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x480
               	sub	x2, x29, #0x2a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x40000000         // =1073741824
               	ldr	s0, [x2]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	ldr	s1, [x2, #0x4]
               	fmov	s17, w1
               	fmul	s1, s1, s17
               	ldr	s2, [x2, #0x8]
               	fmov	s17, w1
               	fmul	s2, s2, s17
               	ldr	s3, [x2, #0xc]
               	fmov	s17, w1
               	fmul	s3, s3, s17
               	str	s0, [x2]
               	str	s1, [x2, #0x4]
               	str	s2, [x2, #0x8]
               	str	s3, [x2, #0xc]
               	ldr	s0, [x0]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	ldr	s1, [x0, #0x4]
               	fmov	s17, w1
               	fmul	s1, s1, s17
               	ldr	s2, [x0, #0x8]
               	fmov	s17, w1
               	fmul	s2, s2, s17
               	ldr	s3, [x0, #0xc]
               	fmov	s17, w1
               	fmul	s3, s3, s17
               	sub	x3, x29, #0x290
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x480
               	ldr	s0, [x0]
               	fneg	s0, s0
               	ldr	s1, [x0, #0x4]
               	fneg	s1, s1
               	ldr	s2, [x0, #0x8]
               	fneg	s2, s2
               	ldr	s3, [x0, #0xc]
               	fneg	s3, s3
               	sub	x3, x29, #0x280
               	str	s0, [x3]
               	str	s1, [x3, #0x4]
               	str	s2, [x3, #0x8]
               	str	s3, [x3, #0xc]
               	sub	x2, x29, #0x240
               	add	x1, x2, #0x0
               	add	x4, x0, #0x0
               	ldr	s0, [x4]
               	fneg	s0, s0
               	str	s0, [x1]
               	ldr	s0, [x0, #0x4]
               	fneg	s0, s0
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	fneg	s0, s0
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	fneg	s0, s0
               	str	s0, [x2, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x280
               	ldrb	w0, [x0, #0xf]
               	eor	x0, x0, #0x80
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x460
               	ldr	d0, [x0]
               	fneg	d0, d0
               	ldr	d1, [x0, #0x8]
               	fneg	d1, d1
               	sub	x2, x29, #0x270
               	str	d0, [x2]
               	str	d1, [x2, #0x8]
               	sub	x4, x29, #0x240
               	add	x1, x4, #0x0
               	add	x3, x0, #0x0
               	ldr	d0, [x3]
               	fneg	d0, d0
               	str	d0, [x1]
               	ldr	d0, [x0, #0x8]
               	fneg	d0, d0
               	str	d0, [x4, #0x8]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	add	x5, x4, x1
               	ldrb	w5, [x5]
               	cmp	w3, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x480
               	sub	x7, x29, #0x470
               	ldr	s0, [x3]
               	ldr	s1, [x7]
               	fadd	s0, s0, s1
               	ldr	s1, [x3, #0x4]
               	ldr	s2, [x7, #0x4]
               	fadd	s1, s1, s2
               	ldr	s2, [x3, #0x8]
               	ldr	s3, [x7, #0x8]
               	fadd	s2, s2, s3
               	ldr	s3, [x3, #0xc]
               	ldr	s4, [x7, #0xc]
               	fadd	s3, s3, s4
               	mov	x2, #0x40000000         // =1073741824
               	ldr	s4, [x3]
               	fmov	s17, w2
               	fnmsub	s0, s0, s17, s4
               	ldr	s4, [x3, #0x4]
               	fmov	s17, w2
               	fnmsub	s1, s1, s17, s4
               	ldr	s4, [x3, #0x8]
               	fmov	s17, w2
               	fnmsub	s2, s2, s17, s4
               	ldr	s4, [x3, #0xc]
               	fmov	s17, w2
               	fnmsub	s3, s3, s17, s4
               	sub	x0, x29, #0x260
               	str	s0, [x0]
               	str	s1, [x0, #0x4]
               	str	s2, [x0, #0x8]
               	str	s3, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x5, w0
               	lsl	x1, x5, #2
               	add	x8, x4, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x7, x1
               	ldr	s1, [x1]
               	fadd	s1, s0, s1
               	fmov	s17, w2
               	fnmsub	s0, s1, s17, s0
               	str	s0, [x8]
               	add	x0, x5, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x260
               	sub	x3, x29, #0x240
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	d8, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
