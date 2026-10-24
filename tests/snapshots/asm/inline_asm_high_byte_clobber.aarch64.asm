
inline_asm_high_byte_clobber.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	ret

<gprs>:
               	stp	x24, x25, [sp, #-0x70]!
               	stp	x26, x27, [sp, #0x10]
               	stp	x28, x20, [sp, #0x20]
               	stp	x21, x22, [sp, #0x30]
               	str	x23, [sp, #0x40]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x17, #0x3               // =3
               	mul	x2, x0, x17
               	add	x24, x2, x1
               	mov	x17, #0x5               // =5
               	mul	x2, x0, x17
               	sub	x25, x2, x1
               	eor	x26, x0, x1, lsl #4
               	mov	x17, #0x7               // =7
               	mul	x2, x1, x17
               	add	x27, x0, x2
               	mul	x2, x0, x1
               	add	x28, x2, #0x1
               	mov	x17, #0x3               // =3
               	mul	x2, x1, x17
               	sub	x16, x0, x2
               	str	x16, [sp, #0x58]
               	mov	x17, #0x9               // =9
               	mul	x0, x1, x17
               	add	x16, x0, #0x2
               	str	x16, [sp, #0x50]
               	bl	<addr>
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	bl	<addr>
               	add	x0, x24, x25, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x1, x26, x17
               	add	x0, x0, x1
               	add	x0, x0, x27, lsl #2
               	mov	x17, #0x5               // =5
               	mul	x1, x28, x17
               	add	x0, x0, x1
               	ldr	x16, [sp, #0x58]
               	mov	x17, #0x6               // =6
               	mul	x1, x16, x17
               	add	x0, x0, x1
               	ldr	x16, [sp, #0x50]
               	mov	x17, #0x7               // =7
               	mul	x1, x16, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x23, [sp, #0x40]
               	ldp	x21, x22, [sp, #0x30]
               	ldp	x28, x20, [sp, #0x20]
               	ldp	x26, x27, [sp, #0x10]
               	ldp	x24, x25, [sp], #0x70
               	ret

<simd>:
               	stp	d8, d9, [sp, #-0x90]!
               	stp	d10, d11, [sp, #0x10]
               	stp	d12, d13, [sp, #0x20]
               	stp	d14, d15, [sp, #0x30]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	fmov	d2, #1.50000000
               	fmul	d16, d0, d2
               	str	d16, [sp, #0x78]
               	fmov	d2, #2.50000000
               	fmul	d16, d1, d2
               	str	d16, [sp, #0x70]
               	fadd	d16, d0, d1
               	str	d16, [sp, #0x68]
               	fsub	d16, d0, d1
               	str	d16, [sp, #0x60]
               	fmul	d16, d0, d1
               	str	d16, [sp, #0x58]
               	fdiv	d16, d0, d1
               	str	d16, [sp, #0x50]
               	fmov	d2, #3.25000000
               	fmul	d16, d0, d2
               	str	d16, [sp, #0x48]
               	fmov	d0, #7.00000000
               	fmul	d16, d1, d0
               	str	d16, [sp, #0x40]
               	bl	<addr>
               	movi	v8.2d, #0000000000000000
               	movi	v9.2d, #0000000000000000
               	movi	v10.2d, #0000000000000000
               	movi	v11.2d, #0000000000000000
               	movi	v12.2d, #0000000000000000
               	movi	v13.2d, #0000000000000000
               	movi	v14.2d, #0000000000000000
               	movi	v15.2d, #0000000000000000
               	bl	<addr>
               	fmov	d0, #2.00000000
               	ldr	d17, [sp, #0x70]
               	ldr	d18, [sp, #0x78]
               	fmadd	d0, d0, d17, d18
               	fmov	d1, #3.00000000
               	ldr	d17, [sp, #0x68]
               	fmadd	d0, d1, d17, d0
               	fmov	d1, #4.00000000
               	ldr	d17, [sp, #0x60]
               	fmadd	d0, d1, d17, d0
               	fmov	d1, #5.00000000
               	ldr	d17, [sp, #0x58]
               	fmadd	d0, d1, d17, d0
               	fmov	d1, #6.00000000
               	ldr	d17, [sp, #0x50]
               	fmadd	d0, d1, d17, d0
               	fmov	d1, #7.00000000
               	ldr	d17, [sp, #0x48]
               	fmadd	d0, d1, d17, d0
               	fmov	d1, #8.00000000
               	ldr	d17, [sp, #0x40]
               	fmadd	d0, d1, d17, d0
               	ldp	x29, x30, [sp, #0x80]
               	ldp	d14, d15, [sp, #0x30]
               	ldp	d12, d13, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret

<leaf_lr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x30, [sp]
               	mov	x30, xzr
               	ldr	x30, [sp]
               	add	x0, x0, #0x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<frame_fp>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x150
               	str	x20, [sp]
               	mov	x20, x0
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x130
               	add	x2, x2, x1
               	and	x3, x1, #0x7
               	strb	w3, [x2]
               	add	x1, x1, #0x1
               	cmp	w1, #0x12c
               	b.lt	<addr>
               	bl	<addr>
               	str	x29, [sp, #0x10]
               	mov	x29, xzr
               	ldr	x29, [sp, #0x10]
               	bl	<addr>
               	ldurb	w0, [x29, #-0x5]
               	ldrb	w1, [sp, #0x21]
               	add	x0, x0, x1
               	add	x0, x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	lsl	x1, x20, #1
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x127
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2a               // =42
               	b	<addr>
               	fmov	d0, #2.00000000
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	fmov	d1, #4.00000000
               	ldr	d2, [x0]
               	fmul	d1, d1, d2
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
