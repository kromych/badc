
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
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, x0
               	str	w2, [x1]
               	ret

<both>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x0, w0
               	cmp	w0, #0x3
               	b.ge	<addr>
               	cmp	w1, #0x7
               	b.ge	<addr>
               	bl	<addr>
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp], #0x10
               	ret

<either>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	w1, #0x7
               	b.ge	<addr>
               	mov	x0, x1
               	bl	<addr>
               	add	x0, x0, #0xc8
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x2               // =-2
               	ldp	x29, x30, [sp], #0x10
               	ret

<pick>:
               	sxtw	x0, w0
               	sxtw	x2, w2
               	sxtw	x1, w1
               	cbz	x0, <addr>
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>

<carry>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x1, w1
               	mov	x17, #0x3               // =3
               	mul	x2, x0, x17
               	add	x2, x2, #0x1
               	sxtw	x20, w2
               	cmp	w0, #0x3
               	b.ge	<addr>
               	cmp	w1, #0x7
               	b.ge	<addr>
               	mov	x0, x1
               	bl	<addr>
               	add	x0, x20, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	w0, #0x5
               	b.gt	<addr>
               	cmp	w1, #0x9
               	b.le	<addr>
               	sub	x0, x20, x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<tally>:
               	mov	x8, x0
               	mov	x2, #0x0                // =0
               	mov	x4, #0xa                // =10
               	mov	x5, #0x999a             // =39322
               	movk	x5, #0x1999, lsl #16
               	mov	x7, x2
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
               	add	x2, x2, #0x1
               	cmp	w2, w8
               	b.lt	<addr>
               	mov	x0, x7
               	ret

<count_wanted>:
               	mov	x2, #0x0                // =0
               	cmp	w0, w1
               	b.ge	<addr>
               	cmp	w0, #0x1
               	b.le	<addr>
               	cmp	w0, #0x9
               	b.lt	<addr>
               	cmp	w0, #0x64
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	sxtw	x0, w2
               	ret

<route>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	mov	x3, #0x0                // =0
               	cbz	x0, <addr>
               	cbz	x1, <addr>
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
               	sxtw	x0, w0
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
               	sxtw	x0, w1
               	ret

