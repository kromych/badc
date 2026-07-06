
hfa_struct_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mkd2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	str	d0, [x0]
               	sub	x0, x29, #0x10
               	str	d1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	d0, [x16]
               	ldr	d1, [x16, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mkd3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	str	d0, [x0]
               	sub	x0, x29, #0x18
               	str	d1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	str	d2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	ldr	d0, [x16]
               	ldr	d1, [x16, #0x8]
               	ldr	d2, [x16, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<mkd4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	str	d0, [x0]
               	sub	x0, x29, #0x20
               	str	d1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	str	d2, [x0, #0x10]
               	sub	x0, x29, #0x20
               	str	d3, [x0, #0x18]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	d0, [x16]
               	ldr	d1, [x16, #0x8]
               	ldr	d2, [x16, #0x10]
               	ldr	d3, [x16, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<mkf2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	str	s0, [x0]
               	sub	x0, x29, #0x18
               	str	s1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	ldr	s0, [x16]
               	ldr	s1, [x16, #0x4]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<sumd2>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	d0, [x0]
               	sub	x0, x29, #0x10
               	ldr	d1, [x0, #0x8]
               	fadd	d0, d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<sumd4>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	str	d3, [x16, #0x18]
               	sub	x0, x29, #0x20
               	ldr	d0, [x0]
               	sub	x0, x29, #0x20
               	ldr	d1, [x0, #0x8]
               	fadd	d0, d0, d1
               	sub	x0, x29, #0x20
               	ldr	d1, [x0, #0x10]
               	fadd	d0, d0, d1
               	sub	x0, x29, #0x20
               	ldr	d1, [x0, #0x18]
               	fadd	d0, d0, d1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<sumf4>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	s0, [x16]
               	str	s1, [x16, #0x4]
               	str	s2, [x16, #0x8]
               	str	s3, [x16, #0xc]
               	sub	x0, x29, #0x10
               	ldr	s0, [x0]
               	sub	x0, x29, #0x10
               	ldr	s1, [x0, #0x4]
               	fadd	s0, s0, s1
               	sub	x0, x29, #0x10
               	ldr	s1, [x0, #0x8]
               	fadd	s0, s0, s1
               	sub	x0, x29, #0x10
               	ldr	s1, [x0, #0xc]
               	fadd	s0, s0, s1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x170
               	str	x20, [sp]
               	mov	x20, #0x401c000000000000 // =4619567317775286272
               	fmov	d0, x20
               	bl	<addr>
               	sub	x16, x29, #0xd0
               	str	d0, [x16]
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x8
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3fd0000000000000 // =4598175219545276416
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x20
               	fmov	d1, x1
               	bl	<addr>
               	sub	x16, x29, #0xe0
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x20
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x20
               	fmov	d1, x1
               	fmov	d2, x2
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x48
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x48
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x48
               	ldr	d0, [x0, #0x10]
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4024000000000000 // =4621819117588971520
               	mov	x1, #0x4034000000000000 // =4626322717216342016
               	mov	x2, #0x403e000000000000 // =4629137466983448576
               	mov	x3, #0x4044000000000000 // =4630826316843712512
               	fmov	d0, x20
               	fmov	d1, x1
               	fmov	d2, x2
               	fmov	d3, x3
               	bl	<addr>
               	sub	x16, x29, #0x130
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	str	d3, [x16, #0x18]
               	sub	x0, x29, #0x130
               	sub	x1, x29, #0x80
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
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x4034000000000000 // =4626322717216342016
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x80
               	ldr	d0, [x0, #0x10]
               	mov	x0, #0x403e000000000000 // =4629137466983448576
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	ldr	d0, [x0, #0x18]
               	mov	x0, #0x4044000000000000 // =4630826316843712512
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3fc00000        // =1069547520
               	mov	x1, #0x40200000         // =1075838976
               	fmov	d0, x20
               	fmov	d1, x1
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	s0, [x16]
               	str	s1, [x16, #0x4]
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa8
               	ldr	s0, [x0]
               	fmov	s17, w20
               	fcmp	s0, s17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	ldr	s0, [x0, #0x4]
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	bl	<addr>
               	mov	x0, #0x3fe8000000000000 // =4604930618986332160
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	bl	<addr>
               	mov	x0, #0x4059000000000000 // =4636737291354636288
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	ldr	s0, [x0]
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x0, #0x8]
               	ldr	s3, [x0, #0xc]
               	bl	<addr>
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
