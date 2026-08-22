
int128_divmod.aarch64:	file format elf64-littleaarch64

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

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x14, <page>
               	add	x14, x14, <lo12>
               	ldr	x1, [x14]
               	orr	x1, x0, x1
               	orr	x0, x2, x0
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0x7fff, lsl #48
               	adrp	x13, <page>
               	add	x13, x13, <lo12>
               	ldr	x9, [x13]
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x8, x4
               	mov	x7, x3
               	mov	x6, x2
               	b	<addr>
               	lsr	x10, x6, #63
               	lsl	x11, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x11, x10
               	lsl	x11, x7, #1
               	lsl	x6, x6, #1
               	lsr	x7, x7, #63
               	orr	x6, x6, x7
               	cmp	x4, #0x0
               	cset	x7, lo
               	cmp	x4, #0x0
               	cset	x10, eq
               	cmp	x8, x9
               	cset	x12, lo
               	and	x10, x10, x12
               	orr	x7, x7, x10
               	mov	x17, #0x1               // =1
               	eor	x7, x7, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x7
               	and	x10, x9, x10
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x4, x4, #0x0
               	sub	x4, x4, x12
               	orr	x7, x11, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xcccc, lsl #48
               	cmp	x7, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xccc, lsl #48
               	cmp	x6, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x1                // =1
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x7, [x13]
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x4
               	b	<addr>
               	lsr	x8, x2, #63
               	lsl	x9, x6, #1
               	lsl	x4, x4, #1
               	lsr	x6, x6, #63
               	orr	x4, x4, x6
               	orr	x6, x9, x8
               	lsl	x9, x3, #1
               	lsl	x2, x2, #1
               	lsr	x3, x3, #63
               	orr	x2, x2, x3
               	cmp	x4, #0x0
               	cset	x3, lo
               	cmp	x4, #0x0
               	cset	x8, eq
               	cmp	x6, x7
               	cset	x10, lo
               	and	x8, x8, x10
               	orr	x3, x3, x8
               	mov	x17, #0x1               // =1
               	eor	x3, x3, x17
               	mov	x8, #0x0                // =0
               	sub	x8, x8, x3
               	and	x8, x7, x8
               	cmp	x6, x8
               	cset	x10, lo
               	sub	x6, x6, x8
               	sub	x4, x4, #0x0
               	sub	x4, x4, x10
               	orr	x3, x9, x3
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	cmp	x6, #0x7
               	cset	x2, ne
               	cbnz	x2, <addr>
               	cmp	x4, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x2, #0x2                // =2
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x2, #0x3                // =3
               	mov	x3, #0x1                // =1
               	orr	x4, x0, x3
               	cbz	x4, <addr>
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x7, x4
               	mov	x6, x1
               	mov	x8, x0
               	b	<addr>
               	lsr	x9, x8, #63
               	lsl	x10, x7, #1
               	lsl	x4, x4, #1
               	lsr	x7, x7, #63
               	orr	x4, x4, x7
               	orr	x7, x10, x9
               	lsl	x11, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x4, #0x1
               	cset	x6, lo
               	cmp	x4, #0x1
               	cset	x9, eq
               	cmp	x7, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x2, x9
               	and	x9, x3, x9
               	cmp	x7, x10
               	cset	x12, lo
               	sub	x7, x7, x10
               	sub	x4, x4, x9
               	sub	x4, x4, x12
               	orr	x6, x11, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0xeefd            // =61181
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x6, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x8, #0x0
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x3                // =3
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	orr	x4, x0, x3
               	cbz	x4, <addr>
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x4
               	mov	x7, x1
               	mov	x8, x0
               	b	<addr>
               	lsr	x9, x8, #63
               	lsl	x10, x6, #1
               	lsl	x4, x4, #1
               	lsr	x6, x6, #63
               	orr	x4, x4, x6
               	orr	x6, x10, x9
               	lsl	x11, x7, #1
               	lsl	x8, x8, #1
               	lsr	x7, x7, #63
               	orr	x8, x8, x7
               	cmp	x4, #0x1
               	cset	x7, lo
               	cmp	x4, #0x1
               	cset	x9, eq
               	cmp	x6, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x7, x7, x9
               	mov	x17, #0x1               // =1
               	eor	x7, x7, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x7
               	and	x10, x2, x9
               	and	x9, x3, x9
               	cmp	x6, x10
               	cset	x12, lo
               	sub	x6, x6, x10
               	sub	x4, x4, x9
               	sub	x4, x4, x12
               	orr	x7, x11, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0x9980            // =39296
               	movk	x17, #0xddbb, lsl #16
               	movk	x17, #0x21ff, lsl #32
               	movk	x17, #0x6644, lsl #48
               	cmp	x6, x17
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x4, #0x0
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x4, #0x4                // =4
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x5, [x14]
               	mov	x4, #0x0                // =0
               	mov	x6, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x6
               	b	<addr>
               	lsr	x9, x4, #63
               	lsl	x10, x8, #1
               	lsl	x6, x6, #1
               	lsr	x8, x8, #63
               	orr	x6, x6, x8
               	orr	x8, x10, x9
               	lsl	x11, x5, #1
               	lsl	x4, x4, #1
               	lsr	x5, x5, #63
               	orr	x4, x4, x5
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
               	and	x10, x2, x9
               	and	x9, x3, x9
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
               	cmp	x4, #0x0
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x4, #0x5                // =5
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x6, [x14]
               	mov	x5, #0x0                // =0
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x11, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x1
               	cset	x6, lo
               	cmp	x4, #0x1
               	cset	x9, eq
               	cmp	x8, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	and	x10, x2, x9
               	and	x9, x3, x9
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x4, x4, x9
               	sub	x4, x4, x12
               	orr	x6, x11, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	ldr	x5, [x14]
               	cmp	x8, x5
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x4, #0x0
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x4, #0x6                // =6
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x10, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x0
               	cset	x6, lo
               	cmp	x4, #0x0
               	cset	x9, eq
               	cmp	x8, #0x7
               	cset	x11, lo
               	and	x9, x9, x11
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	mov	x17, #0x7               // =7
               	and	x9, x9, x17
               	cmp	x8, x9
               	cset	x11, lo
               	sub	x8, x8, x9
               	sub	x4, x4, #0x0
               	sub	x4, x4, x11
               	orr	x6, x10, x6
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
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0x4924            // =18724
               	movk	x17, #0x2492, lsl #16
               	movk	x17, #0xfff9, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x7, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x7                // =7
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x10, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x0
               	cset	x6, lo
               	cmp	x4, #0x0
               	cset	x9, eq
               	cmp	x8, #0x7
               	cset	x11, lo
               	and	x9, x9, x11
               	orr	x6, x6, x9
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x9, #0x0                // =0
               	sub	x9, x9, x6
               	mov	x17, #0x7               // =7
               	and	x9, x9, x17
               	cmp	x8, x9
               	cset	x11, lo
               	sub	x8, x8, x9
               	sub	x4, x4, #0x0
               	sub	x4, x4, x11
               	orr	x6, x10, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x5, x8
               	mvn	x4, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x4, x4, #0x1
               	sub	x6, x4, x6
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x6, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x8                // =8
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x14, #0x0               // =0
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x9, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x40
               	cset	x6, lo
               	cmp	x4, #0x40
               	cset	x10, eq
               	cmp	x8, #0x0
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x6, x6, x10
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x6
               	mov	x17, #0x40              // =64
               	and	x10, x10, x17
               	cmp	x8, #0x0
               	cset	x11, lo
               	sub	x8, x8, #0x0
               	sub	x4, x4, x10
               	sub	x4, x4, x11
               	orr	x6, x9, x6
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
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x7, #0x0
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0x9                // =9
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x9, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x40
               	cset	x6, lo
               	cmp	x4, #0x40
               	cset	x10, eq
               	cmp	x8, #0x0
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x6, x6, x10
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x6
               	mov	x17, #0x40              // =64
               	and	x10, x10, x17
               	cmp	x8, #0x0
               	cset	x11, lo
               	sub	x8, x8, #0x0
               	sub	x4, x4, x10
               	sub	x4, x4, x11
               	orr	x6, x9, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x5, x8
               	mvn	x4, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x4, x4, #0x1
               	sub	x6, x4, x6
               	mov	x17, #0xcfc7            // =53191
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x6, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0xa                // =10
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x9, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x40
               	cset	x6, lo
               	cmp	x4, #0x40
               	cset	x10, eq
               	cmp	x8, #0x0
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x6, x6, x10
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x6
               	mov	x17, #0x40              // =64
               	and	x10, x10, x17
               	cmp	x8, #0x0
               	cset	x11, lo
               	sub	x8, x8, #0x0
               	sub	x4, x4, x10
               	sub	x4, x4, x11
               	orr	x6, x9, x6
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
               	cset	x4, ne
               	cbnz	x4, <addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x7, x17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0xb                // =11
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x12, #0x0               // =0
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x9, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x40
               	cset	x6, lo
               	cmp	x4, #0x40
               	cset	x10, eq
               	cmp	x8, #0x0
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x6, x6, x10
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x6
               	mov	x17, #0x40              // =64
               	and	x10, x10, x17
               	cmp	x8, #0x0
               	cset	x11, lo
               	sub	x8, x8, #0x0
               	sub	x4, x4, x10
               	sub	x4, x4, x11
               	orr	x6, x9, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	eor	x5, x8, x12
               	eor	x4, x4, x12
               	cmp	x5, #0x0
               	cset	x6, lo
               	sub	x5, x5, #0x0
               	sub	x4, x4, #0x0
               	sub	x6, x4, x6
               	mov	x17, #0x3039            // =12345
               	cmp	x5, x17
               	cset	x4, ne
               	cbnz	x4, <addr>
               	cmp	x6, #0x0
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x4, #0xc                // =12
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x9, [x13]
               	mov	x17, #0x0               // =0
               	orr	x4, x0, x17
               	cbz	x4, <addr>
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x7, x4
               	mov	x6, x1
               	mov	x8, x0
               	b	<addr>
               	lsr	x10, x8, #63
               	lsl	x11, x7, #1
               	lsl	x4, x4, #1
               	lsr	x7, x7, #63
               	orr	x4, x4, x7
               	orr	x7, x11, x10
               	lsl	x11, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x4, #0x0
               	cset	x6, lo
               	cmp	x4, #0x0
               	cset	x10, eq
               	cmp	x7, x9
               	cset	x12, lo
               	and	x10, x10, x12
               	orr	x6, x6, x10
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x6
               	and	x10, x9, x10
               	cmp	x7, x10
               	cset	x12, lo
               	sub	x7, x7, x10
               	sub	x4, x4, #0x0
               	sub	x4, x4, x12
               	orr	x6, x11, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	ldr	x4, [x13]
               	mov	x5, #0x0                // =0
               	mul	x15, x6, x4
               	mov	w7, w6
               	lsr	x9, x6, #32
               	mov	w10, w4
               	lsr	x11, x4, #32
               	mul	x12, x7, x10
               	lsr	x12, x12, #32
               	mul	x10, x9, x10
               	add	x10, x10, x12
               	mov	w12, w10
               	lsr	x10, x10, #32
               	mul	x7, x7, x11
               	add	x7, x7, x12
               	lsr	x7, x7, #32
               	mul	x9, x9, x11
               	add	x9, x9, x10
               	add	x7, x9, x7
               	mul	x6, x6, x5
               	mul	x4, x8, x4
               	add	x6, x7, x6
               	add	x20, x6, x4
               	ldr	x9, [x13]
               	orr	x4, x0, x5
               	cbz	x4, <addr>
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x4
               	mov	x7, x1
               	mov	x8, x0
               	b	<addr>
               	lsr	x10, x8, #63
               	lsl	x11, x6, #1
               	lsl	x4, x4, #1
               	lsr	x6, x6, #63
               	orr	x4, x4, x6
               	orr	x6, x11, x10
               	lsl	x11, x7, #1
               	lsl	x8, x8, #1
               	lsr	x7, x7, #63
               	orr	x8, x8, x7
               	cmp	x4, #0x0
               	cset	x7, lo
               	cmp	x4, #0x0
               	cset	x10, eq
               	cmp	x6, x9
               	cset	x12, lo
               	and	x10, x10, x12
               	orr	x7, x7, x10
               	mov	x17, #0x1               // =1
               	eor	x7, x7, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x7
               	and	x10, x9, x10
               	cmp	x6, x10
               	cset	x12, lo
               	sub	x6, x6, x10
               	sub	x4, x4, #0x0
               	sub	x4, x4, x12
               	orr	x7, x11, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	add	x5, x15, x6
               	cmp	x5, x15
               	cset	x6, lo
               	add	x4, x20, x4
               	add	x4, x4, x6
               	eor	x5, x1, x5
               	eor	x4, x0, x4
               	orr	x4, x5, x4
               	cmp	x4, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x9, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x40
               	cset	x6, lo
               	cmp	x4, #0x40
               	cset	x10, eq
               	cmp	x8, #0x0
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x6, x6, x10
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x6
               	mov	x17, #0x40              // =64
               	and	x10, x10, x17
               	cmp	x8, #0x0
               	cset	x11, lo
               	sub	x8, x8, #0x0
               	sub	x4, x4, x10
               	sub	x4, x4, x11
               	orr	x6, x9, x6
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
               	mul	x12, x5, x14
               	mov	w4, w5
               	lsr	x6, x5, #32
               	mov	x7, #0x0                // =0
               	mov	x8, #0x0                // =0
               	mul	x10, x4, x7
               	lsr	x10, x10, #32
               	mul	x7, x6, x7
               	add	x7, x7, x10
               	mov	w10, w7
               	lsr	x7, x7, #32
               	mul	x4, x4, x8
               	add	x4, x4, x10
               	lsr	x4, x4, #32
               	mul	x6, x6, x8
               	add	x6, x6, x7
               	add	x4, x6, x4
               	mov	x17, #0xffc0            // =65472
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x5, x5, x17
               	mul	x6, x9, x14
               	add	x4, x4, x5
               	add	x14, x4, x6
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x8, x4
               	b	<addr>
               	lsr	x9, x5, #63
               	lsl	x10, x8, #1
               	lsl	x4, x4, #1
               	lsr	x8, x8, #63
               	orr	x4, x4, x8
               	orr	x8, x10, x9
               	lsl	x9, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x4, #0x40
               	cset	x6, lo
               	cmp	x4, #0x40
               	cset	x10, eq
               	cmp	x8, #0x0
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x6, x6, x10
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x10, #0x0               // =0
               	sub	x10, x10, x6
               	mov	x17, #0x40              // =64
               	and	x10, x10, x17
               	cmp	x8, #0x0
               	cset	x11, lo
               	sub	x8, x8, #0x0
               	sub	x4, x4, x10
               	sub	x4, x4, x11
               	orr	x6, x9, x6
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x5, x8
               	mvn	x4, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x5, x17
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x4, x4, #0x1
               	sub	x6, x4, x6
               	add	x4, x12, x5
               	cmp	x4, x12
               	cset	x5, lo
               	add	x6, x14, x6
               	add	x5, x6, x5
               	mov	x17, #0xcfc7            // =53191
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x4, x4, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffcf, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x5, x5, x17
               	orr	x4, x4, x5
               	cmp	x4, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x7, [x13]
               	mov	x17, #0x0               // =0
               	orr	x4, x0, x17
               	cbz	x4, <addr>
               	mov	x5, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x4, x1
               	mov	x1, x5
               	b	<addr>
               	lsr	x8, x0, #63
               	lsl	x9, x1, #1
               	lsl	x5, x5, #1
               	lsr	x1, x1, #63
               	orr	x5, x5, x1
               	orr	x1, x9, x8
               	lsl	x9, x4, #1
               	lsl	x0, x0, #1
               	lsr	x4, x4, #63
               	orr	x0, x0, x4
               	cmp	x5, #0x0
               	cset	x4, lo
               	cmp	x5, #0x0
               	cset	x8, eq
               	cmp	x1, x7
               	cset	x10, lo
               	and	x8, x8, x10
               	orr	x4, x4, x8
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x8, #0x0                // =0
               	sub	x8, x8, x4
               	and	x8, x7, x8
               	cmp	x1, x8
               	cset	x10, lo
               	sub	x1, x1, x8
               	sub	x5, x5, #0x0
               	sub	x5, x5, x10
               	orr	x4, x9, x4
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	orr	x1, x0, x3
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x4
               	mov	x4, x1
               	b	<addr>
               	lsr	x7, x0, #63
               	lsl	x8, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	orr	x4, x8, x7
               	lsl	x9, x6, #1
               	lsl	x0, x0, #1
               	lsr	x6, x6, #63
               	orr	x0, x0, x6
               	cmp	x1, #0x1
               	cset	x6, lo
               	cmp	x1, #0x1
               	cset	x7, eq
               	cmp	x4, #0x3
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x6, x6, x7
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	mov	x7, #0x0                // =0
               	sub	x7, x7, x6
               	and	x8, x2, x7
               	and	x7, x3, x7
               	cmp	x4, x8
               	cset	x10, lo
               	sub	x4, x4, x8
               	sub	x1, x1, x7
               	sub	x1, x1, x10
               	orr	x6, x9, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0x5c28            // =23592
               	movk	x17, #0x962c, lsl #16
               	movk	x17, #0x3699, lsl #32
               	movk	x17, #0xbd6d, lsl #48
               	cmp	x4, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	udiv	x6, x4, x2
               	udiv	x17, x4, x2
               	msub	x4, x17, x2, x4
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	udiv	x4, x1, x7
               	udiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	b	<addr>
               	udiv	x7, x1, x9
               	udiv	x17, x1, x9
               	msub	x6, x17, x9, x1
               	mov	x4, #0x0                // =0
               	mov	x8, x4
               	b	<addr>
               	udiv	x6, x1, x9
               	udiv	x17, x1, x9
               	msub	x7, x17, x9, x1
               	mov	x4, #0x0                // =0
               	mov	x8, x4
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	udiv	x7, x1, x2
               	udiv	x17, x1, x2
               	msub	x6, x17, x2, x1
               	mov	x4, #0x0                // =0
               	mov	x8, x4
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	udiv	x6, x1, x2
               	udiv	x17, x1, x2
               	msub	x7, x17, x2, x1
               	mov	x4, #0x0                // =0
               	mov	x8, x4
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	b	<addr>
