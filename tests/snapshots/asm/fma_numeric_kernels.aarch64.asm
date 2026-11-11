
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
               	fmov	d0, #1.00000000
               	stur	d0, [x29, #-0x28]
               	fmov	d1, #2.00000000
               	stur	d1, [x29, #-0x20]
               	fmov	d0, #3.00000000
               	stur	d0, [x29, #-0x18]
               	fmov	d0, #4.00000000
               	stur	d0, [x29, #-0x10]
               	fmov	d0, #5.00000000
               	stur	d0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	mov	x0, #0x3                // =3
               	add	x2, x1, x0, lsl #3
               	ldr	d2, [x2]
               	fmadd	d0, d0, d1, d2
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fsub	d1, d0, d1
               	movi	d0, #0000000000000000
               	fcmpe	d1, d0
               	b.pl	<addr>
               	fneg	d1, d1
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x8]
               	fcmpe	d1, d2
               	b.mi	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	ldur	d1, [x29, #-0x8]
               	mov	x0, #0x3                // =3
               	add	x2, x1, x0, lsl #3
               	ldr	d2, [x2]
               	fmadd	d1, d1, d0, d2
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	fmov	d0, #1.00000000
               	fsub	d1, d1, d0
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmpe	d1, d17
               	b.pl	<addr>
               	fneg	d1, d1
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x8]
               	fcmpe	d1, d2
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, #0x18               // =24
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	sub	x4, x29, #0x90
               	mul	x3, x1, x5
               	add	x6, x4, x3
               	lsl	x4, x0, #3
               	add	x6, x6, x4
               	add	x7, x1, x1, lsl #1
               	add	x7, x7, x0
               	add	x7, x7, #0x1
               	sxtw	x7, w7
               	scvtf	d1, x7
               	str	d1, [x6]
               	sub	x6, x29, #0x48
               	add	x3, x6, x3
               	add	x3, x3, x4
               	cmp	w1, w0
               	fmov	d17, x2
               	fcsel	d1, d0, d17, eq
               	str	d1, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x3, #0x18               // =24
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	ldur	d3, [x29, #-0x48]
               	ldur	d4, [x29, #-0x40]
               	ldur	d5, [x29, #-0x38]
               	mov	x1, x2
               	sub	x0, x29, #0x90
               	sub	x4, x29, #0x48
               	mul	x5, x1, x3
               	add	x0, x0, x5
               	ldr	d0, [x0]
               	fmov	d18, x2
               	fmadd	d0, d0, d3, d18
               	ldr	d2, [x0, #0x8]
               	add	x6, x4, #0x18
               	ldr	d6, [x6]
               	fmadd	d0, d2, d6, d0
               	ldr	d2, [x0, #0x10]
               	add	x4, x4, #0x30
               	ldr	d6, [x4]
               	fmadd	d0, d2, d6, d0
               	ldr	d2, [x0]
               	fsub	d0, d0, d2
               	fmov	d17, x2
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmpe	d0, d1
               	b.pl	<addr>
               	ldr	d0, [x0]
               	fmov	d18, x2
               	fmadd	d0, d0, d4, d18
               	ldr	d2, [x0, #0x8]
               	ldr	d6, [x6, #0x8]
               	fmadd	d0, d2, d6, d0
               	ldr	d2, [x0, #0x10]
               	ldr	d6, [x4, #0x8]
               	fmadd	d0, d2, d6, d0
               	sub	x0, x29, #0x90
               	add	x4, x0, x5
               	ldr	d2, [x4, #0x8]
               	fsub	d0, d0, d2
               	movi	d2, #0000000000000000
               	fcmpe	d0, d2
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmpe	d0, d1
               	b.pl	<addr>
               	sub	x4, x29, #0x48
               	mul	x5, x1, x3
               	add	x0, x0, x5
               	ldr	d0, [x0]
               	fmadd	d0, d0, d5, d2
               	ldr	d6, [x0, #0x8]
               	add	x5, x4, #0x18
               	ldr	d7, [x5, #0x10]
               	fmadd	d6, d6, d7, d0
               	ldr	d0, [x0, #0x10]
               	add	x0, x4, #0x30
               	ldr	d7, [x0, #0x10]
               	fmadd	d6, d0, d7, d6
               	fsub	d0, d6, d0
               	fcmpe	d0, d2
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmpe	d0, d1
               	b.pl	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0x90
               	mov	x0, #0x0                // =0
               	ldur	d0, [x29, #-0x78]
               	ldur	d1, [x29, #-0x80]
               	fmov	d18, x0
               	fmadd	d1, d0, d1, d18
               	add	x2, x1, #0x18
               	ldr	d2, [x2, #0x8]
               	ldr	d0, [x2, #0x10]
               	fmadd	d1, d2, d0, d1
               	add	x1, x1, #0x30
               	ldr	d2, [x1, #0x10]
               	fmadd	d0, d0, d2, d1
               	mov	x16, #0x4058000000000000 // =4636455816377925632
               	fmov	d1, x16
               	fsub	d0, d0, d1
               	fmov	d17, x0
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmpe	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x4                // =4
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
