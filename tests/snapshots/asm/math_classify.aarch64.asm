
math_classify.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	fdiv	d1, d0, d0
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	fdiv	d2, d16, d0
               	fmov	d16, x1
               	fneg	d3, d16
               	fdiv	d0, d3, d0
               	sub	x17, x29, #0x8
               	str	d1, [x17]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x1
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d2, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d2, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d1, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ge
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	sxtw	x1, w1
               	cmp	x1, #0x2
               	cset	x1, ge
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d2, [x17]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ge
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d1, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ge
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d1, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d2, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x2
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x0, x0, #63
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x2
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x0, x0, #63
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	sxtw	x1, w1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	sxtw	x1, w1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>
