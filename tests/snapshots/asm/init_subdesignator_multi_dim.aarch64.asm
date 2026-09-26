
init_subdesignator_multi_dim.aarch64:	file format elf64-littleaarch64

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

<check>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	ldrh	w2, [x1]
               	eor	x2, x2, #0x1
               	cbnz	w2, <addr>
               	ldrh	w2, [x1, #0x2]
               	eor	x2, x2, #0x2
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrh	w2, [x1, #0xa]
               	eor	x2, x2, #0x7
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x1, #0x24]
               	cmp	w2, #0x5
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x1, #0x2c]
               	cmp	w2, #0x6
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x1, #0x98]
               	cmp	w2, #0x9
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrh	w2, [x1, #0x6]
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x1, #0x18]
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x0, [x1, #0x3c]
               	cmp	w0, #0x0
               	cset	x0, eq
               	ret
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w2, [x0]
               	ldrh	w3, [x0, #0x2]
               	ldrh	w4, [x0, #0xa]
               	ldr	w5, [x0, #0x24]
               	ldr	w6, [x0, #0x2c]
               	ldr	w7, [x0, #0x98]
               	sub	x1, x29, #0x140
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	stp	xzr, xzr, [x1, #0x50]
               	stp	xzr, xzr, [x1, #0x60]
               	stp	xzr, xzr, [x1, #0x70]
               	stp	xzr, xzr, [x1, #0x80]
               	str	xzr, [x1, #0x90]
               	str	wzr, [x1, #0x98]
               	strh	w2, [x1]
               	strh	w3, [x1, #0x2]
               	strh	w4, [x1, #0xa]
               	str	w5, [x1, #0x24]
               	str	w6, [x1, #0x2c]
               	str	w7, [x1, #0x98]
               	sub	x1, x29, #0xa0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldp	x16, x17, [x2, #0x40]
               	stp	x16, x17, [x1, #0x40]
               	ldp	x16, x17, [x2, #0x50]
               	stp	x16, x17, [x1, #0x50]
               	ldp	x16, x17, [x2, #0x60]
               	stp	x16, x17, [x1, #0x60]
               	ldp	x16, x17, [x2, #0x70]
               	stp	x16, x17, [x1, #0x70]
               	ldp	x16, x17, [x2, #0x80]
               	stp	x16, x17, [x1, #0x80]
               	ldr	x16, [x2, #0x90]
               	str	x16, [x1, #0x90]
               	ldr	w16, [x2, #0x98]
               	str	w16, [x1, #0x98]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x140
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x54]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x6c]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrh	w1, [x0, #0x8]
               	eor	x1, x1, #0x8
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x98]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
