
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
               	and	x1, x0, #0x1f
               	cmp	w1, #0x0
               	cset	x1, eq
               	sxtw	x2, w1
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x9
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0xa
               	cset	x1, eq
               	sxtw	x0, w1
               	sub	sp, x29, #0x40
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	and	x4, x1, #0xf
               	cmp	w4, #0x0
               	cset	x4, eq
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	and	x4, x2, #0x1f
               	cmp	w4, #0x0
               	cset	x4, eq
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	and	x4, x3, #0x3f
               	cmp	w4, #0x0
               	cset	x4, eq
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	ldrb	w1, [x1]
               	eor	x1, x1, #0x1
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [x2]
               	eor	x1, x1, #0x2
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [x3]
               	eor	x0, x0, #0x3
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	and	x2, x0, #0xfff
               	cmp	w2, #0x0
               	cset	x2, eq
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	eor	x2, x2, #0x1
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w0, [x0, #0xfff]
               	eor	x0, x0, #0x2
               	cmp	w0, #0x0
               	cset	x1, eq
               	sxtw	x0, w1
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	sub	x16, x16, #0x20
               	mov	sp, x16
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	add	x3, x0, #0x1, lsl #12   // =0x1000
               	mov	x2, #0x2                // =2
               	strb	w2, [x3]
               	mov	x17, #0x2327            // =8999
               	add	x4, x0, x17
               	mov	x2, #0x3                // =3
               	strb	w2, [x4]
               	and	x2, x0, #0x3f
               	cmp	w2, #0x0
               	cset	x2, eq
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	eor	x2, x2, #0x1
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w2, [x3]
               	eor	x2, x2, #0x2
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w0, [x4]
               	eor	x0, x0, #0x3
               	cmp	w0, #0x0
               	cset	x1, eq
               	sxtw	x0, w1
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x350
               	mov	sp, x16
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	and	x1, x1, #0x1f
               	cmp	w1, #0x0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	sub	sp, x29, #0xa0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x150
               	str	x20, [sp]
               	sub	x1, x29, #0x140
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	x1, [x20]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1                // =1
               	strh	w2, [x1]
               	mov	x3, #0x2                // =2
               	strh	w3, [x1, #0x7e]
               	and	x4, x1, #0xf
               	cmp	w4, #0x0
               	cset	x4, eq
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	ldrsh	x4, [x1]
               	cmp	w4, #0x1
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsh	x1, [x1, #0x7e]
               	cmp	w1, #0x2
               	cset	x1, eq
               	cbnz	w1, <addr>
               	mov	x0, x2
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	str	x1, [x20]
               	mov	x4, #0x7                // =7
               	str	x4, [x1]
               	mov	x4, #0x8                // =8
               	str	x4, [x1, #0x18]
               	and	x4, x1, #0xf
               	cmp	w4, #0x0
               	cset	x4, eq
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	ldr	x4, [x1]
               	cmp	x4, #0x7
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldr	x1, [x1, #0x18]
               	cmp	x1, #0x8
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, x2
               	cbz	x1, <addr>
               	mov	x0, x2
               	cbnz	w0, <addr>
               	mov	x0, x3
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20]
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
