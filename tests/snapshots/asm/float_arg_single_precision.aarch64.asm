
float_arg_single_precision.aarch64:	file format elf64-littleaarch64

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
               	str	s0, [x0]
               	sub	x0, x29, #0x10
               	fmov	d0, d1
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x10
               	ldr	s1, [x16]
               	fmul	s0, s0, s1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<add3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	str	s0, [x0]
               	sub	x0, x29, #0x10
               	fmov	d0, d1
               	str	s0, [x0]
               	sub	x0, x29, #0x18
               	fmov	d0, d2
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x10
               	ldr	s1, [x16]
               	fadd	s0, s0, s1
               	sub	x16, x29, #0x18
               	ldr	s1, [x16]
               	fadd	s0, s0, s1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x0
               	fcvt	s1, d16
               	bl	<addr>
               	sub	x0, x29, #0x8
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x3fd8000000000000 // =4600427019358961664
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvt	s0, d0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s1, d16
               	bl	<addr>
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d16, x0
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x0
               	fcvt	s1, d16
               	mov	x0, #0x3fc0000000000000 // =4593671619917905920
               	fmov	d16, x0
               	fcvt	s2, d16
               	bl	<addr>
               	sub	x0, x29, #0x18
               	str	s0, [x0]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	mov	x0, #0x3fec000000000000 // =4606056518893174784
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4020000000000000 // =4620693217682128896
               	fmov	d16, x0
               	fmov	d17, x1
               	fdiv	d0, d16, d17
               	fcvt	s0, d0
               	sub	x0, x29, #0x20
               	str	s0, [x0]
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x0
               	fcvt	s1, d16
               	bl	<addr>
               	sub	x0, x29, #0x28
               	str	s0, [x0]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
