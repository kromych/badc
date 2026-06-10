
fma_contraction.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	fmadd	d0, d0, d1, d2
               	ret

<dmsub>:
               	fnmsub	d0, d0, d1, d2
               	ret

<dnmadd>:
               	fmsub	d0, d0, d1, d2
               	ret

<fmadd_>:
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
               	sub	x16, x29, #0x18
               	ldr	s2, [x16]
               	fmadd	s0, s0, s1, s2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<fmsub_>:
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
               	sub	x16, x29, #0x18
               	ldr	s2, [x16]
               	fnmsub	s0, s0, s1, s2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<fnmadd_>:
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
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	sub	x16, x29, #0x10
               	ldr	s2, [x16]
               	fmsub	s0, s1, s2, s0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmadd	d0, d16, d17, d18
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fnmsub	d0, d16, d17, d18
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmsub	d0, d16, d17, d18
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fcvt	s1, d16
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s2, d16
               	bl	<addr>
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fcvt	s1, d16
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s2, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fcvt	s1, d16
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s2, d16
               	bl	<addr>
               	fmov	d16, x20
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x3fd0000000000000 // =4598175219545276416
               	mov	x2, #0x3fc0000000000000 // =4593671619917905920
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmadd	d0, d16, d17, d18
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x20, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x20
               	fcvt	s1, d16
               	mov	x0, #0x3fc0000000000000 // =4593671619917905920
               	fmov	d16, x0
               	fcvt	s2, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmadd	d0, d16, d17, d18
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x3fd0000000000000 // =4598175219545276416
               	mov	x2, #0x3fc0000000000000 // =4593671619917905920
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmadd	d0, d16, d17, d18
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fcvt	s1, d16
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s2, d16
               	fmadd	s0, s0, s1, s2
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	scvtf	d0, x0
               	mov	x0, #0x3                // =3
               	scvtf	d1, x0
               	mov	x0, #0x4                // =4
               	scvtf	d2, x0
               	fmadd	d0, d0, d1, d2
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
