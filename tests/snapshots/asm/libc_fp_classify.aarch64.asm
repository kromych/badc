
libc_fp_classify.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x8
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	b	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<signbit>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	lsr	x0, x0, #63
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<copysign>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x10
               	str	d1, [x0]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x8
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x1, x1, x17
               	sub	x2, x29, #0x10
               	ldr	x2, [x2]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	and	x2, x2, x17
               	orr	x1, x1, x2
               	str	x1, [x0]
               	sub	x0, x29, #0x8
               	ldr	d0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<copysignf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	fcvt	d0, s0
               	fcvt	d1, s1
               	bl	<addr>
               	fcvt	s0, d0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fneg	d0, d16
               	fmov	d1, d0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d16, x20
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x20
               	fneg	d0, d16
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d1, x0
               	bl	<addr>
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x0
               	fneg	d1, d16
               	fcvt	s1, d1
               	bl	<addr>
               	fmov	d16, x20
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fneg	d0, d16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fneg	d0, d16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8a0             // =51360
               	movk	x0, #0x85eb, lsl #16
               	movk	x0, #0xccf3, lsl #32
               	movk	x0, #0x7fe1, lsl #48
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe62b             // =58923
               	movk	x0, #0x8b70, lsl #16
               	movk	x0, #0x1268, lsl #32
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
