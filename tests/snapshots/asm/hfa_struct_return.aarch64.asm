
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	mov	x2, #0x3fe0000000000000 // =4602678819172646912
               	sub	x1, x29, #0x10
               	fmov	d16, x0
               	str	d16, [x1]
               	fmov	d16, x2
               	str	d16, [x1, #0x8]
               	sub	x3, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x3]
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x3, #0x8]
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x3ff0000000000000 // =4607182418800017408
               	mov	x5, #0x4000000000000000 // =4611686018427387904
               	mov	x6, #0x4008000000000000 // =4613937818241073152
               	sub	x0, x29, #0x18
               	fmov	d16, x4
               	str	d16, [x0]
               	fmov	d16, x5
               	str	d16, [x0, #0x8]
               	fmov	d16, x6
               	str	d16, [x0, #0x10]
               	sub	x2, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x2]
               	fmov	d17, x4
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x2, #0x8]
               	fmov	d17, x5
               	fcmp	d0, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	d0, [x2, #0x10]
               	fmov	d17, x6
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x4024000000000000 // =4621819117588971520
               	mov	x5, #0x4034000000000000 // =4626322717216342016
               	mov	x6, #0x403e000000000000 // =4629137466983448576
               	mov	x7, #0x4044000000000000 // =4630826316843712512
               	sub	x2, x29, #0x20
               	fmov	d16, x4
               	str	d16, [x2]
               	fmov	d16, x5
               	str	d16, [x2, #0x8]
               	fmov	d16, x6
               	str	d16, [x2, #0x10]
               	fmov	d16, x7
               	str	d16, [x2, #0x18]
               	sub	x0, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x0]
               	fmov	d17, x4
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	fmov	d17, x5
               	fcmp	d0, d17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	d0, [x0, #0x10]
               	fmov	d17, x6
               	fcmp	d0, d17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	d0, [x0, #0x18]
               	fmov	d17, x7
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, #0x3fc00000         // =1069547520
               	mov	x6, #0x40200000         // =1075838976
               	sub	x2, x29, #0x8
               	fmov	s16, w5
               	str	s16, [x2]
               	fmov	s16, w6
               	str	s16, [x2, #0x4]
               	sub	x4, x29, #0x58
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x4]
               	ldr	x10, [sp], #0x10
               	ldr	s0, [x4]
               	fmov	s17, w5
               	fcmp	s0, s17
               	b.ne	<addr>
               	ldr	s0, [x4, #0x4]
               	fmov	s17, w6
               	fcmp	s0, s17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x3]
               	ldr	d1, [x3, #0x8]
               	fadd	d0, d0, d1
               	mov	x2, #0x3fe8000000000000 // =4604930618986332160
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	fadd	d0, d0, d1
               	ldr	d1, [x0, #0x10]
               	fadd	d0, d0, d1
               	ldr	d1, [x0, #0x18]
               	fadd	d0, d0, d1
               	mov	x0, #0x4059000000000000 // =4636737291354636288
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	s0, [x1]
               	ldr	s1, [x1, #0x4]
               	fadd	s0, s0, s1
               	ldr	s1, [x1, #0x8]
               	fadd	s0, s0, s1
               	ldr	s1, [x1, #0xc]
               	fadd	s0, s0, s1
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
