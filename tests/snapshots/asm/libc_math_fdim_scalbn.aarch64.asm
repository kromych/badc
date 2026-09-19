
libc_math_fdim_scalbn.aarch64:	file format elf64-littleaarch64

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

<scalbn>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x0, w0
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalbln>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalbnf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	fcvt	d0, s0
               	bl	<addr>
               	fcvt	s0, d0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.gt	<addr>
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	fmov	d16, x1
               	fmov	d17, x0
               	fsub	d0, d16, d17
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.gt	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.eq	<addr>
               	fmov	d16, x0
               	fmov	d17, x1
               	fsub	d0, d16, d17
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.gt	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fsub	d0, d16, d17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
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
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	mov	x1, #-0x1               // =-1
               	fmov	d0, x0
               	mov	x0, x1
               	bl	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
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
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
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
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	mov	x1, #0x40400000         // =1077936128
               	fmov	s16, w0
               	fcvt	d0, s16
               	fmov	s16, w1
               	fcvt	d1, s16
               	fcmp	d0, d1
               	b.gt	<addr>
               	fcmp	d0, d0
               	b.ne	<addr>
               	fcmp	d1, d1
               	b.eq	<addr>
               	fsub	d0, d0, d1
               	fcvt	s0, d0
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x17, #0x0               // =0
               	fmov	d0, x17
               	b	<addr>
               	mov	x17, #0x0               // =0
               	fmov	d0, x17
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x17, #0x0               // =0
               	fmov	d0, x17
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	x17, #0x0               // =0
               	fmov	d0, x17
               	b	<addr>
