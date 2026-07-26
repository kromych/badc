
int128_divmod.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	sub	sp, sp, #0x60
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffffff0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x12, #0x0               // =0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	orr	x2, x12, x0
               	orr	x0, x1, x12
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0x7fff, lsl #48
               	adrp	x15, <page>
               	add	x15, x15, <lo12>
               	ldr	x9, [x15]
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x8, x4
               	mov	x7, x3
               	mov	x6, x1
               	b	<addr>
               	lsr	x10, x6, #63
               	lsl	x11, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x11, x10
               	lsl	x13, x7, #1
               	lsl	x6, x6, #1
               	lsr	x7, x7, #63
               	orr	x6, x6, x7
               	cmp	x4, #0x0
               	cset	x7, lo
               	cmp	x4, #0x0
               	cset	x10, eq
               	cmp	x8, x9
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x7, x7, x10
               	mov	x17, #0x1               // =1
               	eor	x7, x7, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x7
               	and	x11, x9, x10
               	and	x10, x12, x10
               	cmp	x8, x11
               	cset	x14, lo
               	sub	x8, x8, x11
               	sub	x4, x4, x10
               	sub	x4, x4, x14
               	orr	x7, x13, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xcccc, lsl #48
               	cmp	x7, x17
               	cset	x5, ne
               	cbnz	x5, <addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xccc, lsl #48
               	cmp	x6, x17
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x4, #0x1                // =1
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x7, [x15]
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x4
               	b	<addr>
               	lsr	x8, x1, #63
               	lsl	x9, x6, #1
               	lsl	x4, x4, #1
               	lsr	x6, x6, #63
               	orr	x4, x4, x6
               	orr	x6, x9, x8
               	lsl	x10, x3, #1
               	lsl	x1, x1, #1
               	lsr	x3, x3, #63
               	orr	x1, x1, x3
               	cmp	x4, #0x0
               	cset	x3, lo
               	cmp	x4, #0x0
               	cset	x8, eq
               	cmp	x6, x7
               	cset	x9, lo
               	and	x8, x8, x9
               	orr	x3, x3, x8
               	mov	x17, #0x1               // =1
               	eor	x3, x3, x17
               	mov	x8, #0x0                // =0
               	sub	x8, x8, x3
               	and	x9, x7, x8
               	mov	x17, #0x0               // =0
               	and	x8, x8, x17
               	cmp	x6, x9
               	cset	x11, lo
               	sub	x6, x6, x9
               	sub	x4, x4, x8
               	sub	x4, x4, x11
               	orr	x3, x10, x3
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	cmp	x6, #0x7
               	cset	x3, ne
               	cbnz	x3, <addr>
               	cmp	x4, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x1, #0x2                // =2
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3                // =3
               	mov	x4, #0x1                // =1
               	orr	x1, x0, x4
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x7, x1
               	mov	x6, x2
               	mov	x8, x0
               	b	<addr>
               	lsr	x9, x8, #63
               	lsl	x10, x7, #1
               	lsl	x1, x1, #1
               	lsr	x7, x7, #63
               	orr	x1, x1, x7
               	orr	x7, x10, x9
               	lsl	x11, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x1, #0x1
               	cset	x6, lo
               	cmp	x1, #0x1
               	cset	x9, eq
               	cmp	x7, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x3, x9
               	and	x9, x4, x9
               	cmp	x7, x10
               	cset	x12, lo
               	sub	x7, x7, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x12
               	orr	x6, x11, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x1, x8
               	mov	x17, #0xeefd            // =61181
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x6, x17
               	cset	x6, ne
               	cbnz	x6, <addr>
               	cmp	x1, #0x0
               	cset	x6, ne
               	cbz	x6, <addr>
               	mov	x1, #0x3                // =3
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x1, x0, x4
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x1
               	mov	x7, x2
               	mov	x8, x0
               	b	<addr>
               	lsr	x9, x8, #63
               	lsl	x10, x6, #1
               	lsl	x1, x1, #1
               	lsr	x6, x6, #63
               	orr	x1, x1, x6
               	orr	x6, x10, x9
               	lsl	x11, x7, #1
               	lsl	x8, x8, #1
               	lsr	x7, x7, #63
               	orr	x8, x8, x7
               	cmp	x1, #0x1
               	cset	x7, lo
               	cmp	x1, #0x1
               	cset	x9, eq
               	cmp	x6, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x7, x7, x9
               	mov	x17, #0x1               // =1
               	eor	x7, x7, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x7
               	and	x10, x3, x9
               	and	x9, x4, x9
               	cmp	x6, x10
               	cset	x12, lo
               	sub	x6, x6, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x12
               	orr	x7, x11, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0x9980            // =39296
               	movk	x17, #0xddbb, lsl #16
               	movk	x17, #0x21ff, lsl #32
               	movk	x17, #0x6644, lsl #48
               	cmp	x6, x17
               	cset	x6, ne
               	cbnz	x6, <addr>
               	cmp	x1, #0x0
               	cset	x6, ne
               	cbz	x6, <addr>
               	mov	x1, #0x4                // =4
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x5, [x20]
               	mov	x1, #0x0                // =0
               	mov	x6, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x6
               	b	<addr>
               	lsr	x9, x1, #63
               	lsl	x10, x8, #1
               	lsl	x6, x6, #1
               	lsr	x8, x8, #63
               	orr	x6, x6, x8
               	orr	x8, x10, x9
               	lsl	x11, x5, #1
               	lsl	x1, x1, #1
               	lsr	x5, x5, #63
               	orr	x1, x1, x5
               	cmp	x6, #0x1
               	cset	x5, lo
               	cmp	x6, #0x1
               	cset	x9, eq
               	cmp	x8, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x5, x5, x9
               	mov	x17, #0x1               // =1
               	eor	x5, x5, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x5
               	and	x10, x3, x9
               	and	x9, x4, x9
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x6, x6, x9
               	sub	x6, x6, x12
               	orr	x5, x11, x5
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	cmp	x5, #0x0
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x1, #0x0
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x1, #0x5                // =5
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x6, [x20]
               	mov	x5, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x11, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x1
               	cset	x6, lo
               	cmp	x1, #0x1
               	cset	x9, eq
               	cmp	x8, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x3, x9
               	and	x9, x4, x9
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x12
               	orr	x6, x11, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	ldr	x6, [x20]
               	cmp	x8, x6
               	cset	x6, ne
               	cbnz	x6, <addr>
               	cmp	x1, #0x0
               	cset	x6, ne
               	cbz	x6, <addr>
               	mov	x1, #0x6                // =6
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x11, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x0
               	cset	x6, lo
               	cmp	x1, #0x0
               	cset	x9, eq
               	cmp	x8, #0x7
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	mov	x17, #0x7               // =7
               	and	x10, x9, x17
               	mov	x17, #0x0               // =0
               	and	x9, x9, x17
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x12
               	orr	x6, x11, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x6, x6
               	mvn	x5, x5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x6, x17
               	cset	x7, lo
               	add	x6, x6, #0x1
               	add	x5, x5, #0x1
               	sub	x7, x5, x7
               	mov	x17, #0x8b66            // =35686
               	movk	x17, #0x4924, lsl #16
               	movk	x17, #0x2492, lsl #32
               	movk	x17, #0x9249, lsl #48
               	cmp	x6, x17
               	cset	x5, ne
               	cbnz	x5, <addr>
               	mov	x17, #0x4924            // =18724
               	movk	x17, #0x2492, lsl #16
               	movk	x17, #0xfff9, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x7, x17
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x1, #0x7                // =7
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x11, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x0
               	cset	x6, lo
               	cmp	x1, #0x0
               	cset	x9, eq
               	cmp	x8, #0x7
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	mov	x17, #0x7               // =7
               	and	x10, x9, x17
               	mov	x17, #0x0               // =0
               	and	x9, x9, x17
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x12
               	orr	x6, x11, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x5, x8
               	mvn	x1, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x1, x1, #0x1
               	sub	x6, x1, x6
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x5, ne
               	cbnz	x5, <addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x6, x17
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x1, #0x8                // =8
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x11, #0x0               // =0
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x40
               	cset	x6, lo
               	cmp	x1, #0x40
               	cset	x9, eq
               	cmp	x8, #0x0
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x11, x9
               	mov	x17, #0x40              // =64
               	and	x9, x9, x17
               	cmp	x8, x10
               	cset	x13, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x13
               	orr	x6, x12, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mov	x7, #0x0                // =0
               	eor	x6, x6, x7
               	eor	x5, x5, x7
               	cmp	x6, #0x0
               	cset	x7, lo
               	sub	x6, x6, #0x0
               	sub	x5, x5, #0x0
               	sub	x7, x5, x7
               	mov	x17, #0xc0000000        // =3221225472
               	cmp	x6, x17
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x7, #0x0
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x1, #0x9                // =9
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x11, #0x0               // =0
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x40
               	cset	x6, lo
               	cmp	x1, #0x40
               	cset	x9, eq
               	cmp	x8, #0x0
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x11, x9
               	mov	x17, #0x40              // =64
               	and	x9, x9, x17
               	cmp	x8, x10
               	cset	x13, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x13
               	orr	x6, x12, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x5, x8
               	mvn	x1, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x1, x1, #0x1
               	sub	x6, x1, x6
               	mov	x17, #0xcfc7            // =53191
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x5, ne
               	cbnz	x5, <addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x6, x17
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x1, #0xa                // =10
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x11, #0x0               // =0
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x40
               	cset	x6, lo
               	cmp	x1, #0x40
               	cset	x9, eq
               	cmp	x8, #0x0
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x11, x9
               	mov	x17, #0x40              // =64
               	and	x9, x9, x17
               	cmp	x8, x10
               	cset	x13, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x13
               	orr	x6, x12, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x6, x6
               	mvn	x5, x5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x6, x17
               	cset	x7, lo
               	add	x6, x6, #0x1
               	add	x5, x5, #0x1
               	sub	x7, x5, x7
               	mov	x17, #0x40000000        // =1073741824
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x6, x17
               	cset	x5, ne
               	cbnz	x5, <addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x7, x17
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x1, #0xb                // =11
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x11, #0x0               // =0
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x40
               	cset	x6, lo
               	cmp	x1, #0x40
               	cset	x9, eq
               	cmp	x8, #0x0
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x11, x9
               	mov	x17, #0x40              // =64
               	and	x9, x9, x17
               	cmp	x8, x10
               	cset	x13, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x13
               	orr	x6, x12, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	eor	x5, x8, x14
               	eor	x1, x1, x14
               	cmp	x5, #0x0
               	cset	x6, lo
               	sub	x5, x5, #0x0
               	sub	x1, x1, #0x0
               	sub	x6, x1, x6
               	mov	x17, #0x3039            // =12345
               	cmp	x5, x17
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x6, #0x0
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x1, #0xc                // =12
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x9, [x15]
               	mov	x12, #0x0               // =0
               	orr	x1, x0, x12
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x7, x1
               	mov	x6, x2
               	mov	x8, x0
               	b	<addr>
               	lsr	x10, x8, #63
               	lsl	x11, x7, #1
               	lsl	x1, x1, #1
               	lsr	x7, x7, #63
               	orr	x1, x1, x7
               	orr	x7, x11, x10
               	lsl	x13, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x1, #0x0
               	cset	x6, lo
               	cmp	x1, #0x0
               	cset	x10, eq
               	cmp	x7, x9
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x6, x6, x10
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x6
               	and	x11, x9, x10
               	and	x10, x12, x10
               	cmp	x7, x11
               	cset	x14, lo
               	sub	x7, x7, x11
               	sub	x1, x1, x10
               	sub	x1, x1, x14
               	orr	x6, x13, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x1, x8
               	ldr	x5, [x15]
               	mov	x12, #0x0               // =0
               	mul	x21, x6, x5
               	mov	w7, w6
               	lsr	x8, x6, #32
               	mov	w9, w5
               	lsr	x10, x5, #32
               	mul	x11, x7, x9
               	lsr	x11, x11, #32
               	mul	x9, x8, x9
               	add	x9, x9, x11
               	mov	w11, w9
               	lsr	x9, x9, #32
               	mul	x7, x7, x10
               	add	x7, x7, x11
               	lsr	x7, x7, #32
               	mul	x8, x8, x10
               	add	x8, x8, x9
               	add	x7, x8, x7
               	mul	x6, x6, x12
               	mul	x1, x1, x5
               	add	x5, x7, x6
               	add	x22, x5, x1
               	ldr	x9, [x15]
               	orr	x1, x0, x12
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x1
               	mov	x7, x2
               	mov	x8, x0
               	b	<addr>
               	lsr	x10, x8, #63
               	lsl	x11, x6, #1
               	lsl	x1, x1, #1
               	lsr	x6, x6, #63
               	orr	x1, x1, x6
               	orr	x6, x11, x10
               	lsl	x13, x7, #1
               	lsl	x8, x8, #1
               	lsr	x7, x7, #63
               	orr	x8, x8, x7
               	cmp	x1, #0x0
               	cset	x7, lo
               	cmp	x1, #0x0
               	cset	x10, eq
               	cmp	x6, x9
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x7, x7, x10
               	mov	x17, #0x1               // =1
               	eor	x7, x7, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x7
               	and	x11, x9, x10
               	and	x10, x12, x10
               	cmp	x6, x11
               	cset	x14, lo
               	sub	x6, x6, x11
               	sub	x1, x1, x10
               	sub	x1, x1, x14
               	orr	x7, x13, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	add	x5, x21, x6
               	cmp	x5, x21
               	cset	x6, lo
               	add	x1, x22, x1
               	add	x6, x1, x6
               	eor	x1, x2, x5
               	eor	x5, x0, x6
               	orr	x1, x1, x5
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x11, #0x0               // =0
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x40
               	cset	x6, lo
               	cmp	x1, #0x40
               	cset	x9, eq
               	cmp	x8, #0x0
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x11, x9
               	mov	x17, #0x40              // =64
               	and	x9, x9, x17
               	cmp	x8, x10
               	cset	x13, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x13
               	orr	x6, x12, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mov	x7, #0x0                // =0
               	eor	x6, x6, x7
               	eor	x7, x5, x7
               	cmp	x6, #0x0
               	cset	x9, lo
               	sub	x5, x6, #0x0
               	sub	x6, x7, #0x0
               	sub	x9, x6, x9
               	mul	x14, x5, x20
               	mov	w1, w5
               	lsr	x6, x5, #32
               	mov	x7, #0x0                // =0
               	mov	x8, #0x0                // =0
               	mul	x10, x1, x7
               	lsr	x10, x10, #32
               	mul	x7, x6, x7
               	add	x7, x7, x10
               	mov	w10, w7
               	lsr	x7, x7, #32
               	mul	x1, x1, x8
               	add	x1, x1, x10
               	lsr	x1, x1, #32
               	mul	x6, x6, x8
               	add	x6, x6, x7
               	add	x1, x6, x1
               	mov	x17, #0xffc0            // =65472
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x5, x5, x17
               	mul	x6, x9, x20
               	add	x1, x1, x5
               	add	x20, x1, x6
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x11, #0x0               // =0
               	mov	x1, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x1
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x1, x1, #1
               	lsr	x8, x8, #63
               	orr	x1, x1, x8
               	orr	x8, x10, x9
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x1, #0x40
               	cset	x6, lo
               	cmp	x1, #0x40
               	cset	x9, eq
               	cmp	x8, #0x0
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x11, x9
               	mov	x17, #0x40              // =64
               	and	x9, x9, x17
               	cmp	x8, x10
               	cset	x13, lo
               	sub	x8, x8, x10
               	sub	x1, x1, x9
               	sub	x1, x1, x13
               	orr	x6, x12, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x5, x8
               	mvn	x1, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x1, x1, #0x1
               	sub	x6, x1, x6
               	add	x5, x14, x5
               	cmp	x5, x14
               	cset	x1, lo
               	add	x6, x20, x6
               	add	x6, x6, x1
               	mov	x17, #0xcfc7            // =53191
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x1, x5, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffcf, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x5, x6, x17
               	orr	x1, x1, x5
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x7, [x15]
               	mov	x10, #0x0               // =0
               	orr	x1, x0, x10
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x5, x2
               	mov	x2, x1
               	b	<addr>
               	lsr	x8, x0, #63
               	lsl	x9, x2, #1
               	lsl	x1, x1, #1
               	lsr	x2, x2, #63
               	orr	x1, x1, x2
               	orr	x2, x9, x8
               	lsl	x11, x5, #1
               	lsl	x0, x0, #1
               	lsr	x5, x5, #63
               	orr	x0, x0, x5
               	cmp	x1, #0x0
               	cset	x5, lo
               	cmp	x1, #0x0
               	cset	x8, eq
               	cmp	x2, x7
               	cset	x9, lo
               	and	x8, x8, x9
               	orr	x5, x5, x8
               	mov	x17, #0x1               // =1
               	eor	x5, x5, x17
               	mov	x8, #0x0                // =0
               	sub	x8, x8, x5
               	and	x9, x7, x8
               	and	x8, x10, x8
               	cmp	x2, x9
               	cset	x12, lo
               	sub	x2, x2, x9
               	sub	x1, x1, x8
               	sub	x1, x1, x12
               	orr	x5, x11, x5
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	mov	x1, x0
               	orr	x0, x1, x4
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x6, x5
               	mov	x5, x0
               	b	<addr>
               	lsr	x7, x1, #63
               	lsl	x8, x5, #1
               	lsl	x0, x0, #1
               	lsr	x5, x5, #63
               	orr	x0, x0, x5
               	orr	x5, x8, x7
               	lsl	x9, x6, #1
               	lsl	x1, x1, #1
               	lsr	x6, x6, #63
               	orr	x1, x1, x6
               	cmp	x0, #0x1
               	cset	x6, lo
               	cmp	x0, #0x1
               	cset	x7, eq
               	cmp	x5, #0x3
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x6, x6, x7
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x6
               	and	x8, x3, x7
               	and	x7, x4, x7
               	cmp	x5, x8
               	cset	x10, lo
               	sub	x5, x5, x8
               	sub	x0, x0, x7
               	sub	x0, x0, x10
               	orr	x6, x9, x6
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x17, #0x5c28            // =23592
               	movk	x17, #0x962c, lsl #16
               	movk	x17, #0x3699, lsl #32
               	movk	x17, #0xbd6d, lsl #48
               	cmp	x5, x17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xf                // =15
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x20
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	udiv	x6, x5, x3
               	udiv	x17, x5, x3
               	msub	x5, x17, x3, x5
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x5, x2, x7
               	udiv	x17, x2, x7
               	msub	x2, x17, x7, x2
               	mov	x1, #0x0                // =0
               	b	<addr>
               	udiv	x7, x2, x9
               	udiv	x17, x2, x9
               	msub	x6, x17, x9, x2
               	mov	x1, #0x0                // =0
               	mov	x8, x1
               	b	<addr>
               	udiv	x6, x2, x9
               	udiv	x17, x2, x9
               	msub	x7, x17, x9, x2
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	udiv	x7, x2, x3
               	udiv	x17, x2, x3
               	msub	x6, x17, x3, x2
               	mov	x1, #0x0                // =0
               	mov	x8, x1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	udiv	x6, x2, x3
               	udiv	x17, x2, x3
               	msub	x7, x17, x3, x2
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
