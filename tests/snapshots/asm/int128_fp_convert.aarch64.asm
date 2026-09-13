
int128_fp_convert.aarch64:	file format elf64-littleaarch64

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

<chk_to_fp>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x13, x2
               	mov	x20, x5
               	mov	x15, x4
               	mov	x14, x3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x1, [x3]
               	ldr	x4, [x2]
               	ldr	x5, [x3]
               	sub	x0, x29, #0x10
               	str	x4, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	orr	x12, x1, x5
               	orr	x5, x4, x1
               	mov	x1, #0x0                // =0
               	cmp	x5, #0x0
               	cset	x8, ne
               	lsr	x4, x5, #32
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #5
               	add	x9, x4, #0x1
               	lsr	x4, x5, x4
               	lsr	x7, x4, #16
               	cmp	x7, #0x0
               	cset	x7, ne
               	lsl	x7, x7, #4
               	add	x9, x9, x7
               	lsr	x4, x4, x7
               	lsr	x7, x4, #8
               	cmp	x7, #0x0
               	cset	x7, ne
               	lsl	x7, x7, #3
               	add	x9, x9, x7
               	lsr	x4, x4, x7
               	lsr	x7, x4, #4
               	cmp	x7, #0x0
               	cset	x7, ne
               	lsl	x7, x7, #2
               	add	x9, x9, x7
               	lsr	x4, x4, x7
               	lsr	x7, x4, #2
               	cmp	x7, #0x0
               	cset	x7, ne
               	lsl	x7, x7, #1
               	add	x9, x9, x7
               	lsr	x4, x4, x7
               	lsr	x7, x4, #1
               	cmp	x7, #0x0
               	cset	x7, ne
               	add	x9, x9, x7
               	mul	x4, x9, x8
               	mov	x8, #0x40               // =64
               	sub	x7, x8, x4
               	and	x7, x7, #0x3f
               	mov	x9, #-0x1               // =-1
               	lsr	x7, x9, x7
               	cmp	x4, #0x0
               	cset	x9, ne
               	mul	x7, x7, x9
               	and	x7, x12, x7
               	cmp	x7, #0x0
               	cset	x21, ne
               	and	x9, x4, #0x7f
               	and	x7, x4, #0x3f
               	mov	x10, #0x3f              // =63
               	sub	x22, x10, x7
               	lsr	x9, x9, #6
               	sub	x9, x1, x9
               	mvn	x10, x9
               	lsr	x11, x5, x7
               	lsl	x5, x5, x22
               	lsl	x5, x5, #1
               	lsr	x7, x12, x7
               	orr	x5, x7, x5
               	and	x5, x5, x10
               	and	x7, x11, x9
               	orr	x5, x5, x7
               	orr	x5, x5, x21
               	ucvtf	d0, x5
               	add	x4, x4, #0x3ff
               	lsl	x4, x4, #52
               	orr	x4, x4, x1
               	stur	x4, [x29, #-0x18]
               	ldur	d1, [x29, #-0x18]
               	fmul	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldur	x4, [x29, #-0x8]
               	cmp	x4, x13
               	b.eq	<addr>
               	sxtw	x0, w6
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x4, [x2]
               	ldr	x5, [x3]
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	orr	x12, x1, x5
               	orr	x4, x4, x1
               	cmp	x4, #0x0
               	cset	x7, ne
               	lsr	x0, x4, #32
               	cmp	x0, #0x0
               	cset	x0, ne
               	lsl	x0, x0, #5
               	add	x9, x0, #0x1
               	lsr	x0, x4, x0
               	lsr	x5, x0, #16
               	cmp	x5, #0x0
               	cset	x5, ne
               	lsl	x5, x5, #4
               	add	x9, x9, x5
               	lsr	x0, x0, x5
               	lsr	x5, x0, #8
               	cmp	x5, #0x0
               	cset	x5, ne
               	lsl	x5, x5, #3
               	add	x9, x9, x5
               	lsr	x0, x0, x5
               	lsr	x5, x0, #4
               	cmp	x5, #0x0
               	cset	x5, ne
               	lsl	x5, x5, #2
               	add	x9, x9, x5
               	lsr	x0, x0, x5
               	lsr	x5, x0, #2
               	cmp	x5, #0x0
               	cset	x5, ne
               	lsl	x5, x5, #1
               	add	x9, x9, x5
               	lsr	x0, x0, x5
               	lsr	x5, x0, #1
               	cmp	x5, #0x0
               	cset	x5, ne
               	add	x9, x9, x5
               	mul	x0, x9, x7
               	sub	x5, x8, x0
               	and	x5, x5, #0x3f
               	mov	x7, #-0x1               // =-1
               	lsr	x5, x7, x5
               	cmp	x0, #0x0
               	cset	x8, ne
               	mul	x5, x5, x8
               	and	x5, x12, x5
               	cmp	x5, #0x0
               	cset	x13, ne
               	and	x9, x0, #0x7f
               	and	x5, x0, #0x3f
               	mov	x8, #0x3f               // =63
               	sub	x21, x8, x5
               	lsr	x9, x9, #6
               	sub	x9, x1, x9
               	mvn	x10, x9
               	lsr	x11, x4, x5
               	lsl	x4, x4, x21
               	lsl	x4, x4, #1
               	lsr	x5, x12, x5
               	orr	x4, x5, x4
               	and	x4, x4, x10
               	and	x5, x11, x9
               	orr	x4, x4, x5
               	orr	x4, x4, x13
               	ucvtf	s0, x4
               	fcvt	d0, s0
               	add	x0, x0, #0x3ff
               	lsl	x0, x0, #52
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x18]
               	ldur	d1, [x29, #-0x18]
               	fmul	d0, d0, d1
               	fcvt	s0, d0
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	ldr	w4, [x0]
               	mov	w1, w14
               	cmp	w4, w1
               	b.eq	<addr>
               	add	x0, x6, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x4, [x2]
               	ldr	x5, [x3]
               	str	x4, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	orr	x9, x1, x5
               	orr	x5, x4, x1
               	asr	x1, x5, #63
               	eor	x4, x9, x1
               	eor	x5, x5, x1
               	cmp	x4, x1
               	cset	x9, lo
               	sub	x10, x4, x1
               	sub	x4, x5, x1
               	sub	x4, x4, x9
               	and	x21, x1, #0x8000000000000000
               	cmp	x4, #0x0
               	cset	x9, ne
               	lsr	x1, x4, #32
               	cmp	x1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x11, x1, #0x1
               	lsr	x1, x4, x1
               	lsr	x5, x1, #16
               	cmp	x5, #0x0
               	cset	x5, ne
               	lsl	x5, x5, #4
               	add	x11, x11, x5
               	lsr	x1, x1, x5
               	lsr	x5, x1, #8
               	cmp	x5, #0x0
               	cset	x5, ne
               	lsl	x5, x5, #3
               	add	x11, x11, x5
               	lsr	x1, x1, x5
               	lsr	x5, x1, #4
               	cmp	x5, #0x0
               	cset	x5, ne
               	lsl	x5, x5, #2
               	add	x11, x11, x5
               	lsr	x1, x1, x5
               	lsr	x5, x1, #2
               	cmp	x5, #0x0
               	cset	x5, ne
               	lsl	x5, x5, #1
               	add	x11, x11, x5
               	lsr	x1, x1, x5
               	lsr	x5, x1, #1
               	cmp	x5, #0x0
               	cset	x5, ne
               	add	x11, x11, x5
               	mul	x1, x11, x9
               	mov	x11, #0x40              // =64
               	sub	x5, x11, x1
               	and	x5, x5, #0x3f
               	lsr	x5, x7, x5
               	cmp	x1, #0x0
               	cset	x9, ne
               	mul	x5, x5, x9
               	and	x5, x10, x5
               	cmp	x5, #0x0
               	cset	x22, ne
               	and	x5, x1, #0x7f
               	and	x9, x1, #0x3f
               	sub	x23, x8, x9
               	lsr	x12, x5, #6
               	mov	x5, #0x0                // =0
               	sub	x12, x5, x12
               	mvn	x13, x12
               	lsr	x14, x4, x9
               	lsl	x4, x4, x23
               	lsl	x4, x4, #1
               	lsr	x9, x10, x9
               	orr	x4, x9, x4
               	and	x4, x4, x13
               	and	x9, x14, x12
               	orr	x4, x4, x9
               	orr	x4, x4, x22
               	ucvtf	d0, x4
               	add	x1, x1, #0x3ff
               	lsl	x1, x1, #52
               	orr	x1, x1, x21
               	stur	x1, [x29, #-0x18]
               	ldur	d1, [x29, #-0x18]
               	fmul	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	cmp	x1, x15
               	b.eq	<addr>
               	add	x0, x6, #0x2
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	x1, [x2]
               	ldr	x2, [x3]
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	orr	x3, x5, x2
               	orr	x2, x1, x5
               	asr	x0, x2, #63
               	eor	x1, x3, x0
               	eor	x2, x2, x0
               	cmp	x1, x0
               	cset	x4, lo
               	sub	x3, x1, x0
               	sub	x1, x2, x0
               	sub	x1, x1, x4
               	and	x9, x0, #0x8000000000000000
               	cmp	x1, #0x0
               	cset	x4, ne
               	lsr	x0, x1, #32
               	cmp	x0, #0x0
               	cset	x0, ne
               	lsl	x0, x0, #5
               	add	x10, x0, #0x1
               	lsr	x0, x1, x0
               	lsr	x2, x0, #16
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #4
               	add	x10, x10, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #8
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #3
               	add	x10, x10, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #4
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #2
               	add	x10, x10, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #2
               	cmp	x2, #0x0
               	cset	x2, ne
               	lsl	x2, x2, #1
               	add	x10, x10, x2
               	lsr	x0, x0, x2
               	lsr	x2, x0, #1
               	cmp	x2, #0x0
               	cset	x2, ne
               	add	x10, x10, x2
               	mul	x0, x10, x4
               	sub	x2, x11, x0
               	and	x2, x2, #0x3f
               	lsr	x2, x7, x2
               	cmp	x0, #0x0
               	cset	x4, ne
               	mul	x2, x2, x4
               	and	x2, x3, x2
               	cmp	x2, #0x0
               	cset	x10, ne
               	and	x4, x0, #0x7f
               	and	x2, x0, #0x3f
               	sub	x8, x8, x2
               	lsr	x4, x4, #6
               	sub	x4, x5, x4
               	mvn	x5, x4
               	lsr	x7, x1, x2
               	lsl	x1, x1, x8
               	lsl	x1, x1, #1
               	lsr	x2, x3, x2
               	orr	x1, x2, x1
               	and	x1, x1, x5
               	and	x2, x7, x4
               	orr	x1, x1, x2
               	orr	x1, x1, x10
               	ucvtf	s0, x1
               	fcvt	d0, s0
               	add	x0, x0, #0x3ff
               	lsl	x0, x0, #52
               	orr	x0, x0, x9
               	stur	x0, [x29, #-0x18]
               	ldur	d1, [x29, #-0x18]
               	fmul	d0, d0, d1
               	fcvt	s0, d0
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	ldr	w1, [x0]
               	mov	w0, w20
               	cmp	w1, w0
               	b.eq	<addr>
               	add	x0, x6, #0x3
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<chk_from_fp>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x8, x0
               	mov	x5, x2
               	mov	x9, x1
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	d0, [x4]
               	ldr	d0, [x4]
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	asr	x14, x0, #63
               	and	x1, x0, #0x7fffffffffffffff
               	lsr	x1, x1, #52
               	sub	x10, x1, #0x3ff
               	and	x0, x0, #0xfffffffffffff
               	orr	x6, x0, #0x10000000000000
               	sub	x0, x1, #0x433
               	asr	x1, x0, #63
               	eor	x0, x0, x1
               	sub	x2, x0, x1
               	mov	x0, #0x0                // =0
               	and	x3, x2, #0x7f
               	and	x2, x2, #0x3f
               	mov	x11, #0x3f              // =63
               	sub	x12, x11, x2
               	lsr	x3, x3, #6
               	sub	x7, x0, x3
               	mvn	x3, x7
               	lsl	x13, x6, x2
               	lsr	x15, x6, x12
               	lsr	x15, x15, #1
               	lsl	x20, x0, x2
               	orr	x15, x20, x15
               	and	x20, x13, x3
               	orr	x20, x20, x0
               	and	x15, x15, x3
               	and	x13, x13, x7
               	orr	x15, x15, x13
               	lsr	x13, x0, x2
               	lsl	x12, x0, x12
               	lsl	x12, x12, #1
               	lsr	x2, x6, x2
               	orr	x2, x2, x12
               	and	x2, x2, x3
               	and	x6, x13, x7
               	orr	x6, x2, x6
               	and	x2, x13, x3
               	orr	x3, x2, x0
               	mvn	x2, x1
               	and	x7, x20, x2
               	and	x6, x6, x1
               	orr	x6, x7, x6
               	and	x2, x15, x2
               	and	x1, x3, x1
               	orr	x2, x2, x1
               	asr	x1, x10, #63
               	mvn	x1, x1
               	and	x3, x6, x1
               	and	x6, x2, x1
               	cmp	x10, #0x80
               	cset	x1, ge
               	sub	x1, x0, x1
               	mvn	x2, x1
               	and	x3, x3, x2
               	mov	x17, #-0x1              // =-1
               	and	x1, x1, x17
               	orr	x3, x3, x1
               	and	x2, x6, x2
               	orr	x2, x2, x1
               	mvn	x1, x14
               	and	x3, x3, x1
               	and	x1, x2, x1
               	cmp	x1, x8
               	b.ne	<addr>
               	cmp	x3, x9
               	cset	x1, ne
               	cbz	x1, <addr>
               	sxtw	x0, w5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	d0, [x4]
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	asr	x1, x2, #63
               	and	x3, x2, #0x7fffffffffffffff
               	lsr	x3, x3, #52
               	sub	x10, x3, #0x3ff
               	and	x2, x2, #0xfffffffffffff
               	orr	x6, x2, #0x10000000000000
               	sub	x3, x3, #0x433
               	asr	x2, x3, #63
               	eor	x3, x3, x2
               	sub	x3, x3, x2
               	and	x4, x3, #0x7f
               	and	x3, x3, #0x3f
               	sub	x11, x11, x3
               	lsr	x4, x4, #6
               	sub	x7, x0, x4
               	mvn	x4, x7
               	lsl	x12, x6, x3
               	lsr	x13, x6, x11
               	lsr	x13, x13, #1
               	lsl	x14, x0, x3
               	orr	x13, x14, x13
               	and	x14, x12, x4
               	orr	x14, x14, x0
               	and	x13, x13, x4
               	and	x12, x12, x7
               	orr	x13, x13, x12
               	lsr	x12, x0, x3
               	lsl	x11, x0, x11
               	lsl	x11, x11, #1
               	lsr	x3, x6, x3
               	orr	x3, x3, x11
               	and	x3, x3, x4
               	and	x6, x12, x7
               	orr	x6, x3, x6
               	and	x3, x12, x4
               	orr	x4, x3, x0
               	mvn	x3, x2
               	and	x7, x14, x3
               	and	x6, x6, x2
               	orr	x6, x7, x6
               	and	x3, x13, x3
               	and	x2, x4, x2
               	orr	x3, x3, x2
               	asr	x2, x10, #63
               	mvn	x2, x2
               	and	x4, x6, x2
               	and	x3, x3, x2
               	cmp	x10, #0x80
               	cset	x2, ge
               	sub	x0, x0, x2
               	eor	x2, x4, x1
               	eor	x3, x3, x1
               	cmp	x2, x1
               	cset	x4, lo
               	sub	x2, x2, x1
               	sub	x3, x3, x1
               	sub	x3, x3, x4
               	mvn	x4, x1
               	eor	x6, x1, #0x7fffffffffffffff
               	mvn	x1, x0
               	and	x2, x2, x1
               	and	x4, x4, x0
               	orr	x2, x2, x4
               	and	x1, x3, x1
               	and	x0, x6, x0
               	orr	x0, x1, x0
               	cmp	x0, x8
               	b.ne	<addr>
               	cmp	x2, x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	add	x0, x5, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<chk_from_fp_neg>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x11, x0
               	mov	x7, x2
               	mov	x12, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	d0, [x0]
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	and	x2, x0, #0x7fffffffffffffff
               	lsr	x2, x2, #52
               	sub	x8, x2, #0x3ff
               	and	x0, x0, #0xfffffffffffff
               	orr	x5, x0, #0x10000000000000
               	sub	x0, x2, #0x433
               	asr	x2, x0, #63
               	eor	x0, x0, x2
               	sub	x3, x0, x2
               	mov	x0, #0x0                // =0
               	and	x4, x3, #0x7f
               	and	x3, x3, #0x3f
               	mov	x6, #0x3f               // =63
               	sub	x9, x6, x3
               	lsr	x4, x4, #6
               	sub	x6, x0, x4
               	mvn	x4, x6
               	lsl	x10, x5, x3
               	lsr	x13, x5, x9
               	lsr	x13, x13, #1
               	lsl	x14, x0, x3
               	orr	x13, x14, x13
               	and	x14, x10, x4
               	orr	x14, x14, x0
               	and	x13, x13, x4
               	and	x10, x10, x6
               	orr	x13, x13, x10
               	lsr	x10, x0, x3
               	lsl	x9, x0, x9
               	lsl	x9, x9, #1
               	lsr	x3, x5, x3
               	orr	x3, x3, x9
               	and	x3, x3, x4
               	and	x5, x10, x6
               	orr	x5, x3, x5
               	and	x3, x10, x4
               	orr	x4, x3, x0
               	mvn	x3, x2
               	and	x6, x14, x3
               	and	x5, x5, x2
               	orr	x5, x6, x5
               	and	x3, x13, x3
               	and	x2, x4, x2
               	orr	x3, x3, x2
               	asr	x2, x8, #63
               	mvn	x2, x2
               	and	x4, x5, x2
               	and	x5, x3, x2
               	cmp	x8, #0x80
               	cset	x2, ge
               	sub	x2, x0, x2
               	eor	x3, x4, x1
               	eor	x4, x5, x1
               	cmp	x3, x1
               	cset	x5, lo
               	sub	x3, x3, x1
               	sub	x4, x4, x1
               	sub	x4, x4, x5
               	mvn	x5, x1
               	eor	x6, x1, #0x7fffffffffffffff
               	mvn	x1, x2
               	and	x3, x3, x1
               	and	x5, x5, x2
               	orr	x3, x3, x5
               	and	x1, x4, x1
               	and	x2, x6, x2
               	orr	x1, x1, x2
               	cmp	x1, x11
               	b.ne	<addr>
               	cmp	x3, x12
               	cset	x1, ne
               	cbz	x1, <addr>
               	sxtw	x0, w7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	mov	x6, #0x1                // =1
               	mov	x1, x0
               	mov	x5, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #-0x1               // =-1
               	mov	x2, #0x43f0000000000000 // =4895412794951729152
               	mov	x3, #0x5f800000         // =1602224128
               	mov	x6, #0x19               // =25
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	mov	x2, #0x47f0000000000000 // =5183643171103440896
               	mov	x3, #0x7f800000         // =2139095040
               	mov	x4, #-0x4010000000000000 // =-4616189618054758400
               	mov	x5, #0xbf800000         // =3212836864
               	mov	x6, #0x31               // =49
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7fffffffffffffff // =9223372036854775807
               	mov	x1, #-0x1               // =-1
               	mov	x2, #0x47e0000000000000 // =5179139571476070400
               	mov	x3, #0x7f000000         // =2130706432
               	mov	x6, #0x39               // =57
               	mov	x4, x2
               	mov	x5, x3
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #0x41               // =65
               	fmov	d0, x0
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	mov	x0, #0x0                // =0
               	mov	x2, #0x45               // =69
               	fmov	d0, x1
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fneg	d0, d16
               	mov	x0, #0x0                // =0
               	mov	x2, #0x47               // =71
               	mov	x1, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa1cb             // =41419
               	movk	x0, #0xb645, lsl #16
               	movk	x0, #0xfdf3, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fmov	d16, x0
               	fneg	d0, d16
               	mov	x0, #-0x1               // =-1
               	mov	x1, #-0x3               // =-3
               	mov	x2, #0x49               // =73
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x47e0000000000000 // =5179139571476070400
               	fmov	d16, x0
               	fneg	d0, d16
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	mov	x1, #0x0                // =0
               	mov	x2, #0x51               // =81
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40200000         // =1075838976
               	fmov	s16, w1
               	str	s16, [x0]
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	asr	x10, x0, #63
               	and	x1, x0, #0x7fffffffffffffff
               	lsr	x1, x1, #52
               	sub	x7, x1, #0x3ff
               	and	x0, x0, #0xfffffffffffff
               	orr	x4, x0, #0x10000000000000
               	sub	x0, x1, #0x433
               	asr	x1, x0, #63
               	eor	x0, x0, x1
               	sub	x2, x0, x1
               	mov	x0, #0x0                // =0
               	and	x3, x2, #0x7f
               	and	x2, x2, #0x3f
               	mov	x5, #0x3f               // =63
               	sub	x8, x5, x2
               	lsr	x3, x3, #6
               	sub	x6, x0, x3
               	mvn	x3, x6
               	lsl	x9, x4, x2
               	and	x12, x9, x3
               	orr	x12, x12, x0
               	lsr	x9, x0, x2
               	lsl	x8, x0, x8
               	lsl	x8, x8, #1
               	lsr	x2, x4, x2
               	orr	x2, x2, x8
               	and	x2, x2, x3
               	and	x4, x9, x6
               	orr	x4, x2, x4
               	mvn	x2, x1
               	and	x6, x12, x2
               	and	x4, x4, x1
               	orr	x4, x6, x4
               	asr	x1, x7, #63
               	mvn	x1, x1
               	and	x3, x4, x1
               	cmp	x7, #0x80
               	cset	x1, ge
               	sub	x1, x0, x1
               	mvn	x2, x1
               	and	x3, x3, x2
               	mov	x17, #-0x1              // =-1
               	and	x1, x1, x17
               	orr	x3, x3, x1
               	mvn	x1, x10
               	and	x3, x3, x1
               	cmp	x3, #0x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	asr	x10, x1, #63
               	and	x2, x1, #0x7fffffffffffffff
               	lsr	x2, x2, #52
               	sub	x7, x2, #0x3ff
               	and	x1, x1, #0xfffffffffffff
               	orr	x4, x1, #0x10000000000000
               	sub	x2, x2, #0x433
               	asr	x1, x2, #63
               	eor	x2, x2, x1
               	sub	x2, x2, x1
               	and	x3, x2, #0x7f
               	and	x2, x2, #0x3f
               	sub	x8, x5, x2
               	lsr	x3, x3, #6
               	sub	x6, x0, x3
               	mvn	x3, x6
               	lsl	x9, x4, x2
               	lsr	x11, x4, x8
               	lsr	x11, x11, #1
               	lsl	x12, x0, x2
               	orr	x11, x12, x11
               	and	x11, x11, x3
               	and	x9, x9, x6
               	orr	x11, x11, x9
               	lsr	x9, x0, x2
               	and	x2, x9, x3
               	orr	x3, x2, x0
               	mvn	x2, x1
               	and	x2, x11, x2
               	and	x1, x3, x1
               	orr	x2, x2, x1
               	asr	x1, x7, #63
               	mvn	x1, x1
               	and	x4, x2, x1
               	cmp	x7, #0x80
               	cset	x1, ge
               	sub	x1, x0, x1
               	mvn	x2, x1
               	mov	x17, #-0x1              // =-1
               	and	x1, x1, x17
               	and	x2, x4, x2
               	orr	x2, x2, x1
               	mvn	x1, x10
               	and	x1, x2, x1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x53               // =83
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x40600000         // =1080033280
               	fmov	s16, w2
               	fneg	s0, s16
               	str	s0, [x1]
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	asr	x1, x2, #63
               	and	x3, x2, #0x7fffffffffffffff
               	lsr	x3, x3, #52
               	sub	x7, x3, #0x3ff
               	and	x2, x2, #0xfffffffffffff
               	orr	x6, x2, #0x10000000000000
               	sub	x3, x3, #0x433
               	asr	x2, x3, #63
               	eor	x3, x3, x2
               	sub	x3, x3, x2
               	and	x4, x3, #0x7f
               	and	x3, x3, #0x3f
               	sub	x8, x5, x3
               	lsr	x4, x4, #6
               	sub	x5, x0, x4
               	mvn	x4, x5
               	lsl	x9, x6, x3
               	and	x11, x9, x4
               	orr	x11, x11, x0
               	lsr	x9, x0, x3
               	lsl	x8, x0, x8
               	lsl	x8, x8, #1
               	lsr	x3, x6, x3
               	orr	x3, x3, x8
               	and	x3, x3, x4
               	and	x5, x9, x5
               	orr	x5, x3, x5
               	mvn	x3, x2
               	and	x6, x11, x3
               	and	x5, x5, x2
               	orr	x5, x6, x5
               	asr	x2, x7, #63
               	mvn	x2, x2
               	and	x4, x5, x2
               	cmp	x7, #0x80
               	cset	x2, ge
               	sub	x2, x0, x2
               	eor	x3, x4, x1
               	sub	x3, x3, x1
               	mvn	x5, x1
               	mvn	x1, x2
               	and	x3, x3, x1
               	and	x5, x5, x2
               	orr	x3, x3, x5
               	mov	x17, #-0x3              // =-3
               	cmp	x3, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	asr	x2, x1, #63
               	and	x3, x1, #0x7fffffffffffffff
               	lsr	x3, x3, #52
               	sub	x9, x3, #0x3ff
               	and	x1, x1, #0xfffffffffffff
               	orr	x7, x1, #0x10000000000000
               	sub	x1, x3, #0x433
               	asr	x3, x1, #63
               	eor	x1, x1, x3
               	sub	x1, x1, x3
               	and	x6, x1, #0x7f
               	and	x4, x1, #0x3f
               	mov	x5, #0x3f               // =63
               	sub	x10, x5, x4
               	lsr	x1, x6, #6
               	sub	x8, x0, x1
               	mvn	x6, x8
               	lsl	x11, x7, x4
               	lsr	x1, x7, x10
               	lsr	x1, x1, #1
               	lsl	x12, x0, x4
               	orr	x12, x12, x1
               	and	x13, x11, x6
               	mov	x1, #0x0                // =0
               	orr	x13, x13, x1
               	and	x12, x12, x6
               	and	x11, x11, x8
               	orr	x12, x12, x11
               	lsr	x11, x0, x4
               	lsl	x10, x0, x10
               	lsl	x10, x10, #1
               	lsr	x4, x7, x4
               	orr	x4, x4, x10
               	and	x4, x4, x6
               	and	x7, x11, x8
               	orr	x7, x4, x7
               	and	x4, x11, x6
               	orr	x6, x4, x1
               	mvn	x4, x3
               	and	x8, x13, x4
               	and	x7, x7, x3
               	orr	x7, x8, x7
               	and	x4, x12, x4
               	and	x3, x6, x3
               	orr	x4, x4, x3
               	asr	x3, x9, #63
               	mvn	x3, x3
               	and	x6, x7, x3
               	and	x4, x4, x3
               	cmp	x9, #0x80
               	cset	x3, ge
               	sub	x0, x0, x3
               	eor	x3, x6, x2
               	eor	x4, x4, x2
               	cmp	x3, x2
               	cset	x6, lo
               	sub	x4, x4, x2
               	sub	x4, x4, x6
               	eor	x7, x2, #0x7fffffffffffffff
               	mvn	x2, x0
               	and	x2, x4, x2
               	and	x0, x7, x0
               	orr	x0, x2, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x54               // =84
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x10000000000000   // =4503599627370496
               	str	x3, [x2]
               	ldr	x0, [x0]
               	ldr	x2, [x2]
               	orr	x10, x1, x2
               	orr	x2, x0, x1
               	cmp	x2, #0x0
               	cset	x4, ne
               	lsr	x0, x2, #32
               	cmp	x0, #0x0
               	cset	x0, ne
               	lsl	x0, x0, #5
               	add	x6, x0, #0x1
               	lsr	x0, x2, x0
               	lsr	x3, x0, #16
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #4
               	add	x6, x6, x3
               	lsr	x0, x0, x3
               	lsr	x3, x0, #8
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #3
               	add	x6, x6, x3
               	lsr	x0, x0, x3
               	lsr	x3, x0, #4
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #2
               	add	x6, x6, x3
               	lsr	x0, x0, x3
               	lsr	x3, x0, #2
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #1
               	add	x6, x6, x3
               	lsr	x0, x0, x3
               	lsr	x3, x0, #1
               	cmp	x3, #0x0
               	cset	x3, ne
               	add	x6, x6, x3
               	mul	x0, x6, x4
               	mov	x6, #0x40               // =64
               	sub	x3, x6, x0
               	and	x3, x3, #0x3f
               	mov	x4, #-0x1               // =-1
               	lsr	x3, x4, x3
               	cmp	x0, #0x0
               	cset	x7, ne
               	mul	x3, x3, x7
               	and	x3, x10, x3
               	cmp	x3, #0x0
               	cset	x11, ne
               	and	x7, x0, #0x7f
               	and	x3, x0, #0x3f
               	sub	x12, x5, x3
               	lsr	x7, x7, #6
               	sub	x7, x1, x7
               	mvn	x8, x7
               	lsr	x9, x2, x3
               	lsl	x2, x2, x12
               	lsl	x2, x2, #1
               	lsr	x3, x10, x3
               	orr	x2, x3, x2
               	and	x2, x2, x8
               	and	x3, x9, x7
               	orr	x2, x2, x3
               	orr	x2, x2, x11
               	ucvtf	d0, x2
               	add	x0, x0, #0x3ff
               	lsl	x0, x0, #52
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	fmul	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	asr	x12, x0, #63
               	and	x2, x0, #0x7fffffffffffffff
               	lsr	x2, x2, #52
               	sub	x9, x2, #0x3ff
               	and	x0, x0, #0xfffffffffffff
               	orr	x7, x0, #0x10000000000000
               	sub	x2, x2, #0x433
               	asr	x0, x2, #63
               	eor	x2, x2, x0
               	sub	x2, x2, x0
               	and	x3, x2, #0x7f
               	and	x2, x2, #0x3f
               	sub	x10, x5, x2
               	lsr	x3, x3, #6
               	sub	x8, x1, x3
               	mvn	x3, x8
               	lsl	x11, x7, x2
               	and	x14, x11, x3
               	orr	x14, x14, x1
               	lsr	x11, x1, x2
               	lsl	x10, x1, x10
               	lsl	x10, x10, #1
               	lsr	x2, x7, x2
               	orr	x2, x2, x10
               	and	x2, x2, x3
               	and	x7, x11, x8
               	orr	x7, x2, x7
               	mvn	x2, x0
               	and	x8, x14, x2
               	and	x7, x7, x0
               	orr	x7, x8, x7
               	asr	x0, x9, #63
               	mvn	x0, x0
               	and	x3, x7, x0
               	cmp	x9, #0x80
               	cset	x0, ge
               	sub	x0, x1, x0
               	mvn	x2, x0
               	and	x3, x3, x2
               	and	x0, x4, x0
               	orr	x3, x3, x0
               	mvn	x0, x12
               	and	x3, x3, x0
               	mov	x17, #0x10000000000000  // =4503599627370496
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x55               // =85
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x5                // =5
               	str	x2, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x1, [x2]
               	ldr	x0, [x0]
               	ldr	x2, [x2]
               	orr	x10, x1, x2
               	orr	x2, x0, x1
               	cmp	x2, #0x0
               	cset	x7, ne
               	lsr	x0, x2, #32
               	cmp	x0, #0x0
               	cset	x0, ne
               	lsl	x0, x0, #5
               	add	x8, x0, #0x1
               	lsr	x0, x2, x0
               	lsr	x3, x0, #16
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #4
               	add	x8, x8, x3
               	lsr	x0, x0, x3
               	lsr	x3, x0, #8
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #3
               	add	x8, x8, x3
               	lsr	x0, x0, x3
               	lsr	x3, x0, #4
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #2
               	add	x8, x8, x3
               	lsr	x0, x0, x3
               	lsr	x3, x0, #2
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #1
               	add	x8, x8, x3
               	lsr	x0, x0, x3
               	lsr	x3, x0, #1
               	cmp	x3, #0x0
               	cset	x3, ne
               	add	x8, x8, x3
               	mul	x0, x8, x7
               	sub	x3, x6, x0
               	and	x3, x3, #0x3f
               	lsr	x3, x4, x3
               	cmp	x0, #0x0
               	cset	x7, ne
               	mul	x3, x3, x7
               	and	x3, x10, x3
               	cmp	x3, #0x0
               	cset	x11, ne
               	and	x7, x0, #0x7f
               	and	x3, x0, #0x3f
               	sub	x12, x5, x3
               	lsr	x7, x7, #6
               	sub	x7, x1, x7
               	mvn	x8, x7
               	lsr	x9, x2, x3
               	lsl	x2, x2, x12
               	lsl	x2, x2, #1
               	lsr	x3, x10, x3
               	orr	x2, x3, x2
               	and	x2, x2, x8
               	and	x3, x9, x7
               	orr	x2, x2, x3
               	orr	x2, x2, x11
               	ucvtf	d0, x2
               	add	x0, x0, #0x3ff
               	lsl	x0, x0, #52
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	fmul	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	asr	x12, x0, #63
               	and	x2, x0, #0x7fffffffffffffff
               	lsr	x2, x2, #52
               	sub	x9, x2, #0x3ff
               	and	x0, x0, #0xfffffffffffff
               	orr	x7, x0, #0x10000000000000
               	sub	x0, x2, #0x433
               	asr	x2, x0, #63
               	eor	x0, x0, x2
               	sub	x0, x0, x2
               	and	x8, x0, #0x7f
               	and	x3, x0, #0x3f
               	sub	x10, x5, x3
               	lsr	x0, x8, #6
               	sub	x8, x1, x0
               	mvn	x5, x8
               	lsl	x11, x7, x3
               	lsr	x0, x7, x10
               	lsr	x0, x0, #1
               	lsl	x13, x1, x3
               	orr	x13, x13, x0
               	mov	x0, #0x0                // =0
               	and	x13, x13, x5
               	and	x11, x11, x8
               	orr	x13, x13, x11
               	lsr	x11, x1, x3
               	and	x3, x11, x5
               	orr	x5, x3, x0
               	mvn	x3, x2
               	and	x3, x13, x3
               	and	x2, x5, x2
               	orr	x3, x3, x2
               	asr	x2, x9, #63
               	mvn	x2, x2
               	and	x3, x3, x2
               	cmp	x9, #0x80
               	cset	x2, ge
               	sub	x1, x1, x2
               	mvn	x2, x1
               	and	x1, x4, x1
               	and	x2, x3, x2
               	orr	x2, x2, x1
               	mvn	x1, x12
               	and	x1, x2, x1
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x56               // =86
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x3                // =3
               	str	x3, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x3, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x3
               	str	d16, [x4]
               	ldr	x1, [x1]
               	ldr	x2, [x2]
               	orr	x10, x0, x2
               	orr	x2, x1, x0
               	cmp	x2, #0x0
               	cset	x5, ne
               	lsr	x1, x2, #32
               	cmp	x1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x7, x1, #0x1
               	lsr	x1, x2, x1
               	lsr	x3, x1, #16
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #4
               	add	x7, x7, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #8
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #3
               	add	x7, x7, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #4
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #2
               	add	x7, x7, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #2
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #1
               	add	x7, x7, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #1
               	cmp	x3, #0x0
               	cset	x3, ne
               	add	x7, x7, x3
               	mul	x1, x7, x5
               	sub	x3, x6, x1
               	and	x3, x3, #0x3f
               	mov	x5, #-0x1               // =-1
               	lsr	x3, x5, x3
               	cmp	x1, #0x0
               	cset	x6, ne
               	mul	x3, x3, x6
               	and	x3, x10, x3
               	cmp	x3, #0x0
               	cset	x11, ne
               	and	x7, x1, #0x7f
               	and	x3, x1, #0x3f
               	mov	x6, #0x3f               // =63
               	sub	x12, x6, x3
               	lsr	x7, x7, #6
               	sub	x7, x0, x7
               	mvn	x8, x7
               	lsr	x9, x2, x3
               	lsl	x2, x2, x12
               	lsl	x2, x2, #1
               	lsr	x3, x10, x3
               	orr	x2, x3, x2
               	and	x2, x2, x8
               	and	x3, x9, x7
               	orr	x2, x2, x3
               	orr	x2, x2, x11
               	ucvtf	d0, x2
               	add	x1, x1, #0x3ff
               	lsl	x1, x1, #52
               	orr	x1, x1, x0
               	stur	x1, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	ldr	d2, [x4]
               	fmadd	d0, d0, d1, d2
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0x4012000000000000 // =4616752568008179712
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x57               // =87
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	orr	x2, x0, x2
               	orr	x3, x1, x0
               	asr	x1, x3, #63
               	eor	x2, x2, x1
               	eor	x3, x3, x1
               	cmp	x2, x1
               	cset	x7, lo
               	sub	x4, x2, x1
               	sub	x2, x3, x1
               	sub	x2, x2, x7
               	and	x8, x1, #0x8000000000000000
               	cmp	x2, #0x0
               	cset	x7, ne
               	lsr	x1, x2, #32
               	cmp	x1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x9, x1, #0x1
               	lsr	x1, x2, x1
               	lsr	x3, x1, #16
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #4
               	add	x9, x9, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #8
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #3
               	add	x9, x9, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #4
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #2
               	add	x9, x9, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #2
               	cmp	x3, #0x0
               	cset	x3, ne
               	lsl	x3, x3, #1
               	add	x9, x9, x3
               	lsr	x1, x1, x3
               	lsr	x3, x1, #1
               	cmp	x3, #0x0
               	cset	x3, ne
               	add	x9, x9, x3
               	mul	x1, x9, x7
               	mov	x3, #0x40               // =64
               	sub	x3, x3, x1
               	and	x3, x3, #0x3f
               	lsr	x3, x5, x3
               	cmp	x1, #0x0
               	cset	x5, ne
               	mul	x3, x3, x5
               	and	x3, x4, x3
               	cmp	x3, #0x0
               	cset	x9, ne
               	and	x5, x1, #0x7f
               	and	x3, x1, #0x3f
               	sub	x10, x6, x3
               	lsr	x5, x5, #6
               	sub	x5, x0, x5
               	mvn	x6, x5
               	lsr	x7, x2, x3
               	lsl	x2, x2, x10
               	lsl	x2, x2, #1
               	lsr	x3, x4, x3
               	orr	x2, x3, x2
               	and	x2, x2, x6
               	and	x3, x7, x5
               	orr	x2, x2, x3
               	orr	x2, x2, x9
               	ucvtf	d0, x2
               	add	x1, x1, #0x3ff
               	lsl	x1, x1, #52
               	orr	x1, x1, x8
               	stur	x1, [x29, #-0x18]
               	ldur	d1, [x29, #-0x18]
               	fmul	d0, d0, d1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d1, [x1]
               	fmul	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0x4012000000000000 // =4616752568008179712
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
