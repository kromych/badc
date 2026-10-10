
long_double_outgoing_area_borrow.aarch64:	file format elf64-littleaarch64

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

<weigh10>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
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
               	mov	x17, #0x7               // =7
               	mul	x1, x6, x17
               	add	x0, x0, x1
               	lsl	x1, x7, #3
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x10]
               	mov	x17, #0x9               // =9
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x18]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<mix>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	d8, [sp, #0x40]
               	stp	x20, x21, [sp, #0x50]
               	mov	x17, #0x3               // =3
               	mul	x7, x0, x17
               	mov	x17, #0x5               // =5
               	mul	x8, x1, x17
               	add	x2, x0, x1
               	sub	x3, x0, x1
               	mul	x4, x0, x1
               	add	x5, x0, #0x7
               	add	x6, x1, #0x9
               	mov	x17, #0xb               // =11
               	mul	x9, x0, x17
               	mov	x17, #0xd               // =13
               	mul	x10, x1, x17
               	eor	x11, x0, x1
               	orr	x12, x0, #0x40
               	lsl	x13, x1, #3
               	mul	x0, x0, x0
               	mul	x14, x1, x1
               	adrp	x15, <page>
               	add	x15, x15, <lo12>
               	mov	x16, x15
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x16]
               	ldr	x10, [x16, #0x8]
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
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
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
               	asr	x15, x13, #63
               	bic	x13, x13, x15
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
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
               	add	x14, x14, x9
               	add	x14, x14, x11
               	b	<addr>
               	orr	x14, x11, #0x7ff0000000000000
               	b	<addr>
               	mov	x14, x11
               	fmov	d8, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	lsl	x20, x8, #1
               	add	x20, x7, x20
               	mov	x17, #0x3               // =3
               	mul	x21, x2, x17
               	add	x20, x20, x21
               	lsl	x21, x3, #2
               	add	x20, x20, x21
               	mov	x17, #0x5               // =5
               	mul	x21, x4, x17
               	add	x20, x20, x21
               	mov	x17, #0x6               // =6
               	mul	x21, x5, x17
               	add	x20, x20, x21
               	mov	x17, #0x7               // =7
               	mul	x21, x6, x17
               	add	x20, x20, x21
               	lsl	x21, x9, #3
               	add	x20, x20, x21
               	mov	x17, #0x9               // =9
               	mul	x21, x10, x17
               	add	x20, x20, x21
               	mov	x17, #0xa               // =10
               	mul	x21, x11, x17
               	add	x20, x20, x21
               	mov	x17, #0xb               // =11
               	mul	x21, x12, x17
               	add	x20, x20, x21
               	mov	x17, #0xc               // =12
               	mul	x21, x13, x17
               	add	x20, x20, x21
               	mov	x17, #0xd               // =13
               	mul	x21, x0, x17
               	add	x20, x20, x21
               	mov	x17, #0xe               // =14
               	mul	x21, x14, x17
               	add	x20, x20, x21
               	fmov	d0, #2.00000000
               	fmul	d0, d8, d0
               	mov	x16, x15
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d0
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	and	x12, x9, #0xfffffffffffff
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	lsl	x13, x11, #48
               	orr	x10, x10, x13
               	b	<addr>
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	orr	x10, x10, #0x7fff000000000000
               	cbz	x12, <addr>
               	orr	x10, x10, #0x800000000000
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	and	x12, x12, #0xfffffffffffff
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	str	x9, [x16, #0x10]
               	str	x10, [x16, #0x18]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	sub	x0, x14, x0
               	add	x0, x0, x13
               	sub	x0, x0, x12
               	add	x0, x0, x11
               	sub	x0, x0, x10
               	add	x0, x0, x9
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldr	x9, [x9]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	mov	x0, x7
               	mov	x7, x20
               	mov	x1, x8
               	blr	x9
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x1, #0x20]
               	ldr	x10, [x1, #0x28]
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
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
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
               	asr	x15, x13, #63
               	bic	x13, x13, x15
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
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
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
               	add	x0, x0, x20
               	fmov	d1, #4.00000000
               	fmul	d1, d8, d1
               	fcvtzs	x1, d1
               	add	x1, x0, x1
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	ldp	x20, x21, [sp, #0x50]
               	ldr	d8, [sp, #0x40]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stp	x20, x21, [sp, #0x40]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x3               // =3
               	mul	x2, x0, x17
               	mov	x17, #0x5               // =5
               	mul	x3, x1, x17
               	add	x12, x0, x1
               	sub	x4, x0, x1
               	mul	x13, x0, x1
               	add	x14, x0, #0x7
               	add	x15, x1, #0x9
               	mov	x17, #0xb               // =11
               	mul	x5, x0, x17
               	mov	x17, #0xd               // =13
               	mul	x6, x1, x17
               	eor	x7, x0, x1
               	orr	x8, x0, #0x40
               	lsl	x9, x1, #3
               	mul	x10, x0, x0
               	mul	x11, x1, x1
               	lsl	x20, x3, #1
               	add	x20, x2, x20
               	mov	x17, #0x3               // =3
               	mul	x12, x12, x17
               	add	x20, x20, x12
               	lsl	x21, x4, #2
               	add	x20, x20, x21
               	mov	x17, #0x5               // =5
               	mul	x13, x13, x17
               	add	x20, x20, x13
               	mov	x17, #0x6               // =6
               	mul	x14, x14, x17
               	add	x20, x20, x14
               	mov	x17, #0x7               // =7
               	mul	x15, x15, x17
               	add	x20, x20, x15
               	lsl	x21, x5, #3
               	add	x20, x20, x21
               	mov	x17, #0x9               // =9
               	mul	x21, x6, x17
               	add	x20, x20, x21
               	mov	x17, #0xa               // =10
               	mul	x21, x7, x17
               	add	x20, x20, x21
               	mov	x17, #0xb               // =11
               	mul	x21, x8, x17
               	add	x20, x20, x21
               	mov	x17, #0xc               // =12
               	mul	x21, x9, x17
               	add	x20, x20, x21
               	mov	x17, #0xd               // =13
               	mul	x21, x10, x17
               	add	x20, x20, x21
               	mov	x17, #0xe               // =14
               	mul	x21, x11, x17
               	add	x20, x20, x21
               	sub	x10, x11, x10
               	add	x9, x10, x9
               	sub	x8, x9, x8
               	add	x7, x8, x7
               	sub	x6, x7, x6
               	add	x5, x6, x5
               	lsl	x3, x3, #1
               	add	x2, x2, x3
               	add	x2, x2, x12
               	lsl	x3, x4, #2
               	add	x2, x2, x3
               	add	x2, x2, x13
               	add	x2, x2, x14
               	add	x2, x2, x15
               	lsl	x3, x20, #3
               	add	x2, x2, x3
               	mov	x17, #0x9               // =9
               	mul	x3, x5, x17
               	add	x2, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x3, x1, x17
               	add	x2, x2, x3
               	add	x2, x2, x20
               	add	x20, x2, #0x7
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x0, #0x10]
               	ldr	x10, [x0, #0x18]
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
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
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
               	asr	x15, x13, #63
               	bic	x13, x13, x15
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
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
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
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
