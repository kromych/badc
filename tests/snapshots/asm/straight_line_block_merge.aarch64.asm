
straight_line_block_merge.aarch64:	file format elf64-littleaarch64

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

<note>:
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x20]
               	add	x2, x2, x0
               	str	w2, [x1, #0x20]
               	ret

<both>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	cmp	w0, #0x3
               	b.ge	<addr>
               	cmp	w1, #0x7
               	b.ge	<addr>
               	bl	<addr>
               	add	x0, x0, #0x64
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp], #0x10
               	ret

<either>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	w1, #0x7
               	b.ge	<addr>
               	mov	x0, x1
               	bl	<addr>
               	add	x0, x0, #0xc8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x2               // =-2
               	ldp	x29, x30, [sp], #0x10
               	ret

<pick>:
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	mov	x2, #0x2                // =2
               	cmp	w1, #0x0
               	csel	x0, x0, x2, ne
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	cmp	w2, #0x0
               	csel	x0, x0, x1, ne
               	b	<addr>

<carry>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	add	x2, x0, x0, lsl #1
               	add	x2, x2, #0x1
               	cmp	w0, #0x3
               	b.ge	<addr>
               	cmp	w1, #0x7
               	b.ge	<addr>
               	str	x2, [sp, #0x8]
               	mov	x0, x1
               	bl	<addr>
               	ldr	x2, [sp, #0x8]
               	add	x0, x2, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x5
               	b.gt	<addr>
               	cmp	w1, #0x9
               	b.le	<addr>
               	sub	x0, x2, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<tally>:
               	mov	x8, x0
               	mov	x2, #0x0                // =0
               	mov	x4, #0xa                // =10
               	mov	x5, #0x999a             // =39322
               	movk	x5, #0x1999, lsl #16
               	mov	x7, x2
               	b	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, w8
               	b.ge	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x2
               	cmp	w0, #0x0
               	b.le	<addr>
               	mul	x3, x0, x5
               	lsr	x3, x3, #32
               	mul	x6, x3, x4
               	sub	x6, x0, x6
               	add	x1, x1, x6
               	cmp	w1, w2
               	b.gt	<addr>
               	mov	x0, x3
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x7, x7, #0x1
               	b	<addr>
               	mov	x0, x7
               	ret

<count_wanted>:
               	mov	x2, #0x0                // =0
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.ge	<addr>
               	cmp	w0, #0x1
               	b.le	<addr>
               	cmp	w0, #0x9
               	b.lt	<addr>
               	cmp	w0, #0x64
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	b	<addr>
               	mov	x0, x2
               	ret

<route>:
               	mov	x3, #0x0                // =0
               	cbz	w0, <addr>
               	cbz	w1, <addr>
               	cmp	w2, #0x3
               	b.lt	<addr>
               	cmp	w2, #0x4
               	b.lt	<addr>
               	cmp	w2, #0x5
               	b.lt	<addr>
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x3, #0x13               // =19
               	add	x0, x3, x0
               	ret
               	mov	x3, #0xf                // =15
               	b	<addr>
               	mov	x3, #0xe                // =14
               	b	<addr>
               	mov	x3, #0xd                // =13
               	b	<addr>
               	cmp	w2, #0x1
               	b.lt	<addr>
               	cmp	w2, #0x2
               	b.lt	<addr>
               	mov	x3, #0xc                // =12
               	b	<addr>
               	mov	x3, #0xb                // =11
               	b	<addr>
               	cbnz	w2, <addr>
               	mov	x3, #0xa                // =10
               	b	<addr>

<spin>:
               	mov	x1, #0x0                // =0
               	add	x1, x1, x0
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.gt	<addr>
               	mov	x0, x1
               	ret

<scan>:
               	mov	x5, x0
               	mov	x0, #0x0                // =0
               	mov	x4, x0
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.ge	<addr>
               	ldrsw	x6, [x5, x0, lsl #2]
               	cmp	w6, w2
               	b.lt	<addr>
               	cmp	w6, w3
               	b.gt	<addr>
               	add	x4, x4, #0x1
               	b	<addr>
               	ldrsw	x6, [x5, x0, lsl #2]
               	cmn	w6, #0x1
               	b.eq	<addr>
               	cmp	w6, #0x63
               	b.eq	<addr>
               	add	x4, x4, #0x64
               	b	<addr>
               	mov	x0, x4
               	ret

<ladder>:
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2, w0, sxtw #3]
               	br	x0
               	mov	x1, #0x1                // =1
               	add	x1, x1, #0x2
               	add	x0, x1, #0x4
               	ret
               	b	<addr>
               	b	<addr>

<fork_at>:
               	cbz	w0, <addr>
               	adr	x0, <addr>
               	mov	x1, #0x5                // =5
               	br	x0
               	mov	x1, #0xf                // =15
               	add	x0, x1, #0x1
               	ret
               	b	<addr>
               	adr	x0, <addr>
               	b	<addr>

<lift>:
               	fmov	d1, #1.50000000
               	fadd	d0, d1, d0
               	ret

<liftf>:
               	fmov	s1, #0.75000000
               	fadd	s0, s1, s0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x22, #0x0               // =0
               	mov	x20, x22
               	mov	x21, #0x4               // =4
               	add	x24, x22, #0x64
               	add	x0, x22, x22, lsl #1
               	add	x23, x0, #0x1
               	b	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0xa
               	b.ge	<addr>
               	cbnz	w20, <addr>
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	w22, #0x3
               	cset	x1, lt
               	cmp	w21, #0x7
               	cset	x2, lt
               	and	x1, x1, x2
               	cmp	w1, #0x0
               	cset	x1, ne
               	neg	x1, x1
               	and	x2, x1, x24
               	mvn	x1, x1
               	orr	x1, x2, x1
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	cbnz	w20, <addr>
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	w22, #0x3
               	cset	x1, lt
               	cmp	w21, #0x7
               	cset	x2, lt
               	orr	x1, x1, x2
               	add	x2, x21, #0xc8
               	cmp	w1, #0x0
               	cset	x1, ne
               	neg	x1, x1
               	and	x2, x1, x2
               	mvn	x1, x1
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x2, x1
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x20, #0x2               // =2
               	cmp	w22, #0x3
               	cset	x0, lt
               	cmp	w21, #0x7
               	cset	x1, lt
               	and	x0, x0, x1
               	add	x1, x23, x21
               	cmp	w0, #0x0
               	cset	x0, ne
               	neg	x0, x0
               	and	x1, x0, x1
               	mvn	x0, x0
               	and	x0, x0, x23
               	orr	x25, x1, x0
               	cbnz	w20, <addr>
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	w0, w25
               	b.eq	<addr>
               	mov	x20, #0x3               // =3
               	b	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x6
               	b.lt	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x7                // =7
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x20, #0x4               // =4
               	mov	x25, #0x0               // =0
               	and	x22, x25, #0x4
               	and	x23, x25, #0x2
               	and	x21, x25, #0x1
               	cbnz	w20, <addr>
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	cmp	w23, #0x0
               	cset	x1, ne
               	neg	x1, x1
               	and	x2, x1, #0x1
               	mvn	x1, x1
               	and	x1, x1, #0x2
               	orr	x2, x2, x1
               	cmp	w21, #0x0
               	cset	x1, ne
               	neg	x1, x1
               	and	x3, x1, #0x3
               	mvn	x1, x1
               	and	x1, x1, #0x4
               	orr	x3, x3, x1
               	cmp	w22, #0x0
               	cset	x1, ne
               	neg	x1, x1
               	and	x2, x1, x2
               	mvn	x1, x1
               	and	x1, x1, x3
               	orr	x1, x2, x1
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x20, #0x5               // =5
               	mov	x21, #-0x1              // =-1
               	b	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x8
               	b.ge	<addr>
               	cmp	w21, #0x0
               	cset	x0, ge
               	cmp	w21, #0x5
               	cset	x1, le
               	and	x0, x0, x1
               	add	x1, x21, #0xa
               	cmp	w0, #0x0
               	cset	x0, ne
               	neg	x0, x0
               	and	x1, x0, x1
               	mvn	x0, x0
               	mov	x17, #0x13              // =19
               	and	x0, x0, x17
               	orr	x24, x1, x0
               	cbnz	w20, <addr>
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	cmp	w22, #0x0
               	cset	x1, ne
               	cmp	w23, #0x0
               	cset	x2, ne
               	and	x1, x1, x2
               	cmp	w1, #0x0
               	cset	x1, ne
               	neg	x1, x1
               	and	x1, x1, x24
               	add	x1, x1, x22
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x20, #0x6               // =6
               	b	<addr>
               	add	x25, x25, #0x1
               	cmp	w25, #0x8
               	b.lt	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0x7               // =7
               	mov	x0, #0x0                // =0
               	mov	x4, #0x9                // =9
               	mov	x2, x0
               	cmp	w0, #0x3
               	cset	x3, lt
               	add	x5, x0, #0x4
               	neg	x1, x3
               	and	x5, x1, x5
               	add	x2, x2, x5
               	add	x2, x2, #0x4
               	add	x5, x0, #0x5
               	and	x5, x1, x5
               	add	x2, x2, x5
               	add	x2, x2, #0x5
               	add	x5, x0, #0x6
               	and	x1, x1, x5
               	add	x1, x2, x1
               	add	x1, x1, #0x6
               	neg	x2, x3
               	and	x2, x2, #0x7
               	add	x2, x1, x2
               	cmp	w0, #0x3
               	cset	x1, lt
               	neg	x1, x1
               	and	x3, x1, #0x8
               	add	x2, x2, x3
               	and	x1, x1, x4
               	add	x2, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	cbnz	w20, <addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, w2
               	b.eq	<addr>
               	mov	x20, #0x16              // =22
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	cbnz	w20, <addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x20, #0x8               // =8
               	b	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x3e8              // =1000
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x20, #0x9               // =9
               	b	<addr>
               	cbnz	w20, <addr>
               	mov	x1, #0x13               // =19
               	mov	x3, #0xa                // =10
               	mov	x4, #0x999a             // =39322
               	movk	x4, #0x1999, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	mul	x5, x2, x3
               	sub	x1, x1, x5
               	add	x0, x0, x1
               	cmp	w0, #0xa
               	b.gt	<addr>
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0xa
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, #0x13               // =19
               	mov	x3, #0xa                // =10
               	mov	x4, #0x999a             // =39322
               	movk	x4, #0x1999, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	mul	x5, x2, x3
               	sub	x1, x1, x5
               	add	x0, x0, x1
               	cmp	w0, #0x9
               	b.gt	<addr>
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x1, #0x5b               // =91
               	mov	x3, #0xa                // =10
               	mov	x4, #0x999a             // =39322
               	movk	x4, #0x1999, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	mul	x5, x2, x3
               	sub	x1, x1, x5
               	add	x0, x0, x1
               	cmp	w0, #0x1
               	b.gt	<addr>
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x20, #0xa               // =10
               	b	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #-0x5               // =-5
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x20, #0xb               // =11
               	b	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x9                // =9
               	mov	x1, #0x64               // =100
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x20, #0xc               // =12
               	b	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x64               // =100
               	mov	x1, #0x65               // =101
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x20, #0xd               // =13
               	b	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0xa
               	b.ne	<addr>
               	mov	x0, #-0x3               // =-3
               	bl	<addr>
               	cmn	w0, #0x3
               	b.eq	<addr>
               	mov	x20, #0xe               // =14
               	b	<addr>
               	cbnz	w20, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3                // =3
               	mov	x3, x1
               	bl	<addr>
               	cmp	w0, #0xcb
               	b.eq	<addr>
               	mov	x20, #0xf               // =15
               	b	<addr>
               	cbnz	w20, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	mov	x2, #0x0                // =0
               	mov	x3, #0x64               // =100
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x20, #0x10              // =16
               	b	<addr>
               	cbnz	w20, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x3, #0x64               // =100
               	mov	x2, x1
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x20, #0x11              // =17
               	b	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x6
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x20, #0x12              // =18
               	b	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x10
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x20, #0x13              // =19
               	b	<addr>
               	cbnz	w20, <addr>
               	fmov	d0, #0.25000000
               	bl	<addr>
               	fmov	d1, #1.75000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x14              // =20
               	b	<addr>
               	cbnz	w20, <addr>
               	fmov	s0, #0.50000000
               	bl	<addr>
               	fmov	s1, #1.25000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x20, #0x15              // =21
               	b	<addr>
