
int128_bitfield.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	and	x0, x0, #0xfffffffff
               	mov	x17, #0x1234            // =4660
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x2, [x1, #0x8]
               	and	x2, x2, #0xfffffffff
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1, #0x8]
               	lsr	x0, x0, #36
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xab               // =171
               	sturb	w0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x18]
               	and	x0, x0, #0xff
               	and	x1, x1, #0xfffff00000000000
               	orr	x2, x0, #0x300
               	orr	x0, x1, #0x200000
               	stur	x2, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	lsr	x1, x0, #8
               	lsl	x0, x0, #56
               	orr	x0, x0, #0x3
               	and	x1, x1, #0xfffffffff
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x20]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x38               // =56
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x20]
               	and	x0, x0, #0xffffffffffffffe0
               	orr	x0, x0, #0x1f
               	stur	w0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x18]
               	and	x0, x0, #0x1f
               	and	x1, x1, #0xfffffffffffffffe
               	mov	x17, #0x160             // =352
               	orr	x0, x0, x17
               	orr	x1, x1, #0x1
               	stur	x0, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	and	x1, x1, #0xffffffffffe00001
               	orr	x1, x1, #0x1ffffe
               	stur	x1, [x29, #-0x18]
               	lsr	x0, x0, #5
               	lsl	x2, x1, #59
               	orr	x0, x0, x2
               	and	x0, x0, #0xfffffffffffffff
               	mov	x17, #0xb               // =11
               	movk	x17, #0x800, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x39               // =57
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x20]
               	and	x0, x0, #0x1f
               	cmp	w0, #0x1f
               	b.ne	<addr>
               	asr	x0, x1, #1
               	and	x0, x0, #0xfffff
               	mov	x17, #0xfffff           // =1048575
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3c               // =60
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xe0000000         // =3758096384
               	mov	x4, #0x0                // =0
               	mov	x0, #0xb6db             // =46811
               	movk	x0, #0xdb6d, lsl #16
               	mov	x1, #0x14               // =20
               	movk	x1, #0x6000, lsl #16
               	mov	x2, #0xa0000000         // =2684354560
               	lsr	x5, x0, #32
               	cbnz	x5, <addr>
               	mul	x5, x0, x4
               	lsl	x6, x1, #32
               	orr	x6, x6, x2
               	cmp	x5, x6
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x5, x1, #32
               	cbz	x5, <addr>
               	mov	x1, #0xa0000000         // =2684354560
               	movk	x1, #0x14, lsl #32
               	mov	x17, #-0x2000000000000000 // =-2305843009213693952
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #29
               	mov	x5, #0x2493             // =9363
               	movk	x5, #0x9249, lsl #16
               	movk	x5, #0x4924, lsl #32
               	movk	x5, #0x2492, lsl #48
               	umulh	x1, x1, x5
               	msub	x2, x1, x3, x2
               	lsr	x5, x1, #32
               	cbnz	x5, <addr>
               	mul	x5, x1, x4
               	lsl	x6, x2, #32
               	cmp	x5, x6
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	lsl	x0, x0, #32
               	orr	x8, x0, x1
               	mov	x17, #0xdb85            // =56197
               	movk	x17, #0x6db6, lsl #16
               	movk	x17, #0xb6db, lsl #32
               	movk	x17, #0xdb6d, lsl #48
               	cmp	x8, x17
               	b.eq	<addr>
               	mov	x0, #0x55               // =85
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3000             // =12288
               	movk	x3, #0xf424, lsl #16
               	mov	x4, #0x0                // =0
               	lsr	x0, x8, #1
               	lsr	x0, x0, #19
               	mov	x17, #0xd00000000000    // =228698418577408
               	movk	x17, #0xa99, lsl #48
               	orr	x9, x0, x17
               	lsl	x0, x8, #44
               	lsr	x2, x0, #32
               	mov	w5, w0
               	mov	x0, #0x59c7             // =22983
               	movk	x0, #0x49cb, lsl #16
               	movk	x0, #0xf454, lsl #32
               	movk	x0, #0x10c6, lsl #48
               	umulh	x0, x9, x0
               	lsr	x0, x0, #28
               	msub	x1, x0, x3, x9
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	lsl	x1, x9, #32
               	orr	x1, x1, x2
               	mov	x17, #0x300000000000    // =52776558133248
               	movk	x17, #0xf424, lsl #48
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #12
               	mov	x6, #0xe5ad             // =58797
               	movk	x6, #0x2a24, lsl #16
               	movk	x6, #0x637a, lsl #32
               	movk	x6, #0x8, lsl #48
               	umulh	x1, x1, x6
               	lsr	x1, x1, #7
               	msub	x2, x1, x3, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	mul	x6, x1, x4
               	lsl	x7, x2, #32
               	orr	x7, x7, x5
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x0, x0, x17
               	sub	x0, x8, x0
               	mov	x17, #0x47c3            // =18371
               	movk	x17, #0x2, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	w1, [x0, #0x1]
               	ldrb	w0, [x0, #0x5]
               	lsl	x0, x0, #32
               	orr	x0, x1, x0
               	lsl	x0, x0, #24
               	asr	x0, x0, #24
               	asr	x1, x0, #63
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x79               // =121
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldrh	w16, [x1, #0x4]
               	strh	w16, [x0, #0x4]
               	ldrb	w16, [x1, #0x6]
               	strb	w16, [x0, #0x6]
               	mov	x1, #0x7fffffffff       // =549755813887
               	stur	w1, [x0, #0x1]
               	mov	x1, #0x7f               // =127
               	sturb	w1, [x29, #-0x3]
               	mov	x1, #0x8000000000       // =549755813888
               	stur	w1, [x0, #0x1]
               	mov	x1, #0x80               // =128
               	sturb	w1, [x29, #-0x3]
               	mov	x2, #0x1                // =1
               	movk	x2, #0x80, lsl #32
               	stur	w2, [x0, #0x1]
               	sturb	w1, [x29, #-0x3]
               	mov	x1, #0xfffffffffe       // =1099511627774
               	stur	w1, [x0, #0x1]
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x3]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x7a               // =122
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x2000            // =8192
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x36               // =54
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x800000000       // =34359738368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
