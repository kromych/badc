
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
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x1
               	sub	x17, x29, #0x20
               	str	d16, [x17]
               	strb	w2, [x0]
               	mov	x4, #0x2                // =2
               	strb	w4, [x0]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	mov	x3, #0x1                // =1
               	strb	w3, [x0]
               	strb	w1, [x0]
               	strb	w1, [x0]
               	strb	w3, [x0]
               	strb	w2, [x0]
               	strb	w3, [x0]
               	strb	w1, [x0]
               	strb	w1, [x0]
               	strb	w4, [x0]
               	strb	w1, [x0]
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x2, ne
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	lsl	x2, x2, #1
               	mov	x17, #0x1               // =1
               	orr	x2, x2, x17
               	strb	w2, [x0]
               	mov	x17, #0xff              // =255
               	and	x0, x2, x17
               	asr	x0, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x2, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x2
               	fcvtzs	x2, d16
               	mov	x17, #0x7               // =7
               	and	x2, x2, x17
               	ldr	w3, [x0]
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	lsl	x2, x2, #2
               	orr	x2, x3, x2
               	str	w2, [x0]
               	mov	w3, w2
               	asr	x4, x3, #2
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	mov	x17, #0x2               // =2
               	eor	x4, x4, x17
               	mov	w4, w4
               	cbz	x4, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x4
               	fcvtzs	x4, d16
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	mov	x17, #0xfe1f            // =65055
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x3, x17
               	lsl	x3, x4, #5
               	orr	x2, x2, x3
               	str	w2, [x0]
               	mov	w3, w2
               	asr	x4, x3, #5
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	lsl	x4, x4, #60
               	asr	x4, x4, #60
               	cmp	x4, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x3, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	str	w2, [x0]
               	mov	w3, w2
               	asr	x4, x3, #2
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	cbz	x4, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x3, x17
               	mov	x17, #0x4               // =4
               	orr	x2, x2, x17
               	str	w2, [x0]
               	mov	w3, w2
               	asr	x4, x3, #2
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	w4, w4
               	cbz	x4, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfe1f            // =65055
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x3, x17
               	mov	x17, #0x120             // =288
               	orr	x2, x2, x17
               	str	w2, [x0]
               	mov	w2, w2
               	asr	x2, x2, #5
               	mov	x17, #0xf               // =15
               	and	x2, x2, x17
               	lsl	x2, x2, #60
               	asr	x2, x2, #60
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	asr	x2, x2, #1
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	asr	x2, x2, #2
               	mov	x17, #0x7               // =7
               	and	x2, x2, x17
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbz	x2, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	asr	x2, x2, #5
               	mov	x17, #0xf               // =15
               	and	x2, x2, x17
               	lsl	x2, x2, #60
               	asr	x2, x2, #60
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2, #0x1]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2, #0x2]
               	cmp	w2, #0x1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cbz	x2, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cbz	x2, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2, #0x1]
               	cbz	x2, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2, #0x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	asr	x2, x2, #1
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w1, [x0]
               	strb	w1, [x0]
               	mov	x2, #0x2                // =2
               	strb	w2, [x0]
               	ldr	w3, [x0]
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x3, x3, x1
               	str	w3, [x0]
               	mov	w3, w3
               	mov	x17, #0xfe1f            // =65055
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x1, x3, x1
               	str	w1, [x0]
               	ldrb	w0, [x0]
               	asr	x0, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x0, #0x8]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	strb	w2, [x0, #0x8]
               	ldrb	w0, [x0, #0x8]
               	asr	x0, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
