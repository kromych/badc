
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
               	sub	x0, x29, #0x490
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x480
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	sub	x2, x29, #0x470
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
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
               	ldr	x10, [x3, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x430
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
               	sub	x2, x29, #0x240
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fadd	s0, s0, s1
               	str	s0, [x2]
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
               	sub	x3, x29, #0x410
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x490
               	sub	x1, x29, #0x480
               	sub	x2, x29, #0x240
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fsub	s0, s0, s1
               	str	s0, [x2]
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
               	sub	x3, x29, #0x400
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x490
               	sub	x1, x29, #0x480
               	sub	x2, x29, #0x240
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fmul	s0, s0, s1
               	str	s0, [x2]
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
               	sub	x3, x29, #0x3f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x490
               	sub	x1, x29, #0x480
               	sub	x2, x29, #0x240
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	fdiv	s0, s0, s1
               	str	s0, [x2]
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
               	sub	x3, x29, #0x3e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	sub	x1, x29, #0x460
               	sub	x2, x29, #0x240
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fadd	d0, d0, d1
               	str	d0, [x2]
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fadd	d0, d0, d1
               	str	d0, [x2, #0x8]
               	sub	x3, x29, #0x3d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	sub	x1, x29, #0x460
               	sub	x2, x29, #0x240
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fsub	d0, d0, d1
               	str	d0, [x2]
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fsub	d0, d0, d1
               	str	d0, [x2, #0x8]
               	sub	x3, x29, #0x3c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	sub	x1, x29, #0x460
               	sub	x2, x29, #0x240
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fmul	d0, d0, d1
               	str	d0, [x2]
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fmul	d0, d0, d1
               	str	d0, [x2, #0x8]
               	sub	x3, x29, #0x3b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	sub	x1, x29, #0x460
               	sub	x2, x29, #0x240
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fdiv	d0, d0, d1
               	str	d0, [x2]
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fdiv	d0, d0, d1
               	str	d0, [x2, #0x8]
               	sub	x3, x29, #0x3a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x450
               	sub	x2, x29, #0x430
               	sub	x1, x29, #0x250
               	ldr	s0, [x0]
               	ldr	s1, [x2]
               	fadd	s0, s0, s1
               	str	s0, [x1]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x2, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x2, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x2, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0xc]
               	ldr	s0, [x0, #0x10]
               	ldr	s1, [x2, #0x10]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x10]
               	ldr	s0, [x0, #0x14]
               	ldr	s1, [x2, #0x14]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x14]
               	ldr	s0, [x0, #0x18]
               	ldr	s1, [x2, #0x18]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x18]
               	ldr	s0, [x0, #0x1c]
               	ldr	s1, [x2, #0x1c]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x1c]
               	sub	x3, x29, #0x390
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x3, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
               	add	x4, x1, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	add	x5, x2, #0x0
               	ldr	s1, [x5]
               	fadd	s0, s0, s1
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x2, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x2, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x2, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0xc]
               	ldr	s0, [x0, #0x10]
               	ldr	s1, [x2, #0x10]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x10]
               	ldr	s0, [x0, #0x14]
               	ldr	s1, [x2, #0x14]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x14]
               	ldr	s0, [x0, #0x18]
               	ldr	s1, [x2, #0x18]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x18]
               	ldr	s0, [x0, #0x1c]
               	ldr	s1, [x2, #0x1c]
               	fadd	s0, s0, s1
               	str	s0, [x1, #0x1c]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	add	x4, x3, x2
               	ldrb	w4, [x4]
               	add	x5, x1, x2
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x450
               	sub	x2, x29, #0x430
               	sub	x1, x29, #0x250
               	ldr	s0, [x0]
               	ldr	s1, [x2]
               	fmul	s0, s0, s1
               	str	s0, [x1]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x2, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x2, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x2, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0xc]
               	ldr	s0, [x0, #0x10]
               	ldr	s1, [x2, #0x10]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x10]
               	ldr	s0, [x0, #0x14]
               	ldr	s1, [x2, #0x14]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x14]
               	ldr	s0, [x0, #0x18]
               	ldr	s1, [x2, #0x18]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x18]
               	ldr	s0, [x0, #0x1c]
               	ldr	s1, [x2, #0x1c]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x1c]
               	sub	x3, x29, #0x370
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x3, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
               	add	x4, x1, #0x0
               	add	x5, x0, #0x0
               	ldr	s0, [x5]
               	add	x5, x2, #0x0
               	ldr	s1, [x5]
               	fmul	s0, s0, s1
               	str	s0, [x4]
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x2, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x4]
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x2, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x8]
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x2, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0xc]
               	ldr	s0, [x0, #0x10]
               	ldr	s1, [x2, #0x10]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x10]
               	ldr	s0, [x0, #0x14]
               	ldr	s1, [x2, #0x14]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x14]
               	ldr	s0, [x0, #0x18]
               	ldr	s1, [x2, #0x18]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x18]
               	ldr	s0, [x0, #0x1c]
               	ldr	s1, [x2, #0x1c]
               	fmul	s0, s0, s1
               	str	s0, [x1, #0x1c]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	add	x4, x3, x2
               	ldrb	w4, [x4]
               	add	x5, x1, x2
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x490
               	mov	x1, #0x40200000         // =1075838976
               	sub	x2, x29, #0x240
               	ldr	s0, [x0]
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	str	s0, [x2]
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
               	sub	x3, x29, #0x350
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x490
               	mov	x1, #0x3                // =3
               	scvtf	s0, x1
               	sub	x2, x29, #0x240
               	ldr	s1, [x0]
               	fmul	s1, s1, s0
               	str	s1, [x2]
               	ldr	s1, [x0, #0x4]
               	fmul	s1, s1, s0
               	str	s1, [x2, #0x4]
               	ldr	s1, [x0, #0x8]
               	fmul	s1, s1, s0
               	str	s1, [x2, #0x8]
               	ldr	s1, [x0, #0xc]
               	fmul	s0, s1, s0
               	str	s0, [x2, #0xc]
               	sub	x3, x29, #0x340
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	sub	x2, x29, #0x240
               	ldr	d0, [x0]
               	fmov	d17, x1
               	fdiv	d0, d0, d17
               	str	d0, [x2]
               	ldr	d0, [x0, #0x8]
               	fmov	d17, x1
               	fdiv	d0, d0, d17
               	str	d0, [x2, #0x8]
               	sub	x3, x29, #0x330
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	mov	x1, #0x3                // =3
               	scvtf	d0, x1
               	sub	x2, x29, #0x240
               	ldr	d1, [x0]
               	fadd	d1, d1, d0
               	str	d1, [x2]
               	ldr	d1, [x0, #0x8]
               	fadd	d0, d1, d0
               	str	d0, [x2, #0x8]
               	sub	x3, x29, #0x320
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x490
               	sub	x1, x29, #0x480
               	sub	x0, x29, #0x240
               	ldr	s0, [x4]
               	ldr	s1, [x1]
               	fmul	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x4, #0x4]
               	ldr	s1, [x1, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x4, #0x8]
               	ldr	s1, [x1, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x4, #0xc]
               	ldr	s1, [x1, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0xc]
               	sub	x3, x29, #0x310
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	sub	x2, x29, #0x300
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x2]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x2
               	ldr	s0, [x2]
               	ldr	s1, [x1]
               	fmul	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x2, #0x4]
               	ldr	s1, [x1, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x2, #0x8]
               	ldr	s1, [x1, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x2, #0xc]
               	ldr	s1, [x1, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0xc]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x490
               	sub	x1, x29, #0x480
               	sub	x0, x29, #0x240
               	ldr	s0, [x4]
               	ldr	s1, [x1]
               	fadd	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x4, #0x4]
               	ldr	s1, [x1, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x4, #0x8]
               	ldr	s1, [x1, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x4, #0xc]
               	ldr	s1, [x1, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0xc]
               	sub	x3, x29, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	sub	x2, x29, #0x2e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x2]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x2
               	ldr	s0, [x2]
               	ldr	s1, [x1]
               	fadd	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x2, #0x4]
               	ldr	s1, [x1, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x2, #0x8]
               	ldr	s1, [x1, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x2, #0xc]
               	ldr	s1, [x1, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0xc]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x470
               	sub	x1, x29, #0x460
               	sub	x0, x29, #0x240
               	ldr	d0, [x4]
               	ldr	d1, [x1]
               	fdiv	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x4, #0x8]
               	ldr	d1, [x1, #0x8]
               	fdiv	d0, d0, d1
               	str	d0, [x0, #0x8]
               	sub	x3, x29, #0x2d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	sub	x2, x29, #0x2c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x2]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x2
               	ldr	d0, [x2]
               	ldr	d1, [x1]
               	fdiv	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x2, #0x8]
               	ldr	d1, [x1, #0x8]
               	fdiv	d0, d0, d1
               	str	d0, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x490
               	sub	x2, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x3, #0x40000000         // =1073741824
               	sub	x0, x29, #0x240
               	ldr	s0, [x2]
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x0]
               	ldr	s0, [x2, #0x4]
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x0, #0x4]
               	ldr	s0, [x2, #0x8]
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x0, #0x8]
               	ldr	s0, [x2, #0xc]
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x0, #0xc]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x2
               	ldr	s0, [x1]
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x0, #0xc]
               	sub	x3, x29, #0x2a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x490
               	sub	x2, x29, #0x240
               	ldr	s0, [x0]
               	fneg	s0, s0
               	str	s0, [x2]
               	ldr	s0, [x0, #0x4]
               	fneg	s0, s0
               	str	s0, [x2, #0x4]
               	ldr	s0, [x0, #0x8]
               	fneg	s0, s0
               	str	s0, [x2, #0x8]
               	ldr	s0, [x0, #0xc]
               	fneg	s0, s0
               	str	s0, [x2, #0xc]
               	sub	x3, x29, #0x290
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x290
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x80              // =128
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	sub	x2, x29, #0x240
               	ldr	d0, [x0]
               	fneg	d0, d0
               	str	d0, [x2]
               	ldr	d0, [x0, #0x8]
               	fneg	d0, d0
               	str	d0, [x2, #0x8]
               	sub	x3, x29, #0x280
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	add	x1, x2, #0x0
               	add	x4, x0, #0x0
               	ldr	d0, [x4]
               	fneg	d0, d0
               	str	d0, [x1]
               	ldr	d0, [x0, #0x8]
               	fneg	d0, d0
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x490
               	sub	x7, x29, #0x480
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
               	sub	x6, x29, #0x240
               	ldr	s4, [x3]
               	fmov	s17, w2
               	fnmsub	s0, s0, s17, s4
               	str	s0, [x6]
               	ldr	s0, [x3, #0x4]
               	fmov	s17, w2
               	fnmsub	s0, s1, s17, s0
               	str	s0, [x6, #0x4]
               	ldr	s0, [x3, #0x8]
               	fmov	s17, w2
               	fnmsub	s0, s2, s17, s0
               	str	s0, [x6, #0x8]
               	ldr	s0, [x3, #0xc]
               	fmov	s17, w2
               	fnmsub	s0, s3, s17, s0
               	str	s0, [x6, #0xc]
               	sub	x0, x29, #0x270
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x6]
               	str	x10, [x0]
               	ldr	x10, [x6, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x4, w0
               	lsl	x1, x4, #2
               	add	x8, x6, x1
               	add	x5, x3, x1
               	ldr	s0, [x5]
               	add	x1, x7, x1
               	ldr	s1, [x1]
               	fadd	s1, s0, s1
               	fmov	s17, w2
               	fnmsub	s0, s1, s17, s0
               	str	s0, [x8]
               	add	x0, x4, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x270
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
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
