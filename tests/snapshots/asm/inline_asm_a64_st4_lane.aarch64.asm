
inline_asm_a64_st4_lane.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xb0
               	sub	x3, x29, #0x38
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x3, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x2, x29, #0x58
               	mov	x0, #0x0                // =0
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	str	x0, [x2, #0x10]
               	str	x0, [x2, #0x18]
               	stur	x3, [x29, #-0x60]
               	stur	x2, [x29, #-0x68]
               	sub	x1, x29, #0x60
               	sub	x4, x29, #0x68
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	d0, [sp, #0x20]
               	str	d1, [sp, #0x28]
               	str	d2, [sp, #0x30]
               	str	d3, [sp, #0x38]
               	str	x1, [sp]
               	str	x4, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ld4	{ v0.s, v1.s, v2.s, v3.s }[0], [x0], #16
               	ld4	{ v0.s, v1.s, v2.s, v3.s }[3], [x0]
               	st4	{ v0.s, v1.s, v2.s, v3.s }[0], [x1], #16
               	st4	{ v0.s, v1.s, v2.s, v3.s }[3], [x1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	d0, [sp, #0x20]
               	ldr	d1, [sp, #0x28]
               	ldr	d2, [sp, #0x30]
               	ldr	d3, [sp, #0x38]
               	b	<addr>
               	sxtw	x1, w0
               	ldr	w4, [x2, x1, lsl #2]
               	ldr	w5, [x3, x1, lsl #2]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x1                // =1
               	cbz	x0, <addr>
               	sub	x2, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x28
               	mov	x0, #0x0                // =0
               	str	x0, [x3]
               	stur	x2, [x29, #-0x30]
               	stur	x3, [x29, #-0x38]
               	mov	x1, #0x4                // =4
               	sub	x4, x29, #0x30
               	sub	x5, x29, #0x38
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	d4, [sp, #0x30]
               	str	d5, [sp, #0x38]
               	str	x4, [sp]
               	str	x5, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ldr	x2, [sp, #0x10]
               	ld2	{ v4.h, v5.h }[0], [x0], x2
               	ld2	{ v4.h, v5.h }[7], [x0]
               	st2	{ v4.h, v5.h }[0], [x1], x2
               	st2	{ v4.h, v5.h }[7], [x1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldr	d4, [sp, #0x30]
               	ldr	d5, [sp, #0x38]
               	b	<addr>
               	sxtw	x1, w0
               	ldrh	w4, [x3, x1, lsl #1]
               	ldrh	w5, [x2, x1, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x3, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x2, x29, #0x48
               	mov	x0, #0x0                // =0
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	str	x0, [x2, #0x10]
               	stur	x3, [x29, #-0x50]
               	stur	x2, [x29, #-0x58]
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x58
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	d5, [sp, #0x20]
               	str	d6, [sp, #0x28]
               	str	d7, [sp, #0x30]
               	str	x1, [sp]
               	str	x4, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	ldr	x1, [x16]
               	ld3	{ v5.d, v6.d, v7.d }[1], [x0], #24
               	st3	{ v5.d, v6.d, v7.d }[1], [x1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	d5, [sp, #0x20]
               	ldr	d6, [sp, #0x28]
               	ldr	d7, [sp, #0x30]
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x4, [x2, x1, lsl #3]
               	ldr	x5, [x3, x1, lsl #3]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	stur	x0, [x29, #-0x28]
               	sub	x2, x29, #0x38
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	sub	x3, x29, #0x28
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x3, [sp]
               	str	x2, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	st1	{ v0.s }[1], [x0]
               	add	x0, x0, #0x4
               	st1	{ v0.s }[3], [x0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	ldr	w2, [x0]
               	cmp	w2, #0x9
               	b.ne	<addr>
               	ldr	w0, [x0, #0x4]
               	cmp	w0, #0xd
               	cset	x1, eq
               	sxtw	x0, w1
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
