
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

<st4_lane_words>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
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
               	add	sp, sp, #0x50
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
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x28
               	str	xzr, [x1]
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	mov	x16, #0x4               // =4
               	str	x16, [sp, #0x20]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	x2, [sp, #0x20]
               	ld2	{ v4.h, v5.h }[0], [x0], x2
               	ld2	{ v4.h, v5.h }[7], [x0]
               	st2	{ v4.h, v5.h }[0], [x1], x2
               	st2	{ v4.h, v5.h }[7], [x1]
               	ldurh	w0, [x29, #-0x28]
               	ldurh	w1, [x29, #-0x20]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x26]
               	ldurh	w1, [x29, #-0x1e]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x24]
               	ldurh	w1, [x29, #-0x1c]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x22]
               	ldurh	w1, [x29, #-0x1a]
               	cmp	w0, w1
               	b.ne	<addr>
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x1, x29, #0x48
               	stp	xzr, xzr, [x1]
               	str	xzr, [x1, #0x10]
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ld3	{ v5.d, v6.d, v7.d }[1], [x0], #24
               	st3	{ v5.d, v6.d, v7.d }[1], [x1]
               	ldur	x0, [x29, #-0x48]
               	ldur	x1, [x29, #-0x30]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x40]
               	ldur	x1, [x29, #-0x28]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x20]
               	cmp	x0, x1
               	b.ne	<addr>
               	sub	x0, x29, #0x68
               	str	xzr, [x0]
               	sub	x1, x29, #0xc0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	str	x0, [sp, #0x10]
               	sub	x16, x29, #0xc0
               	str	x16, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x18]
               	ldr	q0, [x16]
               	st1	{ v0.s }[1], [x0]
               	add	x0, x0, #0x4
               	st1	{ v0.s }[3], [x0]
               	ldur	w0, [x29, #-0x68]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x64]
               	cmp	w0, #0xd
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
