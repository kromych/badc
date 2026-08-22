
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
               	sub	sp, sp, #0xd0
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0xc0
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fadd	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xb0
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	s0, [x3]
               	add	x3, x1, #0x0
               	ldr	s1, [x3]
               	fadd	s0, s0, s1
               	str	s0, [x2]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x4]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x8]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0xc]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fsub	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fsub	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fsub	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fsub	s0, s0, s1
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xb0
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	s0, [x3]
               	add	x3, x1, #0x0
               	ldr	s1, [x3]
               	fsub	s0, s0, s1
               	str	s0, [x2]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fsub	s0, s0, s1
               	str	s0, [x2, #0x4]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fsub	s0, s0, s1
               	str	s0, [x2, #0x8]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fsub	s0, s0, s1
               	str	s0, [x2, #0xc]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fmul	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xb0
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	s0, [x3]
               	add	x3, x1, #0x0
               	ldr	s1, [x3]
               	fmul	s0, s0, s1
               	str	s0, [x2]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x4]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x8]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0xc]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fdiv	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fdiv	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fdiv	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fdiv	s0, s0, s1
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xb0
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	s0, [x3]
               	add	x3, x1, #0x0
               	ldr	s1, [x3]
               	fdiv	s0, s0, s1
               	str	s0, [x2]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fdiv	s0, s0, s1
               	str	s0, [x2, #0x4]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fdiv	s0, s0, s1
               	str	s0, [x2, #0x8]
               	sub	x2, x29, #0x10
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fdiv	s0, s0, s1
               	str	s0, [x2, #0xc]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	sub	x2, x29, #0x90
               	sub	x0, x29, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x1, #0x8]
               	ldr	d1, [x2, #0x8]
               	fadd	d0, d0, d1
               	str	d0, [x0, #0x8]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	d0, [x3]
               	add	x3, x1, #0x0
               	ldr	d1, [x3]
               	fadd	d0, d0, d1
               	str	d0, [x2]
               	sub	x2, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fadd	d0, d0, d1
               	str	d0, [x2, #0x8]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	sub	x2, x29, #0x90
               	sub	x0, x29, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	fsub	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x1, #0x8]
               	ldr	d1, [x2, #0x8]
               	fsub	d0, d0, d1
               	str	d0, [x0, #0x8]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	d0, [x3]
               	add	x3, x1, #0x0
               	ldr	d1, [x3]
               	fsub	d0, d0, d1
               	str	d0, [x2]
               	sub	x2, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fsub	d0, d0, d1
               	str	d0, [x2, #0x8]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	sub	x2, x29, #0x90
               	sub	x0, x29, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	fmul	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x1, #0x8]
               	ldr	d1, [x2, #0x8]
               	fmul	d0, d0, d1
               	str	d0, [x0, #0x8]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	d0, [x3]
               	add	x3, x1, #0x0
               	ldr	d1, [x3]
               	fmul	d0, d0, d1
               	str	d0, [x2]
               	sub	x2, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fmul	d0, d0, d1
               	str	d0, [x2, #0x8]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	sub	x2, x29, #0x90
               	sub	x0, x29, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	fdiv	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x1, #0x8]
               	ldr	d1, [x2, #0x8]
               	fdiv	d0, d0, d1
               	str	d0, [x0, #0x8]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	d0, [x3]
               	add	x3, x1, #0x0
               	ldr	d1, [x3]
               	fdiv	d0, d0, d1
               	str	d0, [x2]
               	sub	x2, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	ldr	d1, [x1, #0x8]
               	fdiv	d0, d0, d1
               	str	d0, [x2, #0x8]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x60
               	sub	x0, x29, #0x20
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fadd	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0xc]
               	ldr	s0, [x1, #0x10]
               	ldr	s1, [x2, #0x10]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x10]
               	ldr	s0, [x1, #0x14]
               	ldr	s1, [x2, #0x14]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x14]
               	ldr	s0, [x1, #0x18]
               	ldr	s1, [x2, #0x18]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x18]
               	ldr	s0, [x1, #0x1c]
               	ldr	s1, [x2, #0x1c]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x1c]
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x20
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	s0, [x3]
               	add	x3, x1, #0x0
               	ldr	s1, [x3]
               	fadd	s0, s0, s1
               	str	s0, [x2]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x4]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x8]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0xc]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x10]
               	ldr	s1, [x1, #0x10]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x10]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x14]
               	ldr	s1, [x1, #0x14]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x14]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x18]
               	ldr	s1, [x1, #0x18]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x18]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x1c]
               	ldr	s1, [x1, #0x1c]
               	fadd	s0, s0, s1
               	str	s0, [x2, #0x1c]
               	sub	x2, x29, #0x40
               	sub	x3, x29, #0x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x20
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x60
               	sub	x0, x29, #0x20
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fmul	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0xc]
               	ldr	s0, [x1, #0x10]
               	ldr	s1, [x2, #0x10]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x10]
               	ldr	s0, [x1, #0x14]
               	ldr	s1, [x2, #0x14]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x14]
               	ldr	s0, [x1, #0x18]
               	ldr	s1, [x2, #0x18]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x18]
               	ldr	s0, [x1, #0x1c]
               	ldr	s1, [x2, #0x1c]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x1c]
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x20
               	add	x2, x2, #0x0
               	add	x3, x0, #0x0
               	ldr	s0, [x3]
               	add	x3, x1, #0x0
               	ldr	s1, [x3]
               	fmul	s0, s0, s1
               	str	s0, [x2]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x4]
               	ldr	s1, [x1, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x4]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x8]
               	ldr	s1, [x1, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x8]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0xc]
               	ldr	s1, [x1, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0xc]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x10]
               	ldr	s1, [x1, #0x10]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x10]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x14]
               	ldr	s1, [x1, #0x14]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x14]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x18]
               	ldr	s1, [x1, #0x18]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x18]
               	sub	x2, x29, #0x20
               	ldr	s0, [x0, #0x1c]
               	ldr	s1, [x1, #0x1c]
               	fmul	s0, s0, s1
               	str	s0, [x2, #0x1c]
               	sub	x2, x29, #0x40
               	sub	x3, x29, #0x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x20
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	mov	x2, #0x40200000         // =1075838976
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x0
               	add	x2, x0, #0x0
               	ldr	s0, [x2]
               	mov	x2, #0x40200000         // =1075838976
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x1]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0x4]
               	mov	x2, #0x40200000         // =1075838976
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x1, #0x4]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	mov	x2, #0x40200000         // =1075838976
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x1, #0x8]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0xc]
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1, #0xc]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	mov	x0, #0x3                // =3
               	scvtf	s0, x0
               	sub	x0, x29, #0x10
               	ldr	s1, [x1]
               	fmul	s1, s1, s0
               	str	s1, [x0]
               	ldr	s1, [x1, #0x4]
               	fmul	s1, s1, s0
               	str	s1, [x0, #0x4]
               	ldr	s1, [x1, #0x8]
               	fmul	s1, s1, s0
               	str	s1, [x0, #0x8]
               	ldr	s1, [x1, #0xc]
               	fmul	s0, s1, s0
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x0
               	add	x2, x0, #0x0
               	ldr	s0, [x2]
               	mov	x2, #0x40400000         // =1077936128
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x1]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0x4]
               	mov	x2, #0x40400000         // =1077936128
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x1, #0x4]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	mov	x2, #0x40400000         // =1077936128
               	fmov	s17, w2
               	fmul	s0, s0, s17
               	str	s0, [x1, #0x8]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0xc]
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1, #0xc]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	sub	x0, x29, #0x10
               	ldr	d0, [x1]
               	fmov	d17, x2
               	fdiv	d0, d0, d17
               	str	d0, [x0]
               	ldr	d0, [x1, #0x8]
               	fmov	d17, x2
               	fdiv	d0, d0, d17
               	str	d0, [x0, #0x8]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x0
               	add	x2, x0, #0x0
               	ldr	d0, [x2]
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x2
               	fdiv	d0, d0, d17
               	str	d0, [x1]
               	sub	x1, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	str	d0, [x1, #0x8]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	mov	x0, #0x3                // =3
               	scvtf	d0, x0
               	sub	x0, x29, #0x10
               	ldr	d1, [x1]
               	fadd	d1, d1, d0
               	str	d1, [x0]
               	ldr	d1, [x1, #0x8]
               	fadd	d0, d1, d0
               	str	d0, [x0, #0x8]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x0
               	add	x2, x0, #0x0
               	ldr	d0, [x2]
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x2
               	fadd	d0, d0, d17
               	str	d0, [x1]
               	sub	x1, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	str	d0, [x1, #0x8]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fmul	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x30
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fmul	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fmul	s0, s0, s1
               	str	s0, [x0, #0xc]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x50
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fadd	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x30
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fadd	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0xc]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x50
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	sub	x2, x29, #0x90
               	sub	x0, x29, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	fdiv	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x1, #0x8]
               	ldr	d1, [x2, #0x8]
               	fdiv	d0, d0, d1
               	str	d0, [x0, #0x8]
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x30
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x90
               	sub	x0, x29, #0x10
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	fdiv	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x1, #0x8]
               	ldr	d1, [x2, #0x8]
               	fdiv	d0, d0, d1
               	str	d0, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x50
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x50
               	sub	x2, x29, #0x50
               	mov	x0, #0x40000000         // =1073741824
               	sub	x1, x29, #0x10
               	ldr	s0, [x2]
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1]
               	ldr	s0, [x2, #0x4]
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1, #0x4]
               	ldr	s0, [x2, #0x8]
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1, #0x8]
               	ldr	s0, [x2, #0xc]
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1, #0xc]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	sub	x2, x29, #0xc0
               	sub	x1, x29, #0x10
               	ldr	s0, [x2]
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1]
               	ldr	s0, [x2, #0x4]
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1, #0x4]
               	ldr	s0, [x2, #0x8]
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1, #0x8]
               	ldr	s0, [x2, #0xc]
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	str	s0, [x1, #0xc]
               	sub	x0, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x50
               	sub	x3, x29, #0x30
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	sub	x0, x29, #0x10
               	ldr	s0, [x1]
               	fneg	s0, s0
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	fneg	s0, s0
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	fneg	s0, s0
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	fneg	s0, s0
               	str	s0, [x0, #0xc]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x0
               	add	x2, x0, #0x0
               	ldr	s0, [x2]
               	fneg	s0, s0
               	str	s0, [x1]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0x4]
               	fneg	s0, s0
               	str	s0, [x1, #0x4]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	fneg	s0, s0
               	str	s0, [x1, #0x8]
               	sub	x1, x29, #0x10
               	ldr	s0, [x0, #0xc]
               	fneg	s0, s0
               	str	s0, [x1, #0xc]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x80              // =128
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	sub	x0, x29, #0x10
               	ldr	d0, [x1]
               	fneg	d0, d0
               	str	d0, [x0]
               	ldr	d0, [x1, #0x8]
               	fneg	d0, d0
               	str	d0, [x0, #0x8]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x0
               	add	x2, x0, #0x0
               	ldr	d0, [x2]
               	fneg	d0, d0
               	str	d0, [x1]
               	sub	x1, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	fneg	d0, d0
               	str	d0, [x1, #0x8]
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xb0
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
               	mov	x0, #0x40000000         // =1073741824
               	sub	x2, x29, #0xc0
               	sub	x1, x29, #0x10
               	ldr	s4, [x2]
               	fmov	s17, w0
               	fnmsub	s0, s0, s17, s4
               	str	s0, [x1]
               	ldr	s0, [x2, #0x4]
               	fmov	s17, w0
               	fnmsub	s0, s1, s17, s0
               	str	s0, [x1, #0x4]
               	ldr	s0, [x2, #0x8]
               	fmov	s17, w0
               	fnmsub	s0, s2, s17, s0
               	str	s0, [x1, #0x8]
               	ldr	s0, [x2, #0xc]
               	fmov	s17, w0
               	fnmsub	s0, s3, s17, s0
               	str	s0, [x1, #0xc]
               	sub	x0, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0xc0
               	sub	x5, x29, #0xb0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x10
               	lsl	x2, x1, #2
               	add	x6, x3, x2
               	add	x3, x4, x2
               	ldr	s0, [x3]
               	add	x2, x5, x2
               	ldr	s1, [x2]
               	fadd	s1, s0, s1
               	mov	x2, #0x40000000         // =1073741824
               	fmov	s17, w2
               	fnmsub	s0, s1, s17, s0
               	str	s0, [x6]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xd0
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
