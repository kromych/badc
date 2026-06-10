
fma_numeric_kernels.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	fsub	d1, d0, d1
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d1, d1
               	b	<addr>
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, mi
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x1, w1
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	lsl	x2, x2, #3
               	add	x2, x0, x2
               	ldr	d1, [x2]
               	sub	x1, x1, #0x2
               	sxtw	x2, w1
               	b	<addr>
               	sxtw	x1, w2
               	cmp	x1, #0x0
               	b.lt	<addr>
               	b	<addr>
               	sxtw	x1, w2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x2, x1, x17
               	b	<addr>
               	sxtw	x1, w2
               	lsl	x1, x1, #3
               	add	x1, x0, x1
               	ldr	d2, [x1]
               	fmadd	d1, d1, d0, d2
               	b	<addr>
               	fmov	d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x2, w2
               	sxtw	x3, w3
               	mov	x5, #0x0                // =0
               	fmov	d16, x5
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	b	<addr>
               	sxtw	x4, w5
               	cmp	x4, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x4, w5
               	add	x5, x4, #0x1
               	b	<addr>
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x17, #0x18              // =24
               	mul	x4, x2, x17
               	add	x4, x0, x4
               	sxtw	x6, w5
               	lsl	x7, x6, #3
               	add	x4, x4, x7
               	ldr	d1, [x4]
               	mov	x17, #0x18              // =24
               	mul	x4, x6, x17
               	add	x4, x1, x4
               	lsl	x6, x3, #3
               	add	x4, x4, x6
               	ldr	d2, [x4]
               	fmadd	d0, d1, d2, d0
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fmul	d2, d1, d17
               	fmadd	d3, d2, d0, d0
               	fmadd	d2, d2, d3, d0
               	fmadd	d4, d1, d2, d0
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x0
               	fdiv	d1, d1, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmadd	d3, d16, d3, d0
               	fmov	d16, x0
               	fmadd	d2, d16, d2, d3
               	fadd	d2, d2, d4
               	fmadd	d0, d1, d2, d0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	sub	x0, x29, #0x28
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	str	d16, [x0]
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x8
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	str	d16, [x0]
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x10
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	str	d16, [x0]
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x18
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x1
               	str	d16, [x0]
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x20
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x1
               	str	d16, [x0]
               	sub	x0, x29, #0x28
               	mov	x1, #0x5                // =5
               	fmov	d0, x2
               	bl	<addr>
               	mov	x0, #0x200000000000     // =35184372088832
               	movk	x0, #0x4060, lsl #48
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x5                // =5
               	mov	x2, #0x0                // =0
               	fmov	d0, x2
               	bl	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	sxtw	x3, w1
               	mov	x17, #0x18              // =24
               	mul	x4, x3, x17
               	add	x0, x0, x4
               	sxtw	x4, w2
               	lsl	x5, x4, #3
               	add	x0, x0, x5
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sxtw	x3, w3
               	add	x3, x3, x4
               	sxtw	x3, w3
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	scvtf	d0, x3
               	str	d0, [x0]
               	sub	x0, x29, #0xb8
               	sxtw	x3, w1
               	mov	x17, #0x18              // =24
               	mul	x4, x3, x17
               	add	x0, x0, x4
               	sxtw	x4, w2
               	lsl	x5, x4, #3
               	add	x0, x0, x5
               	cmp	x3, x4
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x3
               	sub	x17, x29, #0xf8
               	str	d16, [x17]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	fmov	d16, x3
               	sub	x17, x29, #0xf8
               	str	d16, [x17]
               	b	<addr>
               	sub	x16, x29, #0xf8
               	ldr	d0, [x16]
               	str	d0, [x0]
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	mov	x21, #0x0               // =0
               	b	<addr>
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x70
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0x4058000000000000 // =4636455816377925632
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w21
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xb8
               	sxtw	x2, w20
               	sxtw	x3, w21
               	bl	<addr>
               	sub	x0, x29, #0x70
               	sxtw	x1, w20
               	mov	x17, #0x18              // =24
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	sxtw	x1, w21
               	lsl	x1, x1, #3
               	add	x0, x0, x1
               	ldr	d1, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	sub	x17, x29, #0xd0
               	str	d16, [x17]
               	mov	x1, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x0
               	fmov	d17, x1
               	fdiv	d8, d16, d17
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	sub	x16, x29, #0xd0
               	ldr	d0, [x16]
               	fmov	d1, d8
               	bl	<addr>
               	sub	x17, x29, #0xd0
               	str	d0, [x17]
               	b	<addr>
               	mov	x0, #0x5769             // =22377
               	movk	x0, #0x8b14, lsl #16
               	movk	x0, #0xbf0a, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0xe8
               	str	d16, [x17]
               	sub	x16, x29, #0xd0
               	ldr	d0, [x16]
               	sub	x16, x29, #0xe8
               	ldr	d1, [x16]
               	fsub	d1, d0, d1
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d1, d1
               	b	<addr>
               	mov	x0, #0xed8d             // =60813
               	movk	x0, #0xa0b5, lsl #16
               	movk	x0, #0xc6f7, lsl #32
               	movk	x0, #0x3eb0, lsl #48
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
