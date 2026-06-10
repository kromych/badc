
fp_unary_intrinsic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s0, d16
               	fsqrt	s0, s0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x0
               	fcvt	s0, d16
               	fsqrt	s0, s0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4022000000000000 // =4621256167635550208
               	fmov	d16, x0
               	fsqrt	d0, d16
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvt	s0, d0
               	fabs	s0, s0
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x0
               	fneg	d0, d16
               	fabs	d0, d0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x0
               	fcvt	s0, d16
               	fsqrt	s0, s0
               	fcvt	d0, s0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d16, x0
               	frintm	d0, d16
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x6666, lsl #16
               	movk	x0, #0x6666, lsl #32
               	movk	x0, #0x4002, lsl #48
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvt	s0, d0
               	frintm	s0, s0
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x6666, lsl #16
               	movk	x0, #0x6666, lsl #32
               	movk	x0, #0x4002, lsl #48
               	fmov	d16, x0
               	frintp	d0, d16
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvt	s0, d0
               	frintp	s0, s0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d16, x0
               	fneg	d0, d16
               	frintz	d0, d0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x4007, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	frintz	s0, s0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvt	s0, d0
               	fabs	s0, s0
               	fsqrt	s0, s0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	fmul	s0, s0, s0
               	fsqrt	s0, s0
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0x3fec, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	frintm	s0, s0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
