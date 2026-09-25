
callee_function_types.aarch64:	file format elf64-littleaarch64

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

<twice>:
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	ret

<half>:
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	ret

<getfp>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<getfp_t>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<vsum>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x2, x29, #0x20
               	add	x0, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.ge	<addr>
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldrsw	x3, [x3]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<callee_forms>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	fmov	d0, #3.00000000
               	fmov	d2, #2.00000000
               	fmul	d2, d0, d2
               	fcmp	d2, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x2
               	ldur	x0, [x29, #-0x8]
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	fmov	d0, #3.00000000
               	fmov	d2, #2.00000000
               	fmul	d2, d0, d2
               	fcmp	d2, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	blr	x0
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x100
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x200
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x400
               	fmov	d0, #3.00000000
               	fmov	d2, #2.00000000
               	fmul	d2, d0, d2
               	fcmp	d2, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x800
               	fcmp	d2, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x1000
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x2000
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	fmov	d0, #3.00000000
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x4000
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>

<value_forms>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x0               // =0
               	fmov	d0, #3.00000000
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x2
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x10
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x20
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x40
               	sub	x0, x0, #0x1
               	add	x0, x0, #0x1
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x0, x0, #0x1
               	add	x0, x0, #0x1
               	add	x21, x0, #0x1
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x100
               	sub	x0, x21, #0x1
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x200
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<result_types>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	fmov	d0, #3.00000000
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x2
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	blr	x0
               	fmov	d0, #3.00000000
               	blr	x0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x10
               	fmov	d0, #3.00000000
               	fmov	d2, #2.00000000
               	fmul	d0, d0, d2
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x20
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x40
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x80
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x100
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x200
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x400
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x800
               	mov	x0, #0x3                // =3
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, x0
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	orr	x20, x20, #0x1000
               	fmov	s0, #1.50000000
               	fcvt	d1, s0
               	fmov	d0, #2.00000000
               	fmul	d2, d1, d0
               	fmov	d1, #3.00000000
               	fcmp	d2, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x2000
               	fmul	d0, d1, d0
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x4000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x8000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x10000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x20000
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<array_elements>:
               	str	d8, [sp, #-0x30]!
               	str	x20, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x2
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fadd	d0, d8, d0
               	fmov	d1, #12.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x10
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fadd	d0, d8, d0
               	fmov	d1, #12.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x20
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x40
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x20, x20, #0x80
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
