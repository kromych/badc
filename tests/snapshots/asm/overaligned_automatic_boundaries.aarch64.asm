
overaligned_automatic_boundaries.aarch64:	file format elf64-littleaarch64

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

<type32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	mov	x1, #0xa                // =10
               	str	w1, [x0, #0x4]
               	mov	x17, #0x1f              // =31
               	and	x1, x0, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	sxtw	x2, w1
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x2, [x0]
               	cmp	x2, #0x9
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0xa
               	cset	x1, eq
               	sxtw	x0, w1
               	sub	sp, x29, #0x40
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x2, x1
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
               	add	x2, sp, #0x40
               	mov	x3, #0x2                // =2
               	strb	w3, [x2]
               	mov	x3, sp
               	mov	x4, #0x3                // =3
               	strb	w4, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x1, [x4]
               	mov	x17, #0xf               // =15
               	and	x4, x1, x17
               	cmp	x4, #0x0
               	cset	x4, eq
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	mov	x17, #0x1f              // =31
               	and	x4, x2, x17
               	cmp	x4, #0x0
               	cset	x4, eq
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	mov	x17, #0x3f              // =63
               	and	x4, x3, x17
               	cmp	x4, #0x0
               	cset	x4, eq
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	ldrb	w1, [x1]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [x2]
               	mov	x17, #0x2               // =2
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [x3]
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
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
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	strb	w2, [x0]
               	mov	x2, #0x2                // =2
               	strb	w2, [x0, #0xfff]
               	mov	x17, #0xfff             // =4095
               	and	x2, x0, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w0, [x0, #0xfff]
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	sxtw	x0, w1
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	sub	x16, x16, #0x20
               	mov	sp, x16
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x2, x1
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
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	strb	w2, [x0]
               	mov	x17, #0x1000            // =4096
               	add	x3, x0, x17
               	mov	x2, #0x2                // =2
               	strb	w2, [x3]
               	mov	x17, #0x2327            // =8999
               	add	x4, x0, x17
               	mov	x2, #0x3                // =3
               	strb	w2, [x4]
               	mov	x17, #0x3f              // =63
               	and	x2, x0, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w2, [x3]
               	mov	x17, #0x2               // =2
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w0, [x4]
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	sxtw	x0, w1
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x350
               	mov	sp, x16
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>

<nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x1, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x4                // =4
               	strh	w2, [x1]
               	mov	x17, #0x1f              // =31
               	and	x2, x1, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	ldrsh	x0, [x1]
               	cmp	x0, #0x4
               	cset	x0, eq
               	sxtw	x0, w0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	sub	x0, x29, #0x140
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	strh	w2, [x0]
               	mov	x3, #0x2                // =2
               	strh	w3, [x0, #0x7e]
               	mov	x17, #0xf               // =15
               	and	x3, x0, x17
               	cmp	x3, #0x0
               	cset	x3, eq
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	ldrsh	x3, [x0]
               	cmp	x3, #0x1
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsh	x0, [x0, #0x7e]
               	cmp	x0, #0x2
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x0, [x3]
               	mov	x3, #0x7                // =7
               	str	x3, [x0]
               	mov	x3, #0x8                // =8
               	str	x3, [x0, #0x18]
               	mov	x17, #0xf               // =15
               	and	x3, x0, x17
               	cmp	x3, #0x0
               	cset	x3, eq
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	ldr	x3, [x0]
               	cmp	x3, #0x7
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x8
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, x2
               	cbz	x0, <addr>
               	mov	x1, x2
               	sxtw	x0, w1
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
