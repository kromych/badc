
printf_family_formats_c99_conversions.aarch64:	file format elf64-littleaarch64

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

<narrow>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	stur	xzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #1.00000000
               	ldur	d1, [x29, #-0x8]
               	fdiv	d1, d0, d1
               	fmov	d2, #-1.00000000
               	ldur	d3, [x29, #-0x8]
               	fdiv	d2, d2, d3
               	ldur	d3, [x29, #-0x8]
               	fdiv	d0, d0, d3
               	fmov	d17, d1
               	fmov	d1, d2
               	fmov	d2, d0
               	fmov	d0, d17
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0xc
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #1.00000000
               	ldur	d1, [x29, #-0x8]
               	fdiv	d1, d0, d1
               	fmov	d2, #-1.00000000
               	ldur	d3, [x29, #-0x8]
               	fdiv	d2, d2, d3
               	ldur	d3, [x29, #-0x8]
               	fdiv	d0, d0, d3
               	fmov	d17, d1
               	fmov	d1, d2
               	fmov	d2, d0
               	fmov	d0, d17
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldur	d0, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	fdiv	d0, d0, d1
               	fabs	d0, d0
               	ldur	d1, [x29, #-0x8]
               	ldur	d2, [x29, #-0x8]
               	fdiv	d1, d1, d2
               	fabs	d1, d1
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x7
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldur	d0, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	fdiv	d0, d0, d1
               	fabs	d0, d0
               	ldur	d1, [x29, #-0x8]
               	ldur	d2, [x29, #-0x8]
               	fdiv	d1, d1, d2
               	fabs	d1, d1
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x12c              // =300
               	mov	x5, #0x1170             // =4464
               	movk	x5, #0x1, lsl #16
               	mov	x4, x3
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0xa
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x12c              // =300
               	mov	x5, #0x1170             // =4464
               	movk	x5, #0x1, lsl #16
               	mov	x4, x3
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #1.50000000
               	fmov	d1, #1.00000000
               	fmov	d2, #3.00000000
               	fdiv	d1, d1, d2
               	fmov	d2, d1
               	fmov	d1, d0
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x1d
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #1.50000000
               	fmov	d1, #1.00000000
               	fmov	d2, #3.00000000
               	fdiv	d1, d1, d2
               	fmov	d2, d1
               	fmov	d1, d0
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #0.50000000
               	fmov	d1, #1.50000000
               	fmov	d2, #2.50000000
               	fmov	d3, #-2.50000000
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x8
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #0.50000000
               	fmov	d1, #1.50000000
               	fmov	d2, #2.50000000
               	fmov	d3, #-2.50000000
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x560]
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x16
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x560]
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #1.50000000
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x568]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x570]
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x578]
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x27
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #1.50000000
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x568]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x570]
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x578]
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x5                // =5
               	mov	x4, #-0x6               // =-6
               	mov	x5, #0x7                // =7
               	mov	x6, #-0x1               // =-1
               	mov	x7, #0xff               // =255
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0xc
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x5                // =5
               	mov	x4, #-0x6               // =-6
               	mov	x5, #0x7                // =7
               	mov	x6, #-0x1               // =-1
               	mov	x7, #0xff               // =255
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x580]
               	fmov	d1, #2.50000000
               	mov	x3, #0x5                // =5
               	mov	x4, #0x6                // =6
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x14
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x580]
               	fmov	d1, #2.50000000
               	mov	x3, #0x5                // =5
               	mov	x4, #0x6                // =6
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0xff               // =255
               	mov	x4, #0x8                // =8
               	fmov	d0, #3.00000000
               	fmov	d1, #1.00000000
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x13
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0xff               // =255
               	mov	x4, #0x8                // =8
               	fmov	d0, #3.00000000
               	fmov	d1, #1.00000000
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x71               // =113
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x9
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x71               // =113
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #-1.50000000
               	mov	x3, #0x2a               // =42
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x12
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #-1.50000000
               	mov	x3, #0x2a               // =42
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x588]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x590]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x560]
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x31
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x588]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x590]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x560]
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x18
               	mov	x4, #0x64               // =100
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x28               // =40
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x4                // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.ne	<addr>
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x3039             // =12345
               	mov	x1, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x61               // =97
               	mov	x3, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1]
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	bl	<addr>
               	mov	x20, x0
               	cbz	x20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	fmov	d0, #2.25000000
               	mov	x2, #0x201              // =513
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	mov	x2, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2c               // =44
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret

<wide>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	str	x20, [sp]
               	stur	xzr, [x29, #-0x8]
               	sub	x0, x29, #0x108
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x5, #0x63               // =99
               	mov	x6, #0x77               // =119
               	mov	x7, #0x12c              // =300
               	fmov	d0, #1.00000000
               	ldur	d1, [x29, #-0x8]
               	fdiv	d0, d0, d1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x12
               	b.ne	<addr>
               	sub	x0, x29, #0x108
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x32               // =50
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x118
               	mov	x1, #0x4                // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.lt	<addr>
               	mov	x0, #0x33               // =51
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x20, x0
               	cbz	x20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x7                // =7
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x108
               	mov	x1, #0x40               // =64
               	mov	x2, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x108
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x35               // =53
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret

<comma>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x10]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x18]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	bl	<addr>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	fmov	d0, #1.50000000
               	fmov	d1, #0.25000000
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x3c              // =60
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>

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
