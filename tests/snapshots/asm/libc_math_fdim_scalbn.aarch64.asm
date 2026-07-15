
libc_math_fdim_scalbn.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x0, w0
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<scalbln>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x0, w0
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<scalbnf>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x0, w0
               	fcvt	d0, s0
               	bl	<addr>
               	fcvt	s0, d0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x3, gt
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	fmov	d16, x2
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	fmov	d16, x1
               	fmov	d17, x2
               	fsub	d0, d16, d17
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x3, gt
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	fmov	d16, x2
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	fmov	d16, x1
               	fmov	d17, x2
               	fsub	d0, d16, d17
               	sub	x17, x29, #0x40
               	str	d0, [x17]
               	sub	x16, x29, #0x40
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x2, gt
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fsub	d0, d16, d17
               	sub	x17, x29, #0x58
               	str	d0, [x17]
               	sub	x16, x29, #0x58
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x3                // =3
               	fmov	d0, x0
               	mov	x0, x1
               	bl	<addr>
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	fmov	d0, x0
               	mov	x0, x1
               	bl	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4                // =4
               	fmov	d0, x0
               	mov	x0, x1
               	bl	<addr>
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f800000         // =1065353216
               	mov	x1, #0x2                // =2
               	fmov	d0, x0
               	mov	x0, x1
               	bl	<addr>
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	mov	x1, #0x40400000         // =1077936128
               	fmov	s16, w0
               	fcvt	d0, s16
               	fmov	s16, w1
               	fcvt	d1, s16
               	fcmp	d0, d1
               	cset	x1, gt
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	fcmp	d0, d0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	fcmp	d1, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	fsub	d0, d0, d1
               	sub	x17, x29, #0x70
               	str	d0, [x17]
               	sub	x16, x29, #0x70
               	ldr	d0, [x16]
               	fcvt	s0, d0
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x70
               	str	d16, [x17]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x58
               	str	d16, [x17]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x40
               	str	d16, [x17]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	b	<addr>
               	b	<addr>
               	b	<addr>
