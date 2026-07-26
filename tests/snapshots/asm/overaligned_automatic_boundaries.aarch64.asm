
overaligned_automatic_boundaries.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<at16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffffff0
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x0, sp
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	strh	w2, [x0]
               	mov	x0, sp
               	mov	x2, #0x2                // =2
               	strh	w2, [x0, #0x7e]
               	mov	x0, sp
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, sp
               	ldrsh	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldrsh	x0, [x0, #0x7e]
               	cmp	x0, #0x2
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<alignas16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffffff0
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x1, sp
               	mov	x0, #0x0                // =0
               	mov	x2, #0x7                // =7
               	str	x2, [x1]
               	mov	x1, sp
               	mov	x2, #0x8                // =8
               	str	x2, [x1, #0x18]
               	mov	x1, sp
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, sp
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x8
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x2, #0x1                // =1
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	sub	sp, x29, #0x60
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<type16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	sp, sp, #0x10
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffffff0
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x0, sp
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	mov	x0, sp
               	mov	x1, #0xa                // =10
               	str	w1, [x0, #0x4]
               	mov	x0, sp
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, sp
               	ldrsw	x0, [x0]
               	cmp	x0, #0x9
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0xa
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	sub	sp, x29, #0x30
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	add	x1, sp, #0x60
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1                // =1
               	strb	w2, [x1]
               	add	x1, sp, #0x40
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	mov	x1, sp
               	mov	x2, #0x3                // =3
               	strb	w2, [x1]
               	add	x1, sp, #0x60
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x1, [x2]
               	add	x1, sp, #0x60
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	add	x0, sp, #0x40
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, sp
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	add	x0, sp, #0x60
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	add	x0, sp, #0x40
               	ldrb	w0, [x0]
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldrb	w0, [x0]
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<at_page>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x20
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	str	xzr, [sp]
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffff000
               	str	xzr, [sp]
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x0, sp
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	strb	w2, [x0]
               	mov	x0, sp
               	mov	x2, #0x2                // =2
               	strb	w2, [x0, #0xfff]
               	mov	x0, sp
               	mov	x17, #0xfff             // =4095
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, sp
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldrb	w0, [x0, #0xfff]
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	sub	x16, x16, #0x20
               	mov	sp, x16
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<over_a_page>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x350
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x340
               	str	xzr, [sp]
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	str	xzr, [sp]
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x1, sp
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1                // =1
               	strb	w2, [x1]
               	mov	x1, sp
               	mov	x17, #0x1000            // =4096
               	add	x1, x1, x17
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	mov	x1, sp
               	mov	x17, #0x2327            // =8999
               	add	x1, x1, x17
               	mov	x2, #0x3                // =3
               	strb	w2, [x1]
               	mov	x1, sp
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, sp
               	mov	x17, #0x1000            // =4096
               	add	x0, x0, x17
               	ldrb	w0, [x0]
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, sp
               	mov	x17, #0x2327            // =8999
               	add	x0, x0, x17
               	ldrb	w0, [x0]
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x350
               	mov	sp, x16
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x1, sp
               	mov	x0, #0x0                // =0
               	mov	x2, #0x4                // =4
               	strh	w2, [x1]
               	mov	x1, sp
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldrsh	x0, [x0]
               	cmp	x0, #0x4
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
