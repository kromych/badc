
int128_fp_convert.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x2, x0
               	mov	x3, x1
               	sub	x0, x29, #0x10
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	orr	x3, x1, x3
               	orr	x1, x2, x1
               	sub	x0, x29, #0x30
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<dbits>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<fbits>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<chk_to_fp>:
               	stp	x20, x21, [sp, #-0xe0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	mov	x23, x2
               	mov	x20, x6
               	mov	x26, x5
               	mov	x25, x4
               	mov	x24, x3
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x0, [x21]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x1, [x22]
               	ldr	x0, [x21]
               	ldr	x1, [x22]
               	bl	<addr>
               	sub	x16, x29, #0x38
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x4, ne
               	lsr	x1, x0, #32
               	cmp	x1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x6, x1, #0x1
               	lsr	x1, x0, x1
               	lsr	x3, x1, #16
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #4
               	add	x6, x6, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #8
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #3
               	add	x6, x6, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #4
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #2
               	add	x6, x6, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #2
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #1
               	add	x6, x6, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #1
               	cmp	x3, #0x0
               	cset	x3, ne
               	add	x6, x6, x3
               	mul	x1, x6, x4
               	mov	x3, #0x40               // =64
               	sub	x3, x3, x1
               	mov	x17, #0x3f              // =63
               	and	x3, x3, x17
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	lsr	x3, x4, x3
               	cmp	x1, #0x0
               	cset	x4, ne
               	mul	x3, x3, x4
               	and	x3, x5, x3
               	cmp	x3, #0x0
               	cset	x8, ne
               	mov	x17, #0x7f              // =127
               	and	x4, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x1, x17
               	mov	x6, #0x3f               // =63
               	sub	x9, x6, x3
               	lsr	x4, x4, #6
               	sub	x4, x2, x4
               	mvn	x6, x4
               	lsr	x7, x0, x3
               	lsl	x0, x0, x9
               	lsl	x0, x0, #1
               	lsr	x3, x5, x3
               	orr	x0, x3, x0
               	and	x0, x0, x6
               	and	x3, x7, x4
               	orr	x0, x0, x3
               	orr	x0, x0, x8
               	ucvtf	d0, x0
               	add	x0, x1, #0x3ff
               	lsl	x0, x0, #52
               	orr	x1, x0, x2
               	sub	x0, x29, #0x40
               	str	x1, [x0]
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	bl	<addr>
               	cmp	x0, x23
               	b.eq	<addr>
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldr	x0, [x21]
               	ldr	x1, [x22]
               	bl	<addr>
               	sub	x16, x29, #0x50
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x50
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x4, ne
               	lsr	x1, x0, #32
               	cmp	x1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x6, x1, #0x1
               	lsr	x1, x0, x1
               	lsr	x3, x1, #16
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #4
               	add	x6, x6, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #8
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #3
               	add	x6, x6, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #4
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #2
               	add	x6, x6, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #2
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #1
               	add	x6, x6, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #1
               	cmp	x3, #0x0
               	cset	x3, ne
               	add	x6, x6, x3
               	mul	x1, x6, x4
               	mov	x3, #0x40               // =64
               	sub	x3, x3, x1
               	mov	x17, #0x3f              // =63
               	and	x3, x3, x17
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	lsr	x3, x4, x3
               	cmp	x1, #0x0
               	cset	x4, ne
               	mul	x3, x3, x4
               	and	x3, x5, x3
               	cmp	x3, #0x0
               	cset	x8, ne
               	mov	x17, #0x7f              // =127
               	and	x4, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x1, x17
               	mov	x6, #0x3f               // =63
               	sub	x9, x6, x3
               	lsr	x4, x4, #6
               	sub	x4, x2, x4
               	mvn	x6, x4
               	lsr	x7, x0, x3
               	lsl	x0, x0, x9
               	lsl	x0, x0, #1
               	lsr	x3, x5, x3
               	orr	x0, x3, x0
               	and	x0, x0, x6
               	and	x3, x7, x4
               	orr	x0, x0, x3
               	orr	x0, x0, x8
               	ucvtf	s0, x0
               	fcvt	d0, s0
               	add	x0, x1, #0x3ff
               	lsl	x0, x0, #52
               	orr	x1, x0, x2
               	sub	x0, x29, #0x58
               	str	x1, [x0]
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	fcvt	s0, d0
               	bl	<addr>
               	mov	w1, w24
               	cmp	x0, x1
               	b.eq	<addr>
               	add	x0, x20, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldr	x0, [x21]
               	ldr	x1, [x22]
               	bl	<addr>
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x68
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	asr	x0, x1, #63
               	eor	x2, x2, x0
               	eor	x1, x1, x0
               	cmp	x2, x0
               	cset	x3, lo
               	sub	x4, x2, x0
               	sub	x1, x1, x0
               	sub	x1, x1, x3
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	and	x8, x0, x17
               	cmp	x1, #0x0
               	cset	x3, ne
               	lsr	x0, x1, #32
               	cmp	x0, #0x0
               	cset	x0, ne
               	lsl	x0, x0, #5
               	add	x5, x0, #0x1
               	lsr	x0, x1, x0
               	lsr	x2, x0, #16
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #4
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #8
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #3
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #4
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #2
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #2
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #1
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #1
               	cmp	x2, #0x0
               	cset	x2, ne
               	add	x5, x5, x2
               	mul	x0, x5, x3
               	mov	x2, #0x40               // =64
               	sub	x2, x2, x0
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	lsr	x2, x3, x2
               	cmp	x0, #0x0
               	cset	x3, ne
               	mul	x2, x2, x3
               	and	x2, x4, x2
               	cmp	x2, #0x0
               	cset	x9, ne
               	mov	x17, #0x7f              // =127
               	and	x3, x0, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x0, x17
               	mov	x5, #0x3f               // =63
               	sub	x10, x5, x2
               	lsr	x3, x3, #6
               	mov	x5, #0x0                // =0
               	sub	x3, x5, x3
               	mvn	x6, x3
               	lsr	x7, x1, x2
               	lsl	x1, x1, x10
               	lsl	x1, x1, #1
               	lsr	x2, x4, x2
               	orr	x1, x2, x1
               	and	x1, x1, x6
               	and	x2, x7, x3
               	orr	x1, x1, x2
               	orr	x1, x1, x9
               	ucvtf	d0, x1
               	add	x0, x0, #0x3ff
               	lsl	x0, x0, #52
               	orr	x1, x0, x8
               	sub	x0, x29, #0x70
               	str	x1, [x0]
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	bl	<addr>
               	cmp	x0, x25
               	b.eq	<addr>
               	add	x0, x20, #0x2
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldr	x0, [x21]
               	ldr	x1, [x22]
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x80
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	asr	x0, x1, #63
               	eor	x2, x2, x0
               	eor	x1, x1, x0
               	cmp	x2, x0
               	cset	x3, lo
               	sub	x4, x2, x0
               	sub	x1, x1, x0
               	sub	x1, x1, x3
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	and	x8, x0, x17
               	cmp	x1, #0x0
               	cset	x3, ne
               	lsr	x0, x1, #32
               	cmp	x0, #0x0
               	cset	x0, ne
               	lsl	x0, x0, #5
               	add	x5, x0, #0x1
               	lsr	x0, x1, x0
               	lsr	x2, x0, #16
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #4
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #8
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #3
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #4
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #2
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #2
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #1
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #1
               	cmp	x2, #0x0
               	cset	x2, ne
               	add	x5, x5, x2
               	mul	x0, x5, x3
               	mov	x2, #0x40               // =64
               	sub	x2, x2, x0
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	lsr	x2, x3, x2
               	cmp	x0, #0x0
               	cset	x3, ne
               	mul	x2, x2, x3
               	and	x2, x4, x2
               	cmp	x2, #0x0
               	cset	x9, ne
               	mov	x17, #0x7f              // =127
               	and	x3, x0, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x0, x17
               	mov	x5, #0x3f               // =63
               	sub	x10, x5, x2
               	lsr	x3, x3, #6
               	mov	x5, #0x0                // =0
               	sub	x3, x5, x3
               	mvn	x6, x3
               	lsr	x7, x1, x2
               	lsl	x1, x1, x10
               	lsl	x1, x1, #1
               	lsr	x2, x4, x2
               	orr	x1, x2, x1
               	and	x1, x1, x6
               	and	x2, x7, x3
               	orr	x1, x1, x2
               	orr	x1, x1, x9
               	ucvtf	s0, x1
               	fcvt	d0, s0
               	add	x0, x0, #0x3ff
               	lsl	x0, x0, #52
               	orr	x1, x0, x8
               	sub	x0, x29, #0x88
               	str	x1, [x0]
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	fcvt	s0, d0
               	bl	<addr>
               	mov	w1, w26
               	cmp	x0, x1
               	b.eq	<addr>
               	add	x0, x20, #0x3
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret

<chk_from_fp>:
               	stp	x20, x21, [sp, #-0xb0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x9, x0
               	mov	x7, x2
               	mov	x10, x1
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	d0, [x6]
               	sub	x15, x29, #0x10
               	ldr	d0, [x6]
               	sub	x3, x29, #0x30
               	sub	x0, x29, #0x38
               	str	d0, [x0]
               	ldr	x0, [x0]
               	asr	x20, x0, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x1, x0, x17
               	lsr	x1, x1, #52
               	sub	x11, x1, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x8, x0, x17
               	sub	x0, x1, #0x433
               	asr	x1, x0, #63
               	eor	x0, x0, x1
               	sub	x2, x0, x1
               	mov	x0, #0x0                // =0
               	mov	x17, #0x7f              // =127
               	and	x4, x2, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	mov	x5, #0x3f               // =63
               	sub	x12, x5, x2
               	lsr	x4, x4, #6
               	sub	x4, x0, x4
               	mvn	x5, x4
               	lsl	x13, x8, x2
               	lsr	x14, x8, x12
               	lsr	x14, x14, #1
               	lsl	x21, x0, x2
               	orr	x21, x21, x14
               	and	x22, x13, x5
               	and	x14, x0, x4
               	orr	x22, x22, x14
               	and	x21, x21, x5
               	and	x13, x13, x4
               	orr	x21, x21, x13
               	lsr	x13, x0, x2
               	lsl	x12, x0, x12
               	lsl	x12, x12, #1
               	lsr	x2, x8, x2
               	orr	x2, x2, x12
               	and	x2, x2, x5
               	and	x4, x13, x4
               	orr	x4, x2, x4
               	and	x2, x13, x5
               	orr	x5, x2, x14
               	mvn	x2, x1
               	and	x8, x22, x2
               	and	x4, x4, x1
               	orr	x4, x8, x4
               	and	x2, x21, x2
               	and	x1, x5, x1
               	orr	x2, x2, x1
               	asr	x1, x11, #63
               	mvn	x1, x1
               	and	x4, x4, x1
               	and	x5, x2, x1
               	cmp	x11, #0x80
               	cset	x1, ge
               	sub	x1, x0, x1
               	mvn	x2, x1
               	and	x4, x4, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x4, x4, x1
               	and	x2, x5, x2
               	orr	x2, x2, x1
               	mvn	x1, x20
               	and	x4, x4, x1
               	and	x1, x2, x1
               	str	x4, [x3]
               	str	x1, [x3, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x15]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x15
               	sub	x1, x29, #0x10
               	ldr	x2, [x1, #0x8]
               	sub	x1, x29, #0x50
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	cmp	x2, x9
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x10
               	cset	x0, ne
               	cbz	x0, <addr>
               	sxtw	x0, w7
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x15, x29, #0x20
               	ldr	d0, [x6]
               	sub	x4, x29, #0x60
               	sub	x0, x29, #0x68
               	str	d0, [x0]
               	ldr	x1, [x0]
               	asr	x0, x1, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x2, x1, x17
               	lsr	x2, x2, #52
               	sub	x11, x2, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x8, x1, x17
               	sub	x1, x2, #0x433
               	asr	x2, x1, #63
               	eor	x1, x1, x2
               	sub	x3, x1, x2
               	mov	x1, #0x0                // =0
               	mov	x17, #0x7f              // =127
               	and	x5, x3, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x3, x17
               	mov	x6, #0x3f               // =63
               	sub	x12, x6, x3
               	lsr	x5, x5, #6
               	sub	x5, x1, x5
               	mvn	x6, x5
               	lsl	x13, x8, x3
               	lsr	x14, x8, x12
               	lsr	x14, x14, #1
               	lsl	x20, x1, x3
               	orr	x20, x20, x14
               	and	x21, x13, x6
               	and	x14, x1, x5
               	orr	x21, x21, x14
               	and	x20, x20, x6
               	and	x13, x13, x5
               	orr	x20, x20, x13
               	lsr	x13, x1, x3
               	lsl	x12, x1, x12
               	lsl	x12, x12, #1
               	lsr	x3, x8, x3
               	orr	x3, x3, x12
               	and	x3, x3, x6
               	and	x5, x13, x5
               	orr	x5, x3, x5
               	and	x3, x13, x6
               	orr	x6, x3, x14
               	mvn	x3, x2
               	and	x8, x21, x3
               	and	x5, x5, x2
               	orr	x5, x8, x5
               	and	x3, x20, x3
               	and	x2, x6, x2
               	orr	x3, x3, x2
               	asr	x2, x11, #63
               	mvn	x2, x2
               	and	x5, x5, x2
               	and	x6, x3, x2
               	cmp	x11, #0x80
               	cset	x2, ge
               	sub	x2, x1, x2
               	eor	x3, x5, x0
               	eor	x5, x6, x0
               	cmp	x3, x0
               	cset	x6, lo
               	sub	x3, x3, x0
               	sub	x5, x5, x0
               	sub	x5, x5, x6
               	mvn	x6, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	eor	x8, x0, x17
               	mvn	x0, x2
               	and	x3, x3, x0
               	and	x6, x6, x2
               	orr	x3, x3, x6
               	and	x0, x5, x0
               	and	x2, x8, x2
               	orr	x0, x0, x2
               	str	x3, [x4]
               	str	x0, [x4, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x15]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x15
               	sub	x0, x29, #0x20
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x80
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	cmp	x2, x9
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	cmp	x0, x10
               	cset	x0, ne
               	cbz	x0, <addr>
               	add	x0, x7, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	b	<addr>
               	b	<addr>

<chk_from_fp_neg>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x13, x0
               	mov	x8, x2
               	mov	x14, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	d0, [x0]
               	sub	x15, x29, #0x10
               	ldr	d0, [x0]
               	sub	x4, x29, #0x20
               	sub	x0, x29, #0x28
               	str	d0, [x0]
               	ldr	x1, [x0]
               	asr	x0, x1, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x2, x1, x17
               	lsr	x2, x2, #52
               	sub	x9, x2, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x7, x1, x17
               	sub	x1, x2, #0x433
               	asr	x2, x1, #63
               	eor	x1, x1, x2
               	sub	x3, x1, x2
               	mov	x1, #0x0                // =0
               	mov	x17, #0x7f              // =127
               	and	x5, x3, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x3, x17
               	mov	x6, #0x3f               // =63
               	sub	x10, x6, x3
               	lsr	x5, x5, #6
               	sub	x5, x1, x5
               	mvn	x6, x5
               	lsl	x11, x7, x3
               	lsr	x12, x7, x10
               	lsr	x12, x12, #1
               	lsl	x20, x1, x3
               	orr	x20, x20, x12
               	and	x21, x11, x6
               	and	x12, x1, x5
               	orr	x21, x21, x12
               	and	x20, x20, x6
               	and	x11, x11, x5
               	orr	x20, x20, x11
               	lsr	x11, x1, x3
               	lsl	x10, x1, x10
               	lsl	x10, x10, #1
               	lsr	x3, x7, x3
               	orr	x3, x3, x10
               	and	x3, x3, x6
               	and	x5, x11, x5
               	orr	x5, x3, x5
               	and	x3, x11, x6
               	orr	x6, x3, x12
               	mvn	x3, x2
               	and	x7, x21, x3
               	and	x5, x5, x2
               	orr	x5, x7, x5
               	and	x3, x20, x3
               	and	x2, x6, x2
               	orr	x3, x3, x2
               	asr	x2, x9, #63
               	mvn	x2, x2
               	and	x5, x5, x2
               	and	x6, x3, x2
               	cmp	x9, #0x80
               	cset	x2, ge
               	sub	x2, x1, x2
               	eor	x3, x5, x0
               	eor	x5, x6, x0
               	cmp	x3, x0
               	cset	x6, lo
               	sub	x3, x3, x0
               	sub	x5, x5, x0
               	sub	x5, x5, x6
               	mvn	x6, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	eor	x7, x0, x17
               	mvn	x0, x2
               	and	x3, x3, x0
               	and	x6, x6, x2
               	orr	x3, x3, x6
               	and	x0, x5, x0
               	and	x2, x7, x2
               	orr	x0, x0, x2
               	str	x3, [x4]
               	str	x0, [x4, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x15]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x15
               	sub	x0, x29, #0x10
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x40
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	cmp	x2, x13
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x14
               	cset	x0, ne
               	cbz	x0, <addr>
               	sxtw	x0, w8
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x1a0]!
               	stp	x29, x30, [sp, #0x190]
               	add	x29, sp, #0x190
               	mov	x0, #0x0                // =0
               	mov	x6, #0x1                // =1
               	mov	x1, x0
               	mov	x5, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	mov	x3, #0x3f800000         // =1065353216
               	mov	x6, #0x5                // =5
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5                // =5
               	mov	x2, #0x4014000000000000 // =4617315517961601024
               	mov	x3, #0x40a00000         // =1084227584
               	mov	x6, #0x9                // =9
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x20000000000000   // =9007199254740992
               	mov	x2, #0x4340000000000000 // =4845873199050653696
               	mov	x3, #0x5a000000         // =1509949440
               	mov	x6, #0xd                // =13
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	movk	x1, #0x20, lsl #48
               	mov	x2, #0x4340000000000000 // =4845873199050653696
               	mov	x3, #0x5a000000         // =1509949440
               	mov	x6, #0x11               // =17
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3                // =3
               	movk	x1, #0x20, lsl #48
               	mov	x2, #0x2                // =2
               	movk	x2, #0x4340, lsl #48
               	mov	x3, #0x5a000000         // =1509949440
               	mov	x6, #0x15               // =21
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0x43f0000000000000 // =4895412794951729152
               	mov	x3, #0x5f800000         // =1602224128
               	mov	x6, #0x19               // =25
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	mov	x2, #0x43e0000000000000 // =4890909195324358656
               	mov	x3, #0x5f000000         // =1593835520
               	mov	x6, #0x1d               // =29
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	mov	x2, #0x43f0000000000000 // =4895412794951729152
               	mov	x3, #0x5f800000         // =1602224128
               	mov	x6, #0x21               // =33
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4414000000000000 // =4905545894113312768
               	mov	x3, #0x60a00000         // =1621098496
               	mov	x6, #0x25               // =37
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x1000000000000    // =281474976710656
               	mov	x1, #0x1                // =1
               	mov	x2, #0x46f0000000000000 // =5111585577065512960
               	mov	x3, #0x77800000         // =2004877312
               	mov	x6, #0x29               // =41
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x1                // =1
               	movk	x0, #0x1, lsl #48
               	mov	x1, #0x1                // =1
               	mov	x2, #0x10               // =16
               	movk	x2, #0x46f0, lsl #48
               	mov	x3, #0x77800000         // =2004877312
               	mov	x6, #0x2d               // =45
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x2, #0x47f0000000000000 // =5183643171103440896
               	mov	x3, #0x7f800000         // =2139095040
               	mov	x4, #-0x4010000000000000 // =-4616189618054758400
               	mov	x5, #0xbf800000         // =3212836864
               	mov	x6, #0x31               // =49
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	mov	x1, #0x0                // =0
               	mov	x2, #0x47e0000000000000 // =5179139571476070400
               	mov	x3, #0x7f000000         // =2130706432
               	mov	x4, #-0x3820000000000000 // =-4044232465378705408
               	mov	x5, #0xff000000         // =4278190080
               	mov	x6, #0x35               // =53
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0x7fff, lsl #48
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0x47e0000000000000 // =5179139571476070400
               	mov	x3, #0x7f000000         // =2130706432
               	mov	x6, #0x39               // =57
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x6677             // =26231
               	movk	x0, #0x4455, lsl #16
               	movk	x0, #0x2233, lsl #32
               	movk	x0, #0x11, lsl #48
               	mov	x1, #0xeeff             // =61183
               	movk	x1, #0xccdd, lsl #16
               	movk	x1, #0xaabb, lsl #32
               	movk	x1, #0x8899, lsl #48
               	mov	x2, #0x6678             // =26232
               	movk	x2, #0x4455, lsl #16
               	movk	x2, #0x2233, lsl #32
               	movk	x2, #0x4731, lsl #48
               	mov	x3, #0x119a             // =4506
               	movk	x3, #0x7989, lsl #16
               	mov	x6, #0x3d               // =61
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x3, #0x41               // =65
               	fmov	d0, x0
               	mov	x1, x0
               	mov	x2, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0xa1cb             // =41419
               	movk	x0, #0xb645, lsl #16
               	movk	x0, #0xfdf3, lsl #32
               	movk	x0, #0x400f, lsl #48
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x3, #0x43               // =67
               	fmov	d0, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x0                // =0
               	mov	x3, #0x45               // =69
               	fmov	d0, x0
               	mov	x0, x1
               	mov	x2, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fneg	d0, d16
               	mov	x0, #0x0                // =0
               	mov	x2, #0x47               // =71
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0xa1cb             // =41419
               	movk	x0, #0xb645, lsl #16
               	movk	x0, #0xfdf3, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fmov	d16, x0
               	fneg	d0, d16
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0x49               // =73
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0xdb80             // =56192
               	movk	x0, #0x90d9, lsl #16
               	movk	x0, #0x556, lsl #32
               	movk	x0, #0x43ea, lsl #48
               	mov	x1, #0x0                // =0
               	mov	x2, #0xcedc0000         // =3470524416
               	movk	x2, #0xb486, lsl #32
               	movk	x2, #0xd02a, lsl #48
               	mov	x3, #0x4b               // =75
               	fmov	d0, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x43f0000000000000 // =4895412794951729152
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	mov	x3, #0x4d               // =77
               	fmov	d0, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x45c0000000000000 // =5026017184145473536
               	mov	x1, #0x20000000         // =536870912
               	mov	x2, #0x0                // =0
               	mov	x3, #0x4f               // =79
               	fmov	d0, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x47e0000000000000 // =5179139571476070400
               	fmov	d16, x0
               	fneg	d0, d16
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	mov	x1, #0x0                // =0
               	mov	x2, #0x51               // =81
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40200000         // =1075838976
               	fmov	s16, w1
               	str	s16, [x0]
               	ldr	s0, [x0]
               	sub	x3, x29, #0x68
               	fcvt	d0, s0
               	sub	x0, x29, #0x70
               	str	d0, [x0]
               	ldr	x0, [x0]
               	asr	x11, x0, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x1, x0, x17
               	lsr	x1, x1, #52
               	sub	x7, x1, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x6, x0, x17
               	sub	x0, x1, #0x433
               	asr	x1, x0, #63
               	eor	x0, x0, x1
               	sub	x2, x0, x1
               	mov	x0, #0x0                // =0
               	mov	x17, #0x7f              // =127
               	and	x4, x2, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	mov	x5, #0x3f               // =63
               	sub	x8, x5, x2
               	lsr	x4, x4, #6
               	sub	x4, x0, x4
               	mvn	x5, x4
               	lsl	x9, x6, x2
               	lsr	x10, x6, x8
               	lsr	x10, x10, #1
               	lsl	x12, x0, x2
               	orr	x12, x12, x10
               	and	x13, x9, x5
               	and	x10, x0, x4
               	orr	x13, x13, x10
               	and	x12, x12, x5
               	and	x9, x9, x4
               	orr	x12, x12, x9
               	lsr	x9, x0, x2
               	lsl	x8, x0, x8
               	lsl	x8, x8, #1
               	lsr	x2, x6, x2
               	orr	x2, x2, x8
               	and	x2, x2, x5
               	and	x4, x9, x4
               	orr	x4, x2, x4
               	and	x2, x9, x5
               	orr	x5, x2, x10
               	mvn	x2, x1
               	and	x6, x13, x2
               	and	x4, x4, x1
               	orr	x4, x6, x4
               	and	x2, x12, x2
               	and	x1, x5, x1
               	orr	x2, x2, x1
               	asr	x1, x7, #63
               	mvn	x1, x1
               	and	x4, x4, x1
               	and	x2, x2, x1
               	cmp	x7, #0x80
               	cset	x1, ge
               	sub	x0, x0, x1
               	mvn	x1, x0
               	and	x4, x4, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	orr	x4, x4, x0
               	and	x1, x2, x1
               	orr	x2, x1, x0
               	mvn	x0, x11
               	and	x1, x4, x0
               	and	x0, x2, x0
               	str	x1, [x3]
               	str	x0, [x3, #0x8]
               	cmp	x1, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	sub	x1, x29, #0x80
               	fcvt	d0, s0
               	sub	x0, x29, #0x88
               	str	d0, [x0]
               	ldr	x0, [x0]
               	asr	x11, x0, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x2, x0, x17
               	lsr	x2, x2, #52
               	sub	x7, x2, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x6, x0, x17
               	sub	x0, x2, #0x433
               	asr	x2, x0, #63
               	eor	x0, x0, x2
               	sub	x3, x0, x2
               	mov	x0, #0x0                // =0
               	mov	x17, #0x7f              // =127
               	and	x4, x3, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x3, x17
               	mov	x5, #0x3f               // =63
               	sub	x8, x5, x3
               	lsr	x4, x4, #6
               	sub	x4, x0, x4
               	mvn	x5, x4
               	lsl	x9, x6, x3
               	lsr	x10, x6, x8
               	lsr	x10, x10, #1
               	lsl	x12, x0, x3
               	orr	x12, x12, x10
               	and	x13, x9, x5
               	and	x10, x0, x4
               	orr	x13, x13, x10
               	and	x12, x12, x5
               	and	x9, x9, x4
               	orr	x12, x12, x9
               	lsr	x9, x0, x3
               	lsl	x8, x0, x8
               	lsl	x8, x8, #1
               	lsr	x3, x6, x3
               	orr	x3, x3, x8
               	and	x3, x3, x5
               	and	x4, x9, x4
               	orr	x4, x3, x4
               	and	x3, x9, x5
               	orr	x5, x3, x10
               	mvn	x3, x2
               	and	x6, x13, x3
               	and	x4, x4, x2
               	orr	x4, x6, x4
               	and	x3, x12, x3
               	and	x2, x5, x2
               	orr	x3, x3, x2
               	asr	x2, x7, #63
               	mvn	x2, x2
               	and	x4, x4, x2
               	and	x5, x3, x2
               	cmp	x7, #0x80
               	cset	x2, ge
               	sub	x2, x0, x2
               	mvn	x3, x2
               	and	x4, x4, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x4, x4, x2
               	and	x3, x5, x3
               	orr	x3, x3, x2
               	mvn	x2, x11
               	and	x4, x4, x2
               	and	x2, x3, x2
               	str	x4, [x1]
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x98
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	cmp	x2, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x53               // =83
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40600000         // =1080033280
               	fmov	s16, w1
               	fneg	s0, s16
               	str	s0, [x0]
               	ldr	s0, [x0]
               	sub	x4, x29, #0xb0
               	fcvt	d0, s0
               	sub	x0, x29, #0xb8
               	str	d0, [x0]
               	ldr	x1, [x0]
               	asr	x0, x1, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x2, x1, x17
               	lsr	x2, x2, #52
               	sub	x8, x2, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x7, x1, x17
               	sub	x1, x2, #0x433
               	asr	x2, x1, #63
               	eor	x1, x1, x2
               	sub	x3, x1, x2
               	mov	x1, #0x0                // =0
               	mov	x17, #0x7f              // =127
               	and	x5, x3, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x3, x17
               	mov	x6, #0x3f               // =63
               	sub	x9, x6, x3
               	lsr	x5, x5, #6
               	sub	x5, x1, x5
               	mvn	x6, x5
               	lsl	x10, x7, x3
               	lsr	x11, x7, x9
               	lsr	x11, x11, #1
               	lsl	x12, x1, x3
               	orr	x12, x12, x11
               	and	x13, x10, x6
               	and	x11, x1, x5
               	orr	x13, x13, x11
               	and	x12, x12, x6
               	and	x10, x10, x5
               	orr	x12, x12, x10
               	lsr	x10, x1, x3
               	lsl	x9, x1, x9
               	lsl	x9, x9, #1
               	lsr	x3, x7, x3
               	orr	x3, x3, x9
               	and	x3, x3, x6
               	and	x5, x10, x5
               	orr	x5, x3, x5
               	and	x3, x10, x6
               	orr	x6, x3, x11
               	mvn	x3, x2
               	and	x7, x13, x3
               	and	x5, x5, x2
               	orr	x5, x7, x5
               	and	x3, x12, x3
               	and	x2, x6, x2
               	orr	x3, x3, x2
               	asr	x2, x8, #63
               	mvn	x2, x2
               	and	x5, x5, x2
               	and	x3, x3, x2
               	cmp	x8, #0x80
               	cset	x2, ge
               	sub	x1, x1, x2
               	eor	x2, x5, x0
               	eor	x3, x3, x0
               	cmp	x2, x0
               	cset	x5, lo
               	sub	x2, x2, x0
               	sub	x3, x3, x0
               	sub	x3, x3, x5
               	mvn	x5, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	eor	x6, x0, x17
               	mvn	x0, x1
               	and	x2, x2, x0
               	and	x5, x5, x1
               	orr	x2, x2, x5
               	and	x0, x3, x0
               	and	x1, x6, x1
               	orr	x0, x0, x1
               	str	x2, [x4]
               	str	x0, [x4, #0x8]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	sub	x2, x29, #0xc8
               	fcvt	d0, s0
               	sub	x0, x29, #0xd0
               	str	d0, [x0]
               	ldr	x1, [x0]
               	asr	x0, x1, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x3, x1, x17
               	lsr	x3, x3, #52
               	sub	x8, x3, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x7, x1, x17
               	sub	x1, x3, #0x433
               	asr	x3, x1, #63
               	eor	x1, x1, x3
               	sub	x4, x1, x3
               	mov	x1, #0x0                // =0
               	mov	x17, #0x7f              // =127
               	and	x5, x4, x17
               	mov	x17, #0x3f              // =63
               	and	x4, x4, x17
               	mov	x6, #0x3f               // =63
               	sub	x9, x6, x4
               	lsr	x5, x5, #6
               	sub	x5, x1, x5
               	mvn	x6, x5
               	lsl	x10, x7, x4
               	lsr	x11, x7, x9
               	lsr	x11, x11, #1
               	lsl	x12, x1, x4
               	orr	x12, x12, x11
               	and	x13, x10, x6
               	and	x11, x1, x5
               	orr	x13, x13, x11
               	and	x12, x12, x6
               	and	x10, x10, x5
               	orr	x12, x12, x10
               	lsr	x10, x1, x4
               	lsl	x9, x1, x9
               	lsl	x9, x9, #1
               	lsr	x4, x7, x4
               	orr	x4, x4, x9
               	and	x4, x4, x6
               	and	x5, x10, x5
               	orr	x5, x4, x5
               	and	x4, x10, x6
               	orr	x6, x4, x11
               	mvn	x4, x3
               	and	x7, x13, x4
               	and	x5, x5, x3
               	orr	x5, x7, x5
               	and	x4, x12, x4
               	and	x3, x6, x3
               	orr	x4, x4, x3
               	asr	x3, x8, #63
               	mvn	x3, x3
               	and	x5, x5, x3
               	and	x6, x4, x3
               	cmp	x8, #0x80
               	cset	x3, ge
               	sub	x3, x1, x3
               	eor	x4, x5, x0
               	eor	x5, x6, x0
               	cmp	x4, x0
               	cset	x6, lo
               	sub	x4, x4, x0
               	sub	x5, x5, x0
               	sub	x5, x5, x6
               	mvn	x6, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	eor	x7, x0, x17
               	mvn	x0, x3
               	and	x4, x4, x0
               	and	x6, x6, x3
               	orr	x4, x4, x6
               	and	x0, x5, x0
               	and	x3, x7, x3
               	orr	x3, x0, x3
               	str	x4, [x2]
               	str	x3, [x2, #0x8]
               	sub	x0, x29, #0xe0
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x54               // =84
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x0               // =0
               	str	x20, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x10000000000000   // =4503599627370496
               	str	x2, [x1]
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0xf0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0xf0
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x3, ne
               	lsr	x1, x0, #32
               	cmp	x1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x5, x1, #0x1
               	lsr	x1, x0, x1
               	lsr	x2, x1, #16
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #4
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #8
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #3
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #4
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #2
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #2
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #1
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #1
               	cmp	x2, #0x0
               	cset	x2, ne
               	add	x5, x5, x2
               	mul	x1, x5, x3
               	mov	x2, #0x40               // =64
               	sub	x2, x2, x1
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	lsr	x2, x6, x2
               	cmp	x1, #0x0
               	cset	x3, ne
               	mul	x2, x2, x3
               	and	x2, x4, x2
               	cmp	x2, #0x0
               	cset	x9, ne
               	mov	x17, #0x7f              // =127
               	and	x3, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x1, x17
               	mov	x7, #0x3f               // =63
               	sub	x10, x7, x2
               	lsr	x3, x3, #6
               	sub	x3, x20, x3
               	mvn	x5, x3
               	lsr	x8, x0, x2
               	lsl	x0, x0, x10
               	lsl	x0, x0, #1
               	lsr	x2, x4, x2
               	orr	x0, x2, x0
               	and	x0, x0, x5
               	and	x2, x8, x3
               	orr	x0, x0, x2
               	orr	x0, x0, x9
               	ucvtf	d0, x0
               	add	x0, x1, #0x3ff
               	lsl	x0, x0, #52
               	orr	x1, x0, x20
               	sub	x0, x29, #0xf8
               	str	x1, [x0]
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	sub	x2, x29, #0x108
               	sub	x0, x29, #0x110
               	str	d0, [x0]
               	ldr	x0, [x0]
               	asr	x11, x0, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x1, x0, x17
               	lsr	x1, x1, #52
               	sub	x8, x1, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x5, x0, x17
               	sub	x1, x1, #0x433
               	asr	x0, x1, #63
               	eor	x1, x1, x0
               	sub	x1, x1, x0
               	mov	x17, #0x7f              // =127
               	and	x3, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	sub	x7, x7, x1
               	lsr	x3, x3, #6
               	sub	x3, x20, x3
               	mvn	x4, x3
               	lsl	x9, x5, x1
               	lsr	x10, x5, x7
               	lsr	x10, x10, #1
               	lsl	x12, x20, x1
               	orr	x12, x12, x10
               	and	x13, x9, x4
               	and	x10, x20, x3
               	orr	x13, x13, x10
               	and	x12, x12, x4
               	and	x9, x9, x3
               	orr	x12, x12, x9
               	lsr	x9, x20, x1
               	lsl	x7, x20, x7
               	lsl	x7, x7, #1
               	lsr	x1, x5, x1
               	orr	x1, x1, x7
               	and	x1, x1, x4
               	and	x3, x9, x3
               	orr	x3, x1, x3
               	and	x1, x9, x4
               	orr	x4, x1, x10
               	mvn	x1, x0
               	and	x5, x13, x1
               	and	x3, x3, x0
               	orr	x3, x5, x3
               	and	x1, x12, x1
               	and	x0, x4, x0
               	orr	x1, x1, x0
               	asr	x0, x8, #63
               	mvn	x0, x0
               	and	x3, x3, x0
               	and	x4, x1, x0
               	cmp	x8, #0x80
               	cset	x0, ge
               	sub	x0, x20, x0
               	mvn	x1, x0
               	and	x3, x3, x1
               	and	x0, x6, x0
               	orr	x3, x3, x0
               	and	x1, x4, x1
               	orr	x4, x1, x0
               	mvn	x0, x11
               	and	x1, x3, x0
               	and	x0, x4, x0
               	str	x1, [x2]
               	str	x0, [x2, #0x8]
               	mov	x17, #0x10000000000000  // =4503599627370496
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x55               // =85
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5                // =5
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x20, #0x0               // =0
               	str	x20, [x1]
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x120
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x120
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x3, ne
               	lsr	x1, x0, #32
               	cmp	x1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x5, x1, #0x1
               	lsr	x1, x0, x1
               	lsr	x2, x1, #16
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #4
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #8
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #3
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #4
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #2
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #2
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #1
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #1
               	cmp	x2, #0x0
               	cset	x2, ne
               	add	x5, x5, x2
               	mul	x1, x5, x3
               	mov	x2, #0x40               // =64
               	sub	x2, x2, x1
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	lsr	x2, x6, x2
               	cmp	x1, #0x0
               	cset	x3, ne
               	mul	x2, x2, x3
               	and	x2, x4, x2
               	cmp	x2, #0x0
               	cset	x9, ne
               	mov	x17, #0x7f              // =127
               	and	x3, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x1, x17
               	mov	x7, #0x3f               // =63
               	sub	x10, x7, x2
               	lsr	x3, x3, #6
               	sub	x3, x20, x3
               	mvn	x5, x3
               	lsr	x8, x0, x2
               	lsl	x0, x0, x10
               	lsl	x0, x0, #1
               	lsr	x2, x4, x2
               	orr	x0, x2, x0
               	and	x0, x0, x5
               	and	x2, x8, x3
               	orr	x0, x0, x2
               	orr	x0, x0, x9
               	ucvtf	d0, x0
               	add	x0, x1, #0x3ff
               	lsl	x0, x0, #52
               	orr	x1, x0, x20
               	sub	x0, x29, #0x128
               	str	x1, [x0]
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	sub	x0, x29, #0x138
               	sub	x1, x29, #0x140
               	str	d0, [x1]
               	ldr	x1, [x1]
               	asr	x11, x1, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x2, x1, x17
               	lsr	x2, x2, #52
               	sub	x8, x2, #0x3ff
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x10000000000000  // =4503599627370496
               	orr	x5, x1, x17
               	sub	x2, x2, #0x433
               	asr	x1, x2, #63
               	eor	x2, x2, x1
               	sub	x2, x2, x1
               	mov	x17, #0x7f              // =127
               	and	x3, x2, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	sub	x7, x7, x2
               	lsr	x3, x3, #6
               	sub	x3, x20, x3
               	mvn	x4, x3
               	lsl	x9, x5, x2
               	lsr	x10, x5, x7
               	lsr	x10, x10, #1
               	lsl	x12, x20, x2
               	orr	x12, x12, x10
               	and	x13, x9, x4
               	and	x10, x20, x3
               	orr	x13, x13, x10
               	and	x12, x12, x4
               	and	x9, x9, x3
               	orr	x12, x12, x9
               	lsr	x9, x20, x2
               	lsl	x7, x20, x7
               	lsl	x7, x7, #1
               	lsr	x2, x5, x2
               	orr	x2, x2, x7
               	and	x2, x2, x4
               	and	x3, x9, x3
               	orr	x3, x2, x3
               	and	x2, x9, x4
               	orr	x4, x2, x10
               	mvn	x2, x1
               	and	x5, x13, x2
               	and	x3, x3, x1
               	orr	x3, x5, x3
               	and	x2, x12, x2
               	and	x1, x4, x1
               	orr	x2, x2, x1
               	asr	x1, x8, #63
               	mvn	x1, x1
               	and	x3, x3, x1
               	and	x4, x2, x1
               	cmp	x8, #0x80
               	cset	x1, ge
               	sub	x1, x20, x1
               	mvn	x2, x1
               	and	x3, x3, x2
               	and	x1, x6, x1
               	orr	x3, x3, x1
               	and	x2, x4, x2
               	orr	x2, x2, x1
               	mvn	x1, x11
               	and	x3, x3, x1
               	and	x1, x2, x1
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x150
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x56               // =86
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x0               // =0
               	str	x20, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	str	x2, [x1]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x2
               	str	d16, [x21]
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x160
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x160
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x3, ne
               	lsr	x1, x0, #32
               	cmp	x1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x5, x1, #0x1
               	lsr	x1, x0, x1
               	lsr	x2, x1, #16
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #4
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #8
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #3
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #4
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #2
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #2
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #1
               	add	x5, x5, x2
               	lsr	x1, x1, x2
               	lsr	x2, x1, #1
               	cmp	x2, #0x0
               	cset	x2, ne
               	add	x5, x5, x2
               	mul	x1, x5, x3
               	mov	x2, #0x40               // =64
               	sub	x2, x2, x1
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	lsr	x2, x3, x2
               	cmp	x1, #0x0
               	cset	x3, ne
               	mul	x2, x2, x3
               	and	x2, x4, x2
               	cmp	x2, #0x0
               	cset	x7, ne
               	mov	x17, #0x7f              // =127
               	and	x3, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x1, x17
               	mov	x5, #0x3f               // =63
               	sub	x8, x5, x2
               	lsr	x3, x3, #6
               	sub	x3, x20, x3
               	mvn	x5, x3
               	lsr	x6, x0, x2
               	lsl	x0, x0, x8
               	lsl	x0, x0, #1
               	lsr	x2, x4, x2
               	orr	x0, x2, x0
               	and	x0, x0, x5
               	and	x2, x6, x3
               	orr	x0, x0, x2
               	orr	x0, x0, x7
               	ucvtf	d0, x0
               	add	x0, x1, #0x3ff
               	lsl	x0, x0, #52
               	orr	x1, x0, x20
               	sub	x0, x29, #0x168
               	str	x1, [x0]
               	ldr	d1, [x0]
               	ldr	d2, [x21]
               	fmadd	d0, d0, d1, d2
               	bl	<addr>
               	mov	x17, #0x4012000000000000 // =4616752568008179712
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x57               // =87
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x178
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x178
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	asr	x0, x1, #63
               	eor	x2, x2, x0
               	eor	x1, x1, x0
               	cmp	x2, x0
               	cset	x3, lo
               	sub	x4, x2, x0
               	sub	x1, x1, x0
               	sub	x1, x1, x3
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	and	x8, x0, x17
               	cmp	x1, #0x0
               	cset	x3, ne
               	lsr	x0, x1, #32
               	cmp	x0, #0x0
               	cset	x0, ne
               	lsl	x0, x0, #5
               	add	x5, x0, #0x1
               	lsr	x0, x1, x0
               	lsr	x2, x0, #16
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #4
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #8
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #3
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #4
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #2
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #2
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #1
               	add	x5, x5, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #1
               	cmp	x2, #0x0
               	cset	x2, ne
               	add	x5, x5, x2
               	mul	x0, x5, x3
               	mov	x2, #0x40               // =64
               	sub	x2, x2, x0
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	lsr	x2, x3, x2
               	cmp	x0, #0x0
               	cset	x3, ne
               	mul	x2, x2, x3
               	and	x2, x4, x2
               	cmp	x2, #0x0
               	cset	x9, ne
               	mov	x17, #0x7f              // =127
               	and	x3, x0, x17
               	mov	x17, #0x3f              // =63
               	and	x2, x0, x17
               	mov	x5, #0x3f               // =63
               	sub	x10, x5, x2
               	lsr	x3, x3, #6
               	mov	x5, #0x0                // =0
               	sub	x3, x5, x3
               	mvn	x6, x3
               	lsr	x7, x1, x2
               	lsl	x1, x1, x10
               	lsl	x1, x1, #1
               	lsr	x2, x4, x2
               	orr	x1, x2, x1
               	and	x1, x1, x6
               	and	x2, x7, x3
               	orr	x1, x1, x2
               	orr	x1, x1, x9
               	ucvtf	d0, x1
               	add	x0, x0, #0x3ff
               	lsl	x0, x0, #52
               	orr	x1, x0, x8
               	sub	x0, x29, #0x180
               	str	x1, [x0]
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	fmul	d0, d0, d1
               	bl	<addr>
               	mov	x17, #0x4012000000000000 // =4616752568008179712
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x190]
               	ldp	x20, x21, [sp], #0x1a0
               	ret
               	b	<addr>
               	b	<addr>
