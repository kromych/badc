
if_converted_arms.aarch64:	file format elf64-littleaarch64

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

<makeq>:
               	neg	x1, x0
               	mov	w0, w0
               	orr	x0, x0, x1, lsl #32
               	ret

<narrow_compare_in_arm>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	lsr	x2, x0, #32
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x7
               	cset	x0, eq
               	cmp	x20, #0x12
               	csel	x0, x0, x1, eq
               	mov	x17, #-0x7              // =-7
               	cmp	w2, w17
               	cset	x2, eq
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<late_operands>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldrsb	x8, [x29, #0x10]
               	ldrsh	x9, [x29, #0x18]
               	ldrsw	x10, [x29, #0x20]
               	mov	x17, #0x3               // =3
               	mul	x9, x9, x17
               	sub	x10, x10, #0x1
               	cmp	w8, #0x0
               	csel	x8, x9, x10, gt
               	mov	x17, #0x5               // =5
               	mul	x8, x8, x17
               	sxtw	x8, w8
               	add	x6, x6, x8
               	ldrsb	x8, [x29, #0x10]
               	add	x6, x6, x8
               	add	x0, x6, x0
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x7
               	ldp	x29, x30, [sp], #0x10
               	ret

<swap_if>:
               	tst	x2, #0x1
               	csel	x3, x1, x0, ne
               	csel	x0, x0, x1, ne
               	mov	x17, #0xa               // =10
               	mul	x1, x3, x17
               	add	x0, x1, x0
               	ret

<diamond>:
               	sub	x2, x1, x0
               	sub	x3, x0, x1
               	cmp	x0, x1
               	csel	x0, x2, x3, lt
               	ret

<count_below>:
               	mov	x4, x0
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldrsw	x5, [x4, x0, lsl #2]
               	add	x6, x3, #0x1
               	cmp	w5, w2
               	csel	x3, x6, x3, lt
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x3
               	ret

<scale>:
               	sxtw	x0, w0
               	fmov	d1, #1.50000000
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x20]
               	cmp	x0, #0x0
               	fcsel	d1, d1, d2, ne
               	fmul	d0, d1, d0
               	ret

<umax>:
               	cmp	w0, w1
               	csel	x0, x0, x1, hi
               	ret

<pick_ne>:
               	fcmp	d0, d1
               	csel	x0, x0, x1, ne
               	ret

<pick_eq>:
               	fcmp	d0, d1
               	csel	x0, x0, x1, eq
               	ret

<pick_lt>:
               	fcmpe	d0, d1
               	csel	x0, x0, x1, mi
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	d8, [sp, #0x20]
               	mov	x0, #0x12               // =18
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x6, #0x10               // =16
               	mov	x16, #0x78              // =120
               	str	x16, [sp]
               	mov	x16, #-0x12c            // =-300
               	str	x16, [sp, #0x8]
               	mov	x16, #0x1170            // =4464
               	movk	x16, #0x1, lsl #16
               	str	x16, [sp, #0x10]
               	mov	x1, x0
               	mov	x7, x0
               	mov	x5, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	mov	x17, #-0x110c           // =-4364
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x6, #0x10               // =16
               	mov	x16, #-0x2              // =-2
               	str	x16, [sp]
               	mov	x16, #-0x12c            // =-300
               	str	x16, [sp, #0x8]
               	mov	x16, #0x1170            // =4464
               	movk	x16, #0x1, lsl #16
               	str	x16, [sp, #0x10]
               	mov	x1, x0
               	mov	x7, x0
               	mov	x5, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	mov	x17, #0x5739            // =22329
               	movk	x17, #0x5, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #-0x5               // =-5
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	mov	x1, #0x8                // =8
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x8                // =8
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	fmov	d0, #2.00000000
               	bl	<addr>
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x28]
               	bl	<addr>
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80000000         // =2147483648
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	mov	x1, #0xffffffff         // =4294967295
               	bl	<addr>
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	fdiv	d8, d0, d1
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	fmov	d0, #1.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	fmov	d1, d0
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	fmov	d0, #1.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	fmov	d1, d0
               	fmov	d0, d8
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	fmov	d1, d0
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	fmov	d0, d8
               	fmov	d1, d8
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	fmov	d0, #2.00000000
               	fmov	d1, #1.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	fmov	d0, #1.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	fmov	d1, d0
               	fmov	d0, d8
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	fmov	d0, #1.00000000
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	fmov	d1, d8
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
