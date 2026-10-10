
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
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x1, #0x9                // =9
               	str	w1, [sp]
               	mov	x1, #0xa                // =10
               	str	w1, [sp, #0x4]
               	and	x1, x0, #0x1f
               	mov	x0, #0x0                // =0
               	cbnz	w1, <addr>
               	ldrsw	x1, [sp]
               	cmp	w1, #0x9
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrsw	x0, [sp, #0x4]
               	cmp	w0, #0xa
               	cset	x0, eq
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>

<mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	add	x0, sp, #0x60
               	mov	x1, #0x1                // =1
               	strb	w1, [sp, #0x60]
               	add	x1, sp, #0x40
               	mov	x2, #0x2                // =2
               	strb	w2, [sp, #0x40]
               	mov	x2, sp
               	mov	x3, #0x3                // =3
               	strb	w3, [sp]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x0, [x3]
               	and	x3, x0, #0xf
               	mov	x0, #0x0                // =0
               	cbnz	w3, <addr>
               	and	x1, x1, #0x1f
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	and	x1, x2, #0x3f
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [sp, #0x60]
               	eor	x1, x1, #0x1
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [sp, #0x40]
               	eor	x1, x1, #0x2
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [sp]
               	eor	x0, x0, #0x3
               	cmp	w0, #0x0
               	cset	x0, eq
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>

<at_page>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
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
               	mov	x1, #0x1                // =1
               	strb	w1, [sp]
               	mov	x1, #0x2                // =2
               	strb	w1, [sp, #0xfff]
               	and	x1, x0, #0xfff
               	mov	x0, #0x0                // =0
               	cbnz	w1, <addr>
               	ldrb	w1, [sp]
               	eor	x1, x1, #0x1
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [sp, #0xfff]
               	eor	x0, x0, #0x2
               	cmp	w0, #0x0
               	cset	x0, eq
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>

<over_a_page>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
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
               	mov	x1, #0x1                // =1
               	strb	w1, [sp]
               	add	x1, x0, #0x1, lsl #12   // =0x1000
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	mov	x17, #0x2327            // =8999
               	add	x2, x0, x17
               	mov	x3, #0x3                // =3
               	strb	w3, [x2]
               	and	x3, x0, #0x3f
               	mov	x0, #0x0                // =0
               	cbnz	w3, <addr>
               	ldrb	w3, [sp]
               	eor	x3, x3, #0x1
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w1, [x1]
               	eor	x1, x1, #0x2
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [x2]
               	eor	x0, x0, #0x3
               	cmp	w0, #0x0
               	cset	x0, eq
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>

<nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x1, #0x4                // =4
               	strh	w1, [sp]
               	and	x1, x0, #0x1f
               	mov	x0, #0x0                // =0
               	cbnz	w1, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x2, #0x1                // =1
               	sturh	w2, [x29, #-0xa0]
               	mov	x3, #0x2                // =2
               	sturh	w3, [x29, #-0x22]
               	and	x0, x0, #0xf
               	cbnz	w0, <addr>
               	ldursh	x0, [x29, #-0xa0]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	sub	x0, x29, #0x20
               	str	x0, [x1]
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x20]
               	mov	x1, #0x8                // =8
               	stur	x1, [x29, #-0x8]
               	and	x0, x0, #0xf
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x20]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
