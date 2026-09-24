
align16_arg_abi.aarch64:	file format elf64-littleaarch64

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

<mk>:
               	asr	x7, x0, #63
               	mov	x2, #0x0                // =0
               	mul	x3, x0, x2
               	mov	w4, w0
               	lsr	x5, x0, #32
               	mul	x4, x4, x2
               	lsr	x6, x4, #32
               	mul	x5, x5, x2
               	add	x6, x5, x6
               	mov	w8, w6
               	lsr	x6, x6, #32
               	add	x4, x4, x8
               	lsr	x4, x4, #32
               	add	x5, x5, x6
               	add	x4, x5, x4
               	add	x0, x4, x0
               	madd	x2, x7, x2, x0
               	add	x0, x3, x1
               	cmp	x0, x3
               	cset	x1, lo
               	add	x1, x2, x1
               	ret

<after_one>:
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x3, x17
               	add	x1, x1, x2
               	mov	x17, #0x7               // =7
               	mul	x2, x4, x17
               	add	x1, x1, x2
               	cmp	x0, #0x0
               	cset	x0, ne
               	add	x0, x1, x0
               	ret

<after_five>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x17, #0x3e8             // =1000
               	mul	x5, x7, x17
               	add	x5, x5, x6
               	ldr	x6, [x29, #0x10]
               	mov	x17, #0x7               // =7
               	mul	x6, x6, x17
               	add	x5, x5, x6
               	add	x0, x5, x0
               	lsl	x1, x1, #1
               	add	x0, x0, x1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	mov	x17, #0x5               // =5
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<after_seven>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16, #0x8]
               	sub	x7, x29, #0x10
               	ldr	x8, [x7]
               	ldr	x7, [x7, #0x8]
               	mov	x17, #0x3e8             // =1000
               	mul	x7, x7, x17
               	add	x7, x7, x8
               	ldr	x8, [x29, #0x20]
               	mov	x17, #0x7               // =7
               	mul	x8, x8, x17
               	add	x7, x7, x8
               	add	x0, x7, x0
               	lsl	x1, x1, #1
               	add	x0, x0, x1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	mov	x17, #0x5               // =5
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	lsl	x1, x6, #3
               	add	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<after_double>:
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x3, x17
               	add	x1, x1, x2
               	mov	x17, #0x7               // =7
               	mul	x2, x4, x17
               	add	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	fcvtzs	x1, d0
               	add	x0, x0, x1
               	ret

<twice>:
               	mov	x1, #0x0                // =0
               	lsl	x5, x2, #1
               	mov	w6, w2
               	lsr	x7, x2, #32
               	lsl	x8, x6, #1
               	lsr	x8, x8, #32
               	lsl	x9, x7, #1
               	add	x8, x9, x8
               	mov	w9, w8
               	lsr	x8, x8, #32
               	madd	x6, x6, x1, x9
               	lsr	x6, x6, #32
               	madd	x7, x7, x1, x8
               	add	x6, x7, x6
               	lsl	x3, x3, #1
               	madd	x1, x2, x1, x6
               	add	x2, x1, x3
               	asr	x3, x0, #63
               	add	x1, x5, x0
               	cmp	x1, x5
               	cset	x0, lo
               	add	x2, x2, x3
               	add	x2, x2, x0
               	asr	x3, x4, #63
               	add	x0, x1, x4
               	cmp	x0, x1
               	cset	x1, lo
               	add	x2, x2, x3
               	add	x1, x2, x1
               	ret

<wrapped>:
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x3, x17
               	add	x1, x1, x2
               	mov	x17, #0x7               // =7
               	mul	x2, x4, x17
               	add	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ret

<member_aligned>:
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x3, x17
               	add	x1, x1, x2
               	mov	x17, #0x7               // =7
               	mul	x2, x4, x17
               	add	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ret

<whole_aligned>:
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	mov	x17, #0x7               // =7
               	mul	x2, x3, x17
               	add	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ret

<whole_on_stack>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x20]
               	str	x17, [x16, #0x8]
               	sub	x8, x29, #0x10
               	ldr	x9, [x8, #0x8]
               	mov	x17, #0x3e8             // =1000
               	mul	x9, x9, x17
               	ldr	x8, [x8]
               	add	x8, x9, x8
               	ldr	x9, [x29, #0x28]
               	mov	x17, #0x7               // =7
               	mul	x9, x9, x17
               	add	x8, x8, x9
               	ldr	x9, [x29, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x9, x9, x17
               	add	x8, x8, x9
               	add	x0, x8, x0
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<va_after>:
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
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	add	x1, x29, #0x10
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
               	ldr	x3, [x3]
               	add	x0, x0, #0x1
               	madd	x1, x3, x0, x1
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	sub	x3, x29, #0x20
               	mov	x17, x3
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
               	ldr	x3, [x3]
               	sub	x4, x29, #0x20
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	add	x0, x0, x2
               	add	x0, x1, x0
               	mov	x17, #0x7               // =7
               	mul	x1, x3, x17
               	add	x0, x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0x5                // =5
               	mov	x1, #0xb                // =11
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #-0x2               // =-2
               	mov	x1, #0x28               // =40
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x2, x29, #0x40
               	ldr	x1, [x2]
               	ldr	x3, [x2, #0x8]
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	add	x1, x3, x1
               	mov	x17, #0x1393            // =5011
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	mov	x17, #-0x7a8            // =-1960
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x4, #0x3                // =3
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #0x13a9            // =5033
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x30
               	mov	x4, #0x4                // =4
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #-0x78c            // =-1932
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	sub	x6, x29, #0x40
               	sub	sp, sp, #0x10
               	str	x2, [sp]
               	ldr	x7, [x6, #0x8]
               	ldr	x6, [x6]
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x17, #0x13df            // =5087
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x4                // =4
               	mov	x2, #0x3                // =3
               	mov	x3, #0x2                // =2
               	mov	x4, #0x1                // =1
               	sub	x6, x29, #0x30
               	mov	x5, #0x6                // =6
               	sub	sp, sp, #0x10
               	str	x5, [sp]
               	ldr	x7, [x6, #0x8]
               	ldr	x6, [x6]
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x17, #-0x75b            // =-1883
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	sub	x7, x29, #0x40
               	sub	sp, sp, #0x20
               	str	x2, [sp, #0x10]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	bl	<addr>
               	add	sp, sp, #0x20
               	mov	x17, #0x143b            // =5179
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	mov	x6, #0x1                // =1
               	sub	x7, x29, #0x30
               	mov	x1, #0x9                // =9
               	sub	sp, sp, #0x20
               	str	x1, [sp, #0x10]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x1, x0
               	mov	x5, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	add	sp, sp, #0x20
               	mov	x17, #-0x761            // =-1889
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	fmov	d0, #2.00000000
               	mov	x0, #0x1                // =1
               	sub	x2, x29, #0x40
               	mov	x4, #0x3                // =3
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #0x13ad            // =5037
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	fmov	d0, #-1.00000000
               	mov	x0, #0x4                // =4
               	sub	x2, x29, #0x30
               	mov	x4, #0x5                // =5
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #-0x77a            // =-1914
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	sub	x2, x29, #0x40
               	mov	x4, #0x2                // =2
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x20, [x0]
               	ldr	x21, [x0, #0x8]
               	mov	x0, #0xa                // =10
               	mov	x1, #0x19               // =25
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x20, x1
               	eor	x0, x21, x0
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #-0x3               // =-3
               	sub	x2, x29, #0x30
               	mov	x4, #0x4                // =4
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x20, [x0]
               	ldr	x21, [x0, #0x8]
               	mov	x0, #-0x4               // =-4
               	mov	x1, #0x51               // =81
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x20, x1
               	eor	x0, x21, x0
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	sub	x2, x29, #0x20
               	stp	xzr, xzr, [x2]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	mov	x4, #0x3                // =3
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #0x13ab            // =5035
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	sub	x2, x29, #0x20
               	stp	xzr, xzr, [x2]
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	mov	x4, #0x4                // =4
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #-0x786            // =-1926
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	sub	x2, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	mov	x4, #0x3                // =3
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #0x13ab            // =5035
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	sub	x2, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	mov	x4, #0x4                // =4
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #-0x786            // =-1926
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x3, #0x3                // =3
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x17, #0x13ab            // =5035
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x3, #0x4                // =4
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x17, #-0x786            // =-1926
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	sub	x8, x29, #0x20
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldp	x16, x17, [x9]
               	stp	x16, x17, [x8]
               	sub	sp, sp, #0x20
               	str	x0, [sp]
               	str	x2, [sp, #0x18]
               	mov	x16, x8
               	ldr	x17, [x16]
               	str	x17, [sp, #0x8]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x10]
               	bl	<addr>
               	add	sp, sp, #0x20
               	mov	x17, #0x13cf            // =5071
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	mov	x7, #0x1                // =1
               	mov	x2, #0x2                // =2
               	sub	x1, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	mov	x3, #0x4                // =4
               	sub	sp, sp, #0x20
               	str	x2, [sp]
               	str	x3, [sp, #0x18]
               	mov	x16, x1
               	ldr	x17, [x16]
               	str	x17, [sp, #0x8]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x10]
               	mov	x1, x0
               	mov	x6, x0
               	mov	x5, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	add	sp, sp, #0x20
               	mov	x17, #-0x785            // =-1925
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x40
               	mov	x4, #0x3                // =3
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #0x13a8            // =5032
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x30
               	mov	x4, #0x4                // =4
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #-0x78a            // =-1930
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	sub	x4, x29, #0x40
               	mov	x1, x0
               	mov	x6, x2
               	ldr	x5, [x4, #0x8]
               	ldr	x4, [x4]
               	bl	<addr>
               	mov	x17, #0x13b0            // =5040
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x30
               	mov	x3, #0x5                // =5
               	sub	sp, sp, #0x20
               	str	x3, [sp, #0x10]
               	mov	x16, x2
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x2, x1
               	mov	x7, x1
               	mov	x6, x1
               	mov	x5, x1
               	mov	x4, x1
               	mov	x3, x1
               	bl	<addr>
               	add	sp, sp, #0x20
               	mov	x17, #-0x769            // =-1897
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x8                // =8
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x40
               	mov	x3, #0x3                // =3
               	sub	sp, sp, #0x30
               	str	x1, [sp]
               	str	x3, [sp, #0x20]
               	mov	x16, x2
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	mov	x2, x1
               	mov	x7, x1
               	mov	x6, x1
               	mov	x5, x1
               	mov	x4, x1
               	mov	x3, x1
               	bl	<addr>
               	add	sp, sp, #0x30
               	mov	x17, #0x13cc            // =5068
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
