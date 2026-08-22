
hfa_struct_return.aarch64:	file format elf64-littleaarch64

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

<mkd1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	d0, [x0]
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
               	str	d1, [x0, #0x8]
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
               	str	d1, [x0, #0x8]
               	str	d2, [x0, #0x10]
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
               	str	d1, [x0, #0x8]
               	str	d2, [x0, #0x10]
               	str	d3, [x0, #0x18]
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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	s0, [x0]
               	str	s1, [x0, #0x4]
               	mov	x16, x0
               	ldr	s0, [x16]
               	ldr	s1, [x16, #0x4]
               	add	sp, sp, #0x10
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
               	ldr	d1, [x0, #0x8]
               	fadd	d0, d0, d1
               	ldr	d1, [x0, #0x10]
               	fadd	d0, d0, d1
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
               	ldr	s1, [x0, #0x4]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x8]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0xc]
               	fadd	s0, s0, s1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x20, #0x401c000000000000 // =4619567317775286272
               	fmov	d0, x20
               	bl	<addr>
               	sub	x16, x29, #0x8
               	str	d0, [x16]
               	sub	x1, x29, #0x8
               	sub	x0, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x20, #0x3fd0000000000000 // =4598175219545276416
               	mov	x21, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x20
               	fmov	d1, x21
               	bl	<addr>
               	sub	x16, x29, #0x10
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	d0, [x0, #0x8]
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	mov	x23, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x20
               	fmov	d1, x22
               	fmov	d2, x23
               	bl	<addr>
               	sub	x16, x29, #0x18
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	sub	x1, x29, #0x18
               	sub	x0, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	mov	x21, #0x1               // =1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	fmov	d17, x22
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	d0, [x0, #0x10]
               	fmov	d17, x23
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x22, #0x4024000000000000 // =4621819117588971520
               	mov	x23, #0x4034000000000000 // =4626322717216342016
               	mov	x24, #0x403e000000000000 // =4629137466983448576
               	mov	x25, #0x4044000000000000 // =4630826316843712512
               	fmov	d0, x22
               	fmov	d1, x23
               	fmov	d2, x24
               	fmov	d3, x25
               	bl	<addr>
               	sub	x16, x29, #0x20
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	str	d3, [x16, #0x18]
               	sub	x0, x29, #0x20
               	sub	x20, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x20, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	ldr	d0, [x20]
               	fmov	d17, x22
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x20, #0x8]
               	fmov	d17, x23
               	fcmp	d0, d17
               	cset	x21, ne
               	mov	x0, #0x1                // =1
               	cbnz	x21, <addr>
               	ldr	d0, [x20, #0x10]
               	fmov	d17, x24
               	fcmp	d0, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	d0, [x20, #0x18]
               	fmov	d17, x25
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x21, #0x3fc00000        // =1069547520
               	mov	x22, #0x40200000        // =1075838976
               	fmov	d0, x21
               	fmov	d1, x22
               	bl	<addr>
               	sub	x16, x29, #0x8
               	str	s0, [x16]
               	str	s1, [x16, #0x4]
               	sub	x1, x29, #0x8
               	sub	x0, x29, #0x58
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldr	s0, [x0]
               	fmov	s17, w21
               	fcmp	s0, s17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	s0, [x0, #0x4]
               	fmov	s17, w22
               	fcmp	s0, s17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x21, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x21
               	sub	x0, x29, #0x50
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	bl	<addr>
               	mov	x0, #0x3fe8000000000000 // =4604930618986332160
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldr	d0, [x20]
               	ldr	d1, [x20, #0x8]
               	ldr	d2, [x20, #0x10]
               	ldr	d3, [x20, #0x18]
               	bl	<addr>
               	mov	x0, #0x4059000000000000 // =4636737291354636288
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldr	s0, [x21]
               	ldr	s1, [x21, #0x4]
               	ldr	s2, [x21, #0x8]
               	ldr	s3, [x21, #0xc]
               	bl	<addr>
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x21
               	b	<addr>
               	b	<addr>
