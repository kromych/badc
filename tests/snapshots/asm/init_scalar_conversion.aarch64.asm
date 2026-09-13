
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
               	sub	x16, x29, #0x20
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	str	d3, [x16, #0x18]
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
               	mov	x2, #0x400000000000     // =70368744177664
               	movk	x2, #0x408a, lsl #48
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	d0, [x1, #0x18]
               	mov	x0, #0xe00000000000     // =246290604621824
               	movk	x0, #0x4080, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
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
               	mov	x2, #0x400000000000     // =70368744177664
               	movk	x2, #0x408a, lsl #48
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x3, #0xe00000000000     // =246290604621824
               	movk	x3, #0x4080, lsl #48
               	fmov	d17, x3
               	fcmp	d1, d17
               	cset	x4, ne
               	mov	x0, x4
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	mov	x1, #0x0                // =0
               	fmov	d16, x1
               	str	d16, [x0]
               	fmov	d16, x1
               	str	d16, [x0, #0x8]
               	str	d0, [x0, #0x10]
               	str	d1, [x0, #0x18]
               	ldr	d2, [x0, #0x10]
               	fmov	d17, x2
               	fcmp	d2, d17
               	b.ne	<addr>
               	ldr	d2, [x0, #0x18]
               	fmov	d17, x3
               	fcmp	d2, d17
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	cbz	x4, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x2, #0x3333             // =13107
               	movk	x2, #0x3333, lsl #16
               	movk	x2, #0x3333, lsl #32
               	movk	x2, #0x400f, lsl #48
               	fmov	d16, x2
               	fcvtzs	x3, d16
               	cmp	w3, #0x3
               	b.ne	<addr>
               	mov	x3, x1
               	fmov	d16, x2
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	fcvt	s0, d0
               	mov	x1, #0xf5c3             // =62915
               	movk	x1, #0x4078, lsl #16
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.mi	<addr>
               	mov	x1, #0x3d71             // =15729
               	movk	x1, #0x407a, lsl #16
               	fmov	s17, w1
               	fcmp	s0, s17
               	cset	x1, gt
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	mov	x1, #0x0                // =0
               	fmov	d16, x1
               	str	d16, [x0]
               	fmov	d16, x1
               	str	d16, [x0, #0x8]
               	scvtf	d0, x20
               	str	d0, [x0, #0x10]
               	scvtf	d0, x21
               	str	d0, [x0, #0x18]
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	bl	<addr>
               	cbnz	x0, <addr>
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
