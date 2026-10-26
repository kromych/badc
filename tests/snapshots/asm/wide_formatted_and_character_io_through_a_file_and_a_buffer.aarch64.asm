
wide_formatted_and_character_io_through_a_file_and_a_buffer.aarch64:	file format elf64-littleaarch64

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

<vformat>:
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
               	add	x1, x29, #0x20
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x28             // =-40
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	ldr	x0, [x29, #0x10]
               	ldr	x1, [x29, #0x18]
               	ldr	x2, [x29, #0x20]
               	sub	x3, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<vscan>:
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

<vfile_print>:
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

<vfile_scan>:
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

<buffers>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	stur	wzr, [x29, #-0xb8]
               	stur	wzr, [x29, #-0xb0]
               	stur	xzr, [x29, #-0xa8]
               	sub	x0, x29, #0x80
               	mov	x1, #0x20               // =32
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2a               // =42
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	mov	x5, #0x7a               // =122
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.ne	<addr>
               	sub	x0, x29, #0x80
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x4                // =4
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	mov	x3, #0x3039             // =12345
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x4                // =4
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	mov	x3, #0x7b               // =123
               	bl	<addr>
               	cmp	w0, #0x3
               	b.ne	<addr>
               	sub	x0, x29, #0x80
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x20               // =32
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	mov	x4, #-0x7               // =-7
               	bl	<addr>
               	cmp	w0, #0x6
               	b.ne	<addr>
               	sub	x0, x29, #0x80
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0xb8
               	sub	x3, x29, #0xa0
               	sub	x4, x29, #0xa8
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xb8]
               	cmp	w0, #0x11
               	b.ne	<addr>
               	sub	x0, x29, #0xa0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	d0, [x29, #-0xa8]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0xb8
               	sub	x3, x29, #0xb0
               	bl	<addr>
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xb8]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xb0]
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret

<file>:
               	str	x20, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	bl	<addr>
               	mov	x20, x0
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x70]
               	stur	w1, [x29, #-0x68]
               	cbnz	x20, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.gt	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.ne	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x8                // =8
               	mov	x0, x20
               	bl	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x78               // =120
               	mov	x1, x20
               	bl	<addr>
               	eor	x0, x0, #0x78
               	cbnz	w0, <addr>
               	mov	x0, #0x79               // =121
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x70
               	sub	x3, x29, #0x60
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x70]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	sub	x0, x29, #0x60
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x68
               	mov	x0, x20
               	bl	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, x20
               	bl	<addr>
               	eor	x0, x0, #0x78
               	cbnz	w0, <addr>
               	mov	x0, #0x78               // =120
               	mov	x1, x20
               	bl	<addr>
               	eor	x0, x0, #0x78
               	cbz	w0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x10               // =16
               	mov	x2, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x40
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret

<strings_and_conversions>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	sub	x0, x29, #0xc0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	stur	xzr, [x29, #-0xc8]
               	sub	x1, x29, #0x80
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	stp	xzr, xzr, [x1, #0x50]
               	stp	xzr, xzr, [x1, #0x60]
               	stp	xzr, xzr, [x1, #0x70]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0xc0
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0xc
               	cmp	x1, x2
               	b.ne	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x2c
               	cmp	x1, x2
               	b.ne	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0xc8
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	mov	x17, #-0x1a00           // =-6656
               	movk	x17, #0xe78e, lsl #16
               	movk	x17, #0xfffd, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xc8]
               	ldr	w0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0xc8
               	bl	<addr>
               	fmov	s1, #2.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xc8]
               	ldr	w0, [x0]
               	cmp	w0, #0x78
               	b.ne	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	stur	q0, [x29, #-0xe0]
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0xe0]
               	ldur	x10, [x29, #-0xd8]
               	lsr	x11, x10, #63
               	lsl	x11, x11, #63
               	lsl	x12, x10, #1
               	lsr	x12, x12, #49
               	and	x10, x10, #0xffffffffffff
               	mov	x13, #0x7fff            // =32767
               	cmp	x12, x13
               	b.ne	<addr>
               	orr	x13, x10, x9
               	cbz	x13, <addr>
               	lsl	x13, x10, #4
               	orr	x13, x13, x9, lsr #60
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	orr	x10, x10, x9, lsr #49
               	cmp	x12, #0x0
               	cset	x13, ne
               	orr	x10, x10, x13, lsl #63
               	and	x9, x9, #0x1ffffffffffff
               	cmp	x9, #0x0
               	cset	x9, ne
               	cmp	x12, #0x0
               	cset	x13, eq
               	add	x12, x12, x13
               	cbz	x10, <addr>
               	clz	x13, x10
               	lsl	x10, x10, x13
               	sub	x12, x12, x13
               	sub	x12, x12, #0x3, lsl #12 // =0x3000
               	sub	x12, x12, #0xc00
               	mov	x13, #0x7ff             // =2047
               	cmp	x12, x13
               	b.ge	<addr>
               	mov	x13, #0x1               // =1
               	sub	x13, x13, x12
               	bic	x13, x13, x13, asr #63
               	add	x13, x13, #0xa
               	mov	x15, #0x3f              // =63
               	cmp	x13, x15
               	b.gt	<addr>
               	lsr	x14, x10, #1
               	lsr	x14, x14, x13
               	lsr	x15, x10, x13
               	neg	x13, x13
               	lsl	x10, x10, x13
               	cmp	x10, #0x0
               	cset	x10, ne
               	orr	x9, x9, x10
               	and	x10, x14, #0x1
               	orr	x9, x9, x10
               	and	x15, x15, #0x1
               	and	x9, x9, x15
               	sub	x10, x12, #0x1
               	bic	x12, x10, x10, asr #63
               	add	x14, x14, x12, lsl #52
               	add	x14, x14, x9
               	add	x14, x14, x11
               	b	<addr>
               	orr	x14, x11, #0x7ff0000000000000
               	b	<addr>
               	mov	x14, x11
               	fmov	d0, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	fmov	d1, #0.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x80
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x80
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
