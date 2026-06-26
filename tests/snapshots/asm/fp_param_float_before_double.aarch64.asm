
fp_param_float_before_double.aarch64:	file format elf64-littleaarch64

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
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<pick_second>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	fcvt	d0, s1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	fcvt	d0, s0
               	fadd	d0, d0, d1
               	fcvt	d1, s2
               	fadd	d0, d0, d1
               	fadd	d0, d0, d3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<dbl_then_float>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fcvt	d1, s1
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x0
               	fcvt	s0, d16
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x401a000000000000 // =4619004367821864960
               	fmov	d16, x0
               	fcvt	s0, d16
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	fcvt	s1, d16
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	d1, s1
               	fadd	d0, d0, d1
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	mov	x1, #0x4018000000000000 // =4618441417868443648
               	fmov	d16, x1
               	fcvt	s0, d16
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fcvt	d0, s0
               	fmov	d16, x0
               	fmov	d17, x1
               	fmadd	d0, d16, d17, d0
               	mov	x0, #0x404c000000000000 // =4633078116657397760
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
