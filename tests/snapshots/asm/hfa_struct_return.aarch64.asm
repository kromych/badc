
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
               	sub	sp, sp, #0x10
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3fd0000000000000 // =4598175219545276416
               	mov	x2, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x2
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x3, #0x4000000000000000 // =4611686018427387904
               	mov	x4, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x3
               	fmov	d17, x3
               	fcmp	d16, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	fmov	d16, x4
               	fmov	d17, x4
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x4024000000000000 // =4621819117588971520
               	mov	x4, #0x4034000000000000 // =4626322717216342016
               	mov	x5, #0x403e000000000000 // =4629137466983448576
               	mov	x6, #0x4044000000000000 // =4630826316843712512
               	fmov	d16, x3
               	fmov	d17, x3
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x4
               	fmov	d17, x4
               	fcmp	d16, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	fmov	d16, x5
               	fmov	d17, x5
               	fcmp	d16, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	fmov	d16, x6
               	fmov	d17, x6
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x7, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	b.ne	<addr>
               	fmov	s16, w7
               	fmov	s17, w7
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x7]
               	str	x10, [x0]
               	ldr	x10, [x7, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	fmov	d16, x1
               	fmov	d17, x2
               	fadd	d0, d16, d17
               	mov	x1, #0x3fe8000000000000 // =4604930618986332160
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x3
               	fmov	d17, x4
               	fadd	d0, d16, d17
               	fmov	d17, x5
               	fadd	d0, d0, d17
               	fmov	d17, x6
               	fadd	d0, d0, d17
               	mov	x1, #0x4059000000000000 // =4636737291354636288
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	s0, [x0]
               	ldr	s1, [x0, #0x4]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x8]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0xc]
               	fadd	s0, s0, s1
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
