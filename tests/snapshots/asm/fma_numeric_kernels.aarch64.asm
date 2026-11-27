
fma_numeric_kernels.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	ldr	d2, [x1, x0, lsl #3]
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
               	ldr	d2, [x1, x0, lsl #3]
               	fmadd	d1, d1, d0, d2
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	fmov	d0, #1.00000000
               	fsub	d1, d1, d0
               	mov	x2, #0x0                // =0
               	fmov	d17, x2
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
               	mov	x7, #0x18               // =24
               	sub	x8, x29, #0x90
               	sub	x9, x29, #0x48
               	mov	x1, #0x0                // =0
               	mul	x0, x2, x7
               	add	x3, x8, x0
               	add	x4, x2, x2, lsl #1
               	add	x5, x9, x0
               	mov	x0, x1
               	add	x6, x4, x0
               	add	x6, x6, #0x1
               	scvtf	d1, x6
               	str	d1, [x3, x0, lsl #3]
               	cmp	w2, w0
               	fmov	d17, x1
               	fcsel	d1, d0, d17, eq
               	str	d1, [x5, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x4, #0x18               // =24
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	ldur	d2, [x29, #-0x48]
               	ldur	d3, [x29, #-0x30]
               	ldur	d4, [x29, #-0x18]
               	ldur	d5, [x29, #-0x40]
               	ldur	d6, [x29, #-0x28]
               	ldur	d7, [x29, #-0x10]
               	ldur	d19, [x29, #-0x38]
               	ldur	d20, [x29, #-0x20]
               	ldur	d21, [x29, #-0x8]
               	sub	x3, x29, #0x90
               	mov	x2, x0
               	mul	x5, x2, x4
               	add	x1, x3, x5
               	ldr	d0, [x1]
               	fmov	d18, x0
               	fmadd	d22, d0, d2, d18
               	ldr	d23, [x1, #0x8]
               	fmadd	d22, d23, d3, d22
               	ldr	d23, [x1, #0x10]
               	fmadd	d22, d23, d4, d22
               	fsub	d0, d22, d0
               	fmov	d17, x0
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmpe	d0, d1
               	b.pl	<addr>
               	ldr	d0, [x1]
               	fmov	d18, x0
               	fmadd	d0, d0, d5, d18
               	ldr	d22, [x1, #0x8]
               	fmadd	d0, d22, d6, d0
               	ldr	d22, [x1, #0x10]
               	fmadd	d0, d22, d7, d0
               	add	x1, x3, x5
               	ldr	d22, [x1, #0x8]
               	fsub	d0, d0, d22
               	fmov	d17, x0
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmpe	d0, d1
               	b.pl	<addr>
               	mul	x1, x2, x4
               	add	x1, x3, x1
               	ldr	d0, [x1]
               	fmov	d18, x0
               	fmadd	d0, d0, d19, d18
               	ldr	d22, [x1, #0x8]
               	fmadd	d22, d22, d20, d0
               	ldr	d0, [x1, #0x10]
               	fmadd	d22, d0, d21, d22
               	fsub	d0, d22, d0
               	fmov	d17, x0
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	fcmpe	d0, d1
               	b.pl	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldur	d0, [x29, #-0x78]
               	ldur	d1, [x29, #-0x80]
               	fmov	d18, x0
               	fmadd	d1, d0, d1, d18
               	ldur	d2, [x29, #-0x70]
               	ldur	d0, [x29, #-0x68]
               	fmadd	d1, d2, d0, d1
               	ldur	d2, [x29, #-0x50]
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
