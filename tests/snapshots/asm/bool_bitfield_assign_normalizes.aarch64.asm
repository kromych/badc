
bool_bitfield_assign_normalizes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	wzr, [x0]
               	mov	x5, #0x3fe0000000000000 // =4602678819172646912
               	mov	x3, #0x0                // =0
               	strb	w3, [x0]
               	mov	x4, #0x2                // =2
               	strb	w4, [x0]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	mov	x2, #0x1                // =1
               	strb	w2, [x0]
               	strb	w1, [x0]
               	strb	w1, [x0]
               	strb	w2, [x0]
               	strb	w3, [x0]
               	strb	w2, [x0]
               	strb	w1, [x0]
               	strb	w1, [x0]
               	strb	w4, [x0]
               	strb	w1, [x0]
               	sub	x1, x29, #0x8
               	mov	x0, #0x0                // =0
               	fmov	d16, x5
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x2, ne
               	and	x2, x2, #0x1
               	lsl	x2, x2, #1
               	orr	x2, x2, #0x1
               	strb	w2, [x1]
               	asr	x2, x2, #1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x2
               	fcvtzs	x2, d16
               	and	x2, x2, #0x7
               	ldr	w3, [x1]
               	and	x3, x3, #0xffffffffffffffe3
               	lsl	x2, x2, #2
               	orr	x2, x3, x2
               	str	w2, [x1]
               	mov	w3, w2
               	asr	x3, x3, #2
               	and	x3, x3, #0x7
               	eor	x3, x3, #0x2
               	cbz	w3, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x3
               	fcvtzs	x3, d16
               	and	x3, x3, #0xf
               	and	x2, x2, #0xfffffffffffffe1f
               	lsl	x3, x3, #5
               	orr	x2, x2, x3
               	str	w2, [x1]
               	mov	w3, w2
               	asr	x3, x3, #5
               	and	x3, x3, #0xf
               	lsl	x3, x3, #60
               	asr	x3, x3, #60
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x2, #0xffffffffffffffe3
               	str	w2, [x1]
               	mov	w3, w2
               	asr	x3, x3, #2
               	and	x3, x3, #0x7
               	cbz	w3, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x2, #0xffffffffffffffe3
               	orr	x2, x2, #0x4
               	str	w2, [x1]
               	mov	w3, w2
               	asr	x3, x3, #2
               	and	x3, x3, #0x7
               	eor	x3, x3, #0x1
               	cbz	w3, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x2, #0xfffffffffffffe1f
               	mov	x17, #0x120             // =288
               	orr	x2, x2, x17
               	str	w2, [x1]
               	mov	w2, w2
               	asr	x2, x2, #5
               	and	x2, x2, #0xf
               	lsl	x2, x2, #60
               	asr	x2, x2, #60
               	mov	x17, #-0x7              // =-7
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	and	x3, x3, #0x1
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w3, [x2]
               	asr	x3, x3, #1
               	and	x3, x3, #0x1
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w3, [x2]
               	asr	x3, x3, #2
               	and	x3, x3, #0x7
               	eor	x3, x3, #0x1
               	cbz	w3, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w2, [x2]
               	asr	x2, x2, #5
               	and	x2, x2, #0xf
               	lsl	x2, x2, #60
               	asr	x2, x2, #60
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	cmp	w3, #0x1
               	b.ne	<addr>
               	ldrb	w3, [x2, #0x1]
               	cbnz	w3, <addr>
               	ldrb	w2, [x2, #0x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cbz	w2, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cbz	w2, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w3, [x2, #0x1]
               	cbz	w3, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x2, #0x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	and	x3, x3, #0x1
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x2]
               	asr	x2, x2, #1
               	tbz	w2, #0x0, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x1]
               	strb	w0, [x1]
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	ldr	w3, [x1]
               	and	x3, x3, #0xffffffffffffffe3
               	str	w3, [x1]
               	and	x3, x3, #0xfffffffffffffe1f
               	str	w3, [x1]
               	ldrb	w1, [x1]
               	asr	x1, x1, #1
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	strb	w2, [x1, #0x8]
               	ldrb	w2, [x1, #0x8]
               	and	x2, x2, #0xfffffffffffffffd
               	strb	w2, [x1, #0x8]
               	ldrb	w1, [x1, #0x8]
               	asr	x1, x1, #1
               	tbz	w1, #0x0, <addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
