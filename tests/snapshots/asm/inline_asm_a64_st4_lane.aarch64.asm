
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
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x20
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ld4	{ v0.s, v1.s, v2.s, v3.s }[0], [x0], #16
               	ld4	{ v0.s, v1.s, v2.s, v3.s }[3], [x0]
               	st4	{ v0.s, v1.s, v2.s, v3.s }[0], [x1], #16
               	st4	{ v0.s, v1.s, v2.s, v3.s }[3], [x1]
               	ldur	w0, [x29, #-0x20]
               	ldur	w1, [x29, #-0x40]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x1c]
               	ldur	w1, [x29, #-0x3c]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x18]
               	ldur	w1, [x29, #-0x38]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x14]
               	ldur	w1, [x29, #-0x34]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x10]
               	ldur	w1, [x29, #-0x30]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0xc]
               	ldur	w1, [x29, #-0x2c]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x28]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x4]
               	ldur	w1, [x29, #-0x24]
               	cmp	w0, w1
               	b.ne	<addr>
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x30
               	str	xzr, [x1]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	mov	x16, #0x4               // =4
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ld2	{ v4.h, v5.h }[0], [x0], x2
               	ld2	{ v4.h, v5.h }[7], [x0]
               	st2	{ v4.h, v5.h }[0], [x1], x2
               	st2	{ v4.h, v5.h }[7], [x1]
               	ldurh	w0, [x29, #-0x30]
               	ldurh	w1, [x29, #-0x28]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x2e]
               	ldurh	w1, [x29, #-0x26]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x2c]
               	ldurh	w1, [x29, #-0x24]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x2a]
               	ldurh	w1, [x29, #-0x22]
               	cmp	w0, w1
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x1, x29, #0x18
               	stp	xzr, xzr, [x1]
               	str	xzr, [x1, #0x10]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ld3	{ v5.d, v6.d, v7.d }[1], [x0], #24
               	st3	{ v5.d, v6.d, v7.d }[1], [x1]
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x38]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x30]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x28]
               	cmp	x0, x1
               	b.ne	<addr>
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	q0, [x1]
               	str	x0, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	st1	{ v0.s }[1], [x0]
               	add	x0, x0, #0x4
               	st1	{ v0.s }[3], [x0]
               	ldur	w0, [x29, #-0x8]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x4]
               	cmp	w0, #0xd
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
