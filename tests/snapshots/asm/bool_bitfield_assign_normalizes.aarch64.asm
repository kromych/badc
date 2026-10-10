
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
               	fmov	d0, #0.50000000
               	sturb	wzr, [x29, #-0x8]
               	mov	x3, #0x2                // =2
               	sturb	w3, [x29, #-0x8]
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	sturb	w1, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w1, [x29, #-0x8]
               	sturb	wzr, [x29, #-0x8]
               	sturb	w1, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w3, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, ne
               	and	x1, x1, #0x1
               	lsl	x1, x1, #1
               	orr	x1, x1, #0x1
               	sturb	w1, [x29, #-0x8]
               	asr	x1, x1, #1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.50000000
               	fcvtzs	x1, d0
               	and	x1, x1, #0x7
               	ldur	w3, [x29, #-0x8]
               	and	x3, x3, #0xffffffffffffffe3
               	lsl	x1, x1, #2
               	orr	x1, x3, x1
               	stur	w1, [x29, #-0x8]
               	mov	w3, w1
               	asr	x3, x3, #2
               	and	x3, x3, #0x7
               	eor	x3, x3, #0x2
               	cbz	w3, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.50000000
               	fcvtzs	x3, d0
               	and	x3, x3, #0xf
               	and	x1, x1, #0xfffffffffffffe1f
               	lsl	x3, x3, #5
               	orr	x1, x1, x3
               	stur	w1, [x29, #-0x8]
               	mov	w3, w1
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
               	and	x1, x1, #0xffffffffffffffe3
               	stur	w1, [x29, #-0x8]
               	mov	w3, w1
               	asr	x3, x3, #2
               	and	x3, x3, #0x7
               	cbz	w3, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x1, #0xffffffffffffffe3
               	orr	x1, x1, #0x4
               	stur	w1, [x29, #-0x8]
               	mov	w3, w1
               	asr	x3, x3, #2
               	and	x3, x3, #0x7
               	eor	x3, x3, #0x1
               	cbz	w3, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x1, #0xfffffffffffffe1f
               	mov	x17, #0x120             // =288
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x8]
               	mov	w1, w1
               	asr	x1, x1, #5
               	and	x1, x1, #0xf
               	lsl	x1, x1, #60
               	asr	x1, x1, #60
               	mov	x17, #-0x7              // =-7
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w3, [x1]
               	and	x3, x3, #0x1
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w3, [x1]
               	asr	x3, x3, #1
               	and	x3, x3, #0x1
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w3, [x1]
               	asr	x3, x3, #2
               	and	x3, x3, #0x7
               	eor	x3, x3, #0x1
               	cbz	w3, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w1, [x1]
               	asr	x1, x1, #5
               	and	x1, x1, #0xf
               	lsl	x1, x1, #60
               	asr	x1, x1, #60
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w3, [x1]
               	cmp	w3, #0x1
               	b.ne	<addr>
               	ldrb	w3, [x1, #0x1]
               	cbnz	w3, <addr>
               	ldrb	w1, [x1, #0x2]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w3, [x1]
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w3, [x1, #0x1]
               	cbz	w3, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x1, #0x2]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w3, [x1]
               	and	x3, x3, #0x1
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x1]
               	asr	x1, x1, #1
               	tbz	w1, #0x0, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x2]
               	sturb	w0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x8]
               	ldur	w2, [x29, #-0x8]
               	and	x2, x2, #0xffffffffffffffe3
               	stur	w2, [x29, #-0x8]
               	and	x2, x2, #0xfffffffffffffe1f
               	stur	w2, [x29, #-0x8]
               	ldurb	w2, [x29, #-0x8]
               	asr	x2, x2, #1
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x10
               	stp	xzr, xzr, [x2]
               	sturb	w1, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffffd
               	sturb	w1, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x8]
               	asr	x1, x1, #1
               	tbz	w1, #0x0, <addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
