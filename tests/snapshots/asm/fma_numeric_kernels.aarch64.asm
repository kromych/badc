
fma_numeric_kernels.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	sub	x1, x29, #0x28
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	str	d16, [x1]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	str	d16, [x1, #0x8]
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	str	d16, [x1, #0x10]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	str	d16, [x1, #0x18]
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x0
               	str	d16, [x1, #0x20]
               	ldr	d0, [x1, #0x20]
               	mov	x0, #0x3                // =3
               	cmp	w0, #0x0
               	b.lt	<addr>
               	sxtw	x3, w0
               	lsl	x3, x3, #3
               	add	x3, x1, x3
               	ldr	d1, [x3]
               	fmov	d17, x2
               	fmadd	d0, d0, d17, d1
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x200000000000     // =35184372088832
               	movk	x0, #0x4060, lsl #48
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.mi	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x28
               	ldr	d0, [x2, #0x20]
               	mov	x0, #0x3                // =3
               	cmp	w0, #0x0
               	b.lt	<addr>
               	sxtw	x3, w0
               	lsl	x3, x3, #3
               	add	x3, x2, x3
               	ldr	d1, [x3]
               	fmov	d17, x1
               	fmadd	d0, d0, d17, d1
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x8, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x8
               	fsub	d0, d0, d17
               	mov	x4, #0x0                // =0
               	fmov	d17, x4
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x9, #0x3                // =3
               	mov	x10, #0x18              // =24
               	cmp	w4, #0x3
               	b.ge	<addr>
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	cmp	w0, #0x3
               	b.ge	<addr>
               	sub	x2, x29, #0x90
               	sxtw	x1, w4
               	mul	x6, x1, x10
               	add	x3, x2, x6
               	sxtw	x2, w0
               	lsl	x7, x2, #3
               	add	x11, x3, x7
               	mul	x3, x1, x9
               	add	x3, x3, x2
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	scvtf	d0, x3
               	str	d0, [x11]
               	sub	x3, x29, #0x48
               	add	x3, x3, x6
               	add	x3, x3, x7
               	cmp	w1, w2
               	b.ne	<addr>
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	b	<addr>
               	mov	x17, #0x0               // =0
               	fmov	d0, x17
               	str	d0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x4, x4, #0x1
               	cmp	w4, #0x3
               	b.lt	<addr>
               	mov	x6, #0x0                // =0
               	mov	x13, #0x18              // =24
               	mov	x7, #0xd695             // =54933
               	movk	x7, #0xe826, lsl #16
               	movk	x7, #0x2e0b, lsl #32
               	movk	x7, #0x3e11, lsl #48
               	mov	x1, x6
               	cmp	w1, #0x3
               	b.ge	<addr>
               	sub	x2, x29, #0x90
               	sub	x4, x29, #0x48
               	sxtw	x0, w1
               	mul	x5, x0, x13
               	add	x3, x2, x5
               	add	x8, x3, #0x0
               	ldr	d0, [x8]
               	add	x9, x4, #0x0
               	add	x10, x9, #0x0
               	ldr	d1, [x10]
               	fmov	d18, x6
               	fmadd	d2, d0, d1, d18
               	ldr	d0, [x3, #0x8]
               	add	x10, x4, #0x18
               	add	x11, x10, #0x0
               	ldr	d1, [x11]
               	fmadd	d2, d0, d1, d2
               	ldr	d0, [x3, #0x10]
               	add	x11, x4, #0x30
               	add	x12, x11, #0x0
               	ldr	d1, [x12]
               	fmadd	d0, d0, d1, d2
               	ldr	d1, [x8]
               	fsub	d0, d0, d1
               	fmov	d17, x6
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x7
               	fcmp	d0, d17
               	b.pl	<addr>
               	ldr	d0, [x8]
               	ldr	d1, [x9, #0x8]
               	fmov	d18, x6
               	fmadd	d2, d0, d1, d18
               	add	x3, x2, x5
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x10, #0x8]
               	fmadd	d2, d0, d1, d2
               	mul	x3, x0, x13
               	add	x2, x2, x3
               	ldr	d0, [x2, #0x10]
               	ldr	d1, [x11, #0x8]
               	fmadd	d0, d0, d1, d2
               	sub	x4, x29, #0x90
               	add	x2, x4, x3
               	ldr	d1, [x2, #0x8]
               	fsub	d0, d0, d1
               	mov	x5, #0x0                // =0
               	fmov	d17, x5
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x7
               	fcmp	d0, d17
               	b.pl	<addr>
               	sub	x8, x29, #0x48
               	add	x9, x2, #0x0
               	ldr	d0, [x9]
               	add	x9, x8, #0x0
               	ldr	d1, [x9, #0x10]
               	fmov	d18, x5
               	fmadd	d2, d0, d1, d18
               	ldr	d0, [x2, #0x8]
               	add	x9, x8, #0x18
               	ldr	d1, [x9, #0x10]
               	fmadd	d2, d0, d1, d2
               	ldr	d0, [x2, #0x10]
               	add	x8, x8, #0x30
               	ldr	d1, [x8, #0x10]
               	fmadd	d1, d0, d1, d2
               	fsub	d0, d1, d0
               	fmov	d17, x5
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fmov	d17, x7
               	fcmp	d0, d17
               	b.pl	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0x90
               	mov	x2, #0x0                // =0
               	add	x0, x1, #0x18
               	add	x3, x0, #0x0
               	ldr	d0, [x3]
               	add	x3, x1, #0x0
               	ldr	d1, [x3, #0x10]
               	fmov	d18, x2
               	fmadd	d2, d0, d1, d18
               	ldr	d1, [x0, #0x8]
               	ldr	d0, [x0, #0x10]
               	fmadd	d2, d1, d0, d2
               	add	x0, x1, #0x30
               	ldr	d1, [x0, #0x10]
               	fmadd	d0, d0, d1, d2
               	mov	x0, #0x4058000000000000 // =4636455816377925632
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.mi	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x1
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	mov	x2, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x2
               	fmul	d1, d0, d17
               	fmov	d17, x1
               	fmov	d18, x1
               	fmadd	d3, d1, d17, d18
               	fmov	d18, x1
               	fmadd	d4, d1, d3, d18
               	fmov	d18, x1
               	fmadd	d5, d0, d4, d18
               	mov	x3, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x3
               	fdiv	d2, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d18, x1
               	fmadd	d3, d16, d3, d18
               	fmov	d16, x0
               	fmadd	d3, d16, d4, d3
               	fadd	d3, d3, d5
               	fmov	d18, x1
               	fmadd	d3, d2, d3, d18
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d1, d1, d4, d3
               	fmadd	d5, d0, d1, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d1, d16, d1, d4
               	fadd	d1, d1, d5
               	fmadd	d3, d2, d1, d3
               	fmov	d17, x2
               	fmul	d1, d0, d17
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d1, d1, d4, d3
               	fmadd	d5, d0, d1, d3
               	mov	x1, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x1
               	fdiv	d2, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d1, d16, d1, d4
               	fadd	d1, d1, d5
               	fmadd	d3, d2, d1, d3
               	mov	x2, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x2
               	fmul	d1, d0, d17
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	fmadd	d4, d1, d3, d3
               	fmadd	d1, d1, d4, d3
               	fmadd	d5, d0, d1, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d1, d16, d1, d4
               	fadd	d1, d1, d5
               	fmadd	d3, d2, d1, d3
               	fmov	d17, x2
               	fmul	d1, d0, d17
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d2, d2, d4, d3
               	fmadd	d3, d1, d2, d2
               	fmadd	d1, d1, d3, d2
               	fmadd	d5, d0, d1, d2
               	fmov	d17, x1
               	fdiv	d4, d0, d17
               	fmov	d16, x0
               	fmadd	d3, d16, d3, d2
               	fmov	d16, x0
               	fmadd	d1, d16, d1, d3
               	fadd	d1, d1, d5
               	fmadd	d1, d4, d1, d2
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fmul	d2, d0, d17
               	fmadd	d3, d2, d1, d1
               	fmadd	d2, d2, d3, d1
               	fmadd	d4, d0, d2, d1
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmadd	d3, d16, d3, d1
               	fmov	d16, x0
               	fmadd	d2, d16, d2, d3
               	fadd	d2, d2, d4
               	fmadd	d0, d0, d2, d1
               	mov	x0, #0x5769             // =22377
               	movk	x0, #0x8b14, lsl #16
               	movk	x0, #0xbf0a, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x1, #0xed8d             // =60813
               	movk	x1, #0xa0b5, lsl #16
               	movk	x1, #0xc6f7, lsl #32
               	movk	x1, #0x3eb0, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.le	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
