
init_scalar_conversion.aarch64:	file format elf64-littleaarch64

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

<rect_ok>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	d0, [x29, #-0x20]
               	stur	d1, [x29, #-0x18]
               	stur	d2, [x29, #-0x10]
               	stur	d3, [x29, #-0x8]
               	sub	x1, x29, #0x20
               	ldr	d0, [x1]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x1, #0x8]
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	d0, [x1, #0x10]
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	d0, [x1, #0x18]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	cset	x0, eq
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x348             // =840
               	mov	x21, #0x21c             // =540
               	scvtf	d0, x20
               	scvtf	d1, x21
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	b.ne	<addr>
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x8]
               	fcmp	d1, d3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x7, x29, #0x20
               	stp	xzr, xzr, [x7]
               	stp	xzr, xzr, [x7, #0x10]
               	movi	d4, #0000000000000000
               	str	d4, [x7]
               	str	d4, [x7, #0x8]
               	str	d0, [x7, #0x10]
               	str	d1, [x7, #0x18]
               	ldr	d5, [x7, #0x10]
               	fcmp	d5, d2
               	b.ne	<addr>
               	ldr	d5, [x7, #0x18]
               	fcmp	d5, d3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	fcmp	d0, d2
               	b.ne	<addr>
               	fcmp	d1, d3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x10]
               	fcvtzs	x0, d0
               	cmp	w0, #0x3
               	b.ne	<addr>
               	fadd	d0, d0, d4
               	fcvt	s0, d0
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x18]
               	fcmp	s0, s1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x1c]
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x7, #0x10]
               	ldr	d3, [x7, #0x18]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x7, x29, #0x20
               	stp	xzr, xzr, [x7]
               	stp	xzr, xzr, [x7, #0x10]
               	str	xzr, [x7]
               	str	xzr, [x7, #0x8]
               	scvtf	d0, x20
               	str	d0, [x7, #0x10]
               	scvtf	d0, x21
               	str	d0, [x7, #0x18]
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x7, #0x10]
               	ldr	d3, [x7, #0x18]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
