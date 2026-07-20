
int128_divmod.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x30
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	mov	x4, #0x0                // =0
               	sub	x0, x29, #0x28
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	cmp	x1, x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x5f0
               	stp	x20, x21, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	sub	x0, x29, #0x98
               	str	x1, [x0]
               	mov	x8, #0x0                // =0
               	str	x8, [x0, #0x8]
               	sub	x0, x29, #0xa8
               	str	x8, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21]
               	orr	x2, x8, x0
               	orr	x1, x1, x8
               	sub	x0, x29, #0xb8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0xc8
               	str	x1, [x0]
               	str	x8, [x0, #0x8]
               	lsl	x1, x1, #63
               	sub	x0, x29, #0xd8
               	str	x8, [x0]
               	str	x1, [x0, #0x8]
               	cmp	x8, #0x1
               	cset	x0, lo
               	sub	x2, x8, #0x1
               	sub	x1, x1, #0x0
               	sub	x1, x1, x0
               	sub	x0, x29, #0xe8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x1, [x0, #0x8]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x5, [x20]
               	orr	x0, x1, x8
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x3, x4
               	mov	x4, x0
               	b	<addr>
               	lsr	x6, x1, #63
               	lsl	x7, x4, #1
               	lsl	x0, x0, #1
               	lsr	x4, x4, #63
               	orr	x0, x0, x4
               	orr	x4, x7, x6
               	lsl	x9, x3, #1
               	lsl	x1, x1, #1
               	lsr	x3, x3, #63
               	orr	x1, x1, x3
               	cmp	x0, #0x0
               	cset	x3, lo
               	cmp	x0, #0x0
               	cset	x6, eq
               	cmp	x4, x5
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x3, x3, x6
               	mov	x17, #0x1               // =1
               	eor	x3, x3, x17
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x3
               	and	x7, x5, x6
               	and	x6, x8, x6
               	cmp	x4, x7
               	cset	x10, lo
               	sub	x4, x4, x7
               	sub	x0, x0, x6
               	sub	x0, x0, x10
               	orr	x3, x9, x3
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x0, x1
               	sub	x1, x29, #0x120
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0xcccc             // =52428
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0xcccc, lsl #48
               	mov	x2, #0xcccc             // =52428
               	movk	x2, #0xcccc, lsl #16
               	movk	x2, #0xcccc, lsl #32
               	movk	x2, #0xccc, lsl #48
               	mov	x3, #0x1                // =1
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	ldr	x5, [x20]
               	mov	x8, #0x0                // =0
               	orr	x0, x1, x8
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x6, x1, #63
               	lsl	x7, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x7, x6
               	lsl	x9, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x6, eq
               	cmp	x3, x5
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x4, x4, x6
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x4
               	and	x7, x5, x6
               	and	x6, x8, x6
               	cmp	x3, x7
               	cset	x10, lo
               	sub	x3, x3, x7
               	sub	x0, x0, x6
               	sub	x0, x0, x10
               	orr	x4, x9, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x158
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0x7                // =7
               	mov	x2, #0x0                // =0
               	mov	x3, #0x2                // =2
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x168
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x178
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	x3, x1, #0x3
               	cmp	x3, x1
               	cset	x0, lo
               	add	x1, x2, #0x0
               	add	x1, x1, x0
               	sub	x0, x29, #0x188
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	ldr	x4, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x6, [x0]
               	ldr	x5, [x0, #0x8]
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x3, x4
               	mov	x4, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x4, #1
               	lsl	x0, x0, #1
               	lsr	x4, x4, #63
               	orr	x0, x0, x4
               	orr	x4, x8, x7
               	lsl	x9, x3, #1
               	lsl	x1, x1, #1
               	lsr	x3, x3, #63
               	orr	x1, x1, x3
               	cmp	x0, x5
               	cset	x3, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x4, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x3, x3, x7
               	mov	x17, #0x1               // =1
               	eor	x3, x3, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x3
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x4, x8
               	cset	x10, lo
               	sub	x4, x4, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x10
               	orr	x3, x9, x3
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x0, x1
               	sub	x1, x29, #0x1c0
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0xeefd             // =61181
               	movk	x0, #0xccdd, lsl #16
               	movk	x0, #0xaabb, lsl #32
               	movk	x0, #0x8899, lsl #48
               	mov	x2, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x6, [x0]
               	ldr	x5, [x0, #0x8]
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x9, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x10, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x10
               	orr	x4, x9, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x1f8
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0x9980             // =39296
               	movk	x0, #0xddbb, lsl #16
               	movk	x0, #0x21ff, lsl #32
               	movk	x0, #0x6644, lsl #48
               	mov	x2, #0x0                // =0
               	mov	x3, #0x4                // =4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x21]
               	sub	x0, x29, #0x208
               	str	x4, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x6, [x0]
               	ldr	x5, [x0, #0x8]
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x3, x4
               	mov	x4, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x4, #1
               	lsl	x0, x0, #1
               	lsr	x4, x4, #63
               	orr	x0, x0, x4
               	orr	x4, x8, x7
               	lsl	x9, x3, #1
               	lsl	x1, x1, #1
               	lsr	x3, x3, #63
               	orr	x1, x1, x3
               	cmp	x0, x5
               	cset	x3, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x4, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x3, x3, x7
               	mov	x17, #0x1               // =1
               	eor	x3, x3, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x3
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x4, x8
               	cset	x10, lo
               	sub	x4, x4, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x10
               	orr	x3, x9, x3
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x0, x1
               	sub	x1, x29, #0x240
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x5                // =5
               	mov	x2, x0
               	mov	x4, x3
               	mov	x3, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x21]
               	sub	x0, x29, #0x250
               	str	x3, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x6, [x0]
               	ldr	x5, [x0, #0x8]
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x9, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x10, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x10
               	orr	x4, x9, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x288
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	ldr	x0, [x21]
               	mov	x2, #0x0                // =0
               	mov	x3, #0x6                // =6
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3                // =3
               	sub	x0, x29, #0x298
               	str	x1, [x0]
               	mov	x12, #0x0               // =0
               	str	x12, [x0, #0x8]
               	lsl	x2, x1, #36
               	sub	x0, x29, #0x2a8
               	str	x12, [x0]
               	str	x2, [x0, #0x8]
               	mov	x17, #0x3039            // =12345
               	add	x1, x12, x17
               	cmp	x1, x12
               	cset	x0, lo
               	add	x2, x2, #0x0
               	add	x2, x2, x0
               	sub	x0, x29, #0x2b8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x0, hi
               	sub	x1, x12, x1
               	sub	x2, x12, x2
               	sub	x2, x2, x0
               	sub	x0, x29, #0x2c8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x1, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x48
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x8, x0, #63
               	eor	x1, x1, x8
               	eor	x0, x0, x8
               	cmp	x1, x8
               	cset	x2, lo
               	sub	x3, x1, x8
               	sub	x0, x0, x8
               	sub	x1, x0, x2
               	mov	x7, #0x7                // =7
               	mov	x9, #0x0                // =0
               	orr	x0, x1, x9
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x5, x1, #63
               	lsl	x6, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x6, x5
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x5, eq
               	cmp	x3, #0x7
               	cset	x6, lo
               	and	x5, x5, x6
               	orr	x4, x4, x5
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x5, #0x0                // =0
               	sub	x5, x5, x4
               	and	x6, x7, x5
               	and	x5, x9, x5
               	cmp	x3, x6
               	cset	x11, lo
               	sub	x3, x3, x6
               	sub	x0, x0, x5
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x2, x8, x12
               	eor	x4, x4, x2
               	eor	x1, x1, x2
               	cmp	x4, x2
               	cset	x5, lo
               	sub	x4, x4, x2
               	sub	x1, x1, x2
               	sub	x2, x1, x5
               	sub	x0, x29, #0x300
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x8b66             // =35686
               	movk	x1, #0x4924, lsl #16
               	movk	x1, #0x2492, lsl #32
               	movk	x1, #0x9249, lsl #48
               	mov	x2, #0x4924             // =18724
               	movk	x2, #0x2492, lsl #16
               	movk	x2, #0xfff9, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x7                // =7
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x8, x0, #63
               	eor	x1, x1, x8
               	eor	x0, x0, x8
               	cmp	x1, x8
               	cset	x2, lo
               	sub	x3, x1, x8
               	sub	x0, x0, x8
               	sub	x1, x0, x2
               	mov	x7, #0x7                // =7
               	mov	x9, #0x0                // =0
               	orr	x0, x1, x9
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x5, x1, #63
               	lsl	x6, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x6, x5
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x5, eq
               	cmp	x3, #0x7
               	cset	x6, lo
               	and	x5, x5, x6
               	orr	x4, x4, x5
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x5, #0x0                // =0
               	sub	x5, x5, x4
               	and	x6, x7, x5
               	and	x5, x9, x5
               	cmp	x3, x6
               	cset	x11, lo
               	sub	x3, x3, x6
               	sub	x0, x0, x5
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x1, x3, x8
               	eor	x0, x0, x8
               	cmp	x1, x8
               	cset	x2, lo
               	sub	x1, x1, x8
               	sub	x0, x0, x8
               	sub	x2, x0, x2
               	sub	x0, x29, #0x338
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x8                // =8
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x1, x29, #0x348
               	str	x2, [x1]
               	mov	x0, #0x0                // =0
               	str	x0, [x1, #0x8]
               	lsl	x2, x2, #6
               	sub	x1, x29, #0x358
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	cmp	x0, #0x0
               	cset	x1, hi
               	sub	x3, x0, x0
               	sub	x0, x0, x2
               	sub	x1, x0, x1
               	sub	x0, x29, #0x368
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x58
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x48
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x9, x1, #63
               	asr	x12, x0, #63
               	eor	x2, x2, x9
               	eor	x1, x1, x9
               	cmp	x2, x9
               	cset	x5, lo
               	sub	x3, x2, x9
               	sub	x1, x1, x9
               	sub	x1, x1, x5
               	eor	x2, x4, x12
               	eor	x0, x0, x12
               	cmp	x2, x12
               	cset	x4, lo
               	sub	x6, x2, x12
               	sub	x0, x0, x12
               	sub	x5, x0, x4
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x11, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x2, x9, x12
               	eor	x4, x4, x2
               	eor	x1, x1, x2
               	cmp	x4, x2
               	cset	x5, lo
               	sub	x4, x4, x2
               	sub	x1, x1, x2
               	sub	x2, x1, x5
               	sub	x0, x29, #0x3a0
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xc0000000         // =3221225472
               	mov	x2, #0x0                // =0
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x9, x1, #63
               	asr	x12, x0, #63
               	eor	x2, x2, x9
               	eor	x1, x1, x9
               	cmp	x2, x9
               	cset	x5, lo
               	sub	x3, x2, x9
               	sub	x1, x1, x9
               	sub	x1, x1, x5
               	eor	x2, x4, x12
               	eor	x0, x0, x12
               	cmp	x2, x12
               	cset	x4, lo
               	sub	x6, x2, x12
               	sub	x0, x0, x12
               	sub	x5, x0, x4
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x11, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x1, x3, x9
               	eor	x0, x0, x9
               	cmp	x1, x9
               	cset	x2, lo
               	sub	x1, x1, x9
               	sub	x0, x0, x9
               	sub	x2, x0, x2
               	sub	x0, x29, #0x3d8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xcfc7             // =53191
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0xa                // =10
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	cmp	x1, #0x0
               	cset	x4, hi
               	sub	x2, x0, x1
               	sub	x0, x0, x3
               	sub	x1, x0, x4
               	sub	x0, x29, #0x3e8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x9, x1, #63
               	asr	x12, x0, #63
               	eor	x2, x2, x9
               	eor	x1, x1, x9
               	cmp	x2, x9
               	cset	x5, lo
               	sub	x3, x2, x9
               	sub	x1, x1, x9
               	sub	x1, x1, x5
               	eor	x2, x4, x12
               	eor	x0, x0, x12
               	cmp	x2, x12
               	cset	x4, lo
               	sub	x6, x2, x12
               	sub	x0, x0, x12
               	sub	x5, x0, x4
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x11, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x2, x9, x12
               	eor	x4, x4, x2
               	eor	x1, x1, x2
               	cmp	x4, x2
               	cset	x5, lo
               	sub	x4, x4, x2
               	sub	x1, x1, x2
               	sub	x2, x1, x5
               	sub	x0, x29, #0x420
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x40000000         // =1073741824
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0xb                // =11
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	cmp	x1, #0x0
               	cset	x4, hi
               	sub	x2, x0, x1
               	sub	x0, x0, x3
               	sub	x1, x0, x4
               	sub	x0, x29, #0x430
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x9, x1, #63
               	asr	x12, x0, #63
               	eor	x2, x2, x9
               	eor	x1, x1, x9
               	cmp	x2, x9
               	cset	x5, lo
               	sub	x3, x2, x9
               	sub	x1, x1, x9
               	sub	x1, x1, x5
               	eor	x2, x4, x12
               	eor	x0, x0, x12
               	cmp	x2, x12
               	cset	x4, lo
               	sub	x6, x2, x12
               	sub	x0, x0, x12
               	sub	x5, x0, x4
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x11, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x1, x3, x9
               	eor	x0, x0, x9
               	cmp	x1, x9
               	cset	x2, lo
               	sub	x1, x1, x9
               	sub	x0, x0, x9
               	sub	x2, x0, x2
               	sub	x0, x29, #0x468
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x3039             // =12345
               	mov	x2, #0x0                // =0
               	mov	x3, #0xc                // =12
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x13, [x0]
               	ldr	x14, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x4, [x0]
               	ldr	x1, [x0, #0x8]
               	ldr	x5, [x20]
               	mov	x8, #0x0                // =0
               	orr	x0, x1, x8
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x3, x4
               	mov	x4, x0
               	b	<addr>
               	lsr	x6, x1, #63
               	lsl	x7, x4, #1
               	lsl	x0, x0, #1
               	lsr	x4, x4, #63
               	orr	x0, x0, x4
               	orr	x4, x7, x6
               	lsl	x9, x3, #1
               	lsl	x1, x1, #1
               	lsr	x3, x3, #63
               	orr	x1, x1, x3
               	cmp	x0, #0x0
               	cset	x3, lo
               	cmp	x0, #0x0
               	cset	x6, eq
               	cmp	x4, x5
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x3, x3, x6
               	mov	x17, #0x1               // =1
               	eor	x3, x3, x17
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x3
               	and	x7, x5, x6
               	and	x6, x8, x6
               	cmp	x4, x7
               	cset	x10, lo
               	sub	x4, x4, x7
               	sub	x0, x0, x6
               	sub	x0, x0, x10
               	orr	x3, x9, x3
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x0, x1
               	sub	x1, x29, #0x4a0
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	ldr	x1, [x20]
               	mov	x8, #0x0                // =0
               	mul	x11, x3, x1
               	mov	w2, w3
               	lsr	x4, x3, #32
               	mov	w5, w1
               	lsr	x6, x1, #32
               	mul	x7, x2, x5
               	lsr	x7, x7, #32
               	mul	x5, x4, x5
               	add	x5, x5, x7
               	mov	w7, w5
               	lsr	x5, x5, #32
               	mul	x2, x2, x6
               	add	x2, x2, x7
               	lsr	x2, x2, #32
               	mul	x4, x4, x6
               	add	x4, x4, x5
               	add	x2, x4, x2
               	mul	x3, x3, x8
               	mul	x0, x0, x1
               	add	x1, x2, x3
               	add	x12, x1, x0
               	sub	x0, x29, #0x4b0
               	str	x11, [x0]
               	str	x12, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	ldr	x5, [x20]
               	orr	x0, x1, x8
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x6, x1, #63
               	lsl	x7, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x7, x6
               	lsl	x9, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x6, eq
               	cmp	x3, x5
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x4, x4, x6
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x4
               	and	x7, x5, x6
               	and	x6, x8, x6
               	cmp	x3, x7
               	cset	x10, lo
               	sub	x3, x3, x7
               	sub	x0, x0, x6
               	sub	x0, x0, x10
               	orr	x4, x9, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x4e8
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	add	x1, x11, x3
               	cmp	x1, x11
               	cset	x2, lo
               	add	x0, x12, x0
               	add	x2, x0, x2
               	sub	x0, x29, #0x4f8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	eor	x0, x13, x1
               	eor	x1, x14, x2
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	x15, [x0]
               	ldr	x21, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x9, x1, #63
               	asr	x12, x0, #63
               	eor	x2, x2, x9
               	eor	x1, x1, x9
               	cmp	x2, x9
               	cset	x5, lo
               	sub	x3, x2, x9
               	sub	x1, x1, x9
               	sub	x1, x1, x5
               	eor	x2, x4, x12
               	eor	x0, x0, x12
               	cmp	x2, x12
               	cset	x4, lo
               	sub	x6, x2, x12
               	sub	x0, x0, x12
               	sub	x5, x0, x4
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x11, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x2, x9, x12
               	eor	x4, x4, x2
               	eor	x5, x1, x2
               	cmp	x4, x2
               	cset	x6, lo
               	sub	x1, x4, x2
               	sub	x2, x5, x2
               	sub	x4, x2, x6
               	sub	x0, x29, #0x530
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	sub	x2, x29, #0x58
               	ldr	x0, [x2]
               	ldr	x7, [x2, #0x8]
               	mul	x13, x1, x0
               	mov	w2, w1
               	lsr	x3, x1, #32
               	mov	w5, w0
               	lsr	x6, x0, #32
               	mul	x8, x2, x5
               	lsr	x8, x8, #32
               	mul	x5, x3, x5
               	add	x5, x5, x8
               	mov	w8, w5
               	lsr	x5, x5, #32
               	mul	x2, x2, x6
               	add	x2, x2, x8
               	lsr	x2, x2, #32
               	mul	x3, x3, x6
               	add	x3, x3, x5
               	add	x2, x3, x2
               	mul	x1, x1, x7
               	mul	x0, x4, x0
               	add	x1, x2, x1
               	add	x14, x1, x0
               	sub	x0, x29, #0x540
               	str	x13, [x0]
               	str	x14, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x9, x1, #63
               	asr	x12, x0, #63
               	eor	x2, x2, x9
               	eor	x1, x1, x9
               	cmp	x2, x9
               	cset	x5, lo
               	sub	x3, x2, x9
               	sub	x1, x1, x9
               	sub	x1, x1, x5
               	eor	x2, x4, x12
               	eor	x0, x0, x12
               	cmp	x2, x12
               	cset	x4, lo
               	sub	x6, x2, x12
               	sub	x0, x0, x12
               	sub	x5, x0, x4
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x11, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x1, x3, x9
               	eor	x0, x0, x9
               	cmp	x1, x9
               	cset	x2, lo
               	sub	x1, x1, x9
               	sub	x0, x0, x9
               	sub	x2, x0, x2
               	sub	x0, x29, #0x578
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	x1, x13, x1
               	cmp	x1, x13
               	cset	x0, lo
               	add	x2, x14, x2
               	add	x2, x2, x0
               	sub	x0, x29, #0x588
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	eor	x0, x15, x1
               	eor	x1, x21, x2
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x11, x29, #0x68
               	ldr	x4, [x11]
               	ldr	x1, [x11, #0x8]
               	ldr	x5, [x20]
               	mov	x8, #0x0                // =0
               	orr	x0, x1, x8
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x3, x4
               	mov	x4, x0
               	b	<addr>
               	lsr	x6, x1, #63
               	lsl	x7, x4, #1
               	lsl	x0, x0, #1
               	lsr	x4, x4, #63
               	orr	x0, x0, x4
               	orr	x4, x7, x6
               	lsl	x9, x3, #1
               	lsl	x1, x1, #1
               	lsr	x3, x3, #63
               	orr	x1, x1, x3
               	cmp	x0, #0x0
               	cset	x3, lo
               	cmp	x0, #0x0
               	cset	x6, eq
               	cmp	x4, x5
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x3, x3, x6
               	mov	x17, #0x1               // =1
               	eor	x3, x3, x17
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x3
               	and	x7, x5, x6
               	and	x6, x8, x6
               	cmp	x4, x7
               	cset	x10, lo
               	sub	x4, x4, x7
               	sub	x0, x0, x6
               	sub	x0, x0, x10
               	orr	x3, x9, x3
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x0, x1
               	str	x3, [x11]
               	str	x0, [x11, #0x8]
               	sub	x11, x29, #0x68
               	ldr	x3, [x11]
               	ldr	x1, [x11, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x6, [x0]
               	ldr	x5, [x0, #0x8]
               	orr	x0, x1, x5
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x8, x7
               	lsl	x9, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, x5
               	cset	x4, lo
               	cmp	x0, x5
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x4, x4, x7
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x4
               	and	x8, x6, x7
               	and	x7, x5, x7
               	cmp	x3, x8
               	cset	x10, lo
               	sub	x3, x3, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x10
               	orr	x4, x9, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	str	x3, [x11]
               	str	x0, [x11, #0x8]
               	sub	x0, x29, #0x68
               	mov	x1, #0x5c28             // =23592
               	movk	x1, #0x962c, lsl #16
               	movk	x1, #0x3699, lsl #32
               	movk	x1, #0xbd6d, lsl #48
               	mov	x2, #0x0                // =0
               	mov	x3, #0xf                // =15
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x3, x4, x5
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x5
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x3, x4, x5
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x7
               	udiv	x17, x3, x7
               	msub	x3, x17, x7, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x7
               	udiv	x17, x3, x7
               	msub	x3, x17, x7, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x3, x4, x6
               	udiv	x17, x4, x6
               	msub	x4, x17, x6, x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x3, x4, x6
               	udiv	x17, x4, x6
               	msub	x4, x17, x6, x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x4, x3, x5
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x3, x4, x5
               	udiv	x17, x4, x5
               	msub	x4, x17, x5, x4
               	mov	x0, #0x0                // =0
               	b	<addr>
