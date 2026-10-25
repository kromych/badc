
scanf_family_stores_c99_conversions_alike.aarch64:	file format elf64-littleaarch64

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

<v_string>:
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
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x18
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x30             // =-48
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	ldr	x0, [x29, #0x10]
               	ldr	x1, [x29, #0x18]
               	sub	x2, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<v_stream>:
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
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x18
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x30             // =-48
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	ldr	x0, [x29, #0x10]
               	ldr	x1, [x29, #0x18]
               	sub	x2, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<v_wide>:
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
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x18
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x30             // =-48
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	ldr	x0, [x29, #0x10]
               	ldr	x1, [x29, #0x18]
               	sub	x2, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<check>:
               	stp	x20, x21, [sp, #-0x160]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x150]
               	add	x29, sp, #0x150
               	mov	x21, x0
               	sub	x0, x29, #0x100
               	ldr	x1, [x21]
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x80
               	ldr	x1, [x21, #0x8]
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	cmp	w20, #0x2
               	b.eq	<addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	cmp	w20, #0x6
               	b.ne	<addr>
               	bl	<addr>
               	mov	x22, x0
               	sub	x24, x29, #0x110
               	mov	x1, #0xaa               // =170
               	mov	x2, #0x10               // =16
               	mov	x0, x24
               	bl	<addr>
               	cbz	x22, <addr>
               	cmp	w20, #0x6
               	b.ne	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, x22
               	bl	<addr>
               	cbz	x22, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cmp	w20, #0x3
               	b.lt	<addr>
               	cmp	w20, #0x5
               	b.lt	<addr>
               	cmp	w20, #0x6
               	b.lt	<addr>
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x110
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	cbz	x22, <addr>
               	mov	x0, x22
               	bl	<addr>
               	sub	x0, x29, #0x120
               	mov	x2, #0x4                // =4
               	mov	x1, x24
               	bl	<addr>
               	sub	x0, x29, #0x118
               	sub	x24, x29, #0x110
               	mov	x2, #0x8                // =8
               	mov	x1, x24
               	bl	<addr>
               	ldrsw	x0, [x21, #0x14]
               	cmp	w0, #0x0
               	b.ge	<addr>
               	ldrsw	x0, [x21, #0x14]
               	neg	x22, x0
               	ldrsw	x0, [x21, #0x14]
               	mov	x17, #-0x4              // =-4
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	s0, [sp, #0x30]
               	fcmp	s0, s0
               	cset	x1, ne
               	sub	x2, x29, #0x110
               	ldrb	w0, [x2, w22, sxtw]
               	mov	x17, #0xaa              // =170
               	eor	x3, x0, x17
               	mov	x0, #0x1                // =1
               	cbz	w3, <addr>
               	cmp	w20, #0x4
               	mov	x0, #0x0                // =0
               	b.lt	<addr>
               	cmp	w22, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	sub	x3, x22, #0x1
               	ldrb	w3, [x2, w3, sxtw]
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w0, [x2, w22, sxtw]
               	cmp	w0, #0x0
               	cset	x0, eq
               	ldrsw	x2, [x21, #0x10]
               	cmp	w23, w2
               	b.ne	<addr>
               	cbz	w1, <addr>
               	cbnz	w0, <addr>
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	ldrsw	x0, [x21, #0x14]
               	mov	x17, #-0x8              // =-8
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	d0, [sp, #0x38]
               	fcmp	d0, d0
               	cset	x1, ne
               	b	<addr>
               	ldr	x1, [x21, #0x18]
               	sxtw	x2, w22
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	ldrsw	x22, [x21, #0x14]
               	b	<addr>
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x110
               	bl	<addr>
               	mov	x23, x0
               	b	<addr>
               	cmp	w20, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x110
               	bl	<addr>
               	mov	x23, x0
               	b	<addr>
               	ldr	x1, [x21, #0x8]
               	sub	x2, x29, #0x110
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	b	<addr>
               	cmp	w20, #0x1
               	b.lt	<addr>
               	cmp	w20, #0x2
               	b.lt	<addr>
               	ldr	x1, [x21, #0x8]
               	sub	x2, x29, #0x110
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	b	<addr>
               	ldr	x0, [x21]
               	ldr	x1, [x21, #0x8]
               	sub	x2, x29, #0x110
               	bl	<addr>
               	mov	x23, x0
               	b	<addr>
               	ldr	x0, [x21]
               	ldr	x1, [x21, #0x8]
               	mov	x2, x24
               	bl	<addr>
               	mov	x23, x0
               	b	<addr>
               	cbz	x22, <addr>
               	ldr	x0, [x21]
               	mov	x1, x22
               	bl	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x7
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	add	x0, x20, #0x1
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret

<main>:
               	str	x20, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x20, lsl #5
               	bl	<addr>
               	cbnz	w0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x26
               	b.lo	<addr>
               	stur	wzr, [x29, #-0x68]
               	stur	wzr, [x29, #-0x60]
               	stur	xzr, [x29, #-0x58]
               	stur	wzr, [x29, #-0x50]
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x68
               	bl	<addr>
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x58
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x58]
               	sub	x2, x29, #0x68
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x64               // =100
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x3, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x60]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x20
               	sub	x3, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ne	<addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x50]
               	cmp	w0, #0x71
               	b.eq	<addr>
               	mov	x0, #0x66               // =102
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x20
               	sub	x3, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ne	<addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x50]
               	cmp	w0, #0x71
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	stur	xzr, [x29, #-0x48]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x68
               	sub	x3, x29, #0x40
               	sub	x4, x29, #0x48
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	w0, #0xc
               	b.ne	<addr>
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	d0, [x29, #-0x48]
               	fmov	d1, #3.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	bl	<addr>
               	mov	x20, x0
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x69               // =105
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x68
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	w0, #0xc
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	add	x0, x20, #0x1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
