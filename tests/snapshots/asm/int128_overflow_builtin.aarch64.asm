
int128_overflow_builtin.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x40
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x6
               	sxtw	x0, w0
               	sxtw	x2, w2
               	cmp	x0, x2
               	b.eq	<addr>
               	sxtw	x0, w5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x4
               	b.eq	<addr>
               	add	x0, x5, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	cmp	x1, x3
               	b.eq	<addr>
               	add	x0, x5, #0x2
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4a0
               	stp	x20, x21, [sp]
               	mov	x3, #0x0                // =0
               	sub	x0, x29, #0x10
               	str	x3, [x0]
               	str	x3, [x0, #0x8]
               	mvn	x1, x3
               	mvn	x2, x3
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x1, x29, #0x420
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x30
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	lsl	x1, x2, #63
               	sub	x0, x29, #0x40
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x430
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x50
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	lsl	x1, x2, #63
               	sub	x0, x29, #0x60
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	cmp	x3, #0x1
               	cset	x0, lo
               	sub	x4, x3, #0x1
               	sub	x1, x1, #0x0
               	sub	x1, x1, x0
               	sub	x0, x29, #0x70
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x440
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x420
               	ldr	x4, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x80
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x450
               	add	x5, x4, x2
               	cmp	x5, x4
               	cset	x6, lo
               	add	x4, x1, x3
               	add	x4, x4, x6
               	cmp	x4, x1
               	cset	x7, lo
               	cmp	x4, x1
               	cset	x1, eq
               	and	x1, x1, x6
               	orr	x1, x7, x1
               	add	x1, x1, #0x0
               	cmp	x1, #0x0
               	cset	x1, ne
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x450
               	mov	x4, x3
               	mov	x6, x2
               	mov	x5, x3
               	mov	x3, x2
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x90
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x450
               	add	x4, x3, x2
               	cmp	x4, x3
               	cset	x5, lo
               	add	x3, x1, x2
               	add	x3, x3, x5
               	cmp	x3, x1
               	cset	x6, lo
               	cmp	x3, x1
               	cset	x1, eq
               	and	x1, x1, x5
               	orr	x1, x6, x1
               	add	x1, x1, #0x0
               	cmp	x1, #0x0
               	cset	x1, ne
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x450
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x4                // =4
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xa0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	mov	x2, #0x1                // =1
               	sub	x1, x29, #0xb0
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x450
               	cmp	x0, x2
               	cset	x3, lo
               	sub	x4, x0, x2
               	sub	x5, x0, x0
               	sub	x5, x5, x3
               	cmp	x0, x0
               	cset	x6, lo
               	cmp	x0, x0
               	cset	x0, eq
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	mov	x3, #0x0                // =0
               	sub	x0, x3, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	str	x4, [x1]
               	str	x5, [x1, #0x8]
               	sub	x1, x29, #0x450
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x7                // =7
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0xc0
               	str	x2, [x0]
               	mov	x3, #0x0                // =0
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0xd0
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xe0
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0xf0
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x10, x29, #0x450
               	eor	x0, x3, x3
               	eor	x1, x2, x3
               	cmp	x0, #0x0
               	cset	x4, lo
               	sub	x0, x0, #0x0
               	sub	x1, x1, #0x0
               	sub	x1, x1, x4
               	eor	x4, x3, x3
               	eor	x5, x2, x3
               	cmp	x4, #0x0
               	cset	x6, lo
               	sub	x4, x4, #0x0
               	sub	x5, x5, #0x0
               	sub	x5, x5, x6
               	mul	x11, x0, x4
               	mov	w6, w0
               	lsr	x7, x0, #32
               	mov	w8, w4
               	lsr	x9, x4, #32
               	mul	x12, x6, x8
               	lsr	x12, x12, #32
               	mul	x13, x7, x8
               	add	x12, x13, x12
               	mov	w13, w12
               	lsr	x12, x12, #32
               	mul	x14, x6, x9
               	add	x13, x14, x13
               	lsr	x13, x13, #32
               	mul	x14, x7, x9
               	add	x12, x14, x12
               	add	x12, x12, x13
               	mul	x0, x0, x5
               	mul	x4, x1, x4
               	add	x0, x12, x0
               	cmp	x0, x12
               	cset	x12, lo
               	add	x4, x0, x4
               	cmp	x4, x0
               	cset	x13, lo
               	cmp	x1, #0x0
               	cset	x0, ne
               	cmp	x5, #0x0
               	cset	x14, ne
               	and	x14, x0, x14
               	mov	w0, w5
               	lsr	x5, x5, #32
               	mul	x15, x6, x0
               	lsr	x15, x15, #32
               	mul	x0, x7, x0
               	add	x0, x0, x15
               	mov	w15, w0
               	lsr	x0, x0, #32
               	mul	x6, x6, x5
               	add	x6, x6, x15
               	lsr	x6, x6, #32
               	mul	x5, x7, x5
               	add	x0, x5, x0
               	add	x6, x0, x6
               	mov	w0, w1
               	lsr	x1, x1, #32
               	mul	x5, x0, x8
               	lsr	x5, x5, #32
               	mul	x7, x1, x8
               	add	x5, x7, x5
               	mov	w7, w5
               	lsr	x5, x5, #32
               	mul	x0, x0, x9
               	add	x0, x0, x7
               	lsr	x0, x0, #32
               	mul	x1, x1, x9
               	add	x1, x1, x5
               	add	x0, x1, x0
               	cmp	x6, #0x0
               	cset	x1, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	orr	x1, x14, x1
               	orr	x0, x1, x0
               	orr	x0, x0, x12
               	orr	x5, x0, x13
               	mov	x0, #0x0                // =0
               	eor	x1, x11, x0
               	eor	x0, x4, x0
               	cmp	x1, #0x0
               	cset	x6, lo
               	sub	x1, x1, #0x0
               	sub	x0, x0, #0x0
               	sub	x6, x0, x6
               	eor	x0, x11, x3
               	eor	x4, x4, x3
               	orr	x0, x0, x4
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x17, #0x0               // =0
               	and	x0, x0, x17
               	orr	x0, x5, x0
               	str	x1, [x10]
               	str	x6, [x10, #0x8]
               	sub	x1, x29, #0x450
               	mov	x5, #0xa                // =10
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x100
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	lsl	x3, x1, #63
               	sub	x0, x29, #0x110
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x120
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x9, x29, #0x450
               	eor	x0, x2, x2
               	eor	x3, x3, x2
               	cmp	x0, #0x0
               	cset	x4, lo
               	sub	x0, x0, #0x0
               	sub	x3, x3, #0x0
               	sub	x3, x3, x4
               	eor	x1, x1, x2
               	eor	x4, x2, x2
               	cmp	x1, #0x0
               	cset	x5, lo
               	sub	x1, x1, #0x0
               	sub	x4, x4, #0x0
               	sub	x4, x4, x5
               	mul	x10, x0, x1
               	mov	w5, w0
               	lsr	x6, x0, #32
               	mov	w7, w1
               	lsr	x8, x1, #32
               	mul	x11, x5, x7
               	lsr	x11, x11, #32
               	mul	x12, x6, x7
               	add	x11, x12, x11
               	mov	w12, w11
               	lsr	x11, x11, #32
               	mul	x13, x5, x8
               	add	x12, x13, x12
               	lsr	x12, x12, #32
               	mul	x13, x6, x8
               	add	x11, x13, x11
               	add	x11, x11, x12
               	mul	x0, x0, x4
               	mul	x1, x3, x1
               	add	x0, x11, x0
               	cmp	x0, x11
               	cset	x11, lo
               	add	x1, x0, x1
               	cmp	x1, x0
               	cset	x12, lo
               	cmp	x3, #0x0
               	cset	x0, ne
               	cmp	x4, #0x0
               	cset	x13, ne
               	and	x13, x0, x13
               	mov	w0, w4
               	lsr	x4, x4, #32
               	mul	x14, x5, x0
               	lsr	x14, x14, #32
               	mul	x0, x6, x0
               	add	x0, x0, x14
               	mov	w14, w0
               	lsr	x0, x0, #32
               	mul	x5, x5, x4
               	add	x5, x5, x14
               	lsr	x5, x5, #32
               	mul	x4, x6, x4
               	add	x0, x4, x0
               	add	x5, x0, x5
               	mov	w0, w3
               	lsr	x3, x3, #32
               	mul	x4, x0, x7
               	lsr	x4, x4, #32
               	mul	x6, x3, x7
               	add	x4, x6, x4
               	mov	w6, w4
               	lsr	x4, x4, #32
               	mul	x0, x0, x8
               	add	x0, x0, x6
               	lsr	x0, x0, #32
               	mul	x3, x3, x8
               	add	x3, x3, x4
               	add	x0, x3, x0
               	cmp	x5, #0x0
               	cset	x3, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	orr	x3, x13, x3
               	orr	x0, x3, x0
               	orr	x0, x0, x11
               	orr	x4, x0, x12
               	mov	x0, #0x0                // =0
               	eor	x3, x10, x0
               	eor	x0, x1, x0
               	cmp	x3, #0x0
               	cset	x5, lo
               	sub	x3, x3, #0x0
               	sub	x0, x0, #0x0
               	sub	x5, x0, x5
               	eor	x0, x10, x2
               	eor	x1, x1, x2
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x17, #0x0               // =0
               	and	x0, x0, x17
               	orr	x0, x4, x0
               	str	x3, [x9]
               	str	x5, [x9, #0x8]
               	sub	x1, x29, #0x450
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #0xd                // =13
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x2
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3                // =3
               	sub	x1, x29, #0x130
               	str	x2, [x1]
               	mov	x0, #0x0                // =0
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x140
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	mov	x17, #0x5               // =5
               	orr	x3, x0, x17
               	orr	x4, x2, x0
               	sub	x1, x29, #0x150
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	mov	x2, #0x1                // =1
               	sub	x1, x29, #0x160
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	lsl	x5, x2, #63
               	lsl	x1, x0, #63
               	lsr	x6, x2, #1
               	orr	x6, x1, x6
               	sub	x1, x29, #0x170
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	sub	x10, x29, #0x450
               	eor	x1, x3, x0
               	eor	x3, x4, x0
               	cmp	x1, #0x0
               	cset	x4, lo
               	sub	x1, x1, #0x0
               	sub	x3, x3, #0x0
               	sub	x3, x3, x4
               	eor	x4, x5, x0
               	eor	x5, x6, x0
               	cmp	x4, #0x0
               	cset	x6, lo
               	sub	x4, x4, #0x0
               	sub	x5, x5, #0x0
               	sub	x5, x5, x6
               	mul	x11, x1, x4
               	mov	w6, w1
               	lsr	x7, x1, #32
               	mov	w8, w4
               	lsr	x9, x4, #32
               	mul	x12, x6, x8
               	lsr	x12, x12, #32
               	mul	x13, x7, x8
               	add	x12, x13, x12
               	mov	w13, w12
               	lsr	x12, x12, #32
               	mul	x14, x6, x9
               	add	x13, x14, x13
               	lsr	x13, x13, #32
               	mul	x14, x7, x9
               	add	x12, x14, x12
               	add	x12, x12, x13
               	mul	x1, x1, x5
               	mul	x4, x3, x4
               	add	x1, x12, x1
               	cmp	x1, x12
               	cset	x12, lo
               	add	x4, x1, x4
               	cmp	x4, x1
               	cset	x13, lo
               	cmp	x3, #0x0
               	cset	x1, ne
               	cmp	x5, #0x0
               	cset	x14, ne
               	and	x14, x1, x14
               	mov	w1, w5
               	lsr	x5, x5, #32
               	mul	x15, x6, x1
               	lsr	x15, x15, #32
               	mul	x1, x7, x1
               	add	x1, x1, x15
               	mov	w15, w1
               	lsr	x1, x1, #32
               	mul	x6, x6, x5
               	add	x6, x6, x15
               	lsr	x6, x6, #32
               	mul	x5, x7, x5
               	add	x1, x5, x1
               	add	x6, x1, x6
               	mov	w1, w3
               	lsr	x3, x3, #32
               	mul	x5, x1, x8
               	lsr	x5, x5, #32
               	mul	x7, x3, x8
               	add	x5, x7, x5
               	mov	w7, w5
               	lsr	x5, x5, #32
               	mul	x1, x1, x9
               	add	x1, x1, x7
               	lsr	x1, x1, #32
               	mul	x3, x3, x9
               	add	x3, x3, x5
               	add	x1, x3, x1
               	cmp	x6, #0x0
               	cset	x3, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	orr	x3, x14, x3
               	orr	x1, x3, x1
               	orr	x1, x1, x12
               	orr	x5, x1, x13
               	mov	x1, #0x0                // =0
               	eor	x3, x11, x1
               	eor	x1, x4, x1
               	cmp	x3, #0x0
               	cset	x6, lo
               	sub	x3, x3, #0x0
               	sub	x1, x1, #0x0
               	sub	x1, x1, x6
               	eor	x6, x11, x0
               	eor	x0, x4, x0
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x17, #0x0               // =0
               	and	x0, x0, x17
               	orr	x0, x5, x0
               	str	x3, [x10]
               	str	x1, [x10, #0x8]
               	sub	x1, x29, #0x450
               	mov	x3, #0x2                // =2
               	movk	x3, #0x8000, lsl #48
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #0x10               // =16
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x440
               	ldr	x5, [x0]
               	ldr	x1, [x0, #0x8]
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x180
               	str	x2, [x0]
               	mov	x4, #0x0                // =0
               	str	x4, [x0, #0x8]
               	sub	x3, x29, #0x460
               	asr	x7, x1, #63
               	asr	x8, x4, #63
               	add	x6, x5, x2
               	cmp	x6, x5
               	cset	x5, lo
               	add	x0, x1, x4
               	add	x0, x0, x5
               	cmp	x0, x1
               	cset	x9, lo
               	cmp	x0, x1
               	cset	x1, eq
               	and	x1, x1, x5
               	orr	x1, x9, x1
               	add	x5, x7, x8
               	add	x1, x5, x1
               	asr	x5, x0, #63
               	cmp	x1, x5
               	cset	x1, ne
               	str	x6, [x3]
               	str	x0, [x3, #0x8]
               	sub	x0, x29, #0x460
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #0x13               // =19
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x430
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	sub	x0, x29, #0x190
               	str	x4, [x0]
               	str	x4, [x0, #0x8]
               	sub	x2, x29, #0x460
               	asr	x6, x1, #63
               	asr	x7, x4, #63
               	add	x5, x3, x4
               	cmp	x5, x3
               	cset	x3, lo
               	add	x0, x1, x4
               	add	x0, x0, x3
               	cmp	x0, x1
               	cset	x8, lo
               	cmp	x0, x1
               	cset	x1, eq
               	and	x1, x1, x3
               	orr	x1, x8, x1
               	add	x3, x6, x7
               	add	x1, x3, x1
               	asr	x3, x0, #63
               	cmp	x1, x3
               	cset	x1, ne
               	str	x5, [x2]
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0x460
               	mov	x2, #0x1                // =1
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	mov	x5, #0x16               // =22
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x440
               	ldr	x3, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x1, x29, #0x1a0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x460
               	asr	x5, x2, #63
               	asr	x6, x0, #63
               	add	x4, x3, x0
               	cmp	x4, x3
               	cset	x3, lo
               	add	x0, x2, x0
               	add	x0, x0, x3
               	cmp	x0, x2
               	cset	x7, lo
               	cmp	x0, x2
               	cset	x2, eq
               	and	x2, x2, x3
               	orr	x2, x7, x2
               	add	x3, x5, x6
               	add	x2, x3, x2
               	asr	x3, x0, #63
               	cmp	x2, x3
               	cset	x2, ne
               	str	x4, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x460
               	mov	x0, #0x0                // =0
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	mov	x4, #0xfffe             // =65534
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0x19               // =25
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x0
               	mov	x0, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x430
               	ldr	x4, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x3, #0x1                // =1
               	sub	x0, x29, #0x1b0
               	str	x3, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x460
               	asr	x6, x2, #63
               	asr	x7, x1, #63
               	cmp	x4, x3
               	cset	x5, lo
               	sub	x8, x4, x3
               	sub	x4, x2, x1
               	sub	x4, x4, x5
               	cmp	x2, x1
               	cset	x9, lo
               	cmp	x2, x1
               	cset	x1, eq
               	and	x1, x1, x5
               	orr	x1, x9, x1
               	sub	x2, x6, x7
               	sub	x1, x2, x1
               	asr	x2, x4, #63
               	cmp	x1, x2
               	cset	x1, ne
               	str	x8, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x460
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0x7fff, lsl #48
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0x1c               // =28
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x2
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x430
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	sub	x0, x29, #0x1c0
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	sub	x10, x29, #0x460
               	asr	x0, x3, #63
               	asr	x1, x2, #63
               	eor	x4, x4, x0
               	eor	x5, x3, x0
               	cmp	x4, x0
               	cset	x6, lo
               	sub	x3, x4, x0
               	sub	x4, x5, x0
               	sub	x4, x4, x6
               	eor	x5, x2, x1
               	eor	x6, x2, x1
               	cmp	x5, x1
               	cset	x7, lo
               	sub	x2, x5, x1
               	sub	x5, x6, x1
               	sub	x5, x5, x7
               	mul	x11, x3, x2
               	mov	w6, w3
               	lsr	x7, x3, #32
               	mov	w8, w2
               	lsr	x9, x2, #32
               	mul	x12, x6, x8
               	lsr	x12, x12, #32
               	mul	x13, x7, x8
               	add	x12, x13, x12
               	mov	w13, w12
               	lsr	x12, x12, #32
               	mul	x14, x6, x9
               	add	x13, x14, x13
               	lsr	x13, x13, #32
               	mul	x14, x7, x9
               	add	x12, x14, x12
               	add	x12, x12, x13
               	mul	x3, x3, x5
               	mul	x2, x4, x2
               	add	x3, x12, x3
               	cmp	x3, x12
               	cset	x13, lo
               	add	x2, x3, x2
               	cmp	x2, x3
               	cset	x14, lo
               	mov	x12, #0x0               // =0
               	cmp	x4, #0x0
               	cset	x3, ne
               	cmp	x5, #0x0
               	cset	x15, ne
               	and	x15, x3, x15
               	mov	w3, w5
               	lsr	x5, x5, #32
               	mul	x20, x6, x3
               	lsr	x20, x20, #32
               	mul	x3, x7, x3
               	add	x3, x3, x20
               	mov	w20, w3
               	lsr	x3, x3, #32
               	mul	x6, x6, x5
               	add	x6, x6, x20
               	lsr	x6, x6, #32
               	mul	x5, x7, x5
               	add	x3, x5, x3
               	add	x6, x3, x6
               	mov	w3, w4
               	lsr	x4, x4, #32
               	mul	x5, x3, x8
               	lsr	x5, x5, #32
               	mul	x7, x4, x8
               	add	x5, x7, x5
               	mov	w7, w5
               	lsr	x5, x5, #32
               	mul	x3, x3, x9
               	add	x3, x3, x7
               	lsr	x3, x3, #32
               	mul	x4, x4, x9
               	add	x4, x4, x5
               	add	x3, x4, x3
               	cmp	x6, #0x0
               	cset	x4, ne
               	cmp	x3, #0x0
               	cset	x3, ne
               	orr	x4, x15, x4
               	orr	x3, x4, x3
               	orr	x3, x3, x13
               	orr	x4, x3, x14
               	eor	x0, x0, x1
               	eor	x1, x11, x0
               	eor	x3, x2, x0
               	cmp	x1, x0
               	cset	x5, lo
               	sub	x1, x1, x0
               	sub	x3, x3, x0
               	sub	x5, x3, x5
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x3, x2
               	cset	x6, lo
               	cmp	x3, x2
               	cset	x7, eq
               	cmp	x11, #0x0
               	cset	x8, hi
               	and	x7, x7, x8
               	orr	x6, x6, x7
               	eor	x7, x11, x12
               	eor	x2, x2, x3
               	orr	x2, x7, x2
               	cmp	x2, #0x0
               	cset	x2, eq
               	add	x0, x0, #0x1
               	and	x0, x2, x0
               	orr	x0, x6, x0
               	orr	x0, x4, x0
               	str	x1, [x10]
               	str	x5, [x10, #0x8]
               	sub	x1, x29, #0x460
               	mov	x2, #0x1                // =1
               	mov	x5, #0x1f               // =31
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x12
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x1d0
               	str	x0, [x1]
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x8]
               	lsl	x3, x0, #36
               	sub	x1, x29, #0x1e0
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x1f0
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	lsl	x1, x0, #27
               	lsl	x4, x2, #27
               	lsr	x0, x0, #37
               	orr	x4, x4, x0
               	sub	x0, x29, #0x200
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x0, hi
               	sub	x6, x2, x1
               	sub	x1, x2, x4
               	sub	x5, x1, x0
               	sub	x0, x29, #0x210
               	str	x6, [x0]
               	str	x5, [x0, #0x8]
               	sub	x11, x29, #0x460
               	asr	x0, x3, #63
               	asr	x1, x5, #63
               	eor	x4, x2, x0
               	eor	x7, x3, x0
               	cmp	x4, x0
               	cset	x8, lo
               	sub	x3, x4, x0
               	sub	x4, x7, x0
               	sub	x4, x4, x8
               	eor	x6, x6, x1
               	eor	x7, x5, x1
               	cmp	x6, x1
               	cset	x8, lo
               	sub	x5, x6, x1
               	sub	x6, x7, x1
               	sub	x6, x6, x8
               	mul	x12, x3, x5
               	mov	w7, w3
               	lsr	x8, x3, #32
               	mov	w9, w5
               	lsr	x10, x5, #32
               	mul	x13, x7, x9
               	lsr	x13, x13, #32
               	mul	x14, x8, x9
               	add	x13, x14, x13
               	mov	w14, w13
               	lsr	x13, x13, #32
               	mul	x15, x7, x10
               	add	x14, x15, x14
               	lsr	x14, x14, #32
               	mul	x15, x8, x10
               	add	x13, x15, x13
               	add	x13, x13, x14
               	mul	x3, x3, x6
               	mul	x14, x4, x5
               	add	x5, x13, x3
               	cmp	x5, x13
               	cset	x13, lo
               	add	x3, x5, x14
               	cmp	x3, x5
               	cset	x14, lo
               	cmp	x4, #0x0
               	cset	x5, ne
               	cmp	x6, #0x0
               	cset	x15, ne
               	and	x15, x5, x15
               	mov	w5, w6
               	lsr	x6, x6, #32
               	mul	x20, x7, x5
               	lsr	x20, x20, #32
               	mul	x5, x8, x5
               	add	x5, x5, x20
               	mov	w20, w5
               	lsr	x5, x5, #32
               	mul	x7, x7, x6
               	add	x7, x7, x20
               	lsr	x7, x7, #32
               	mul	x6, x8, x6
               	add	x5, x6, x5
               	add	x7, x5, x7
               	mov	w5, w4
               	lsr	x4, x4, #32
               	mul	x6, x5, x9
               	lsr	x6, x6, #32
               	mul	x8, x4, x9
               	add	x6, x8, x6
               	mov	w8, w6
               	lsr	x6, x6, #32
               	mul	x5, x5, x10
               	add	x5, x5, x8
               	lsr	x5, x5, #32
               	mul	x4, x4, x10
               	add	x4, x4, x6
               	add	x4, x4, x5
               	cmp	x7, #0x0
               	cset	x5, ne
               	cmp	x4, #0x0
               	cset	x4, ne
               	orr	x5, x15, x5
               	orr	x4, x5, x4
               	orr	x4, x4, x13
               	orr	x4, x4, x14
               	eor	x0, x0, x1
               	eor	x1, x12, x0
               	eor	x5, x3, x0
               	cmp	x1, x0
               	cset	x6, lo
               	sub	x7, x1, x0
               	sub	x1, x5, x0
               	sub	x5, x1, x6
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x3
               	cset	x6, lo
               	cmp	x1, x3
               	cset	x8, eq
               	cmp	x12, #0x0
               	cset	x9, hi
               	and	x8, x8, x9
               	orr	x6, x6, x8
               	eor	x8, x12, x2
               	eor	x3, x3, x1
               	orr	x3, x8, x3
               	cmp	x3, #0x0
               	cset	x3, eq
               	add	x0, x0, #0x1
               	and	x0, x3, x0
               	orr	x0, x6, x0
               	orr	x0, x4, x0
               	str	x7, [x11]
               	str	x5, [x11, #0x8]
               	sub	x3, x29, #0x460
               	mov	x5, #0x22               // =34
               	mov	x4, x1
               	mov	x6, x5
               	mov	x5, x2
               	mov	x1, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x220
               	str	x2, [x0]
               	mov	x4, #0x0                // =0
               	str	x4, [x0, #0x8]
               	lsl	x3, x2, #36
               	sub	x0, x29, #0x230
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x240
               	str	x2, [x0]
               	str	x4, [x0, #0x8]
               	lsl	x7, x2, #27
               	lsl	x0, x4, #27
               	lsr	x1, x2, #37
               	orr	x6, x0, x1
               	sub	x0, x29, #0x250
               	str	x7, [x0]
               	str	x6, [x0, #0x8]
               	sub	x12, x29, #0x460
               	asr	x0, x3, #63
               	asr	x1, x6, #63
               	eor	x5, x4, x0
               	eor	x8, x3, x0
               	cmp	x5, x0
               	cset	x9, lo
               	sub	x3, x5, x0
               	sub	x5, x8, x0
               	sub	x5, x5, x9
               	eor	x7, x7, x1
               	eor	x8, x6, x1
               	cmp	x7, x1
               	cset	x9, lo
               	sub	x6, x7, x1
               	sub	x7, x8, x1
               	sub	x7, x7, x9
               	mul	x13, x3, x6
               	mov	w8, w3
               	lsr	x9, x3, #32
               	mov	w10, w6
               	lsr	x11, x6, #32
               	mul	x14, x8, x10
               	lsr	x14, x14, #32
               	mul	x15, x9, x10
               	add	x14, x15, x14
               	mov	w15, w14
               	lsr	x14, x14, #32
               	mul	x20, x8, x11
               	add	x15, x20, x15
               	lsr	x15, x15, #32
               	mul	x20, x9, x11
               	add	x14, x20, x14
               	add	x14, x14, x15
               	mul	x3, x3, x7
               	mul	x15, x5, x6
               	add	x6, x14, x3
               	cmp	x6, x14
               	cset	x14, lo
               	add	x3, x6, x15
               	cmp	x3, x6
               	cset	x15, lo
               	cmp	x5, #0x0
               	cset	x6, ne
               	cmp	x7, #0x0
               	cset	x20, ne
               	and	x20, x6, x20
               	mov	w6, w7
               	lsr	x7, x7, #32
               	mul	x21, x8, x6
               	lsr	x21, x21, #32
               	mul	x6, x9, x6
               	add	x6, x6, x21
               	mov	w21, w6
               	lsr	x6, x6, #32
               	mul	x8, x8, x7
               	add	x8, x8, x21
               	lsr	x8, x8, #32
               	mul	x7, x9, x7
               	add	x6, x7, x6
               	add	x8, x6, x8
               	mov	w6, w5
               	lsr	x5, x5, #32
               	mul	x7, x6, x10
               	lsr	x7, x7, #32
               	mul	x9, x5, x10
               	add	x7, x9, x7
               	mov	w9, w7
               	lsr	x7, x7, #32
               	mul	x6, x6, x11
               	add	x6, x6, x9
               	lsr	x6, x6, #32
               	mul	x5, x5, x11
               	add	x5, x5, x7
               	add	x5, x5, x6
               	cmp	x8, #0x0
               	cset	x6, ne
               	cmp	x5, #0x0
               	cset	x5, ne
               	orr	x6, x20, x6
               	orr	x5, x6, x5
               	orr	x5, x5, x14
               	orr	x5, x5, x15
               	eor	x0, x0, x1
               	eor	x1, x13, x0
               	eor	x6, x3, x0
               	cmp	x1, x0
               	cset	x7, lo
               	sub	x8, x1, x0
               	sub	x1, x6, x0
               	sub	x6, x1, x7
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x3
               	cset	x7, lo
               	cmp	x1, x3
               	cset	x9, eq
               	cmp	x13, #0x0
               	cset	x10, hi
               	and	x9, x9, x10
               	orr	x7, x7, x9
               	eor	x9, x13, x4
               	eor	x3, x3, x1
               	orr	x3, x9, x3
               	cmp	x3, #0x0
               	cset	x3, eq
               	add	x0, x0, #0x1
               	and	x0, x3, x0
               	orr	x0, x7, x0
               	orr	x0, x5, x0
               	str	x8, [x12]
               	str	x6, [x12, #0x8]
               	sub	x3, x29, #0x460
               	mov	x5, #0x25               // =37
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x1
               	mov	x1, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x430
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x260
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	sub	x11, x29, #0x460
               	asr	x0, x3, #63
               	asr	x1, x2, #63
               	eor	x4, x4, x0
               	eor	x5, x3, x0
               	cmp	x4, x0
               	cset	x6, lo
               	sub	x3, x4, x0
               	sub	x4, x5, x0
               	sub	x4, x4, x6
               	eor	x5, x2, x1
               	eor	x6, x2, x1
               	cmp	x5, x1
               	cset	x7, lo
               	sub	x5, x5, x1
               	sub	x6, x6, x1
               	sub	x6, x6, x7
               	mul	x12, x3, x5
               	mov	w7, w3
               	lsr	x8, x3, #32
               	mov	w9, w5
               	lsr	x10, x5, #32
               	mul	x13, x7, x9
               	lsr	x13, x13, #32
               	mul	x14, x8, x9
               	add	x13, x14, x13
               	mov	w14, w13
               	lsr	x13, x13, #32
               	mul	x15, x7, x10
               	add	x14, x15, x14
               	lsr	x14, x14, #32
               	mul	x15, x8, x10
               	add	x13, x15, x13
               	add	x13, x13, x14
               	mul	x3, x3, x6
               	mul	x14, x4, x5
               	add	x5, x13, x3
               	cmp	x5, x13
               	cset	x13, lo
               	add	x3, x5, x14
               	cmp	x3, x5
               	cset	x14, lo
               	cmp	x4, #0x0
               	cset	x5, ne
               	cmp	x6, #0x0
               	cset	x15, ne
               	and	x15, x5, x15
               	mov	w5, w6
               	lsr	x6, x6, #32
               	mul	x20, x7, x5
               	lsr	x20, x20, #32
               	mul	x5, x8, x5
               	add	x5, x5, x20
               	mov	w20, w5
               	lsr	x5, x5, #32
               	mul	x7, x7, x6
               	add	x7, x7, x20
               	lsr	x7, x7, #32
               	mul	x6, x8, x6
               	add	x5, x6, x5
               	add	x7, x5, x7
               	mov	w5, w4
               	lsr	x4, x4, #32
               	mul	x6, x5, x9
               	lsr	x6, x6, #32
               	mul	x8, x4, x9
               	add	x6, x8, x6
               	mov	w8, w6
               	lsr	x6, x6, #32
               	mul	x5, x5, x10
               	add	x5, x5, x8
               	lsr	x5, x5, #32
               	mul	x4, x4, x10
               	add	x4, x4, x6
               	add	x4, x4, x5
               	cmp	x7, #0x0
               	cset	x5, ne
               	cmp	x4, #0x0
               	cset	x4, ne
               	orr	x5, x15, x5
               	orr	x4, x5, x4
               	orr	x4, x4, x13
               	orr	x4, x4, x14
               	eor	x0, x0, x1
               	eor	x1, x12, x0
               	eor	x5, x3, x0
               	cmp	x1, x0
               	cset	x6, lo
               	sub	x7, x1, x0
               	sub	x1, x5, x0
               	sub	x5, x1, x6
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x3
               	cset	x6, lo
               	cmp	x1, x3
               	cset	x8, eq
               	cmp	x12, #0x0
               	cset	x9, hi
               	and	x8, x8, x9
               	orr	x6, x6, x8
               	eor	x8, x12, x2
               	eor	x1, x3, x1
               	orr	x1, x8, x1
               	cmp	x1, #0x0
               	cset	x1, eq
               	add	x0, x0, #0x1
               	and	x0, x1, x0
               	orr	x0, x6, x0
               	orr	x0, x4, x0
               	str	x7, [x11]
               	str	x5, [x11, #0x8]
               	sub	x1, x29, #0x460
               	mov	x5, #0x28               // =40
               	mov	x3, x2
               	mov	x6, x5
               	mov	x5, x2
               	mov	x4, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x270
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	lsl	x1, x1, #63
               	sub	x0, x29, #0x280
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	sub	x0, x29, #0x450
               	sub	x4, x2, #0x1
               	cmp	x4, x2
               	cset	x5, lo
               	sub	x3, x1, #0x1
               	add	x3, x3, x5
               	cmp	x3, x1
               	cset	x7, lo
               	cmp	x3, x1
               	cset	x1, eq
               	and	x1, x1, x5
               	orr	x1, x7, x1
               	sub	x1, x1, #0x1
               	cmp	x1, #0x0
               	cset	x1, ne
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x450
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	mov	x5, #0x2b               // =43
               	mov	x4, x3
               	mov	x3, x2
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	mov	x16, x6
               	mov	x6, x5
               	mov	x5, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	ldr	x4, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x1, x29, #0x290
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x450
               	mov	x3, #0x0                // =0
               	asr	x6, x0, #63
               	cmp	x4, x0
               	cset	x5, lo
               	sub	x4, x4, x0
               	sub	x7, x2, x0
               	sub	x7, x7, x5
               	cmp	x2, x0
               	cset	x8, lo
               	cmp	x2, x0
               	cset	x0, eq
               	and	x0, x0, x5
               	orr	x0, x8, x0
               	sub	x2, x3, x6
               	sub	x0, x2, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	str	x4, [x1]
               	str	x7, [x1, #0x8]
               	sub	x1, x29, #0x450
               	mov	x2, #0x1                // =1
               	mov	x5, #0x2e               // =46
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	ldr	x3, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x2a0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x460
               	asr	x5, x0, #63
               	add	x4, x3, x0
               	cmp	x4, x3
               	cset	x3, lo
               	add	x0, x2, x0
               	add	x0, x0, x3
               	cmp	x0, x2
               	cset	x6, lo
               	cmp	x0, x2
               	cset	x2, eq
               	and	x2, x2, x3
               	orr	x2, x6, x2
               	add	x3, x5, #0x0
               	add	x2, x3, x2
               	asr	x3, x0, #63
               	cmp	x2, x3
               	cset	x2, ne
               	str	x4, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x460
               	mov	x0, #0x1                // =1
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x31               // =49
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x0
               	mov	x0, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	ldr	x2, [x0]
               	ldr	x4, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	sub	x0, x29, #0x2b0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	sub	x10, x29, #0x460
               	mov	x3, #0x0                // =0
               	asr	x0, x1, #63
               	eor	x2, x2, x3
               	eor	x4, x4, x3
               	cmp	x2, #0x0
               	cset	x5, lo
               	sub	x2, x2, #0x0
               	sub	x4, x4, #0x0
               	sub	x4, x4, x5
               	eor	x5, x1, x0
               	eor	x6, x1, x0
               	cmp	x5, x0
               	cset	x7, lo
               	sub	x1, x5, x0
               	sub	x5, x6, x0
               	sub	x5, x5, x7
               	mul	x11, x2, x1
               	mov	w6, w2
               	lsr	x7, x2, #32
               	mov	w8, w1
               	lsr	x9, x1, #32
               	mul	x12, x6, x8
               	lsr	x12, x12, #32
               	mul	x13, x7, x8
               	add	x12, x13, x12
               	mov	w13, w12
               	lsr	x12, x12, #32
               	mul	x14, x6, x9
               	add	x13, x14, x13
               	lsr	x13, x13, #32
               	mul	x14, x7, x9
               	add	x12, x14, x12
               	add	x12, x12, x13
               	mul	x2, x2, x5
               	mul	x1, x4, x1
               	add	x2, x12, x2
               	cmp	x2, x12
               	cset	x12, lo
               	add	x1, x2, x1
               	cmp	x1, x2
               	cset	x13, lo
               	cmp	x4, #0x0
               	cset	x2, ne
               	cmp	x5, #0x0
               	cset	x14, ne
               	and	x14, x2, x14
               	mov	w2, w5
               	lsr	x5, x5, #32
               	mul	x15, x6, x2
               	lsr	x15, x15, #32
               	mul	x2, x7, x2
               	add	x2, x2, x15
               	mov	w15, w2
               	lsr	x2, x2, #32
               	mul	x6, x6, x5
               	add	x6, x6, x15
               	lsr	x6, x6, #32
               	mul	x5, x7, x5
               	add	x2, x5, x2
               	add	x6, x2, x6
               	mov	w2, w4
               	lsr	x4, x4, #32
               	mul	x5, x2, x8
               	lsr	x5, x5, #32
               	mul	x7, x4, x8
               	add	x5, x7, x5
               	mov	w7, w5
               	lsr	x5, x5, #32
               	mul	x2, x2, x9
               	add	x2, x2, x7
               	lsr	x2, x2, #32
               	mul	x4, x4, x9
               	add	x4, x4, x5
               	add	x2, x4, x2
               	cmp	x6, #0x0
               	cset	x4, ne
               	cmp	x2, #0x0
               	cset	x2, ne
               	orr	x4, x14, x4
               	orr	x2, x4, x2
               	orr	x2, x2, x12
               	orr	x4, x2, x13
               	eor	x0, x3, x0
               	eor	x2, x11, x0
               	eor	x5, x1, x0
               	cmp	x2, x0
               	cset	x6, lo
               	sub	x7, x2, x0
               	sub	x2, x5, x0
               	sub	x5, x2, x6
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x1
               	cset	x6, lo
               	cmp	x2, x1
               	cset	x8, eq
               	cmp	x11, #0x0
               	cset	x9, hi
               	and	x8, x8, x9
               	orr	x6, x6, x8
               	eor	x8, x11, x3
               	eor	x1, x1, x2
               	orr	x1, x8, x1
               	cmp	x1, #0x0
               	cset	x1, eq
               	add	x0, x0, #0x1
               	and	x0, x1, x0
               	orr	x0, x6, x0
               	orr	x0, x4, x0
               	str	x7, [x10]
               	str	x5, [x10, #0x8]
               	sub	x1, x29, #0x460
               	mov	x2, #0x1                // =1
               	mov	x5, #0x34               // =52
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x2
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x64               // =100
               	sub	x0, x29, #0x2c0
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	mov	x3, #0x17               // =23
               	sub	x0, x29, #0x2d0
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x4, x29, #0x480
               	add	x0, x1, x3
               	cmp	x0, x1
               	cset	x3, lo
               	add	x1, x2, x2
               	add	x1, x1, x3
               	cmp	x1, x2
               	cset	x5, lo
               	cmp	x1, x2
               	cset	x6, eq
               	and	x3, x6, x3
               	orr	x3, x5, x3
               	add	x3, x3, #0x0
               	cmp	x3, #0x0
               	cset	x5, ne
               	mov	w3, w0
               	str	w3, [x4]
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x1, #0x0
               	cset	x1, eq
               	and	x0, x0, x1
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	orr	x0, x5, x0
               	sub	x16, x29, #0x480
               	ldr	w3, [x16]
               	sub	x1, x29, #0x2e0
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	mov	x4, #0x7b               // =123
               	mov	x5, #0x37               // =55
               	mov	x3, x2
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	sub	x0, x29, #0x2f0
               	str	x1, [x0]
               	mov	x3, #0x0                // =0
               	str	x3, [x0, #0x8]
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x300
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x5, x29, #0x480
               	add	x0, x1, x2
               	cmp	x0, x1
               	cset	x4, lo
               	add	x1, x3, x3
               	add	x1, x1, x4
               	cmp	x1, x3
               	cset	x6, lo
               	cmp	x1, x3
               	cset	x7, eq
               	and	x4, x7, x4
               	orr	x4, x6, x4
               	add	x4, x4, #0x0
               	cmp	x4, #0x0
               	cset	x6, ne
               	mov	w4, w0
               	str	w4, [x5]
               	cmp	x4, x0
               	cset	x0, eq
               	cmp	x1, #0x0
               	cset	x1, eq
               	and	x0, x0, x1
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	orr	x0, x6, x0
               	sub	x16, x29, #0x480
               	ldr	w4, [x16]
               	sub	x1, x29, #0x310
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	mov	x5, #0x3a               // =58
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x320
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	mov	x3, #0x7                // =7
               	sub	x0, x29, #0x330
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x5, x29, #0x478
               	asr	x6, x2, #63
               	asr	x7, x2, #63
               	cmp	x1, x3
               	cset	x4, lo
               	sub	x0, x1, x3
               	sub	x1, x2, x2
               	sub	x1, x1, x4
               	cmp	x2, x2
               	cset	x3, lo
               	cmp	x2, x2
               	cset	x8, eq
               	and	x4, x8, x4
               	orr	x3, x3, x4
               	sub	x4, x6, x7
               	sub	x3, x4, x3
               	asr	x4, x1, #63
               	cmp	x3, x4
               	cset	x4, ne
               	sxtw	x3, w0
               	str	w0, [x5]
               	asr	x5, x3, #63
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x5, x1
               	cset	x1, eq
               	and	x0, x0, x1
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	orr	x0, x4, x0
               	sub	x16, x29, #0x478
               	ldrsw	x3, [x16]
               	sub	x1, x29, #0x340
               	str	x3, [x1]
               	asr	x3, x3, #63
               	str	x3, [x1, #0x8]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x4, #0xfffe             // =65534
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0x3d               // =61
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x10000            // =65536
               	sub	x0, x29, #0x350
               	str	x2, [x0]
               	mov	x3, #0x0                // =0
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x360
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x13, x29, #0x478
               	asr	x0, x3, #63
               	asr	x1, x3, #63
               	eor	x4, x2, x0
               	eor	x5, x3, x0
               	cmp	x4, x0
               	cset	x6, lo
               	sub	x4, x4, x0
               	sub	x5, x5, x0
               	sub	x5, x5, x6
               	eor	x2, x2, x1
               	eor	x6, x3, x1
               	cmp	x2, x1
               	cset	x7, lo
               	sub	x2, x2, x1
               	sub	x6, x6, x1
               	sub	x6, x6, x7
               	mul	x11, x4, x2
               	mov	w7, w4
               	lsr	x8, x4, #32
               	mov	w9, w2
               	lsr	x10, x2, #32
               	mul	x12, x7, x9
               	lsr	x12, x12, #32
               	mul	x14, x8, x9
               	add	x12, x14, x12
               	mov	w14, w12
               	lsr	x12, x12, #32
               	mul	x15, x7, x10
               	add	x14, x15, x14
               	lsr	x14, x14, #32
               	mul	x15, x8, x10
               	add	x12, x15, x12
               	add	x12, x12, x14
               	mul	x4, x4, x6
               	mul	x2, x5, x2
               	add	x4, x12, x4
               	cmp	x4, x12
               	cset	x12, lo
               	add	x2, x4, x2
               	cmp	x2, x4
               	cset	x14, lo
               	cmp	x5, #0x0
               	cset	x4, ne
               	cmp	x6, #0x0
               	cset	x15, ne
               	and	x15, x4, x15
               	mov	w4, w6
               	lsr	x6, x6, #32
               	mul	x20, x7, x4
               	lsr	x20, x20, #32
               	mul	x4, x8, x4
               	add	x4, x4, x20
               	mov	w20, w4
               	lsr	x4, x4, #32
               	mul	x7, x7, x6
               	add	x7, x7, x20
               	lsr	x7, x7, #32
               	mul	x6, x8, x6
               	add	x4, x6, x4
               	add	x7, x4, x7
               	mov	w4, w5
               	lsr	x5, x5, #32
               	mul	x6, x4, x9
               	lsr	x6, x6, #32
               	mul	x8, x5, x9
               	add	x6, x8, x6
               	mov	w8, w6
               	lsr	x6, x6, #32
               	mul	x4, x4, x10
               	add	x4, x4, x8
               	lsr	x4, x4, #32
               	mul	x5, x5, x10
               	add	x5, x5, x6
               	add	x4, x5, x4
               	cmp	x7, #0x0
               	cset	x5, ne
               	cmp	x4, #0x0
               	cset	x4, ne
               	orr	x5, x15, x5
               	orr	x4, x5, x4
               	orr	x4, x4, x12
               	orr	x5, x4, x14
               	eor	x0, x0, x1
               	eor	x1, x11, x0
               	eor	x4, x2, x0
               	cmp	x1, x0
               	cset	x6, lo
               	sub	x1, x1, x0
               	sub	x4, x4, x0
               	sub	x6, x4, x6
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x4, x2
               	cset	x7, lo
               	cmp	x4, x2
               	cset	x8, eq
               	cmp	x11, #0x0
               	cset	x9, hi
               	and	x8, x8, x9
               	orr	x7, x7, x8
               	eor	x8, x11, x3
               	eor	x2, x2, x4
               	orr	x2, x8, x2
               	cmp	x2, #0x0
               	cset	x2, eq
               	add	x0, x0, #0x1
               	and	x0, x2, x0
               	orr	x0, x7, x0
               	orr	x2, x5, x0
               	sxtw	x0, w1
               	str	w1, [x13]
               	asr	x4, x0, #63
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x4, x6
               	cset	x1, eq
               	and	x0, x0, x1
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	orr	x0, x2, x0
               	sub	x16, x29, #0x478
               	ldrsw	x2, [x16]
               	sub	x1, x29, #0x370
               	str	x2, [x1]
               	asr	x2, x2, #63
               	str	x2, [x1, #0x8]
               	mov	x2, #0x1                // =1
               	mov	x5, #0x40               // =64
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	sub	x0, x29, #0x380
               	str	x3, [x0]
               	str	x3, [x0, #0x8]
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x390
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x4, x29, #0x470
               	cmp	x3, x2
               	cset	x1, lo
               	sub	x0, x3, x2
               	sub	x5, x3, x3
               	sub	x5, x5, x1
               	cmp	x3, x3
               	cset	x6, lo
               	cmp	x3, x3
               	cset	x7, eq
               	and	x1, x7, x1
               	orr	x1, x6, x1
               	mov	x6, #0x0                // =0
               	sub	x1, x6, x1
               	cmp	x1, #0x0
               	cset	x1, ne
               	str	x0, [x4]
               	cmp	x0, x0
               	cset	x0, eq
               	cmp	x5, #0x0
               	cset	x4, eq
               	and	x0, x0, x4
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	orr	x0, x1, x0
               	sub	x16, x29, #0x470
               	ldr	x4, [x16]
               	sub	x1, x29, #0x3a0
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0x43               // =67
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xfffd             // =65533
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	sub	x0, x29, #0x3b0
               	str	x3, [x0]
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	str	x4, [x0, #0x8]
               	mov	x6, #0x5                // =5
               	sub	x0, x29, #0x3c0
               	str	x6, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	sub	x14, x29, #0x468
               	asr	x0, x4, #63
               	asr	x1, x2, #63
               	eor	x3, x3, x0
               	eor	x5, x4, x0
               	cmp	x3, x0
               	cset	x7, lo
               	sub	x3, x3, x0
               	sub	x5, x5, x0
               	sub	x5, x5, x7
               	eor	x6, x6, x1
               	eor	x7, x2, x1
               	cmp	x6, x1
               	cset	x8, lo
               	sub	x6, x6, x1
               	sub	x7, x7, x1
               	sub	x7, x7, x8
               	mul	x12, x3, x6
               	mov	w8, w3
               	lsr	x9, x3, #32
               	mov	w10, w6
               	lsr	x11, x6, #32
               	mul	x13, x8, x10
               	lsr	x13, x13, #32
               	mul	x15, x9, x10
               	add	x13, x15, x13
               	mov	w15, w13
               	lsr	x13, x13, #32
               	mul	x20, x8, x11
               	add	x15, x20, x15
               	lsr	x15, x15, #32
               	mul	x20, x9, x11
               	add	x13, x20, x13
               	add	x13, x13, x15
               	mul	x3, x3, x7
               	mul	x15, x5, x6
               	add	x6, x13, x3
               	cmp	x6, x13
               	cset	x13, lo
               	add	x3, x6, x15
               	cmp	x3, x6
               	cset	x15, lo
               	cmp	x5, #0x0
               	cset	x6, ne
               	cmp	x7, #0x0
               	cset	x20, ne
               	and	x20, x6, x20
               	mov	w6, w7
               	lsr	x7, x7, #32
               	mul	x21, x8, x6
               	lsr	x21, x21, #32
               	mul	x6, x9, x6
               	add	x6, x6, x21
               	mov	w21, w6
               	lsr	x6, x6, #32
               	mul	x8, x8, x7
               	add	x8, x8, x21
               	lsr	x8, x8, #32
               	mul	x7, x9, x7
               	add	x6, x7, x6
               	add	x8, x6, x8
               	mov	w6, w5
               	lsr	x5, x5, #32
               	mul	x7, x6, x10
               	lsr	x7, x7, #32
               	mul	x9, x5, x10
               	add	x7, x9, x7
               	mov	w9, w7
               	lsr	x7, x7, #32
               	mul	x6, x6, x11
               	add	x6, x6, x9
               	lsr	x6, x6, #32
               	mul	x5, x5, x11
               	add	x5, x5, x7
               	add	x5, x5, x6
               	cmp	x8, #0x0
               	cset	x6, ne
               	cmp	x5, #0x0
               	cset	x5, ne
               	orr	x6, x20, x6
               	orr	x5, x6, x5
               	orr	x5, x5, x13
               	orr	x6, x5, x15
               	eor	x0, x0, x1
               	eor	x1, x12, x0
               	eor	x5, x3, x0
               	cmp	x1, x0
               	cset	x7, lo
               	sub	x1, x1, x0
               	sub	x5, x5, x0
               	sub	x7, x5, x7
               	mov	x5, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x5, x3
               	cset	x8, lo
               	cmp	x5, x3
               	cset	x9, eq
               	cmp	x12, #0x0
               	cset	x10, hi
               	and	x9, x9, x10
               	orr	x8, x8, x9
               	eor	x9, x12, x2
               	eor	x3, x3, x5
               	orr	x3, x9, x3
               	cmp	x3, #0x0
               	cset	x3, eq
               	add	x0, x0, #0x1
               	and	x0, x3, x0
               	orr	x0, x8, x0
               	orr	x0, x6, x0
               	str	x1, [x14]
               	asr	x3, x1, #63
               	cmp	x1, x1
               	cset	x1, eq
               	cmp	x3, x7
               	cset	x3, eq
               	and	x1, x1, x3
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	sub	x16, x29, #0x468
               	ldr	x3, [x16]
               	sub	x1, x29, #0x3d0
               	str	x3, [x1]
               	asr	x3, x3, #63
               	str	x3, [x1, #0x8]
               	mov	x3, #0xfff1             // =65521
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x46               // =70
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x1                // =1
               	sub	x1, x29, #0x3e0
               	str	x3, [x1]
               	mov	x0, #0x0                // =0
               	str	x0, [x1, #0x8]
               	lsl	x4, x3, #63
               	lsl	x1, x0, #63
               	lsr	x2, x3, #1
               	orr	x1, x1, x2
               	sub	x2, x29, #0x3f0
               	str	x4, [x2]
               	str	x1, [x2, #0x8]
               	sub	x2, x29, #0x400
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	sub	x5, x29, #0x468
               	asr	x6, x1, #63
               	asr	x7, x0, #63
               	add	x2, x4, x0
               	cmp	x2, x4
               	cset	x4, lo
               	add	x0, x1, x0
               	add	x0, x0, x4
               	cmp	x0, x1
               	cset	x8, lo
               	cmp	x0, x1
               	cset	x1, eq
               	and	x1, x1, x4
               	orr	x1, x8, x1
               	add	x4, x6, x7
               	add	x1, x4, x1
               	asr	x4, x0, #63
               	cmp	x1, x4
               	cset	x1, ne
               	str	x2, [x5]
               	asr	x4, x2, #63
               	cmp	x2, x2
               	cset	x2, eq
               	cmp	x4, x0
               	cset	x0, eq
               	and	x0, x2, x0
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	orr	x0, x1, x0
               	sub	x16, x29, #0x468
               	ldr	x2, [x16]
               	sub	x1, x29, #0x410
               	str	x2, [x1]
               	asr	x2, x2, #63
               	str	x2, [x1, #0x8]
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #0x49               // =73
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x460
               	mov	x2, #0x0                // =0
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	mov	x3, #0x0                // =0
               	mov	x5, #0x0                // =0
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	sub	x1, x29, #0x460
               	mov	x0, #0x4c               // =76
               	mov	x3, x2
               	mov	x6, x0
               	mov	x0, x5
               	mov	x5, x4
               	mov	x4, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x3, #0x1                // =1
               	sub	x0, x29, #0x450
               	mov	x1, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x5, #0x0                // =0
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	sub	x1, x29, #0x450
               	mov	x0, #0x4f               // =79
               	mov	x4, x3
               	mov	x6, x0
               	mov	x0, x5
               	mov	x5, x2
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x450
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x4, #0x1                // =1
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	sub	x1, x29, #0x450
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x52               // =82
               	mov	x0, x4
               	mov	x6, x5
               	mov	x5, x3
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
