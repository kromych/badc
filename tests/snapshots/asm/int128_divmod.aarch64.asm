
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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x6, #0x0                // =0
               	adrp	x14, <page>
               	add	x14, x14, <lo12>
               	ldr	x1, [x14]
               	orr	x2, x6, x1
               	mov	x3, #-0x1               // =-1
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	adrp	x15, <page>
               	add	x15, x15, <lo12>
               	ldr	x10, [x15]
               	mov	x4, #0x80               // =128
               	mov	x5, x6
               	mov	x8, x3
               	mov	x7, x1
               	mov	x9, x6
               	cbz	x4, <addr>
               	lsr	x11, x7, #63
               	lsl	x12, x9, #1
               	lsl	x5, x5, #1
               	lsr	x9, x9, #63
               	orr	x5, x5, x9
               	orr	x9, x12, x11
               	lsl	x12, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	cmp	x5, #0x0
               	cset	x8, lo
               	cmp	x5, #0x0
               	cset	x11, eq
               	cmp	x9, x10
               	cset	x13, lo
               	and	x11, x11, x13
               	orr	x8, x8, x11
               	eor	x8, x8, #0x1
               	sub	x11, x6, x8
               	and	x11, x10, x11
               	cmp	x9, x11
               	cset	x13, lo
               	sub	x9, x9, x11
               	sub	x5, x5, x13
               	orr	x8, x12, x8
               	sub	x4, x4, #0x1
               	cbnz	x4, <addr>
               	mov	x17, #-0x3333333333333334 // =-3689348814741910324
               	cmp	x8, x17
               	b.ne	<addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xccc, lsl #48
               	cmp	x7, x17
               	b.eq	<addr>
               	mov	x4, #0x1                // =1
               	cbz	x4, <addr>
               	mov	x0, x4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x8, [x15]
               	mov	x7, #0x0                // =0
               	mov	x4, #0x80               // =128
               	mov	x5, x7
               	mov	x6, x7
               	cbz	x4, <addr>
               	lsr	x9, x1, #63
               	lsl	x10, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	orr	x6, x10, x9
               	lsl	x10, x3, #1
               	lsl	x1, x1, #1
               	lsr	x3, x3, #63
               	orr	x1, x1, x3
               	cmp	x5, #0x0
               	cset	x3, lo
               	cmp	x5, #0x0
               	cset	x9, eq
               	cmp	x6, x8
               	cset	x11, lo
               	and	x9, x9, x11
               	orr	x3, x3, x9
               	eor	x3, x3, #0x1
               	sub	x9, x7, x3
               	and	x9, x8, x9
               	cmp	x6, x9
               	cset	x11, lo
               	sub	x6, x6, x9
               	sub	x5, x5, x11
               	orr	x3, x10, x3
               	sub	x4, x4, #0x1
               	cbnz	x4, <addr>
               	cmp	x6, #0x7
               	b.ne	<addr>
               	cbz	x5, <addr>
               	mov	x1, #0x2                // =2
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x3, #0x3                // =3
               	mov	x4, #0x1                // =1
               	orr	x1, x0, x4
               	cbz	x1, <addr>
               	mov	x8, #0x0                // =0
               	mov	x1, #0x80               // =128
               	mov	x9, x8
               	mov	x5, x2
               	mov	x6, x0
               	mov	x7, x8
               	cbz	x1, <addr>
               	lsr	x10, x6, #63
               	lsl	x11, x7, #1
               	lsl	x9, x9, #1
               	lsr	x7, x7, #63
               	orr	x9, x9, x7
               	orr	x7, x11, x10
               	lsl	x12, x5, #1
               	lsl	x6, x6, #1
               	lsr	x5, x5, #63
               	orr	x6, x6, x5
               	cmp	x9, #0x1
               	cset	x5, lo
               	cmp	x9, #0x1
               	cset	x10, eq
               	cmp	x7, #0x3
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x5, x5, x10
               	eor	x5, x5, #0x1
               	sub	x10, x8, x5
               	and	x11, x3, x10
               	and	x10, x4, x10
               	cmp	x7, x11
               	cset	x13, lo
               	sub	x7, x7, x11
               	sub	x9, x9, x10
               	sub	x9, x9, x13
               	orr	x5, x12, x5
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	mov	x17, #0xeefd            // =61181
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x5, x17
               	b.ne	<addr>
               	cbz	x6, <addr>
               	mov	x1, #0x3                // =3
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x1, x0, x4
               	cbz	x1, <addr>
               	mov	x8, #0x0                // =0
               	mov	x1, #0x80               // =128
               	mov	x9, x8
               	mov	x5, x2
               	mov	x7, x0
               	mov	x6, x8
               	cbz	x1, <addr>
               	lsr	x10, x7, #63
               	lsl	x11, x6, #1
               	lsl	x9, x9, #1
               	lsr	x6, x6, #63
               	orr	x9, x9, x6
               	orr	x6, x11, x10
               	lsl	x12, x5, #1
               	lsl	x7, x7, #1
               	lsr	x5, x5, #63
               	orr	x7, x7, x5
               	cmp	x9, #0x1
               	cset	x5, lo
               	cmp	x9, #0x1
               	cset	x10, eq
               	cmp	x6, #0x3
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x5, x5, x10
               	eor	x5, x5, #0x1
               	sub	x10, x8, x5
               	and	x11, x3, x10
               	and	x10, x4, x10
               	cmp	x6, x11
               	cset	x13, lo
               	sub	x6, x6, x11
               	sub	x9, x9, x10
               	sub	x9, x9, x13
               	orr	x5, x12, x5
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	mov	x17, #0x9980            // =39296
               	movk	x17, #0xddbb, lsl #16
               	movk	x17, #0x21ff, lsl #32
               	movk	x17, #0x6644, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	cbz	x9, <addr>
               	mov	x1, #0x4                // =4
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x1, [x14]
               	mov	x5, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x9, x5
               	mov	x7, x5
               	mov	x8, x5
               	cbz	x6, <addr>
               	lsr	x10, x7, #63
               	lsl	x11, x8, #1
               	lsl	x9, x9, #1
               	lsr	x8, x8, #63
               	orr	x9, x9, x8
               	orr	x8, x11, x10
               	lsl	x12, x1, #1
               	lsl	x7, x7, #1
               	lsr	x1, x1, #63
               	orr	x7, x7, x1
               	cmp	x9, #0x1
               	cset	x1, lo
               	cmp	x9, #0x1
               	cset	x10, eq
               	cmp	x8, #0x3
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x1, x1, x10
               	eor	x1, x1, #0x1
               	sub	x10, x5, x1
               	and	x11, x3, x10
               	and	x10, x4, x10
               	cmp	x8, x11
               	cset	x13, lo
               	sub	x8, x8, x11
               	sub	x9, x9, x10
               	sub	x9, x9, x13
               	orr	x1, x12, x1
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	cbnz	x1, <addr>
               	cbz	x7, <addr>
               	mov	x1, #0x5                // =5
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x6, [x14]
               	mov	x1, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x9, x1
               	mov	x8, x1
               	mov	x7, x1
               	cbz	x5, <addr>
               	lsr	x10, x8, #63
               	lsl	x11, x7, #1
               	lsl	x9, x9, #1
               	lsr	x7, x7, #63
               	orr	x9, x9, x7
               	orr	x7, x11, x10
               	lsl	x12, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x9, #0x1
               	cset	x6, lo
               	cmp	x9, #0x1
               	cset	x10, eq
               	cmp	x7, #0x3
               	cset	x11, lo
               	and	x10, x10, x11
               	orr	x6, x6, x10
               	eor	x6, x6, #0x1
               	sub	x10, x1, x6
               	and	x11, x3, x10
               	and	x10, x4, x10
               	cmp	x7, x11
               	cset	x13, lo
               	sub	x7, x7, x11
               	sub	x9, x9, x10
               	sub	x9, x9, x13
               	orr	x6, x12, x6
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	ldr	x1, [x14]
               	cmp	x7, x1
               	b.ne	<addr>
               	cbz	x9, <addr>
               	mov	x1, #0x6                // =6
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x13, #-0x1              // =-1
               	mov	x5, #0x3039             // =12345
               	mov	x1, #0x3000000000       // =206158430208
               	mov	x9, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x7, x9
               	mov	x8, x9
               	cbz	x6, <addr>
               	lsr	x10, x1, #63
               	lsl	x11, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	orr	x8, x11, x10
               	lsl	x11, x5, #1
               	lsl	x1, x1, #1
               	lsr	x5, x5, #63
               	orr	x1, x1, x5
               	cmp	x7, #0x0
               	cset	x5, lo
               	cmp	x7, #0x0
               	cset	x10, eq
               	cmp	x8, #0x7
               	cset	x12, lo
               	and	x10, x10, x12
               	orr	x5, x5, x10
               	eor	x5, x5, #0x1
               	sub	x10, x9, x5
               	and	x10, x10, #0x7
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x7, x7, x12
               	orr	x5, x11, x5
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	mvn	x5, x5
               	mvn	x1, x1
               	cmp	x5, x13
               	cset	x6, lo
               	add	x5, x5, #0x1
               	add	x1, x1, #0x1
               	sub	x6, x1, x6
               	mov	x17, #0x8b66            // =35686
               	movk	x17, #0x4924, lsl #16
               	movk	x17, #0x2492, lsl #32
               	movk	x17, #0x9249, lsl #48
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x17, #-0xb6dc           // =-46812
               	movk	x17, #0x2492, lsl #16
               	movk	x17, #0xfff9, lsl #32
               	cmp	x6, x17
               	b.eq	<addr>
               	mov	x1, #0x7                // =7
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x13, #-0x1              // =-1
               	mov	x5, #0x3039             // =12345
               	mov	x1, #0x3000000000       // =206158430208
               	mov	x9, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x7, x9
               	mov	x8, x9
               	cbz	x6, <addr>
               	lsr	x10, x1, #63
               	lsl	x11, x8, #1
               	lsl	x7, x7, #1
               	lsr	x8, x8, #63
               	orr	x7, x7, x8
               	orr	x8, x11, x10
               	lsl	x11, x5, #1
               	lsl	x1, x1, #1
               	lsr	x5, x5, #63
               	orr	x1, x1, x5
               	cmp	x7, #0x0
               	cset	x5, lo
               	cmp	x7, #0x0
               	cset	x10, eq
               	cmp	x8, #0x7
               	cset	x12, lo
               	and	x10, x10, x12
               	orr	x5, x5, x10
               	eor	x5, x5, #0x1
               	sub	x10, x9, x5
               	and	x10, x10, #0x7
               	cmp	x8, x10
               	cset	x12, lo
               	sub	x8, x8, x10
               	sub	x7, x7, x12
               	orr	x5, x11, x5
               	sub	x6, x6, #0x1
               	cbnz	x6, <addr>
               	mvn	x1, x8
               	mvn	x5, x7
               	cmp	x1, x13
               	cset	x6, lo
               	add	x1, x1, #0x1
               	add	x5, x5, #0x1
               	sub	x5, x5, x6
               	mov	x17, #-0x3              // =-3
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x1, #0x8                // =8
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x9, #0x0                // =0
               	mov	x5, #0x3039             // =12345
               	mov	x6, #0x3000000000       // =206158430208
               	mov	x7, #0x80               // =128
               	mov	x8, x9
               	mov	x1, x9
               	cbz	x7, <addr>
               	lsr	x10, x6, #63
               	lsl	x11, x1, #1
               	lsl	x8, x8, #1
               	lsr	x1, x1, #63
               	orr	x8, x8, x1
               	orr	x1, x11, x10
               	lsl	x11, x5, #1
               	lsl	x6, x6, #1
               	lsr	x5, x5, #63
               	orr	x6, x6, x5
               	cmp	x8, #0x40
               	cset	x10, lo
               	cmp	x8, #0x40
               	cset	x12, eq
               	cmp	x1, #0x0
               	cset	x5, lo
               	and	x12, x12, x5
               	orr	x10, x10, x12
               	eor	x10, x10, #0x1
               	sub	x12, x9, x10
               	and	x12, x12, #0x40
               	sub	x8, x8, x12
               	sub	x8, x8, x5
               	orr	x5, x11, x10
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	cmp	x5, #0x0
               	cset	x7, lo
               	sub	x6, x6, x7
               	mov	x17, #0xc0000000        // =3221225472
               	cmp	x5, x17
               	b.ne	<addr>
               	cbz	x6, <addr>
               	mov	x1, #0x9                // =9
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x8, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x10, x8
               	mov	x1, x8
               	cbz	x7, <addr>
               	lsr	x11, x5, #63
               	lsl	x12, x1, #1
               	lsl	x10, x10, #1
               	lsr	x1, x1, #63
               	orr	x10, x10, x1
               	orr	x1, x12, x11
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x10, #0x40
               	cset	x11, lo
               	cmp	x10, #0x40
               	cset	x13, eq
               	cmp	x1, #0x0
               	cset	x6, lo
               	and	x13, x13, x6
               	orr	x11, x11, x13
               	eor	x11, x11, #0x1
               	sub	x13, x8, x11
               	and	x13, x13, #0x40
               	sub	x10, x10, x13
               	sub	x10, x10, x6
               	orr	x6, x12, x11
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x1, x1
               	mvn	x5, x10
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	cset	x6, lo
               	add	x1, x1, #0x1
               	add	x5, x5, #0x1
               	sub	x5, x5, x6
               	mov	x17, #-0x3039           // =-12345
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x1, #0xa                // =10
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x8, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x10, x8
               	mov	x1, x8
               	cbz	x7, <addr>
               	lsr	x11, x5, #63
               	lsl	x12, x1, #1
               	lsl	x10, x10, #1
               	lsr	x1, x1, #63
               	orr	x10, x10, x1
               	orr	x1, x12, x11
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x10, #0x40
               	cset	x11, lo
               	cmp	x10, #0x40
               	cset	x13, eq
               	cmp	x1, #0x0
               	cset	x6, lo
               	and	x13, x13, x6
               	orr	x11, x11, x13
               	eor	x11, x11, #0x1
               	sub	x13, x8, x11
               	and	x13, x13, #0x40
               	sub	x10, x10, x13
               	sub	x10, x10, x6
               	orr	x6, x12, x11
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x6, x6
               	mvn	x5, x5
               	mov	x17, #-0x1              // =-1
               	cmp	x6, x17
               	cset	x7, lo
               	add	x6, x6, #0x1
               	add	x5, x5, #0x1
               	sub	x5, x5, x7
               	mov	x17, #-0x10000          // =-65536
               	movk	x17, #0x4000, lsl #16
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x1, #0xb                // =11
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x8, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x10, x8
               	mov	x1, x8
               	cbz	x7, <addr>
               	lsr	x11, x5, #63
               	lsl	x12, x1, #1
               	lsl	x10, x10, #1
               	lsr	x1, x1, #63
               	orr	x10, x10, x1
               	orr	x1, x12, x11
               	lsl	x12, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x10, #0x40
               	cset	x11, lo
               	cmp	x10, #0x40
               	cset	x13, eq
               	cmp	x1, #0x0
               	cset	x6, lo
               	and	x13, x13, x6
               	orr	x11, x11, x13
               	eor	x11, x11, #0x1
               	sub	x13, x8, x11
               	and	x13, x13, #0x40
               	sub	x10, x10, x13
               	sub	x10, x10, x6
               	orr	x6, x12, x11
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	cmp	x1, #0x0
               	cset	x5, lo
               	sub	x5, x10, x5
               	mov	x17, #0x3039            // =12345
               	cmp	x1, x17
               	b.ne	<addr>
               	cbz	x5, <addr>
               	mov	x1, #0xc                // =12
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x11, [x15]
               	cbz	x0, <addr>
               	mov	x10, #0x0               // =0
               	mov	x1, #0x80               // =128
               	mov	x5, x10
               	mov	x6, x2
               	mov	x8, x0
               	mov	x7, x10
               	cbz	x1, <addr>
               	lsr	x12, x8, #63
               	lsl	x13, x7, #1
               	lsl	x5, x5, #1
               	lsr	x7, x7, #63
               	orr	x5, x5, x7
               	orr	x7, x13, x12
               	lsl	x13, x6, #1
               	lsl	x8, x8, #1
               	lsr	x6, x6, #63
               	orr	x8, x8, x6
               	cmp	x5, #0x0
               	cset	x6, lo
               	cmp	x5, #0x0
               	cset	x12, eq
               	cmp	x7, x11
               	cset	x14, lo
               	and	x12, x12, x14
               	orr	x6, x6, x12
               	eor	x6, x6, #0x1
               	sub	x12, x10, x6
               	and	x12, x11, x12
               	cmp	x7, x12
               	cset	x14, lo
               	sub	x7, x7, x12
               	sub	x5, x5, x14
               	orr	x6, x13, x6
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	ldr	x1, [x15]
               	mov	x7, #0x0                // =0
               	mul	x20, x6, x1
               	mov	w11, w6
               	lsr	x5, x6, #32
               	mov	w12, w1
               	lsr	x10, x1, #32
               	mul	x13, x11, x12
               	lsr	x13, x13, #32
               	madd	x12, x5, x12, x13
               	mov	w13, w12
               	lsr	x12, x12, #32
               	madd	x11, x11, x10, x13
               	lsr	x11, x11, #32
               	madd	x5, x5, x10, x12
               	add	x5, x5, x11
               	madd	x5, x6, x7, x5
               	madd	x21, x8, x1, x5
               	ldr	x11, [x15]
               	cbz	x0, <addr>
               	mov	x1, #0x80               // =128
               	mov	x5, x7
               	mov	x6, x2
               	mov	x10, x0
               	mov	x8, x7
               	cbz	x1, <addr>
               	lsr	x12, x10, #63
               	lsl	x13, x8, #1
               	lsl	x5, x5, #1
               	lsr	x8, x8, #63
               	orr	x5, x5, x8
               	orr	x8, x13, x12
               	lsl	x13, x6, #1
               	lsl	x10, x10, #1
               	lsr	x6, x6, #63
               	orr	x10, x10, x6
               	cmp	x5, #0x0
               	cset	x6, lo
               	cmp	x5, #0x0
               	cset	x12, eq
               	cmp	x8, x11
               	cset	x14, lo
               	and	x12, x12, x14
               	orr	x6, x6, x12
               	eor	x6, x6, #0x1
               	sub	x12, x7, x6
               	and	x12, x11, x12
               	cmp	x8, x12
               	cset	x14, lo
               	sub	x8, x8, x12
               	sub	x5, x5, x14
               	orr	x6, x13, x6
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	mov	x7, x5
               	add	x1, x20, x8
               	cmp	x1, x20
               	cset	x5, lo
               	add	x6, x21, x7
               	add	x5, x6, x5
               	eor	x1, x2, x1
               	eor	x5, x0, x5
               	orr	x1, x1, x5
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x5, #0x3039             // =12345
               	mov	x6, #0x3000000000       // =206158430208
               	mov	x8, #0x0                // =0
               	mov	x7, #0x80               // =128
               	mov	x10, x8
               	mov	x1, x8
               	cbz	x7, <addr>
               	lsr	x11, x6, #63
               	lsl	x12, x1, #1
               	lsl	x10, x10, #1
               	lsr	x1, x1, #63
               	orr	x10, x10, x1
               	orr	x1, x12, x11
               	lsl	x12, x5, #1
               	lsl	x6, x6, #1
               	lsr	x5, x5, #63
               	orr	x6, x6, x5
               	cmp	x10, #0x40
               	cset	x11, lo
               	cmp	x10, #0x40
               	cset	x13, eq
               	cmp	x1, #0x0
               	cset	x5, lo
               	and	x13, x13, x5
               	orr	x11, x11, x13
               	eor	x11, x11, #0x1
               	sub	x13, x8, x11
               	and	x13, x13, #0x40
               	sub	x10, x10, x13
               	sub	x10, x10, x5
               	orr	x5, x12, x11
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	cmp	x5, #0x0
               	cset	x7, lo
               	sub	x6, x6, x7
               	mul	x13, x5, x9
               	mov	w1, w5
               	lsr	x7, x5, #32
               	mov	x8, #0x0                // =0
               	mul	x10, x1, x8
               	lsr	x12, x10, #32
               	mul	x11, x7, x8
               	add	x12, x11, x12
               	mov	w14, w12
               	lsr	x12, x12, #32
               	add	x1, x10, x14
               	lsr	x1, x1, #32
               	add	x7, x11, x12
               	add	x1, x7, x1
               	mov	x17, #-0x40             // =-64
               	mul	x5, x5, x17
               	add	x1, x1, x5
               	madd	x14, x6, x9, x1
               	mov	x6, #0x3039             // =12345
               	mov	x5, #0x3000000000       // =206158430208
               	mov	x7, #0x80               // =128
               	mov	x9, x8
               	mov	x1, x8
               	cbz	x7, <addr>
               	lsr	x10, x5, #63
               	lsl	x11, x1, #1
               	lsl	x9, x9, #1
               	lsr	x1, x1, #63
               	orr	x9, x9, x1
               	orr	x1, x11, x10
               	lsl	x11, x6, #1
               	lsl	x5, x5, #1
               	lsr	x6, x6, #63
               	orr	x5, x5, x6
               	cmp	x9, #0x40
               	cset	x10, lo
               	cmp	x9, #0x40
               	cset	x12, eq
               	cmp	x1, #0x0
               	cset	x6, lo
               	and	x12, x12, x6
               	orr	x10, x10, x12
               	eor	x10, x10, #0x1
               	sub	x12, x8, x10
               	and	x12, x12, #0x40
               	sub	x9, x9, x12
               	sub	x9, x9, x6
               	orr	x6, x11, x10
               	sub	x7, x7, #0x1
               	cbnz	x7, <addr>
               	mvn	x1, x1
               	mvn	x5, x9
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	cset	x6, lo
               	add	x1, x1, #0x1
               	add	x5, x5, #0x1
               	sub	x5, x5, x6
               	add	x1, x13, x1
               	cmp	x1, x13
               	cset	x6, lo
               	add	x5, x14, x5
               	add	x5, x5, x6
               	mov	x17, #-0x3039           // =-12345
               	eor	x1, x1, x17
               	eor	x5, x5, #0xffffffcfffffffff
               	orr	x1, x1, x5
               	cbz	x1, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x8, [x15]
               	cbz	x0, <addr>
               	mov	x7, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, x7
               	mov	x1, x2
               	mov	x2, x7
               	cbz	x5, <addr>
               	lsr	x9, x0, #63
               	lsl	x10, x6, #1
               	lsl	x2, x2, #1
               	lsr	x6, x6, #63
               	orr	x2, x2, x6
               	orr	x6, x10, x9
               	lsl	x10, x1, #1
               	lsl	x0, x0, #1
               	lsr	x1, x1, #63
               	orr	x0, x0, x1
               	cmp	x2, #0x0
               	cset	x1, lo
               	cmp	x2, #0x0
               	cset	x9, eq
               	cmp	x6, x8
               	cset	x11, lo
               	and	x9, x9, x11
               	orr	x1, x1, x9
               	eor	x1, x1, #0x1
               	sub	x9, x7, x1
               	and	x9, x8, x9
               	cmp	x6, x9
               	cset	x11, lo
               	sub	x6, x6, x9
               	sub	x2, x2, x11
               	orr	x1, x10, x1
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	orr	x2, x0, x4
               	cbz	x2, <addr>
               	mov	x6, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x7, x6
               	mov	x5, x1
               	mov	x1, x6
               	cbz	x2, <addr>
               	lsr	x8, x0, #63
               	lsl	x9, x1, #1
               	lsl	x7, x7, #1
               	lsr	x1, x1, #63
               	orr	x7, x7, x1
               	orr	x1, x9, x8
               	lsl	x10, x5, #1
               	lsl	x0, x0, #1
               	lsr	x5, x5, #63
               	orr	x0, x0, x5
               	cmp	x7, #0x1
               	cset	x5, lo
               	cmp	x7, #0x1
               	cset	x8, eq
               	cmp	x1, #0x3
               	cset	x9, lo
               	and	x8, x8, x9
               	orr	x5, x5, x8
               	eor	x5, x5, #0x1
               	sub	x8, x6, x5
               	and	x9, x3, x8
               	and	x8, x4, x8
               	cmp	x1, x9
               	cset	x11, lo
               	sub	x1, x1, x9
               	sub	x7, x7, x8
               	sub	x7, x7, x11
               	orr	x5, x10, x5
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x17, #0x5c28            // =23592
               	movk	x17, #0x962c, lsl #16
               	movk	x17, #0x3699, lsl #32
               	movk	x17, #0xbd6d, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	cbz	x7, <addr>
               	mov	x0, #0xf                // =15
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	umulh	x0, x1, x0
               	lsr	x5, x0, #1
               	msub	x1, x5, x3, x1
               	mov	x7, #0x0                // =0
               	mov	x0, x7
               	b	<addr>
               	udiv	x1, x2, x8
               	msub	x6, x1, x8, x2
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	udiv	x6, x2, x11
               	msub	x8, x6, x11, x2
               	mov	x10, x7
               	b	<addr>
               	udiv	x6, x2, x11
               	msub	x7, x6, x11, x2
               	mov	x5, #0x0                // =0
               	mov	x8, x5
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xaaab             // =43691
               	movk	x1, #0xaaaa, lsl #16
               	movk	x1, #0xaaaa, lsl #32
               	movk	x1, #0xaaaa, lsl #48
               	umulh	x1, x2, x1
               	lsr	x5, x1, #1
               	msub	x6, x5, x3, x2
               	mov	x9, #0x0                // =0
               	mov	x7, x9
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xaaab             // =43691
               	movk	x1, #0xaaaa, lsl #16
               	movk	x1, #0xaaaa, lsl #32
               	movk	x1, #0xaaaa, lsl #48
               	umulh	x1, x2, x1
               	lsr	x5, x1, #1
               	msub	x7, x5, x3, x2
               	mov	x9, #0x0                // =0
               	mov	x6, x9
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
