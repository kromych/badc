
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	orr	x2, x0, x2
               	mov	x4, #-0x1               // =-1
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x9, [x5]
               	mov	x5, #0x80               // =128
               	mov	x8, x0
               	mov	x7, x4
               	mov	x6, x3
               	lsr	x10, x6, #63
               	lsl	x11, x8, #1
               	lsl	x0, x0, #1
               	lsr	x8, x8, #63
               	orr	x0, x0, x8
               	orr	x8, x11, x10
               	lsl	x11, x7, #1
               	lsl	x6, x6, #1
               	lsr	x7, x7, #63
               	orr	x6, x6, x7
               	cmp	x0, #0x0
               	cset	x7, lo
               	cmp	x0, #0x0
               	cset	x10, eq
               	cmp	x8, x9
               	cset	x12, lo
               	and	x10, x10, x12
               	orr	x7, x7, x10
               	eor	x7, x7, #0x1
               	neg	x10, x7
               	and	x10, x9, x10
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x0, x0, x12
               	orr	x7, x11, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #-0x3333333333333334 // =-3689348814741910324
               	cmp	x7, x17
               	b.ne	<addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xccc, lsl #48
               	cmp	x6, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x7, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x0
               	lsr	x8, x3, #63
               	lsl	x9, x6, #1
               	lsl	x0, x0, #1
               	lsr	x6, x6, #63
               	orr	x0, x0, x6
               	orr	x6, x9, x8
               	lsl	x9, x4, #1
               	lsl	x3, x3, #1
               	lsr	x4, x4, #63
               	orr	x3, x3, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x8, eq
               	cmp	x6, x7
               	cset	x10, lo
               	and	x8, x8, x10
               	orr	x4, x4, x8
               	eor	x4, x4, #0x1
               	neg	x8, x4
               	and	x8, x7, x8
               	cmp	x6, x8
               	cset	x10, lo
               	sub	x6, x6, x8
               	sub	x0, x0, x10
               	orr	x4, x9, x4
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	cmp	x6, #0x7
               	b.ne	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbz	x0, <addr>
               	ret
               	mov	x3, #0x3                // =3
               	mov	x4, #0x1                // =1
               	orr	x0, x1, x4
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x7, x0
               	mov	x6, x2
               	mov	x8, x1
               	lsr	x9, x8, #63
               	lsl	x10, x7, #1
               	lsl	x0, x0, #1
               	lsr	x7, x7, #63
               	orr	x0, x0, x7
               	orr	x7, x10, x9
               	lsl	x11, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x0, #0x1
               	cset	x6, lo
               	cmp	x0, #0x1
               	cset	x9, eq
               	cmp	x7, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	eor	x6, x6, #0x1
               	neg	x9, x6
               	and	x10, x3, x9
               	and	x9, x4, x9
               	cmp	x7, x10
               	cset	x12, lo
               	sub	x7, x7, x10
               	sub	x0, x0, x9
               	sub	x0, x0, x12
               	orr	x6, x11, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0xeefd            // =61181
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	cbz	x8, <addr>
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	ret
               	orr	x0, x1, x4
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x0
               	mov	x7, x2
               	mov	x8, x1
               	lsr	x9, x8, #63
               	lsl	x10, x6, #1
               	lsl	x0, x0, #1
               	lsr	x6, x6, #63
               	orr	x0, x0, x6
               	orr	x6, x10, x9
               	lsl	x11, x7, #1
               	lsl	x8, x8, #1
               	lsr	x7, x7, #63
               	orr	x8, x8, x7
               	cmp	x0, #0x1
               	cset	x7, lo
               	cmp	x0, #0x1
               	cset	x9, eq
               	cmp	x6, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x7, x7, x9
               	eor	x7, x7, #0x1
               	neg	x9, x7
               	and	x10, x3, x9
               	and	x9, x4, x9
               	cmp	x6, x10
               	cset	x12, lo
               	sub	x6, x6, x10
               	sub	x0, x0, x9
               	sub	x0, x0, x12
               	orr	x7, x11, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0x9980            // =39296
               	movk	x17, #0xddbb, lsl #16
               	movk	x17, #0x21ff, lsl #32
               	movk	x17, #0x6644, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x5, [x0]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x8, x0
               	mov	x7, x0
               	lsr	x9, x7, #63
               	lsl	x10, x8, #1
               	lsl	x0, x0, #1
               	lsr	x8, x8, #63
               	orr	x0, x0, x8
               	orr	x8, x10, x9
               	lsl	x11, x5, #1
               	lsl	x7, x7, #1
               	lsr	x5, x5, #63
               	orr	x7, x7, x5
               	cmp	x0, #0x1
               	cset	x5, lo
               	cmp	x0, #0x1
               	cset	x9, eq
               	cmp	x8, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x5, x5, x9
               	eor	x5, x5, #0x1
               	neg	x9, x5
               	and	x10, x3, x9
               	and	x9, x4, x9
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x0, x0, x9
               	sub	x0, x0, x12
               	orr	x5, x11, x5
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	cbnz	x5, <addr>
               	cbz	x7, <addr>
               	mov	x0, #0x5                // =5
               	cbz	x0, <addr>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x6, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x7, x0
               	mov	x8, x0
               	lsr	x9, x8, #63
               	lsl	x10, x7, #1
               	lsl	x0, x0, #1
               	lsr	x7, x7, #63
               	orr	x0, x0, x7
               	orr	x7, x10, x9
               	lsl	x11, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x0, #0x1
               	cset	x6, lo
               	cmp	x0, #0x1
               	cset	x9, eq
               	cmp	x7, #0x3
               	cset	x10, lo
               	and	x9, x9, x10
               	orr	x6, x6, x9
               	eor	x6, x6, #0x1
               	neg	x9, x6
               	and	x10, x3, x9
               	and	x9, x4, x9
               	cmp	x7, x10
               	cset	x12, lo
               	sub	x7, x7, x10
               	sub	x0, x0, x9
               	sub	x0, x0, x12
               	orr	x6, x11, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x5, [x5]
               	cmp	x7, x5
               	b.ne	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	cbz	x0, <addr>
               	ret
               	mov	x12, #-0x1              // =-1
               	mov	x5, #0x3039             // =12345
               	mov	x0, #0x3000000000       // =206158430208
               	mov	x7, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x8, x7
               	lsr	x9, x0, #63
               	lsl	x10, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	orr	x8, x10, x9
               	lsl	x10, x5, #1
               	lsl	x0, x0, #1
               	lsr	x5, x5, #63
               	orr	x0, x0, x5
               	cmp	x7, #0x0
               	cset	x5, lo
               	cmp	x7, #0x0
               	cset	x9, eq
               	cmp	x8, #0x7
               	cset	x11, lo
               	and	x9, x9, x11
               	orr	x5, x5, x9
               	eor	x5, x5, #0x1
               	neg	x9, x5
               	and	x9, x9, #0x7
               	cmp	x8, x9
               	cset	x11, lo
               	sub	x8, x8, x9
               	sub	x7, x7, x11
               	orr	x5, x10, x5
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	mvn	x5, x5
               	mvn	x0, x0
               	cmp	x5, x12
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x0, x0, #0x1
               	sub	x0, x0, x6
               	mov	x17, #0x8b66            // =35686
               	movk	x17, #0x4924, lsl #16
               	movk	x17, #0x2492, lsl #32
               	movk	x17, #0x9249, lsl #48
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x17, #-0xb6dc           // =-46812
               	movk	x17, #0x2492, lsl #16
               	movk	x17, #0xfff9, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	cbz	x0, <addr>
               	ret
               	mov	x12, #-0x1              // =-1
               	mov	x7, #0x3039             // =12345
               	mov	x6, #0x3000000000       // =206158430208
               	mov	x0, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x8, x0
               	lsr	x9, x6, #63
               	lsl	x10, x8, #1
               	lsl	x0, x0, #1
               	lsr	x8, x8, #63
               	orr	x0, x0, x8
               	orr	x8, x10, x9
               	lsl	x10, x7, #1
               	lsl	x6, x6, #1
               	lsr	x7, x7, #63
               	orr	x6, x6, x7
               	cmp	x0, #0x0
               	cset	x7, lo
               	cmp	x0, #0x0
               	cset	x9, eq
               	cmp	x8, #0x7
               	cset	x11, lo
               	and	x9, x9, x11
               	orr	x7, x7, x9
               	eor	x7, x7, #0x1
               	neg	x9, x7
               	and	x9, x9, #0x7
               	cmp	x8, x9
               	cset	x11, lo
               	sub	x8, x8, x9
               	sub	x0, x0, x11
               	orr	x7, x10, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mvn	x5, x8
               	mvn	x0, x0
               	cmp	x5, x12
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x0, x0, #0x1
               	sub	x0, x0, x6
               	mov	x17, #-0x3              // =-3
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	cbz	x0, <addr>
               	ret
               	mov	x9, #0x0                // =0
               	mov	x0, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x6, #0x80               // =128
               	mov	x8, x9
               	mov	x7, x9
               	lsr	x10, x5, #63
               	lsl	x11, x7, #1
               	lsl	x8, x8, #1
               	lsr	x7, x7, #63
               	orr	x8, x8, x7
               	orr	x7, x11, x10
               	lsl	x11, x0, #1
               	lsl	x5, x5, #1
               	lsr	x0, x0, #63
               	orr	x5, x5, x0
               	cmp	x8, #0x40
               	cset	x10, lo
               	cmp	x8, #0x40
               	cset	x12, eq
               	cmp	x7, #0x0
               	cset	x0, lo
               	and	x12, x12, x0
               	orr	x10, x10, x12
               	eor	x10, x10, #0x1
               	neg	x12, x10
               	and	x12, x12, #0x40
               	sub	x8, x8, x12
               	sub	x8, x8, x0
               	orr	x0, x11, x10
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	cmp	x0, #0x0
               	cset	x6, lo
               	sub	x5, x5, x6
               	mov	x17, #0xc0000000        // =3221225472
               	cmp	x0, x17
               	b.ne	<addr>
               	cbz	x5, <addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	ret
               	mov	x8, #0x3039             // =12345
               	mov	x7, #0x3000000000       // =206158430208
               	mov	x0, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x5, x0
               	lsr	x10, x7, #63
               	lsl	x11, x5, #1
               	lsl	x0, x0, #1
               	lsr	x5, x5, #63
               	orr	x0, x0, x5
               	orr	x5, x11, x10
               	lsl	x11, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	cmp	x0, #0x40
               	cset	x10, lo
               	cmp	x0, #0x40
               	cset	x12, eq
               	cmp	x5, #0x0
               	cset	x8, lo
               	and	x12, x12, x8
               	orr	x10, x10, x12
               	eor	x10, x10, #0x1
               	neg	x12, x10
               	and	x12, x12, #0x40
               	sub	x0, x0, x12
               	sub	x0, x0, x8
               	orr	x8, x11, x10
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	mvn	x5, x5
               	mvn	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x5, x17
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x0, x0, #0x1
               	sub	x0, x0, x6
               	mov	x17, #-0x3039           // =-12345
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	cbz	x0, <addr>
               	ret
               	mov	x5, #0x3039             // =12345
               	mov	x0, #0x3000000000       // =206158430208
               	mov	x7, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x8, x7
               	lsr	x10, x0, #63
               	lsl	x11, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	orr	x8, x11, x10
               	lsl	x11, x5, #1
               	lsl	x0, x0, #1
               	lsr	x5, x5, #63
               	orr	x0, x0, x5
               	cmp	x7, #0x40
               	cset	x10, lo
               	cmp	x7, #0x40
               	cset	x12, eq
               	cmp	x8, #0x0
               	cset	x5, lo
               	and	x12, x12, x5
               	orr	x10, x10, x12
               	eor	x10, x10, #0x1
               	neg	x12, x10
               	and	x12, x12, #0x40
               	sub	x7, x7, x12
               	sub	x7, x7, x5
               	orr	x5, x11, x10
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	mvn	x5, x5
               	mvn	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x5, x17
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x0, x0, #0x1
               	sub	x0, x0, x6
               	mov	x17, #-0x10000          // =-65536
               	movk	x17, #0x4000, lsl #16
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	cbz	x0, <addr>
               	ret
               	mov	x8, #0x3039             // =12345
               	mov	x7, #0x3000000000       // =206158430208
               	mov	x5, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x0, x5
               	lsr	x10, x7, #63
               	lsl	x11, x0, #1
               	lsl	x5, x5, #1
               	lsr	x0, x0, #63
               	orr	x5, x5, x0
               	orr	x0, x11, x10
               	lsl	x11, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	cmp	x5, #0x40
               	cset	x10, lo
               	cmp	x5, #0x40
               	cset	x12, eq
               	cmp	x0, #0x0
               	cset	x8, lo
               	and	x12, x12, x8
               	orr	x10, x10, x12
               	eor	x10, x10, #0x1
               	neg	x12, x10
               	and	x12, x12, #0x40
               	sub	x5, x5, x12
               	sub	x5, x5, x8
               	orr	x8, x11, x10
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	cmp	x0, #0x0
               	cset	x6, lo
               	sub	x5, x5, x6
               	mov	x17, #0x3039            // =12345
               	cmp	x0, x17
               	b.ne	<addr>
               	cbz	x5, <addr>
               	mov	x0, #0xc                // =12
               	cbz	x0, <addr>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x10, [x0]
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x7, x0
               	mov	x6, x2
               	mov	x8, x1
               	lsr	x11, x8, #63
               	lsl	x12, x7, #1
               	lsl	x0, x0, #1
               	lsr	x7, x7, #63
               	orr	x0, x0, x7
               	orr	x7, x12, x11
               	lsl	x12, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x0, #0x0
               	cset	x6, lo
               	cmp	x0, #0x0
               	cset	x11, eq
               	cmp	x7, x10
               	cset	x13, lo
               	and	x11, x11, x13
               	orr	x6, x6, x11
               	eor	x6, x6, #0x1
               	neg	x11, x6
               	and	x11, x10, x11
               	cmp	x7, x11
               	cset	x13, lo
               	sub	x7, x7, x11
               	sub	x0, x0, x13
               	orr	x6, x12, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldr	x5, [x7]
               	mov	x0, #0x0                // =0
               	mul	x14, x6, x5
               	mov	w10, w6
               	lsr	x11, x6, #32
               	mov	w12, w5
               	lsr	x13, x5, #32
               	mul	x15, x10, x12
               	lsr	x15, x15, #32
               	madd	x12, x11, x12, x15
               	mov	w15, w12
               	lsr	x12, x12, #32
               	madd	x10, x10, x13, x15
               	lsr	x10, x10, #32
               	madd	x11, x11, x13, x12
               	add	x10, x11, x10
               	madd	x6, x6, x0, x10
               	madd	x15, x8, x5, x6
               	ldr	x10, [x7]
               	cbz	x1, <addr>
               	mov	x5, #0x80               // =128
               	mov	x6, x0
               	mov	x7, x2
               	mov	x8, x1
               	lsr	x11, x8, #63
               	lsl	x12, x6, #1
               	lsl	x0, x0, #1
               	lsr	x6, x6, #63
               	orr	x0, x0, x6
               	orr	x6, x12, x11
               	lsl	x12, x7, #1
               	lsl	x8, x8, #1
               	lsr	x7, x7, #63
               	orr	x8, x8, x7
               	cmp	x0, #0x0
               	cset	x7, lo
               	cmp	x0, #0x0
               	cset	x11, eq
               	cmp	x6, x10
               	cset	x13, lo
               	and	x11, x11, x13
               	orr	x7, x7, x11
               	eor	x7, x7, #0x1
               	neg	x11, x7
               	and	x11, x10, x11
               	cmp	x6, x11
               	cset	x13, lo
               	sub	x6, x6, x11
               	sub	x0, x0, x13
               	orr	x7, x12, x7
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	add	x5, x14, x6
               	cmp	x5, x14
               	cset	x6, lo
               	add	x0, x15, x0
               	add	x0, x0, x6
               	eor	x5, x2, x5
               	eor	x0, x1, x0
               	orr	x0, x5, x0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x7, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x8, x7
               	lsr	x10, x5, #63
               	lsl	x11, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	orr	x8, x11, x10
               	lsl	x11, x0, #1
               	lsl	x5, x5, #1
               	lsr	x0, x0, #63
               	orr	x5, x5, x0
               	cmp	x7, #0x40
               	cset	x10, lo
               	cmp	x7, #0x40
               	cset	x12, eq
               	cmp	x8, #0x0
               	cset	x0, lo
               	and	x12, x12, x0
               	orr	x10, x10, x12
               	eor	x10, x10, #0x1
               	neg	x12, x10
               	and	x12, x12, #0x40
               	sub	x7, x7, x12
               	sub	x7, x7, x0
               	orr	x0, x11, x10
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	cmp	x0, #0x0
               	cset	x6, lo
               	sub	x10, x5, x6
               	mul	x12, x0, x9
               	mov	w6, w0
               	lsr	x7, x0, #32
               	mov	x5, #0x0                // =0
               	mul	x6, x6, x5
               	lsr	x8, x6, #32
               	mul	x7, x7, x5
               	add	x8, x7, x8
               	mov	w11, w8
               	lsr	x8, x8, #32
               	add	x6, x6, x11
               	lsr	x6, x6, #32
               	add	x7, x7, x8
               	add	x6, x7, x6
               	mov	x17, #-0x40             // =-64
               	mul	x0, x0, x17
               	add	x0, x6, x0
               	madd	x13, x10, x9, x0
               	mov	x8, #0x3039             // =12345
               	mov	x7, #0x3000000000       // =206158430208
               	mov	x6, #0x80               // =128
               	mov	x0, x5
               	lsr	x9, x7, #63
               	lsl	x10, x0, #1
               	lsl	x5, x5, #1
               	lsr	x0, x0, #63
               	orr	x5, x5, x0
               	orr	x0, x10, x9
               	lsl	x10, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	cmp	x5, #0x40
               	cset	x9, lo
               	cmp	x5, #0x40
               	cset	x11, eq
               	cmp	x0, #0x0
               	cset	x8, lo
               	and	x11, x11, x8
               	orr	x9, x9, x11
               	eor	x9, x9, #0x1
               	neg	x11, x9
               	and	x11, x11, #0x40
               	sub	x5, x5, x11
               	sub	x5, x5, x8
               	orr	x8, x10, x9
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	mvn	x0, x0
               	mvn	x5, x5
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	cset	x6, lo
               	add	x0, x0, #0x1
               	add	x5, x5, #0x1
               	sub	x5, x5, x6
               	add	x0, x12, x0
               	cmp	x0, x12
               	cset	x6, lo
               	add	x5, x13, x5
               	add	x5, x5, x6
               	mov	x17, #-0x3039           // =-12345
               	eor	x0, x0, x17
               	eor	x5, x5, #0xffffffcfffffffff
               	orr	x0, x0, x5
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x7, [x0]
               	cbz	x1, <addr>
               	mov	x5, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x0, x2
               	mov	x2, x5
               	lsr	x8, x1, #63
               	lsl	x9, x2, #1
               	lsl	x5, x5, #1
               	lsr	x2, x2, #63
               	orr	x5, x5, x2
               	orr	x2, x9, x8
               	lsl	x9, x0, #1
               	lsl	x1, x1, #1
               	lsr	x0, x0, #63
               	orr	x1, x1, x0
               	cmp	x5, #0x0
               	cset	x0, lo
               	cmp	x5, #0x0
               	cset	x8, eq
               	cmp	x2, x7
               	cset	x10, lo
               	and	x8, x8, x10
               	orr	x0, x0, x8
               	eor	x0, x0, #0x1
               	neg	x8, x0
               	and	x8, x7, x8
               	cmp	x2, x8
               	cset	x10, lo
               	sub	x2, x2, x8
               	sub	x5, x5, x10
               	orr	x0, x9, x0
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	orr	x2, x1, x4
               	cbz	x2, <addr>
               	mov	x2, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x0
               	mov	x0, x2
               	lsr	x7, x1, #63
               	lsl	x8, x0, #1
               	lsl	x2, x2, #1
               	lsr	x0, x0, #63
               	orr	x2, x2, x0
               	orr	x0, x8, x7
               	lsl	x9, x6, #1
               	lsl	x1, x1, #1
               	lsr	x6, x6, #63
               	orr	x1, x1, x6
               	cmp	x2, #0x1
               	cset	x6, lo
               	cmp	x2, #0x1
               	cset	x7, eq
               	cmp	x0, #0x3
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x6, x6, x7
               	eor	x6, x6, #0x1
               	neg	x7, x6
               	and	x8, x3, x7
               	and	x7, x4, x7
               	cmp	x0, x8
               	cset	x10, lo
               	sub	x0, x0, x8
               	sub	x2, x2, x7
               	sub	x2, x2, x10
               	orr	x6, x9, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x17, #0x5c28            // =23592
               	movk	x17, #0x962c, lsl #16
               	movk	x17, #0x3699, lsl #32
               	movk	x17, #0xbd6d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0xf                // =15
               	cbz	x0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xaaab             // =43691
               	movk	x1, #0xaaaa, lsl #16
               	movk	x1, #0xaaaa, lsl #32
               	movk	x1, #0xaaaa, lsl #48
               	umulh	x1, x0, x1
               	lsr	x6, x1, #1
               	msub	x0, x6, x3, x0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	udiv	x0, x2, x7
               	msub	x2, x0, x7, x2
               	mov	x5, #0x0                // =0
               	mov	x1, x5
               	b	<addr>
               	udiv	x7, x2, x10
               	msub	x6, x7, x10, x2
               	mov	x8, x0
               	b	<addr>
               	udiv	x6, x2, x10
               	msub	x7, x6, x10, x2
               	mov	x0, #0x0                // =0
               	mov	x8, x0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	umulh	x0, x2, x0
               	lsr	x7, x0, #1
               	msub	x6, x7, x3, x2
               	mov	x0, #0x0                // =0
               	mov	x8, x0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	umulh	x0, x2, x0
               	lsr	x6, x0, #1
               	msub	x7, x6, x3, x2
               	mov	x0, #0x0                // =0
               	mov	x8, x0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
