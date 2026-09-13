
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
               	sub	sp, sp, #0xf0
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
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	and	x0, x0, #0xfffffffff
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	and	x0, x0, #0xfffffff000000000
               	orr	x1, x0, #0x800000000
               	stur	x1, [x29, #-0x28]
               	and	x0, x1, #0xfffffffff
               	mov	x17, #0x800000000       // =34359738368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x28]
               	and	x0, x0, #0xfffffffff
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	and	x0, x0, #0xfffffff000000000
               	orr	x0, x0, #0xfffffffff
               	stur	x0, [x29, #-0x28]
               	and	x0, x0, #0xfffffffff
               	orr	x0, x0, #0xfffffff000000000
               	stur	x0, [x29, #-0x28]
               	and	x1, x0, #0xfffffffff
               	mov	x17, #0xfffffffff       // =68719476735
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x1, #0x1b               // =27
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x1, x0, #36
               	mov	x17, #0xfffffff         // =268435455
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x1, #0x1d               // =29
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	stur	x1, [x29, #-0x28]
               	and	x0, x1, #0xfffffffff
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x1, #36
               	mov	x17, #0xfffffff         // =268435455
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldur	x1, [x29, #-0x28]
               	and	x1, x1, #0xfffffff000000000
               	orr	x1, x1, #0xfffffffff
               	stur	x1, [x29, #-0x28]
               	and	x1, x1, #0xfffffffff
               	mov	x17, #0xffd000000000    // =281268818280448
               	movk	x17, #0xffff, lsl #48
               	orr	x1, x1, x17
               	stur	x1, [x29, #-0x28]
               	and	x2, x1, #0xfffffffff
               	lsl	x2, x2, #28
               	orr	x2, x2, #0xf000000
               	asr	x3, x2, #28
               	lsl	x2, x2, #36
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	mov	x17, #-0x1000000000000000 // =-1152921504606846976
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x29               // =41
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x2, x1, #36
               	lsl	x2, x2, #36
               	asr	x3, x2, #36
               	asr	x2, x3, #63
               	mov	x17, #-0x3              // =-3
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x2, #0x2c               // =44
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x1, #0xfffffff000000000
               	orr	x1, x1, #0x800000000
               	stur	x1, [x29, #-0x28]
               	and	x2, x1, #0xfffffffff
               	lsl	x2, x2, #28
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	asr	x3, x2, #28
               	lsl	x2, x2, #36
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x0, #0x2f               // =47
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xfffffff000000000
               	orr	x0, x0, #0x400000000
               	stur	x0, [x29, #-0x28]
               	and	x0, x0, #0xfffffffff
               	lsl	x0, x0, #28
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	asr	x1, x0, #28
               	lsl	x0, x0, #36
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x32               // =50
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb0
               	mov	x1, #0xab               // =171
               	strb	w1, [x0]
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	and	x1, x1, #0xff
               	and	x2, x2, #0xfffff00000000000
               	orr	x3, x1, #0x300
               	orr	x1, x2, #0x200000
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x2, x1, #8
               	lsl	x1, x1, #56
               	orr	x1, x1, #0x3
               	and	x2, x2, #0xfffffffff
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x1, #0x35               // =53
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x38               // =56
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	ldr	w1, [x0]
               	and	x1, x1, #0xffffffffffffffe0
               	orr	x1, x1, #0x1f
               	str	w1, [x0]
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	and	x1, x1, #0x1f
               	and	x2, x2, #0xfffffffffffffffe
               	mov	x17, #0x160             // =352
               	orr	x3, x1, x17
               	orr	x1, x2, #0x1
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	and	x1, x1, #0xffffffffffe00001
               	orr	x1, x1, #0x1ffffe
               	str	x1, [x0, #0x8]
               	lsr	x2, x3, #5
               	lsl	x3, x1, #59
               	orr	x2, x2, x3
               	and	x2, x2, #0xfffffffffffffff
               	mov	x17, #0xb               // =11
               	movk	x17, #0x800, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x39               // =57
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [x0]
               	and	x0, x0, #0x1f
               	cmp	w0, #0x1f
               	b.ne	<addr>
               	asr	x0, x1, #1
               	and	x0, x0, #0xfffff
               	mov	x17, #0xfffff           // =1048575
               	cmp	w0, w17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3c               // =60
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	and	x0, x0, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x28]
               	and	x1, x0, #0xfffffffff
               	mov	x17, #0x4000000         // =67108864
               	add	x1, x1, x17
               	add	x1, x1, #0x0
               	and	x1, x1, #0xfffffffff
               	and	x0, x0, #0xfffffff000000000
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x28]
               	and	x2, x0, #0xfffffffff
               	mov	x17, #0x4000000         // =67108864
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x3e               // =62
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x1, x1, #0x0
               	and	x1, x1, #0xfffffffff
               	and	x0, x0, #0xfffffff000000000
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x28]
               	and	x2, x0, #0xfffffffff
               	mov	x17, #0xc000000         // =201326592
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x41               // =65
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x2, #0x0
               	sub	x1, x1, #0x0
               	and	x0, x0, #0xfffffff000000000
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x28]
               	and	x2, x0, #0xfffffffff
               	mov	x17, #0xc000000         // =201326592
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x44               // =68
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x1, x2, #5
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	and	x1, x1, #0xfffffffff
               	and	x0, x0, #0xfffffff000000000
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x28]
               	and	x2, x0, #0xfffffffff
               	mov	x17, #0x180000000       // =6442450944
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x47               // =71
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x1, x2, #3
               	lsl	x2, x2, #61
               	orr	x2, x2, #0x8
               	and	x0, x0, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	orr	x1, x0, x1
               	stur	x1, [x29, #-0x28]
               	and	x3, x1, #0xfffffffff
               	cmp	x2, #0x8
               	b.eq	<addr>
               	mov	x0, #0x49               // =73
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x0                // =0
               	orr	x2, x2, #0xff
               	orr	x0, x3, x4
               	and	x1, x1, #0xfffffff000000000
               	orr	x3, x4, x2
               	orr	x0, x1, x0
               	stur	x0, [x29, #-0x28]
               	and	x2, x0, #0xfffffffff
               	cmp	x3, #0xff
               	b.eq	<addr>
               	mov	x1, #0x4c               // =76
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x3, #0xfffffffffffffff0
               	and	x3, x2, #0xfffffffff
               	and	x0, x0, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x2, x1, x17
               	orr	x0, x0, x3
               	stur	x0, [x29, #-0x28]
               	and	x3, x0, #0xfffffffff
               	cmp	x2, #0xf0
               	b.eq	<addr>
               	mov	x1, #0x4f               // =79
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x55              // =85
               	eor	x2, x2, x17
               	eor	x1, x3, x4
               	and	x0, x0, #0xfffffff000000000
               	orr	x2, x4, x2
               	orr	x10, x0, x1
               	stur	x10, [x29, #-0x28]
               	and	x1, x10, #0xfffffffff
               	cmp	x2, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x52               // =82
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x2, x4
               	eor	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x3, lo
               	sub	x2, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x0, x0, x3
               	mov	x7, #0x7                // =7
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	cbz	x1, <addr>
               	mov	x1, #0x80               // =128
               	mov	x6, x4
               	mov	x3, x2
               	mov	x5, x4
               	b	<addr>
               	lsr	x8, x0, #63
               	lsl	x9, x5, #1
               	lsl	x2, x6, #1
               	lsr	x5, x5, #63
               	orr	x2, x2, x5
               	orr	x5, x9, x8
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	cmp	x2, #0x0
               	cset	x3, lo
               	cmp	x2, #0x0
               	cset	x6, eq
               	cmp	x5, #0x7
               	cset	x9, lo
               	and	x6, x6, x9
               	orr	x3, x3, x6
               	eor	x3, x3, #0x1
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x3
               	and	x6, x7, x6
               	cmp	x5, x6
               	cset	x9, lo
               	sub	x5, x5, x6
               	sub	x2, x2, #0x0
               	sub	x6, x2, x9
               	orr	x3, x8, x3
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	mov	x2, #0x0                // =0
               	eor	x1, x3, x2
               	eor	x0, x0, x2
               	cmp	x1, #0x0
               	cset	x3, lo
               	sub	x1, x1, #0x0
               	sub	x0, x0, #0x0
               	sub	x3, x0, x3
               	and	x0, x3, #0xfffffffff
               	and	x3, x10, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	orr	x10, x3, x0
               	stur	x10, [x29, #-0x28]
               	and	x3, x10, #0xfffffffff
               	mov	x17, #0xdb85            // =56197
               	movk	x17, #0x6db6, lsl #16
               	movk	x17, #0xb6db, lsl #32
               	movk	x17, #0xdb6d, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x55               // =85
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x1, x2
               	eor	x1, x3, x2
               	cmp	x0, #0x0
               	cset	x3, lo
               	sub	x4, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x0, x0, x3
               	mov	x6, #0x4243             // =16963
               	movk	x6, #0xf, lsl #16
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	cbz	x1, <addr>
               	mov	x1, #0x80               // =128
               	mov	x5, x2
               	mov	x3, x4
               	mov	x4, x2
               	b	<addr>
               	lsr	x7, x0, #63
               	lsl	x8, x4, #1
               	lsl	x5, x5, #1
               	lsr	x4, x4, #63
               	orr	x5, x5, x4
               	orr	x4, x8, x7
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	cmp	x5, #0x0
               	cset	x3, lo
               	cmp	x5, #0x0
               	cset	x7, eq
               	cmp	x4, x6
               	cset	x9, lo
               	and	x7, x7, x9
               	orr	x3, x3, x7
               	eor	x3, x3, #0x1
               	sub	x7, x2, x3
               	and	x7, x6, x7
               	cmp	x4, x7
               	cset	x9, lo
               	sub	x4, x4, x7
               	sub	x5, x5, #0x0
               	sub	x5, x5, x9
               	orr	x3, x8, x3
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	eor	x0, x4, x2
               	eor	x1, x5, x2
               	cmp	x0, #0x0
               	cset	x2, lo
               	sub	x0, x0, #0x0
               	sub	x1, x1, #0x0
               	sub	x1, x1, x2
               	and	x1, x1, #0xfffffffff
               	and	x2, x10, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x3, x0, x17
               	orr	x1, x2, x1
               	stur	x1, [x29, #-0x28]
               	and	x0, x1, #0xfffffffff
               	mov	x17, #0x47c3            // =18371
               	movk	x17, #0x2, lsl #16
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xfffffff000000000
               	orr	x0, x0, #0xfffffffff
               	stur	x0, [x29, #-0x28]
               	and	x1, x0, #0xfffffffff
               	add	x1, x1, #0x0
               	add	x1, x1, #0x1
               	and	x1, x1, #0xfffffffff
               	and	x0, x0, #0xfffffff000000000
               	orr	x1, x0, x1
               	stur	x1, [x29, #-0x28]
               	and	x0, x1, #0xfffffffff
               	cbz	x0, <addr>
               	mov	x0, #0x5c               // =92
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x28]
               	and	x1, x0, #0xfffffffff
               	sub	x1, x1, #0x1
               	add	x1, x1, #0x0
               	and	x1, x1, #0xfffffffff
               	and	x0, x0, #0xfffffff000000000
               	orr	x1, x0, x1
               	stur	x1, [x29, #-0x28]
               	and	x0, x1, #0xfffffffff
               	mov	x17, #0xfffffffff       // =68719476735
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5f               // =95
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x28]
               	and	x1, x0, #0xfffffffff
               	add	x2, x1, #0x0
               	add	x2, x2, #0x0
               	and	x0, x0, #0xfffffff000000000
               	orr	x2, x0, x2
               	stur	x2, [x29, #-0x28]
               	cbz	x1, <addr>
               	mov	x0, #0x62               // =98
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x2, #0xfffffffff
               	cbz	x0, <addr>
               	mov	x0, #0x65               // =101
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x2, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	stur	x1, [x29, #-0x28]
               	and	x0, x1, #0xfffffffff
               	add	x0, x0, #0x0
               	add	x0, x0, #0x0
               	and	x1, x1, #0xfffffff000000000
               	orr	x1, x1, x0
               	stur	x1, [x29, #-0x28]
               	cbz	x0, <addr>
               	mov	x0, #0x68               // =104
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	and	x0, x0, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x28]
               	and	x0, x0, #0xfffffffff
               	mov	x17, #0x3e8000000000    // =68719476736000
               	orr	x1, x0, x17
               	stur	x1, [x29, #-0x28]
               	lsr	x0, x1, #36
               	cmp	w0, #0x3e8
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	and	x1, x1, #0xfffffffff
               	mov	x17, #0x3ef000000000    // =69200513073152
               	orr	x1, x1, x17
               	stur	x1, [x29, #-0x28]
               	lsr	x2, x1, #36
               	cmp	w2, #0x3ef
               	b.eq	<addr>
               	mov	x0, #0x6c               // =108
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x1, #0xfffffffff
               	orr	x1, x1, #0x3f0000000000
               	stur	x1, [x29, #-0x28]
               	lsr	x2, x1, #36
               	cmp	w2, #0x3f0
               	b.eq	<addr>
               	mov	x0, #0x6d               // =109
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x2, [x29, #-0x28]
               	and	x2, x2, #0xfffffff000000000
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	stur	x2, [x29, #-0x28]
               	and	x2, x2, #0xfffffffff
               	mov	x17, #0xffb000000000    // =281131379326976
               	movk	x17, #0xffff, lsl #48
               	orr	x2, x2, x17
               	stur	x2, [x29, #-0x28]
               	lsr	x3, x2, #36
               	lsl	x3, x3, #36
               	asr	x4, x3, #36
               	mov	x17, #-0x5              // =-5
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x2, x0
               	and	x1, x1, #0xfffffffff
               	cbz	x1, <addr>
               	mov	x1, #0x70               // =112
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x6e               // =110
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6b               // =107
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	cbz	x0, <addr>
               	mov	x0, #0x59               // =89
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x3, x4, x6
               	msub	x4, x3, x6, x4
               	mov	x5, x2
               	mov	x0, x2
               	b	<addr>
               	mov	x17, #0x6db6            // =28086
               	movk	x17, #0x6db, lsl #16
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x56               // =86
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
               	udiv	x3, x2, x7
               	msub	x5, x3, x7, x2
               	mov	x6, x4
               	mov	x0, x4
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x53               // =83
               	b	<addr>
               	mov	x0, x4
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x1, #0x50               // =80
               	b	<addr>
               	mov	x1, x4
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x4d               // =77
               	b	<addr>
               	mov	x1, x4
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x4a               // =74
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x2000            // =8192
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x36               // =54
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x400000000       // =17179869184
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #-0x800000000      // =-34359738368
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x30               // =48
               	b	<addr>
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x2d               // =45
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x2, #0x2a               // =42
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	cbz	x0, <addr>
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