<scan>:
               	mov	x4, #0x0                // =0
               	mov	x6, #-0x1               // =-1
               	mov	x5, x4
               	cmp	w4, w1
               	b.ge	<addr>
               	ldrsw	x7, [x0, x4, lsl #2]
               	cmp	w7, w2
               	b.lt	<addr>
               	ldrsw	x7, [x0, x4, lsl #2]
               	cmp	w7, w3
               	b.gt	<addr>
               	add	x5, x5, #0x1
               	b	<addr>
               	ldrsw	x7, [x0, x4, lsl #2]
               	cmp	w7, w6
               	b.eq	<addr>
               	ldrsw	x7, [x0, x4, lsl #2]
               	cmp	w7, #0x63
               	b.eq	<addr>
               	add	x5, x5, #0x64
               	add	x4, x4, #0x1
               	cmp	w4, w1
               	b.lt	<addr>
               	sxtw	x0, w5
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
               	sxtw	x0, w0
               	cbz	x0, <addr>
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
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	mov	x17, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x17
               	fadd	d0, d1, d0
               	ret

<liftf>:
               	mov	x0, #0x3f400000         // =1061158912
               	mov	x17, #0x3f400000        // =1061158912
               	fmov	s1, w17
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
               	cbnz	w20, <addr>
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	w22, #0x3
               	cset	x1, lt
               	cmp	w21, #0x7
               	cset	x2, lt
               	and	x1, x1, x2
               	add	x2, x22, #0x64
               	cmp	w1, #0x0
               	cset	x1, ne
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x2, x1, x2
               	mvn	x1, x1
               	orr	x1, x2, x1
               	sxtw	x1, w1
               	cmp	x0, x1
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
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x2, x1, x2
               	mvn	x1, x1
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x2, x1
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x20, #0x2               // =2
               	mov	x17, #0x3               // =3
               	mul	x0, x22, x17
               	add	x0, x0, #0x1
               	cmp	w22, #0x3
               	cset	x1, lt
               	cmp	w21, #0x7
               	cset	x2, lt
               	and	x1, x1, x2
               	add	x2, x0, x21
               	cmp	w1, #0x0
               	cset	x1, ne
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x2, x1, x2
               	mvn	x1, x1
               	and	x0, x1, x0
               	orr	x0, x2, x0
               	sxtw	x23, w0
               	cbnz	w20, <addr>
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, x23
               	b.eq	<addr>
               	mov	x20, #0x3               // =3
               	add	x21, x21, #0x1
               	cmp	w21, #0xa
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x6
               	b.lt	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x7                // =7
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	cmp	x0, #0xa
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
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x2, x1, #0x1
               	mvn	x1, x1
               	and	x1, x1, #0x2
               	orr	x2, x2, x1
               	cmp	w21, #0x0
               	cset	x1, ne
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x3, x1, #0x3
               	mvn	x1, x1
               	and	x1, x1, #0x4
               	orr	x3, x3, x1
               	cmp	w22, #0x0
               	cset	x1, ne
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x2, x1, x2
               	mvn	x1, x1
               	and	x1, x1, x3
               	orr	x1, x2, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x20, #0x5               // =5
               	mov	x21, #-0x1              // =-1
               	cmp	w21, #0x0
               	cset	x0, ge
               	cmp	w21, #0x5
               	cset	x1, le
               	and	x0, x0, x1
               	add	x1, x21, #0xa
               	cmp	w0, #0x0
               	cset	x0, ne
               	mov	x17, #-0x1              // =-1
               	mul	x0, x0, x17
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
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x1, x1, x24
               	add	x1, x1, x22
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x20, #0x6               // =6
               	add	x21, x21, #0x1
               	cmp	w21, #0x8
               	b.lt	<addr>
               	add	x25, x25, #0x1
               	cmp	w25, #0x8
               	b.lt	<addr>
               	cbnz	w20, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0x7               // =7
               	cbnz	w20, <addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x20, #0x8               // =8
               	cbnz	w20, <addr>
               	mov	x0, #0x3e8              // =1000
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x20, #0x9               // =9
               	cbnz	w20, <addr>
               	mov	x1, #0x13               // =19
               	mov	x0, #0x0                // =0
               	mov	x17, #0x999a            // =39322
               	movk	x17, #0x1999, lsl #16
               	mul	x2, x1, x17
               	lsr	x2, x2, #32
               	mov	x17, #0xa               // =10
               	mul	x3, x2, x17
               	sub	x1, x1, x3
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
               	mov	x0, #0x0                // =0
               	mov	x17, #0x999a            // =39322
               	movk	x17, #0x1999, lsl #16
               	mul	x2, x1, x17
               	lsr	x2, x2, #32
               	mov	x17, #0xa               // =10
               	mul	x3, x2, x17
               	sub	x1, x1, x3
               	add	x0, x0, x1
               	cmp	w0, #0x9
               	b.gt	<addr>
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x1, #0x5b               // =91
               	mov	x0, #0x0                // =0
               	mov	x17, #0x999a            // =39322
               	movk	x17, #0x1999, lsl #16
               	mul	x2, x1, x17
               	lsr	x2, x2, #32
               	mov	x17, #0xa               // =10
               	mul	x3, x2, x17
               	sub	x1, x1, x3
               	add	x0, x0, x1
               	cmp	w0, #0x1
               	b.gt	<addr>
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x20, #0xa               // =10
               	cbnz	w20, <addr>
               	mov	x0, #-0x5               // =-5
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x20, #0xb               // =11
               	cbnz	w20, <addr>
               	mov	x0, #0x9                // =9
               	mov	x1, #0x64               // =100
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0xc               // =12
               	cbnz	w20, <addr>
               	mov	x0, #0x64               // =100
               	mov	x1, #0x65               // =101
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x20, #0xd               // =13
               	cbnz	w20, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x0, #-0x3               // =-3
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x20, #0xe               // =14
               	cbnz	w20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3                // =3
               	mov	x3, x1
               	bl	<addr>
               	cmp	x0, #0xcb
               	b.eq	<addr>
               	mov	x20, #0xf               // =15
               	cbnz	w20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	mov	x2, #0x0                // =0
               	mov	x3, #0x64               // =100
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x20, #0x10              // =16
               	cbnz	w20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x3, #0x64               // =100
               	mov	x2, x1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0x11              // =17
               	cbnz	w20, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x6
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x20, #0x12              // =18
               	cbnz	w20, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x10
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x20, #0x13              // =19
               	cbnz	w20, <addr>
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x3ffc000000000000 // =4610560118520545280
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x20, #0x14              // =20
               	cbnz	w20, <addr>
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x3fa00000         // =1067450368
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x20, #0x15              // =21
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	cmp	w0, #0x3
               	cset	x3, lt
               	add	x4, x0, #0x4
               	cmp	w3, #0x0
               	cset	x1, ne
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x4, x1, x4
               	add	x2, x2, x4
               	add	x2, x2, #0x4
               	add	x4, x0, #0x5
               	and	x4, x1, x4
               	add	x2, x2, x4
               	add	x2, x2, #0x5
               	add	x4, x0, #0x6
               	and	x1, x1, x4
               	add	x1, x2, x1
               	add	x1, x1, #0x6
               	mov	x17, #-0x1              // =-1
               	mul	x2, x3, x17
               	and	x2, x2, #0x7
               	add	x2, x1, x2
               	cmp	w0, #0x3
               	cset	x1, lt
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	and	x3, x1, #0x8
               	add	x2, x2, x3
               	mov	x17, #0x9               // =9
               	and	x1, x1, x17
               	add	x2, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	cbnz	w20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, w2
               	b.eq	<addr>
               	mov	x20, #0x16              // =22
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
