
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x2]
               	add	x1, x1, x0
               	str	w1, [x2]
               	sxtw	x0, w0
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
               	sxtw	x1, w1
               	sxtw	x2, w2
               	cbz	x0, <addr>
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
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
               	mov	x12, x0
               	mov	x4, #0x0                // =0
               	mov	x8, #0xa                // =10
               	mov	x9, #0x6667             // =26215
               	movk	x9, #0x6666, lsl #16
               	mov	x11, x4
               	cmp	w4, w12
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x4
               	cmp	w1, #0x0
               	b.le	<addr>
               	sxtw	x3, w1
               	mul	x5, x3, x9
               	asr	x2, x5, #34
               	lsr	x6, x2, #63
               	add	x7, x2, x6
               	mul	x10, x7, x8
               	sub	x10, x3, x10
               	add	x0, x0, x10
               	cmp	w0, w4
               	b.gt	<addr>
               	mov	x1, x7
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, w4
               	b.ne	<addr>
               	add	x11, x11, #0x1
               	add	x4, x4, #0x1
               	cmp	w4, w12
               	b.lt	<addr>
               	mov	x0, x11
               	ret

<count_wanted>:
               	mov	x2, x1
               	mov	x1, #0x0                // =0
               	cmp	w0, w2
               	b.ge	<addr>
               	cmp	w0, #0x1
               	b.le	<addr>
               	cmp	w0, #0x9
               	b.lt	<addr>
               	cmp	w0, #0x64
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<route>:
               	mov	x3, x0
               	sxtw	x3, w3
               	sxtw	x1, w1
               	sxtw	x2, w2
               	mov	x0, #0x0                // =0
               	cbz	x3, <addr>
               	cbz	x1, <addr>
               	cmp	w2, #0x3
               	b.lt	<addr>
               	cmp	w2, #0x4
               	b.lt	<addr>
               	cmp	w2, #0x5
               	b.lt	<addr>
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	x0, x0, x3
               	sxtw	x0, w0
               	ret
               	mov	x0, #0xf                // =15
               	b	<addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	mov	x0, #0xd                // =13
               	b	<addr>
               	cmp	w2, #0x1
               	b.lt	<addr>
               	cmp	w2, #0x2
               	b.lt	<addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	cbnz	x2, <addr>
               	mov	x0, #0xa                // =10
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
               	mov	x4, x0
               	mov	x6, x2
               	mov	x5, x1
               	mov	x0, #0x0                // =0
               	mov	x7, #-0x1               // =-1
               	mov	x1, x0
               	cmp	w0, w5
               	b.ge	<addr>
               	sxtw	x2, w0
               	ldrsw	x8, [x4, x2, lsl #2]
               	cmp	w8, w6
               	b.lt	<addr>
               	ldrsw	x8, [x4, x2, lsl #2]
               	cmp	w8, w3
               	b.gt	<addr>
               	add	x1, x1, #0x1
               	b	<addr>
               	ldrsw	x8, [x4, x2, lsl #2]
               	cmp	w8, w7
               	b.eq	<addr>
               	ldrsw	x2, [x4, x2, lsl #2]
               	cmp	w2, #0x63
               	b.eq	<addr>
               	add	x1, x1, #0x64
               	add	x0, x0, #0x1
               	cmp	w0, w5
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<ladder>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #-0x20]
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x2
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x4
               	stur	w0, [x29, #-0x8]
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<fork_at>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #-0x20]
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	adr	x0, <addr>
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	adr	x0, <addr>
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x10]
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x8]
               	br	x0
               	mov	x0, #0xf                // =15
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x8]
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

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
               	cmp	w22, #0x6
               	b.ge	<addr>
               	mov	x21, #0x4               // =4
               	cmp	w21, #0xa
               	b.ge	<addr>
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x5, x0
               	cmp	w22, #0x3
               	cset	x0, lt
               	cmp	w21, #0x7
               	cset	x1, lt
               	and	x1, x0, x1
               	add	x2, x22, #0x64
               	cmp	w1, #0x0
               	cset	x4, ne
               	mov	x17, #-0x1              // =-1
               	mul	x0, x4, x17
               	and	x2, x0, x2
               	mvn	x0, x0
               	mov	x17, #-0x1              // =-1
               	and	x0, x0, x17
               	orr	x0, x2, x0
               	sxtw	x0, w0
               	cmp	x5, x0
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x5, x0
               	cmp	w22, #0x3
               	cset	x0, lt
               	cmp	w21, #0x7
               	cset	x1, lt
               	orr	x1, x0, x1
               	add	x2, x21, #0xc8
               	cmp	w1, #0x0
               	cset	x4, ne
               	mov	x17, #-0x1              // =-1
               	mul	x0, x4, x17
               	and	x2, x0, x2
               	mvn	x0, x0
               	and	x0, x0, #0xfffffffffffffffe
               	orr	x0, x2, x0
               	sxtw	x0, w0
               	cmp	x5, x0
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
               	mov	x17, #-0x1              // =-1
               	and	x0, x0, x17
               	mov	x17, #0x0               // =0
               	orr	x3, x0, x17
               	cmp	w1, #0x0
               	cset	x5, ne
               	mov	x17, #-0x1              // =-1
               	mul	x0, x5, x17
               	and	x2, x0, x2
               	mvn	x0, x0
               	and	x0, x0, x3
               	orr	x0, x2, x0
               	sxtw	x23, w0
               	cmp	w20, #0x0
               	b.ne	<addr>
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
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x20, #0x4               // =4
               	mov	x25, #0x0               // =0
               	cmp	w25, #0x8
               	b.ge	<addr>
               	and	x22, x25, #0x4
               	and	x23, x25, #0x2
               	and	x21, x25, #0x1
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	mov	x5, x0
               	cmp	w23, #0x0
               	cset	x2, ne
               	mov	x17, #-0x1              // =-1
               	mul	x0, x2, x17
               	and	x3, x0, #0x1
               	mvn	x0, x0
               	and	x0, x0, #0x2
               	orr	x1, x3, x0
               	cmp	w21, #0x0
               	cset	x3, ne
               	mov	x17, #-0x1              // =-1
               	mul	x0, x3, x17
               	and	x7, x0, #0x3
               	mvn	x0, x0
               	and	x0, x0, #0x4
               	orr	x2, x7, x0
               	cmp	w22, #0x0
               	cset	x4, ne
               	mov	x17, #-0x1              // =-1
               	mul	x0, x4, x17
               	and	x1, x0, x1
               	mvn	x0, x0
               	and	x0, x0, x2
               	orr	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x5, x0
               	b.eq	<addr>
               	mov	x20, #0x5               // =5
               	mov	x21, #-0x1              // =-1
               	cmp	w21, #0x8
               	b.ge	<addr>
               	cmp	w21, #0x0
               	cset	x0, ge
               	cmp	w21, #0x5
               	cset	x1, le
               	and	x1, x0, x1
               	add	x2, x21, #0xa
               	cmp	w1, #0x0
               	cset	x4, ne
               	mov	x17, #-0x1              // =-1
               	mul	x0, x4, x17
               	and	x2, x0, x2
               	mvn	x0, x0
               	mov	x17, #0x13              // =19
               	and	x0, x0, x17
               	orr	x24, x2, x0
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	mov	x3, x0
               	cmp	w22, #0x0
               	cset	x0, ne
               	cmp	w23, #0x0
               	cset	x1, ne
               	and	x0, x0, x1
               	cmp	w0, #0x0
               	cset	x2, ne
               	mov	x17, #-0x1              // =-1
               	mul	x2, x2, x17
               	and	x2, x2, x24
               	mov	x17, #0x0               // =0
               	orr	x0, x2, x17
               	add	x0, x0, x22
               	sxtw	x0, w0
               	cmp	x3, x0
               	b.eq	<addr>
               	mov	x20, #0x6               // =6
               	add	x21, x21, #0x1
               	cmp	w21, #0x8
               	b.lt	<addr>
               	add	x25, x25, #0x1
               	cmp	w25, #0x8
               	b.lt	<addr>
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0x7               // =7
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x20, #0x8               // =8
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3e8              // =1000
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x20, #0x9               // =9
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x1, #0x13               // =19
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x0
               	b.le	<addr>
               	sxtw	x3, w1
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x4, x3, x17
               	asr	x2, x4, #34
               	lsr	x5, x2, #63
               	add	x6, x2, x5
               	mov	x17, #0xa               // =10
               	mul	x7, x6, x17
               	sub	x7, x3, x7
               	add	x0, x0, x7
               	cmp	w0, #0xa
               	b.gt	<addr>
               	mov	x1, x6
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0xa
               	cset	x0, eq
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x1, #0x13               // =19
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x0
               	b.le	<addr>
               	sxtw	x3, w1
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x4, x3, x17
               	asr	x2, x4, #34
               	lsr	x5, x2, #63
               	add	x6, x2, x5
               	mov	x17, #0xa               // =10
               	mul	x7, x6, x17
               	sub	x7, x3, x7
               	add	x0, x0, x7
               	cmp	w0, #0x9
               	b.gt	<addr>
               	mov	x1, x6
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x1, #0x5b               // =91
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x0
               	b.le	<addr>
               	sxtw	x3, w1
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x4, x3, x17
               	asr	x2, x4, #34
               	lsr	x5, x2, #63
               	add	x6, x2, x5
               	mov	x17, #0xa               // =10
               	mul	x7, x6, x17
               	sub	x7, x3, x7
               	add	x0, x0, x7
               	cmp	w0, #0x1
               	b.gt	<addr>
               	mov	x1, x6
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0x1
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x20, #0xa               // =10
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #-0x5               // =-5
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x20, #0xb               // =11
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	mov	x1, #0x64               // =100
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0xc               // =12
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x64               // =100
               	mov	x1, #0x65               // =101
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x20, #0xd               // =13
               	cmp	w20, #0x0
               	b.ne	<addr>
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
               	cmp	w20, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3                // =3
               	mov	x3, x1
               	bl	<addr>
               	cmp	x0, #0xcb
               	b.eq	<addr>
               	mov	x20, #0xf               // =15
               	cmp	w20, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	mov	x2, #0x0                // =0
               	mov	x3, #0x64               // =100
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x20, #0x10              // =16
               	cmp	w20, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x3, #0x64               // =100
               	mov	x2, x1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0x11              // =17
               	cmp	w20, #0x0
               	b.ne	<addr>
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
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x10
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x20, #0x13              // =19
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x3ffc000000000000 // =4610560118520545280
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x20, #0x14              // =20
               	cmp	w20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x3fa00000         // =1067450368
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x20, #0x15              // =21
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	cmp	w0, #0x6
               	b.ge	<addr>
               	cmp	w0, #0x3
               	cset	x1, lt
               	add	x4, x0, #0x4
               	cmp	w1, #0x0
               	cset	x5, ne
               	mov	x17, #-0x1              // =-1
               	mul	x2, x5, x17
               	and	x7, x2, x4
               	mov	x17, #0x0               // =0
               	orr	x4, x7, x17
               	add	x3, x3, x4
               	add	x3, x3, #0x4
               	add	x4, x0, #0x5
               	and	x7, x2, x4
               	mov	x17, #0x0               // =0
               	orr	x4, x7, x17
               	add	x3, x3, x4
               	add	x3, x3, #0x5
               	add	x4, x0, #0x6
               	and	x4, x2, x4
               	mov	x17, #0x0               // =0
               	orr	x2, x4, x17
               	add	x2, x3, x2
               	add	x2, x2, #0x6
               	add	x2, x2, #0x0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x4, ne
               	mov	x17, #-0x1              // =-1
               	mul	x4, x4, x17
               	and	x4, x4, #0x7
               	mov	x17, #0x0               // =0
               	orr	x1, x4, x17
               	add	x1, x2, x1
               	add	x3, x1, #0x0
               	cmp	w0, #0x3
               	cset	x4, lt
               	mov	x17, #0x0               // =0
               	orr	x1, x4, x17
               	cmp	w1, #0x0
               	cset	x6, ne
               	mov	x17, #-0x1              // =-1
               	mul	x2, x6, x17
               	and	x7, x2, #0x8
               	mov	x17, #0x0               // =0
               	orr	x5, x7, x17
               	add	x3, x3, x5
               	add	x3, x3, #0x0
               	mov	x17, #0x9               // =9
               	and	x2, x2, x17
               	mov	x17, #0x0               // =0
               	orr	x1, x2, x17
               	add	x3, x3, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	cmp	w20, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, w3
               	b.eq	<addr>
               	mov	x20, #0x16              // =22
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
