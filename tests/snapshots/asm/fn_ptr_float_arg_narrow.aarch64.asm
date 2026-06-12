
fn_ptr_float_arg_narrow.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	fcvt	s0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<negf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	fneg	s0, s0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<addf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	fadd	s0, s0, s1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	fcvt	s0, d16
               	mov	x9, x0
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x9, x0
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	fmov	d16, x20
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x10
               	ldr	x0, [x1, x0, lsl #3]
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x1
               	fcvt	s0, d16
               	mov	x9, x0
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, #0xe0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	ldr	x0, [x0]
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x1
               	fcvt	s0, d16
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x1
               	fcvt	s1, d16
               	mov	x9, x0
               	fmov	x16, d1
               	str	x16, [sp, #-0x10]!
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x238
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x1
               	fcvt	s0, d16
               	mov	x9, x0
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	mov	x9, x0
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x402c000000000000 // =4624070917402656768
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
