
libc_math_minmax.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3a0              // =928
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	fmov	x0, d0
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x20
               	fmov	d1, x1
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	fmov	d17, x20
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x20
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	fmov	d17, x20
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	mov	x20, #0x4010000000000000 // =4616189618054758400
               	fmov	d1, x20
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	fmov	d17, x20
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4014000000000000 // =4617315517961601024
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	fmov	d1, d0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	fmov	d17, x20
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s1, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	x0, d0
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fcvt	s1, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	x0, d0
               	fmov	d16, x0
               	fmov	d17, x20
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x20
               	fcvt	s1, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	x0, d0
               	fmov	d16, x0
               	fmov	d17, x20
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
