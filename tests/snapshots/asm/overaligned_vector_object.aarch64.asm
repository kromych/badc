
overaligned_vector_object.aarch64:	file format elf64-littleaarch64

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

<automatic_boundaries>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	add	x0, sp, #0x10
               	mov	x17, #0xf               // =15
               	and	x1, x0, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, sp
               	mov	x17, #0x1f              // =31
               	and	x3, x1, x17
               	cmp	w3, #0x0
               	cset	x4, ne
               	sxtw	x2, w4
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, #0x7                // =7
               	sturb	w5, [x29, #-0x8]
               	mov	x6, #0x8                // =8
               	sturb	w6, [x29, #-0x20]
               	mov	x7, #0xb                // =11
               	str	w7, [x0]
               	mov	x7, #0xd                // =13
               	str	w7, [x0, #0xc]
               	mov	x7, #0x11               // =17
               	str	w7, [x1, #0x4]
               	ldrsw	x8, [x0]
               	ldrsw	x0, [x0, #0xc]
               	add	x0, x8, x0
               	add	x0, x0, x7
               	cmp	w0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x8]
               	ldurb	w7, [x29, #-0x20]
               	add	x0, x0, x7
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, x5
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbz	x2, <addr>
               	mov	x0, x6
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x0, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x13               // =19
               	str	w1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x17               // =23
               	str	w2, [x1]
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x0, #0x17
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	cmp	w0, #0x6
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	ldrb	w1, [x2]
               	add	x0, x0, x1
               	cmp	w0, #0xf
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
