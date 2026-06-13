
float_increment_decrement.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xb0
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x1, x29, #0x8
               	ldr	s0, [x1]
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fcvt	d1, s0
               	fmov	d17, x2
               	fadd	d1, d1, d17
               	fcvt	s1, d1
               	str	s1, [x1]
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x17, x29, #0x18
               	str	s0, [x17]
               	sub	x0, x29, #0x18
               	ldr	s0, [x0]
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x0]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	fmov	d16, x0
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x1, #-0x4010000000000000 // =-4616189618054758400
               	fmov	d17, x1
               	fadd	d1, d0, d17
               	sub	x17, x29, #0x28
               	str	d1, [x17]
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x0, #0x4002000000000000 // =4612248968380809216
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	fmov	d16, x0
               	sub	x17, x29, #0x38
               	str	d16, [x17]
               	sub	x16, x29, #0x38
               	ldr	d0, [x16]
               	mov	x0, #-0x4010000000000000 // =-4616189618054758400
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	sub	x17, x29, #0x38
               	str	d0, [x17]
               	mov	x0, #0x4002000000000000 // =4612248968380809216
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x38
               	ldr	d0, [x16]
               	mov	x0, #0x4002000000000000 // =4612248968380809216
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x17, x29, #0x48
               	str	s0, [x17]
               	sub	x1, x29, #0x48
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x1]
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x1]
               	sub	x16, x29, #0x48
               	ldr	s0, [x16]
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, #0xd8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x60
               	ldr	s0, [x0]
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x0, x29, #0x60
               	add	x0, x0, #0x8
               	ldr	d0, [x0]
               	mov	x1, #-0x4010000000000000 // =-4616189618054758400
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0]
               	sub	x0, x29, #0x60
               	ldr	s0, [x0]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x60
               	add	x0, x0, #0x8
               	ldr	d0, [x0]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldr	d0, [x0]
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0]
               	ldr	d0, [x0]
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0]
               	ldr	d0, [x0]
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, #0xe8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x8
               	ldr	d0, [x0]
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0]
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x10
               	ldr	d0, [x0]
               	mov	x1, #-0x4010000000000000 // =-4616189618054758400
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0]
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x8
               	ldr	d0, [x0]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x10
               	ldr	d0, [x0]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4170000000000000 // =4715268809856909312
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x17, x29, #0x80
               	str	s0, [x17]
               	sub	x1, x29, #0x80
               	ldr	s0, [x1]
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fcvt	d0, s0
               	fmov	d17, x2
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x1]
               	sub	x16, x29, #0x80
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
