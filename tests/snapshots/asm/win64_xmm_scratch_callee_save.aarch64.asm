
win64_xmm_scratch_callee_save.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	fmul	d2, d2, d3
               	fmadd	d0, d0, d1, d2
               	fmadd	d0, d4, d5, d0
               	ret

<make>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	fmul	d2, d2, d3
               	fmadd	d1, d0, d1, d2
               	fmadd	d1, d4, d5, d1
               	sub	x0, x29, #0x8
               	fcvtzs	x1, d1
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fmadd	d0, d1, d17, d0
               	fcvtzs	x1, d0
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x4, #0x4008000000000000 // =4613937818241073152
               	mov	x5, #0x4010000000000000 // =4616189618054758400
               	mov	x2, #0x4014000000000000 // =4617315517961601024
               	mov	x3, #0x4018000000000000 // =4618441417868443648
               	fmov	d16, x4
               	fmov	d17, x5
               	fmul	d0, d16, d17
               	fmov	d16, x0
               	fmov	d17, x1
               	fmadd	d0, d16, d17, d0
               	fmov	d16, x2
               	fmov	d17, x3
               	fmadd	d0, d16, d17, d0
               	sub	x1, x29, #0x58
               	fcvtzs	x2, d0
               	str	w2, [x1]
               	sub	x1, x29, #0x58
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fmov	d18, x0
               	fmadd	d0, d0, d17, d18
               	fcvtzs	x0, d0
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x58
               	sub	x1, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x59
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fmul	d0, d16, d17
               	fmov	d16, x1
               	fmov	d17, x2
               	fmadd	d0, d16, d17, d0
               	fmov	d16, x0
               	fmov	d17, x0
               	fmadd	d0, d16, d17, d0
               	sub	x0, x29, #0x60
               	fcvtzs	x2, d0
               	str	w2, [x0]
               	sub	x0, x29, #0x60
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fmov	d18, x1
               	fmadd	d0, d0, d17, d18
               	fcvtzs	x1, d0
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x18
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
