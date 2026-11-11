
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
               	mov	x4, #0xb                // =11
               	mov	x5, #0xc                // =12
               	sub	x5, x5, x3
               	cmp	w3, #0x1
               	csel	x5, x4, x5, ge
               	cmp	w3, #0x7ff
               	b.lt	<addr>
               	orr	x0, x0, #0x7ff0000000000000
               	ret
               	cmp	w5, #0x40
               	b.le	<addr>
               	ret
               	mov	x4, #0x0                // =0
               	sxtw	x6, w5
               	lsr	x6, x1, x6
               	cmp	w5, #0x40
               	csel	x4, x4, x6, eq
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
               	orr	x0, x0, x3, lsl #52
               	and	x1, x4, #0xfffffffffffff
               	orr	x0, x0, x1
               	ret

<check_widen>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x20
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x30
               	ldur	d0, [x29, #-0x8]
               	bl	<addr>
               	ldur	x4, [x29, #-0x30]
               	ldur	x5, [x29, #-0x28]
               	ldur	x2, [x29, #-0x20]
               	and	x3, x2, #0x8000000000000000
               	ubfx	x1, x2, #52, #11
               	and	x0, x2, #0xfffffffffffff
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	orr	x1, x3, #0x7fff000000000000
               	orr	x1, x1, x0, lsr #4
               	mov	x3, #0x800000000000     // =140737488355328
               	mov	x6, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x3, x6, ne
               	orr	x0, x1, x0
               	stur	x0, [x29, #-0x10]
               	lsl	x0, x2, #60
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldur	x1, [x29, #-0x8]
               	cmp	x4, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x5, x0
               	cset	x0, eq
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	stur	x3, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
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
               	orr	x1, x3, x1, lsl #48
               	orr	x1, x1, x0, lsr #4
               	stur	x1, [x29, #-0x10]
               	lsl	x0, x0, #60
               	stur	x0, [x29, #-0x8]
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x24, #0x0               // =0
               	mov	x23, #0x0               // =0
               	mov	x20, #0x0               // =0
               	cmp	w20, #0x8
               	b.ge	<addr>
               	mov	x0, #0xffffffffffff     // =281474976710655
               	mov	x1, #0x0                // =0
               	tst	x20, #0x1
               	csel	x1, x0, x1, ne
               	cmp	w20, #0x8
               	b.ge	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0, x20, lsl #3]
               	lsl	x0, x23, #63
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, x24, lsl #3]
               	orr	x0, x0, x2, lsl #48
               	orr	x22, x0, x1
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	stur	x21, [x29, #-0x10]
               	stur	x22, [x29, #-0x8]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	bl	<addr>
               	stur	d0, [x29, #-0x20]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x20
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x25, [x29, #-0x18]
               	and	x0, x22, #0x8000000000000000
               	ubfx	x3, x22, #48, #15
               	and	x1, x22, #0xffffffffffff
               	mov	x17, #0x7fff            // =32767
               	cmp	w3, w17
               	b.ne	<addr>
               	orr	x2, x1, x21
               	cbnz	x2, <addr>
               	orr	x0, x0, #0x7ff0000000000000
               	cmp	x25, x0
               	b.eq	<addr>
               	b	<addr>
               	orr	x0, x0, #0x7ff8000000000000
               	orr	x0, x0, x1, lsl #4
               	orr	x0, x0, x21, lsr #60
               	b	<addr>
               	cbz	w3, <addr>
               	lsl	x1, x1, #15
               	orr	x1, x1, #0x8000000000000000
               	orr	x1, x1, x21, lsr #49
               	and	x2, x21, #0x1ffffffffffff
               	cmp	x2, #0x0
               	cset	x2, ne
               	mov	x17, #0x3fff            // =16383
               	sub	x3, x3, x17
               	add	x3, x3, #0x3ff
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	eor	x2, x2, x2, lsl #13
               	str	x2, [x0, #0x18]
               	eor	x2, x2, x2, lsr #7
               	str	x2, [x0, #0x18]
               	eor	x21, x2, x2, lsl #17
               	str	x21, [x0, #0x18]
               	b	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsl #13
               	str	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsr #7
               	str	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x0, #0x18]
               	lsr	x1, x1, #16
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x30
               	b.lt	<addr>
               	add	x23, x23, #0x1
               	cmp	w23, #0x2
               	b.lo	<addr>
               	add	x24, x24, #0x1
               	cmp	w24, #0x10
               	b.lo	<addr>
               	mov	x22, #0x0               // =0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsl #13
               	str	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsr #7
               	str	x1, [x0, #0x18]
               	eor	x20, x1, x1, lsl #17
               	str	x20, [x0, #0x18]
               	eor	x1, x20, x20, lsl #13
               	str	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsr #7
               	str	x1, [x0, #0x18]
               	eor	x21, x1, x1, lsl #17
               	str	x21, [x0, #0x18]
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	stur	x21, [x29, #-0x10]
               	stur	x20, [x29, #-0x8]
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	bl	<addr>
               	stur	d0, [x29, #-0x20]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x20
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x23, [x29, #-0x18]
               	and	x0, x20, #0x8000000000000000
               	ubfx	x3, x20, #48, #15
               	and	x1, x20, #0xffffffffffff
               	mov	x17, #0x7fff            // =32767
               	cmp	w3, w17
               	b.ne	<addr>
               	orr	x2, x1, x21
               	cbnz	x2, <addr>
               	orr	x0, x0, #0x7ff0000000000000
               	cmp	x23, x0
               	b.eq	<addr>
               	b	<addr>
               	orr	x0, x0, #0x7ff8000000000000
               	orr	x0, x0, x1, lsl #4
               	orr	x0, x0, x21, lsr #60
               	b	<addr>
               	cbz	w3, <addr>
               	lsl	x1, x1, #15
               	orr	x1, x1, #0x8000000000000000
               	orr	x1, x1, x21, lsr #49
               	and	x2, x21, #0x1ffffffffffff
               	cmp	x2, #0x0
               	cset	x2, ne
               	mov	x17, #0x3fff            // =16383
               	sub	x3, x3, x17
               	add	x3, x3, #0x3ff
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	add	x22, x22, #0x1
               	mov	x17, #0x1000            // =4096
               	cmp	w22, w17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
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
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsl #13
               	str	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsr #7
               	str	x1, [x0, #0x18]
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x0, #0x18]
               	and	x0, x1, #0x800fffffffffffff
               	tst	x20, #0x1
               	csel	x0, x0, x1, ne
               	bl	<addr>
               	cbz	w0, <addr>
               	add	x20, x20, #0x1
               	mov	x17, #0x1000            // =4096
               	cmp	w20, w17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
