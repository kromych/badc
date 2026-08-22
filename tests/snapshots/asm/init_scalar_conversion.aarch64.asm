
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
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
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
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>

<main>:
               	stp	d8, d9, [sp, #-0x90]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x22, #0x348             // =840
               	mov	x23, #0x21c             // =540
               	sub	x1, x29, #0x18
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	scvtf	d8, x22
               	str	d8, [x1]
               	scvtf	d9, x23
               	str	d9, [x1, #0x8]
               	ldr	d0, [x1]
               	mov	x3, #0x400000000000     // =70368744177664
               	movk	x3, #0x408a, lsl #48
               	fmov	d17, x3
               	fcmp	d0, d17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	d0, [x1, #0x8]
               	mov	x1, #0xe00000000000     // =246290604621824
               	movk	x1, #0x4080, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	sub	x20, x29, #0x28
               	str	x0, [x20]
               	str	x0, [x20, #0x8]
               	str	x0, [x20, #0x10]
               	str	x0, [x20, #0x18]
               	fmov	d16, x0
               	str	d16, [x20]
               	fmov	d16, x0
               	str	d16, [x20, #0x8]
               	str	d8, [x20, #0x10]
               	str	d9, [x20, #0x18]
               	ldr	d0, [x20, #0x10]
               	fmov	d17, x3
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	d0, [x20, #0x18]
               	mov	x1, #0xe00000000000     // =246290604621824
               	movk	x1, #0x4080, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	sub	x1, x29, #0x38
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	d8, [x1]
               	str	d9, [x1, #0x8]
               	ldr	d0, [x1]
               	fmov	d17, x3
               	fcmp	d0, d17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	d0, [x1, #0x8]
               	mov	x1, #0xe00000000000     // =246290604621824
               	movk	x1, #0x4080, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	mov	x1, #0x3333             // =13107
               	movk	x1, #0x3333, lsl #16
               	movk	x1, #0x3333, lsl #32
               	movk	x1, #0x400f, lsl #48
               	fmov	d16, x1
               	sub	x17, x29, #0x50
               	str	d16, [x17]
               	sub	x16, x29, #0x50
               	ldr	d0, [x16]
               	fcvtzs	x1, d0
               	sxtw	x1, w1
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, x0
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	mov	x1, #0x0                // =0
               	fmov	s16, w1
               	sub	x17, x29, #0x48
               	str	s16, [x17]
               	sub	x1, x29, #0x30
               	str	w0, [x1]
               	sub	x16, x29, #0x50
               	ldr	d0, [x16]
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x1]
               	ldr	s0, [x1]
               	sub	x17, x29, #0x48
               	str	s0, [x17]
               	sub	x16, x29, #0x48
               	ldr	s0, [x16]
               	mov	x0, #0xf5c3             // =62915
               	movk	x0, #0x4078, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, mi
               	cbnz	x0, <addr>
               	sub	x16, x29, #0x48
               	ldr	s0, [x16]
               	mov	x0, #0x3d71             // =15729
               	movk	x0, #0x407a, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	ldr	d0, [x20]
               	ldr	d1, [x20, #0x8]
               	ldr	d2, [x20, #0x10]
               	ldr	d3, [x20, #0x18]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	mov	x21, #0x0               // =0
               	str	x21, [x20]
               	str	x21, [x20, #0x8]
               	str	x21, [x20, #0x10]
               	str	x21, [x20, #0x18]
               	sub	x0, x29, #0x28
               	fmov	d16, x21
               	str	d16, [x0]
               	fmov	d16, x21
               	str	d16, [x0, #0x8]
               	str	d8, [x0, #0x10]
               	str	d9, [x0, #0x18]
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
