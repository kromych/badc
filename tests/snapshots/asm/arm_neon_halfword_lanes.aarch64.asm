
arm_neon_halfword_lanes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x16, x29, #0x10
               	ldr	q0, [x16]
               	mov	x16, #0x4141            // =16705
               	dup	v1.8h, w16
               	cmeq	v0.8h, v0.8h, v1.8h
               	shrn	v0.8b, v0.8h, #0x4
               	stur	d0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0xff000000        // =4278190080
               	movk	x17, #0xff00, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	sub	x16, x29, #0x30
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	ldur	x1, [x29, #-0x20]
               	sub	x2, x29, #0x18
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x20]
               	fmov	d16, x0
               	fmov	d17, x1
               	eor	v0.8b, v16.8b, v17.8b
               	stur	d0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0x800000000000    // =140737488355328
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	ldur	w0, [x29, #-0x14]
               	mov	x17, #0x605             // =1541
               	movk	x17, #0x807, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	movk	x0, #0x2, lsl #16
               	movk	x0, #0x3, lsl #32
               	movk	x0, #0x4, lsl #48
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x38]
               	ldur	q0, [x29, #-0x40]
               	stur	q0, [x29, #-0x40]
               	ldurh	w0, [x29, #-0x40]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x3a]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x38]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x32]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
