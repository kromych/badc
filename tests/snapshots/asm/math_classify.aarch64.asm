
math_classify.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	lsr	x0, x0, #63
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x260
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fdiv	d1, d0, d0
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fdiv	d2, d16, d0
               	fmov	d16, x0
               	fneg	d3, d16
               	fdiv	d0, d3, d0
               	sub	x0, x29, #0x30
               	str	d1, [x0]
               	sub	x0, x29, #0x30
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x30
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	sub	x1, x29, #0x58
               	fmov	d16, x0
               	str	d16, [x1]
               	sub	x0, x29, #0x58
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x58
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	str	d2, [x0]
               	sub	x0, x29, #0x80
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x80
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	str	d2, [x0]
               	sub	x0, x29, #0xa8
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0xa8
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd0
               	str	d0, [x0]
               	sub	x0, x29, #0xd0
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0xd0
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	sub	x1, x29, #0xf8
               	fmov	d16, x0
               	str	d16, [x1]
               	sub	x0, x29, #0xf8
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0xf8
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x120
               	str	d1, [x0]
               	sub	x0, x29, #0x120
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x120
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	sub	x1, x29, #0x148
               	fmov	d16, x0
               	str	d16, [x1]
               	sub	x0, x29, #0x148
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x148
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ge
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x170
               	fmov	d16, x0
               	str	d16, [x1]
               	sub	x0, x29, #0x170
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x170
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ge
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x198
               	str	d2, [x0]
               	sub	x0, x29, #0x198
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x198
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ge
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1c0
               	str	d1, [x0]
               	sub	x0, x29, #0x1c0
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x1c0
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ge
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1e8
               	str	d1, [x0]
               	sub	x0, x29, #0x1e8
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x1e8
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x210
               	str	d2, [x0]
               	sub	x0, x29, #0x210
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x210
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	sub	x1, x29, #0x238
               	fmov	d16, x0
               	str	d16, [x1]
               	sub	x0, x29, #0x238
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x238
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
