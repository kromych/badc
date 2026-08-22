
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

<dot3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	sxtw	x2, w2
               	sxtw	x3, w3
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d2, [x16]
               	mov	x17, #0x18              // =24
               	mul	x5, x2, x17
               	add	x0, x4, x5
               	add	x6, x0, #0x0
               	ldr	d0, [x6]
               	add	x7, x1, #0x0
               	lsl	x6, x3, #3
               	add	x7, x7, x6
               	ldr	d1, [x7]
               	fmadd	d0, d0, d1, d2
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	sub	x16, x29, #0x8
               	ldr	d2, [x16]
               	ldr	d0, [x0, #0x8]
               	add	x7, x1, #0x18
               	add	x7, x7, x6
               	ldr	d1, [x7]
               	fmadd	d0, d0, d1, d2
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	sub	x16, x29, #0x8
               	ldr	d2, [x16]
               	ldr	d0, [x0, #0x10]
               	add	x0, x1, #0x30
               	add	x0, x0, x6
               	ldr	d1, [x0]
               	fmadd	d0, d0, d1, d2
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x100]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0xf0]
               	add	x29, sp, #0xf0
               	sub	x1, x29, #0xb8
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
               	b	<addr>
               	sxtw	x3, w0
               	lsl	x4, x3, #3
               	add	x4, x1, x4
               	ldr	d1, [x4]
               	fmov	d17, x2
               	fmadd	d0, d0, d17, d1
               	sub	x0, x3, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x200000000000     // =35184372088832
               	movk	x0, #0x4060, lsl #48
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	sub	x3, x29, #0xb8
               	mov	x1, #0x0                // =0
               	ldr	d0, [x3, #0x20]
               	mov	x0, #0x3                // =3
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x4, x2, #3
               	add	x4, x3, x4
               	ldr	d1, [x4]
               	fmov	d17, x1
               	fmadd	d0, d0, d17, d1
               	sub	x0, x2, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x8, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x8
               	fsub	d0, d0, d17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	b	<addr>
               	sub	x1, x29, #0x90
               	sxtw	x2, w4
               	mov	x17, #0x18              // =24
               	mul	x6, x2, x17
               	add	x3, x1, x6
               	sxtw	x1, w0
               	lsl	x7, x1, #3
               	add	x9, x3, x7
               	mov	x17, #0x3               // =3
               	mul	x3, x2, x17
               	add	x3, x3, x1
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	scvtf	d0, x3
               	str	d0, [x9]
               	sub	x3, x29, #0x48
               	add	x3, x3, x6
               	add	x3, x3, x7
               	cmp	w2, w1
               	b.ne	<addr>
               	fmov	d16, x8
               	sub	x17, x29, #0xc8
               	str	d16, [x17]
               	sub	x16, x29, #0xc8
               	ldr	d0, [x16]
               	str	d0, [x3]
               	b	<addr>
               	fmov	d16, x5
               	sub	x17, x29, #0xc8
               	str	d16, [x17]
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w4
               	add	x4, x0, #0x1
               	cmp	w4, #0x3
               	b.lt	<addr>
               	mov	x21, #0x0               // =0
               	b	<addr>
               	mov	x22, #0x0               // =0
               	mov	x20, x22
               	b	<addr>
               	sub	x23, x29, #0x90
               	sub	x1, x29, #0x48
               	mov	x0, x23
               	mov	x3, x20
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w21
               	mov	x17, #0x18              // =24
               	mul	x0, x0, x17
               	add	x0, x23, x0
               	sxtw	x1, w20
               	lsl	x1, x1, #3
               	add	x0, x0, x1
               	ldr	d1, [x0]
               	fsub	d0, d0, d1
               	fmov	d17, x22
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0x3
               	b.lt	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	cmp	w21, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x90
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x1, x0
               	bl	<addr>
               	mov	x0, #0x4058000000000000 // =4636455816377925632
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	sub	x17, x29, #0xd0
               	str	d16, [x17]
               	mov	x1, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x0
               	fmov	d17, x1
               	fdiv	d0, d16, d17
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x1
               	fmul	d1, d0, d17
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	mov	x2, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x2
               	fdiv	d2, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d1, d1, d4, d3
               	fmadd	d5, d0, d1, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d1, d16, d1, d4
               	fadd	d1, d1, d5
               	fmadd	d1, d2, d1, d3
               	sub	x17, x29, #0xd0
               	str	d1, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d2, [x16]
               	fmov	d17, x1
               	fmul	d1, d0, d17
               	fmadd	d3, d1, d2, d2
               	fmadd	d4, d1, d3, d2
               	fmadd	d6, d0, d4, d2
               	fmov	d17, x2
               	fdiv	d5, d0, d17
               	fmov	d16, x0
               	fmadd	d3, d16, d3, d2
               	fmov	d16, x0
               	fmadd	d3, d16, d4, d3
               	fadd	d3, d3, d6
               	fmadd	d2, d5, d3, d2
               	sub	x17, x29, #0xd0
               	str	d2, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d2, [x16]
               	fmadd	d3, d1, d2, d2
               	fmadd	d1, d1, d3, d2
               	fmadd	d4, d0, d1, d2
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmadd	d3, d16, d3, d2
               	fmov	d16, x0
               	fmadd	d1, d16, d1, d3
               	fadd	d1, d1, d4
               	fmadd	d1, d5, d1, d2
               	sub	x17, x29, #0xd0
               	str	d1, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x1
               	fmul	d1, d0, d17
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	mov	x2, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x2
               	fdiv	d2, d0, d17
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d5, d1, d4, d3
               	fmadd	d6, d0, d5, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d5, d4
               	fadd	d4, d4, d6
               	fmadd	d3, d2, d4, d3
               	sub	x17, x29, #0xd0
               	str	d3, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d3, [x16]
               	fmadd	d4, d1, d3, d3
               	fmadd	d1, d1, d4, d3
               	fmadd	d5, d0, d1, d3
               	fmov	d16, x0
               	fmadd	d4, d16, d4, d3
               	fmov	d16, x0
               	fmadd	d1, d16, d1, d4
               	fadd	d1, d1, d5
               	fmadd	d1, d2, d1, d3
               	sub	x17, x29, #0xd0
               	str	d1, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d2, [x16]
               	fmov	d17, x1
               	fmul	d1, d0, d17
               	fmadd	d3, d1, d2, d2
               	fmadd	d4, d1, d3, d2
               	fmadd	d6, d0, d4, d2
               	fmov	d17, x2
               	fdiv	d5, d0, d17
               	fmov	d16, x0
               	fmadd	d3, d16, d3, d2
               	fmov	d16, x0
               	fmadd	d3, d16, d4, d3
               	fadd	d3, d3, d6
               	fmadd	d2, d5, d3, d2
               	sub	x17, x29, #0xd0
               	str	d2, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d2, [x16]
               	fmadd	d3, d1, d2, d2
               	fmadd	d1, d1, d3, d2
               	fmadd	d4, d0, d1, d2
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmadd	d3, d16, d3, d2
               	fmov	d16, x0
               	fmadd	d1, d16, d1, d3
               	fadd	d1, d1, d4
               	fmadd	d0, d0, d1, d2
               	sub	x17, x29, #0xd0
               	str	d0, [x17]
               	mov	x0, #0x5769             // =22377
               	movk	x0, #0x8b14, lsl #16
               	movk	x0, #0xbf0a, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0xc8
               	str	d16, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d0, [x16]
               	sub	x16, x29, #0xc8
               	ldr	d1, [x16]
               	fsub	d0, d0, d1
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
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	b	<addr>
               	b	<addr>
