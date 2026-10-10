
long_double_binary128_conversion.aarch64:	file format elf64-littleaarch64

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

<narrow>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x0]
               	ldr	x10, [x0, #0x8]
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
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<widen>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
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
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, x11, lsl #48
               	b	<addr>
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
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
               	str	x9, [x0]
               	str	x10, [x0, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<round_to_double>:
               	sxtw	x2, w2
               	sxtw	x3, w3
               	cmp	w3, #0x1
               	b.lt	<addr>
               	mov	x5, #0xb                // =11
               	cmp	w3, #0x7ff
               	b.lt	<addr>
               	orr	x0, x0, #0x7ff0000000000000
               	ret
               	cmp	w5, #0x40
               	b.le	<addr>
               	ret
               	cmp	w5, #0x40
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	sub	x5, x5, #0x1
               	sxtw	x6, w5
               	lsr	x5, x1, x6
               	and	x7, x5, #0x1
               	mov	x5, #0x1                // =1
               	cbnz	x2, <addr>
               	lsl	x2, x5, x6
               	sub	x2, x2, #0x1
               	and	x1, x1, x2
               	cmp	x1, #0x0
               	cset	x5, ne
               	cbz	x7, <addr>
               	cbnz	x5, <addr>
               	tbz	w4, #0x0, <addr>
               	add	x4, x4, #0x1
               	cmp	w3, #0x1
               	b.ge	<addr>
               	orr	x0, x0, x4
               	ret
               	lsr	x1, x4, #53
               	cbz	x1, <addr>
               	lsr	x4, x4, #1
               	add	x3, x3, #0x1
               	cmp	w3, #0x7ff
               	b.lt	<addr>
               	orr	x0, x0, #0x7ff0000000000000
               	ret
               	lsl	x1, x3, #52
               	orr	x0, x0, x1
               	and	x1, x4, #0xfffffffffffff
               	orr	x0, x0, x1
               	ret
               	sxtw	x4, w5
               	lsr	x4, x1, x4
               	b	<addr>
               	mov	x4, #0xc                // =12
               	sub	x5, x4, x3
               	b	<addr>

<check_narrow>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x21, x0
               	mov	x20, x1
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	stur	x20, [x29, #-0x10]
               	stur	x21, [x29, #-0x8]
               	sub	x0, x29, #0x30
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x30
               	bl	<addr>
               	stur	d0, [x29, #-0x20]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x20
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x22, [x29, #-0x18]
               	and	x0, x21, #0x8000000000000000
               	lsr	x1, x21, #48
               	and	x3, x1, #0x7fff
               	and	x1, x21, #0xffffffffffff
               	mov	x17, #0x7fff            // =32767
               	cmp	w3, w17
               	b.ne	<addr>
               	orr	x2, x1, x20
               	cbnz	x2, <addr>
               	orr	x0, x0, #0x7ff0000000000000
               	cmp	x22, x0
               	cset	x0, eq
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	orr	x0, x0, #0x7ff8000000000000
               	lsl	x1, x1, #4
               	orr	x0, x0, x1
               	lsr	x1, x20, #60
               	orr	x0, x0, x1
               	b	<addr>
               	cbz	w3, <addr>
               	lsl	x1, x1, #15
               	orr	x1, x1, #0x8000000000000000
               	lsr	x2, x20, #49
               	orr	x1, x1, x2
               	and	x2, x20, #0x1ffffffffffff
               	cmp	x2, #0x0
               	cset	x2, ne
               	mov	x17, #0x3fff            // =16383
               	sub	x3, x3, x17
               	add	x3, x3, #0x3ff
               	bl	<addr>
               	b	<addr>

<check_widen>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	x0, [x29, #-0x40]
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x40
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sub	x0, x29, #0x50
               	ldur	d0, [x29, #-0x28]
               	bl	<addr>
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x50
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	ldur	x0, [x29, #-0x40]
               	and	x3, x0, #0x8000000000000000
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	orr	x1, x3, #0x7fff000000000000
               	lsr	x2, x0, #4
               	orr	x2, x1, x2
               	cbz	x0, <addr>
               	mov	x1, #0x800000000000     // =140737488355328
               	orr	x1, x2, x1
               	stur	x1, [x29, #-0x20]
               	lsl	x0, x0, #60
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x0                // =0
               	ldur	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x18]
               	cmp	x1, x2
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x20]
               	cmp	x0, x1
               	cset	x0, eq
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	stur	x3, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	b	<addr>
               	mov	x1, #0x1                // =1
               	lsr	x2, x0, #52
               	cbnz	w2, <addr>
               	lsl	x0, x0, #1
               	sub	x1, x1, #0x1
               	lsr	x2, x0, #52
               	cbz	w2, <addr>
               	and	x0, x0, #0xfffffffffffff
               	sub	x1, x1, #0x3ff
               	mov	x17, #0x3fff            // =16383
               	add	x1, x1, x17
               	sxtw	x1, w1
               	lsl	x1, x1, #48
               	orr	x1, x3, x1
               	lsr	x2, x0, #4
               	orr	x1, x1, x2
               	stur	x1, [x29, #-0x20]
               	lsl	x0, x0, #60
               	stur	x0, [x29, #-0x18]
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x23, #0x0               // =0
               	mov	x22, #0x0               // =0
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	cmp	w20, #0x8
               	b.ge	<addr>
               	tbz	w20, #0x0, <addr>
               	mov	x0, #0xffffffffffff     // =281474976710655
               	cmp	w20, #0x8
               	b.ge	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x20, lsl #3]
               	lsl	x2, x22, #63
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3, x23, lsl #3]
               	lsl	x3, x3, #48
               	orr	x2, x2, x3
               	orr	x0, x2, x0
               	bl	<addr>
               	cbnz	w0, <addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x1, [x2]
               	lsl	x3, x1, #13
               	eor	x1, x1, x3
               	str	x1, [x2]
               	lsr	x3, x1, #7
               	eor	x1, x1, x3
               	str	x1, [x2]
               	lsl	x3, x1, #17
               	eor	x1, x1, x3
               	str	x1, [x2]
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	lsl	x2, x1, #13
               	eor	x1, x1, x2
               	str	x1, [x0]
               	lsr	x2, x1, #7
               	eor	x1, x1, x2
               	str	x1, [x0]
               	lsl	x2, x1, #17
               	eor	x1, x1, x2
               	str	x1, [x0]
               	lsr	x0, x1, #16
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x30
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x2
               	b.lo	<addr>
               	add	x23, x23, #0x1
               	cmp	w23, #0x10
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2]
               	lsl	x1, x0, #13
               	eor	x0, x0, x1
               	str	x0, [x2]
               	lsr	x1, x0, #7
               	eor	x0, x0, x1
               	str	x0, [x2]
               	lsl	x1, x0, #17
               	eor	x0, x0, x1
               	str	x0, [x2]
               	lsl	x1, x0, #13
               	eor	x1, x0, x1
               	str	x1, [x2]
               	lsr	x3, x1, #7
               	eor	x1, x1, x3
               	str	x1, [x2]
               	lsl	x3, x1, #17
               	eor	x1, x1, x3
               	str	x1, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	add	x20, x20, #0x1
               	mov	x17, #0x1000            // =4096
               	cmp	w20, w17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xfffffffffffff    // =4503599627370495
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x8000000000000    // =2251799813685248
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x10000000000000   // =4503599627370496
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x7fefffffffffffff // =9218868437227405311
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x7ff0000000000000 // =9218868437227405312
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7ff0, lsl #48
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x7ff4000000000000 // =9219994337134247936
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x7ff8000000000000 // =9221120237041090560
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #-0x7fffffffffffffff // =-9223372036854775807
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #-0x10000000000000  // =-4503599627370496
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x20, #0x0               // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	lsl	x2, x0, #13
               	eor	x0, x0, x2
               	str	x0, [x1]
               	lsr	x2, x0, #7
               	eor	x0, x0, x2
               	str	x0, [x1]
               	lsl	x2, x0, #17
               	eor	x0, x0, x2
               	str	x0, [x1]
               	tbz	w20, #0x0, <addr>
               	and	x0, x0, #0x800fffffffffffff
               	bl	<addr>
               	cbz	w0, <addr>
               	add	x20, x20, #0x1
               	mov	x17, #0x1000            // =4096
               	cmp	w20, w17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
