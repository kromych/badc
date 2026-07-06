
compound_assign_float_register_resident.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x4059000000000000 // =4636737291354636288
               	fmov	d16, x0
               	fcvt	s1, d16
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d1, s1
               	fmov	d17, x0
               	fsub	d1, d1, d17
               	fcvt	s1, d1
               	fadd	s1, s1, s0
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fcvt	d0, s0
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	b	<addr>
               	mov	x0, #0x405e000000000000 // =4638144666238189568
               	fcvt	d1, s1
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4022000000000000 // =4621256167635550208
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x1, #-0x4010000000000000 // =-4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	d16, x0
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	fcvt	s0, d0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	fcvt	s0, d0
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
