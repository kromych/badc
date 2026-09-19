
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
               	stp	d8, d9, [sp, #-0xb0]!
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	sub	x1, x29, #0x28
               	fmov	d0, #1.00000000
               	str	d0, [x1]
               	fmov	d1, #2.00000000
               	str	d1, [x1, #0x8]
               	fmov	d0, #3.00000000
               	str	d0, [x1, #0x10]
               	fmov	d0, #4.00000000
               	str	d0, [x1, #0x18]
               	fmov	d0, #5.00000000
               	str	d0, [x1, #0x20]
               	ldr	d0, [x1, #0x20]
               	mov	x0, #0x3                // =3
               	lsl	x2, x0, #3
               	add	x2, x1, x2
               	ldr	d2, [x2]
               	fmadd	d0, d0, d1, d2
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fsub	d1, d0, d1
               	movi	d0, #0000000000000000
               	fcmp	d1, d0
               	b.pl	<addr>
               	fneg	d1, d1
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x8]
               	fcmp	d1, d2
               	b.mi	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	d8, d9, [sp], #0xb0
               	ret
               	sub	x1, x29, #0x28
               	ldr	d1, [x1, #0x20]
               	mov	x0, #0x3                // =3
               	lsl	x2, x0, #3
               	add	x2, x1, x2
               	ldr	d2, [x2]
               	fmadd	d1, d1, d0, d2
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	fmov	d0, #1.00000000
               	fsub	d0, d1, d0
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	d8, d9, [sp], #0xb0
               	ret
               	mov	x4, #0x3                // =3
               	mov	x5, #0x18               // =24
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x90
               	mul	x2, x1, x5
               	add	x6, x3, x2
               	lsl	x3, x0, #3
               	add	x6, x6, x3
               	mul	x7, x1, x4
               	add	x7, x7, x0
               	add	x7, x7, #0x1
               	sxtw	x7, w7
               	scvtf	d0, x7
               	str	d0, [x6]
               	sub	x6, x29, #0x48
               	add	x2, x6, x2
               	add	x2, x2, x3
               	cmp	w1, w0
               	b.ne	<addr>
               	fmov	d0, #1.00000000
               	b	<addr>
               	movi	d0, #0000000000000000
               	str	d0, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x4, #0x18               // =24
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	mov	x1, x2
               	sub	x0, x29, #0x90
               	sub	x3, x29, #0x48
               	mul	x5, x1, x4
               	add	x0, x0, x5
               	ldr	d0, [x0]
               	ldr	d2, [x3]
               	fmov	d18, x2
               	fmadd	d0, d0, d2, d18
               	ldr	d2, [x0, #0x8]
               	add	x6, x3, #0x18
               	ldr	d3, [x6]
               	fmadd	d0, d2, d3, d0
               	ldr	d2, [x0, #0x10]
               	add	x7, x3, #0x30
               	ldr	d3, [x7]
               	fmadd	d0, d2, d3, d0
               	ldr	d2, [x0]
               	fsub	d0, d0, d2
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmp	d0, d1
               	b.pl	<addr>
               	ldr	d0, [x0]
               	ldr	d2, [x3, #0x8]
               	fmov	d18, x2
               	fmadd	d0, d0, d2, d18
               	ldr	d2, [x0, #0x8]
               	ldr	d3, [x6, #0x8]
               	fmadd	d0, d2, d3, d0
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x7, #0x8]
               	fmadd	d0, d2, d3, d0
               	sub	x3, x29, #0x90
               	add	x0, x3, x5
               	ldr	d2, [x0, #0x8]
               	fsub	d0, d0, d2
               	movi	d2, #0000000000000000
               	fcmp	d0, d2
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmp	d0, d1
               	b.pl	<addr>
               	sub	x0, x29, #0x48
               	mul	x5, x1, x4
               	add	x3, x3, x5
               	ldr	d0, [x3]
               	ldr	d3, [x0, #0x10]
               	fmadd	d0, d0, d3, d2
               	ldr	d3, [x3, #0x8]
               	add	x5, x0, #0x18
               	ldr	d4, [x5, #0x10]
               	fmadd	d3, d3, d4, d0
               	ldr	d0, [x3, #0x10]
               	add	x0, x0, #0x30
               	ldr	d4, [x0, #0x10]
               	fmadd	d3, d0, d4, d3
               	fsub	d0, d3, d0
               	fcmp	d0, d2
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmp	d0, d1
               	b.pl	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x90
               	movi	d1, #0000000000000000
               	ldr	d0, [x0, #0x18]
               	ldr	d2, [x0, #0x10]
               	fmadd	d2, d0, d2, d1
               	add	x1, x0, #0x18
               	ldr	d3, [x1, #0x8]
               	ldr	d0, [x1, #0x10]
               	fmadd	d2, d3, d0, d2
               	add	x0, x0, #0x30
               	ldr	d3, [x0, #0x10]
               	fmadd	d0, d0, d3, d2
               	mov	x16, #0x4058000000000000 // =4636455816377925632
               	fmov	d2, x16
               	fsub	d0, d0, d2
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	d8, d9, [sp], #0xb0
               	ret
               	fmov	d3, #1.00000000
               	fmov	d0, #16.00000000
               	fdiv	d0, d3, d0
               	fmov	d5, #0.50000000
               	fmul	d2, d0, d5
               	fmadd	d6, d2, d3, d3
               	fmadd	d7, d2, d6, d3
               	fmadd	d8, d0, d7, d3
               	fmov	d1, #6.00000000
               	fdiv	d4, d0, d1
               	fmov	d1, #2.00000000
               	fmadd	d6, d1, d6, d3
               	fmadd	d6, d1, d7, d6
               	fadd	d6, d6, d8
               	fmadd	d3, d4, d6, d3
               	fmadd	d6, d2, d3, d3
               	fmadd	d7, d2, d6, d3
               	fmadd	d8, d0, d7, d3
               	fmadd	d6, d1, d6, d3
               	fmadd	d6, d1, d7, d6
               	fadd	d6, d6, d8
               	fmadd	d3, d4, d6, d3
               	fmadd	d6, d2, d3, d3
               	fmadd	d7, d2, d6, d3
               	fmadd	d8, d0, d7, d3
               	fmadd	d6, d1, d6, d3
               	fmadd	d6, d1, d7, d6
               	fadd	d6, d6, d8
               	fmadd	d3, d4, d6, d3
               	fmadd	d6, d2, d3, d3
               	fmadd	d7, d2, d6, d3
               	fmadd	d8, d0, d7, d3
               	fmadd	d6, d1, d6, d3
               	fmadd	d6, d1, d7, d6
               	fadd	d6, d6, d8
               	fmadd	d3, d4, d6, d3
               	fmadd	d6, d2, d3, d3
               	fmadd	d7, d2, d6, d3
               	fmadd	d8, d0, d7, d3
               	fmadd	d6, d1, d6, d3
               	fmadd	d6, d1, d7, d6
               	fadd	d6, d6, d8
               	fmadd	d3, d4, d6, d3
               	fmadd	d6, d2, d3, d3
               	fmadd	d2, d2, d6, d3
               	fmadd	d7, d0, d2, d3
               	fmadd	d6, d1, d6, d3
               	fmadd	d2, d1, d2, d6
               	fadd	d2, d2, d7
               	fmadd	d2, d4, d2, d3
               	fmul	d3, d0, d5
               	fmadd	d5, d3, d2, d2
               	fmadd	d6, d3, d5, d2
               	fmadd	d7, d0, d6, d2
               	fmadd	d5, d1, d5, d2
               	fmadd	d1, d1, d6, d5
               	fadd	d1, d1, d7
               	fmadd	d2, d4, d1, d2
               	fmadd	d4, d3, d2, d2
               	fmadd	d5, d3, d4, d2
               	fmadd	d7, d0, d5, d2
               	fmov	d6, #6.00000000
               	fdiv	d3, d0, d6
               	fmov	d1, #2.00000000
               	fmadd	d4, d1, d4, d2
               	fmadd	d4, d1, d5, d4
               	fadd	d4, d4, d7
               	fmadd	d4, d3, d4, d2
               	fmov	d5, #0.50000000
               	fmul	d2, d0, d5
               	fmadd	d7, d2, d4, d4
               	fmadd	d8, d2, d7, d4
               	fmadd	d9, d0, d8, d4
               	fmadd	d7, d1, d7, d4
               	fmadd	d7, d1, d8, d7
               	fadd	d7, d7, d9
               	fmadd	d4, d3, d7, d4
               	fmadd	d7, d2, d4, d4
               	fmadd	d8, d2, d7, d4
               	fmadd	d9, d0, d8, d4
               	fmadd	d7, d1, d7, d4
               	fmadd	d7, d1, d8, d7
               	fadd	d7, d7, d9
               	fmadd	d4, d3, d7, d4
               	fmadd	d7, d2, d4, d4
               	fmadd	d8, d2, d7, d4
               	fmadd	d9, d0, d8, d4
               	fmadd	d7, d1, d7, d4
               	fmadd	d7, d1, d8, d7
               	fadd	d7, d7, d9
               	fmadd	d4, d3, d7, d4
               	fmadd	d7, d2, d4, d4
               	fmadd	d8, d2, d7, d4
               	fmadd	d9, d0, d8, d4
               	fmadd	d7, d1, d7, d4
               	fmadd	d7, d1, d8, d7
               	fadd	d7, d7, d9
               	fmadd	d4, d3, d7, d4
               	fmadd	d7, d2, d4, d4
               	fmadd	d2, d2, d7, d4
               	fmadd	d8, d0, d2, d4
               	fmadd	d7, d1, d7, d4
               	fmadd	d2, d1, d2, d7
               	fadd	d2, d2, d8
               	fmadd	d2, d3, d2, d4
               	fmul	d4, d0, d5
               	fmadd	d5, d4, d2, d2
               	fmadd	d7, d4, d5, d2
               	fmadd	d8, d0, d7, d2
               	fmadd	d5, d1, d5, d2
               	fmadd	d5, d1, d7, d5
               	fadd	d5, d5, d8
               	fmadd	d2, d3, d5, d2
               	fmadd	d3, d4, d2, d2
               	fmadd	d4, d4, d3, d2
               	fmadd	d5, d0, d4, d2
               	fdiv	d6, d0, d6
               	fmadd	d3, d1, d3, d2
               	fmadd	d1, d1, d4, d3
               	fadd	d1, d1, d5
               	fmadd	d1, d6, d1, d2
               	fmov	d2, #0.50000000
               	fmul	d2, d0, d2
               	fmadd	d3, d2, d1, d1
               	fmadd	d2, d2, d3, d1
               	fmadd	d4, d0, d2, d1
               	fmov	d5, #6.00000000
               	fdiv	d5, d0, d5
               	fmov	d0, #2.00000000
               	fmadd	d3, d0, d3, d1
               	fmadd	d0, d0, d2, d3
               	fadd	d0, d0, d4
               	fmadd	d0, d5, d0, d1
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fsub	d0, d0, d1
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x18]
               	fcmp	d0, d1
               	b.le	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	d8, d9, [sp], #0xb0
               	ret
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	d8, d9, [sp], #0xb0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	d8, d9, [sp], #0xb0
               	ret
