
gcc_vector_compare_ops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	sp, sp, #0x150
               	sub	x1, x29, #0x150
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x140
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x130
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x120
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x110
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x100
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xf0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xe0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xd0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xc0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xb0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xa0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x90
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x80
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x70
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x28
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x16, [x3]
               	str	x16, [x0]
               	sub	x0, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x16, [x3]
               	str	x16, [x0]
               	ldr	q0, [sp]
               	cmeq	v0.16b, v0.16b, v0.16b
               	smov	x0, v0.b[0]
               	cmn	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	smov	x0, v0.b[1]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[2]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[3]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[4]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[5]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[6]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[7]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[8]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[9]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[10]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[11]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[12]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[13]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[14]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[15]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x28]
               	cmhi	v0.8b, v0.8b, v1.8b
               	smov	x0, v0.b[0]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.b[1]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	cmeq	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x3, #0x0                // =0
               	sub	x4, x29, #0x10
               	mov	x0, x3
               	ldrb	w5, [x2, x0]
               	ldrb	w6, [x1, x0]
               	cmp	w6, w5
               	mov	x16, #-0x1              // =-1
               	csel	x5, x16, x3, eq
               	strb	w5, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	sub	x2, x29, #0x50
               	ldrb	w0, [sp]
               	ldrb	w3, [sp, #0x10]
               	cmp	w0, w3
               	cset	x3, ne
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x50]
               	ldrb	w3, [sp, #0x1]
               	ldrb	w6, [sp, #0x11]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4f]
               	ldrb	w3, [sp, #0x2]
               	ldrb	w6, [sp, #0x12]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4e]
               	ldrb	w3, [sp, #0x3]
               	ldrb	w6, [sp, #0x13]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4d]
               	ldrb	w3, [sp, #0x4]
               	ldrb	w6, [sp, #0x14]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4c]
               	ldrb	w3, [sp, #0x5]
               	ldrb	w6, [sp, #0x15]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4b]
               	ldrb	w3, [sp, #0x6]
               	ldrb	w6, [sp, #0x16]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4a]
               	ldrb	w3, [sp, #0x7]
               	ldrb	w6, [sp, #0x17]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x49]
               	ldrb	w3, [sp, #0x8]
               	ldrb	w6, [sp, #0x18]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x48]
               	ldrb	w3, [sp, #0x9]
               	ldrb	w6, [sp, #0x19]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x47]
               	ldrb	w3, [sp, #0xa]
               	ldrb	w6, [sp, #0x1a]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x46]
               	ldrb	w3, [sp, #0xb]
               	ldrb	w6, [sp, #0x1b]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x45]
               	ldrb	w3, [sp, #0xc]
               	ldrb	w6, [sp, #0x1c]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x44]
               	ldrb	w3, [sp, #0xd]
               	ldrb	w6, [sp, #0x1d]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x43]
               	ldrb	w3, [sp, #0xe]
               	ldrb	w6, [sp, #0x1e]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x42]
               	ldrb	w3, [sp, #0xf]
               	ldrb	w6, [sp, #0x1f]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x41]
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldrb	w2, [x5, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ne
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x40
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	ldr	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	cmhi	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x5, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	ldr	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	cmhs	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x5, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, le
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	cmhi	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x5, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, gt
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	cmhs	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x5, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ge
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	cmeq	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x5, x0]
               	ldrsb	x3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, eq
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	sub	x2, x29, #0x50
               	ldrsb	x0, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	cmp	w0, w3
               	cset	x3, ne
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x50]
               	ldrsb	x3, [sp, #0x21]
               	ldrsb	x6, [sp, #0x31]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4f]
               	ldrsb	x3, [sp, #0x22]
               	ldrsb	x6, [sp, #0x32]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4e]
               	ldrsb	x3, [sp, #0x23]
               	ldrsb	x6, [sp, #0x33]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4d]
               	ldrsb	x3, [sp, #0x24]
               	ldrsb	x6, [sp, #0x34]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4c]
               	ldrsb	x3, [sp, #0x25]
               	ldrsb	x6, [sp, #0x35]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4b]
               	ldrsb	x3, [sp, #0x26]
               	ldrsb	x6, [sp, #0x36]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x4a]
               	ldrsb	x3, [sp, #0x27]
               	ldrsb	x6, [sp, #0x37]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x49]
               	ldrsb	x3, [sp, #0x28]
               	ldrsb	x6, [sp, #0x38]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x48]
               	ldrsb	x3, [sp, #0x29]
               	ldrsb	x6, [sp, #0x39]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x47]
               	ldrsb	x3, [sp, #0x2a]
               	ldrsb	x6, [sp, #0x3a]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x46]
               	ldrsb	x3, [sp, #0x2b]
               	ldrsb	x6, [sp, #0x3b]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x45]
               	ldrsb	x3, [sp, #0x2c]
               	ldrsb	x6, [sp, #0x3c]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x44]
               	ldrsb	x3, [sp, #0x2d]
               	ldrsb	x6, [sp, #0x3d]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x43]
               	ldrsb	x3, [sp, #0x2e]
               	ldrsb	x6, [sp, #0x3e]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x42]
               	ldrsb	x3, [sp, #0x2f]
               	ldrsb	x6, [sp, #0x3f]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x41]
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldrsb	x2, [x5, x0]
               	ldrsb	x3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ne
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x40
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	ldr	q0, [sp, #0x30]
               	ldr	q1, [sp, #0x20]
               	cmgt	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x5, x0]
               	ldrsb	x3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	ldr	q0, [sp, #0x30]
               	ldr	q1, [sp, #0x20]
               	cmge	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x5, x0]
               	ldrsb	x3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, le
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	cmgt	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x5, x0]
               	ldrsb	x3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, gt
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	cmge	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x5, x0]
               	ldrsb	x3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ge
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x110
               	sub	x5, x29, #0x100
               	ldr	q0, [sp, #0x40]
               	ldur	q1, [x29, #-0x100]
               	cmeq	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrh	w2, [x5, x0, lsl #1]
               	ldrh	w3, [x4, x0, lsl #1]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, eq
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x110
               	sub	x5, x29, #0x100
               	ldur	q0, [x29, #-0x100]
               	ldr	q1, [sp, #0x40]
               	cmhi	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrh	w2, [x5, x0, lsl #1]
               	ldrh	w3, [x4, x0, lsl #1]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x110
               	sub	x5, x29, #0x100
               	ldr	q0, [sp, #0x40]
               	ldur	q1, [x29, #-0x100]
               	cmhs	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrh	w2, [x5, x0, lsl #1]
               	ldrh	w3, [x4, x0, lsl #1]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ge
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xf0
               	sub	x5, x29, #0xe0
               	ldursh	x0, [x29, #-0xf0]
               	ldursh	x2, [x29, #-0xe0]
               	cmp	w0, w2
               	cset	x2, ne
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldursh	x3, [x29, #-0xee]
               	ldursh	x6, [x29, #-0xde]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	ldursh	x6, [x29, #-0xec]
               	ldursh	x7, [x29, #-0xdc]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	ldursh	x7, [x29, #-0xea]
               	ldursh	x8, [x29, #-0xda]
               	cmp	w7, w8
               	cset	x7, ne
               	neg	x7, x7
               	ldursh	x8, [x29, #-0xe8]
               	ldursh	x9, [x29, #-0xd8]
               	cmp	w8, w9
               	cset	x8, ne
               	neg	x8, x8
               	ldursh	x9, [x29, #-0xe6]
               	ldursh	x10, [x29, #-0xd6]
               	cmp	w9, w10
               	cset	x9, ne
               	neg	x9, x9
               	ldursh	x10, [x29, #-0xe4]
               	ldursh	x11, [x29, #-0xd4]
               	cmp	w10, w11
               	cset	x10, ne
               	neg	x10, x10
               	ldursh	x11, [x29, #-0xe2]
               	ldursh	x12, [x29, #-0xd2]
               	cmp	w11, w12
               	cset	x11, ne
               	neg	x11, x11
               	and	x2, x2, #0xffff
               	sturh	w2, [x29, #-0x50]
               	and	x2, x3, #0xffff
               	sturh	w2, [x29, #-0x4e]
               	and	x2, x6, #0xffff
               	sturh	w2, [x29, #-0x4c]
               	and	x2, x7, #0xffff
               	sturh	w2, [x29, #-0x4a]
               	and	x2, x8, #0xffff
               	sturh	w2, [x29, #-0x48]
               	and	x2, x9, #0xffff
               	sturh	w2, [x29, #-0x46]
               	and	x2, x10, #0xffff
               	sturh	w2, [x29, #-0x44]
               	and	x2, x11, #0xffff
               	sturh	w2, [x29, #-0x42]
               	ldrsh	x2, [x5, x0, lsl #1]
               	ldrsh	x3, [x4, x0, lsl #1]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ne
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xf0
               	sub	x5, x29, #0xe0
               	ldur	q0, [x29, #-0xe0]
               	ldur	q1, [x29, #-0xf0]
               	cmge	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsh	x2, [x5, x0, lsl #1]
               	ldrsh	x3, [x4, x0, lsl #1]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, le
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xf0
               	sub	x5, x29, #0xe0
               	ldur	q0, [x29, #-0xf0]
               	ldur	q1, [x29, #-0xe0]
               	cmgt	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsh	x2, [x5, x0, lsl #1]
               	ldrsh	x3, [x4, x0, lsl #1]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, gt
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xd0
               	sub	x5, x29, #0xc0
               	ldur	q0, [x29, #-0xc0]
               	ldur	q1, [x29, #-0xd0]
               	cmhi	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldr	w2, [x5, x0, lsl #2]
               	ldr	w3, [x4, x0, lsl #2]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lo
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xd0
               	sub	x5, x29, #0xc0
               	ldur	q0, [x29, #-0xd0]
               	ldur	q1, [x29, #-0xc0]
               	cmeq	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldr	w2, [x5, x0, lsl #2]
               	ldr	w3, [x4, x0, lsl #2]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, eq
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xb0
               	sub	x5, x29, #0xa0
               	ldur	q0, [x29, #-0xa0]
               	ldur	q1, [x29, #-0xb0]
               	cmgt	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsw	x2, [x5, x0, lsl #2]
               	ldrsw	x3, [x4, x0, lsl #2]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xb0
               	sub	x5, x29, #0xa0
               	ldur	q0, [x29, #-0xb0]
               	ldur	q1, [x29, #-0xa0]
               	cmge	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsw	x2, [x5, x0, lsl #2]
               	ldrsw	x3, [x4, x0, lsl #2]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ge
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0xb0
               	sub	x5, x29, #0xa0
               	ldursw	x0, [x29, #-0xb0]
               	ldursw	x2, [x29, #-0xa0]
               	cmp	w0, w2
               	cset	x2, ne
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldursw	x3, [x29, #-0xac]
               	ldursw	x6, [x29, #-0x9c]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	ldursw	x6, [x29, #-0xa8]
               	ldursw	x7, [x29, #-0x98]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	ldursw	x7, [x29, #-0xa4]
               	ldursw	x8, [x29, #-0x94]
               	cmp	w7, w8
               	cset	x7, ne
               	neg	x7, x7
               	stur	w2, [x29, #-0x50]
               	stur	w3, [x29, #-0x4c]
               	stur	w6, [x29, #-0x48]
               	stur	w7, [x29, #-0x44]
               	ldrsw	x2, [x5, x0, lsl #2]
               	ldrsw	x3, [x4, x0, lsl #2]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ne
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x90
               	sub	x5, x29, #0x80
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x90]
               	cmhi	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldr	x2, [x5, x0, lsl #3]
               	ldr	x3, [x4, x0, lsl #3]
               	cmp	x3, x2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lo
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x90
               	sub	x5, x29, #0x80
               	ldur	q0, [x29, #-0x90]
               	ldur	q1, [x29, #-0x80]
               	cmhi	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldr	x2, [x5, x0, lsl #3]
               	ldr	x3, [x4, x0, lsl #3]
               	cmp	x3, x2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, hi
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x70
               	sub	x5, x29, #0x60
               	ldur	q0, [x29, #-0x60]
               	ldur	q1, [x29, #-0x70]
               	cmgt	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldr	x2, [x5, x0, lsl #3]
               	ldr	x3, [x4, x0, lsl #3]
               	cmp	x3, x2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x70
               	sub	x5, x29, #0x60
               	ldur	q0, [x29, #-0x70]
               	ldur	q1, [x29, #-0x60]
               	cmeq	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldr	x2, [x5, x0, lsl #3]
               	ldr	x3, [x4, x0, lsl #3]
               	cmp	x3, x2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, eq
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x28
               	sub	x5, x29, #0x20
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x28]
               	cmhi	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x18]
               	mov	x0, #0x0                // =0
               	sub	x6, x29, #0x8
               	ldrb	w2, [x5, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w3, w2
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	strb	w2, [x6, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x18
               	sub	x3, x29, #0x8
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w16, [x2]
               	str	w16, [x0]
               	sub	x2, x29, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	s0, [x29, #-0x8]
               	stur	s0, [x29, #-0x58]
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x40]
               	fcmp	s0, s1
               	cset	x4, eq
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x3c]
               	fcmp	s0, s1
               	cset	x5, eq
               	neg	x5, x5
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x38]
               	fcmp	s0, s1
               	cset	x6, eq
               	neg	x6, x6
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x34]
               	fcmp	s0, s1
               	cset	x7, eq
               	neg	x7, x7
               	stur	w4, [x29, #-0x50]
               	stur	w5, [x29, #-0x4c]
               	stur	w6, [x29, #-0x48]
               	stur	w7, [x29, #-0x44]
               	ldr	s0, [x3, x0, lsl #2]
               	ldr	s1, [x2, x0, lsl #2]
               	fcmp	s1, s0
               	mov	x16, #-0x1              // =-1
               	csel	x4, x16, xzr, eq
               	str	w4, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x40
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x40]
               	fcmp	s0, s1
               	cset	x2, ne
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x3c]
               	fcmp	s0, s1
               	cset	x5, ne
               	neg	x5, x5
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x38]
               	fcmp	s0, s1
               	cset	x6, ne
               	neg	x6, x6
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x34]
               	fcmp	s0, s1
               	cset	x7, ne
               	neg	x7, x7
               	stur	w2, [x29, #-0x50]
               	stur	w5, [x29, #-0x4c]
               	stur	w6, [x29, #-0x48]
               	stur	w7, [x29, #-0x44]
               	ldr	s0, [x4, x0, lsl #2]
               	ldr	s1, [x3, x0, lsl #2]
               	fcmp	s1, s0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ne
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x40
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x40]
               	fcmpe	s0, s1
               	cset	x2, mi
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x3c]
               	fcmpe	s0, s1
               	cset	x5, mi
               	neg	x5, x5
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x38]
               	fcmpe	s0, s1
               	cset	x6, mi
               	neg	x6, x6
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x34]
               	fcmpe	s0, s1
               	cset	x7, mi
               	neg	x7, x7
               	stur	w2, [x29, #-0x50]
               	stur	w5, [x29, #-0x4c]
               	stur	w6, [x29, #-0x48]
               	stur	w7, [x29, #-0x44]
               	ldr	s0, [x4, x0, lsl #2]
               	ldr	s1, [x3, x0, lsl #2]
               	fcmpe	s1, s0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, mi
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x40
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x40]
               	fcmpe	s0, s1
               	cset	x2, ls
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x3c]
               	fcmpe	s0, s1
               	cset	x5, ls
               	neg	x5, x5
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x38]
               	fcmpe	s0, s1
               	cset	x6, ls
               	neg	x6, x6
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x34]
               	fcmpe	s0, s1
               	cset	x7, ls
               	neg	x7, x7
               	stur	w2, [x29, #-0x50]
               	stur	w5, [x29, #-0x4c]
               	stur	w6, [x29, #-0x48]
               	stur	w7, [x29, #-0x44]
               	ldr	s0, [x4, x0, lsl #2]
               	ldr	s1, [x3, x0, lsl #2]
               	fcmpe	s1, s0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ls
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x40
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x40]
               	fcmpe	s0, s1
               	cset	x2, gt
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x3c]
               	fcmpe	s0, s1
               	cset	x5, gt
               	neg	x5, x5
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x38]
               	fcmpe	s0, s1
               	cset	x6, gt
               	neg	x6, x6
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x34]
               	fcmpe	s0, s1
               	cset	x7, gt
               	neg	x7, x7
               	stur	w2, [x29, #-0x50]
               	stur	w5, [x29, #-0x4c]
               	stur	w6, [x29, #-0x48]
               	stur	w7, [x29, #-0x44]
               	ldr	s0, [x4, x0, lsl #2]
               	ldr	s1, [x3, x0, lsl #2]
               	fcmpe	s1, s0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, gt
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x40
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x40]
               	fcmpe	s0, s1
               	cset	x2, ge
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x3c]
               	fcmpe	s0, s1
               	cset	x5, ge
               	neg	x5, x5
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x38]
               	fcmpe	s0, s1
               	cset	x6, ge
               	neg	x6, x6
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x34]
               	fcmpe	s0, s1
               	cset	x7, ge
               	neg	x7, x7
               	stur	w2, [x29, #-0x50]
               	stur	w5, [x29, #-0x4c]
               	stur	w6, [x29, #-0x48]
               	stur	w7, [x29, #-0x44]
               	ldr	s0, [x4, x0, lsl #2]
               	ldr	s1, [x3, x0, lsl #2]
               	fcmpe	s1, s0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ge
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	fmov	s0, #2.00000000
               	ldur	s1, [x29, #-0x60]
               	fcmpe	s1, s0
               	cset	x2, gt
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	s1, [x29, #-0x5c]
               	fcmpe	s1, s0
               	cset	x4, gt
               	neg	x4, x4
               	ldur	s1, [x29, #-0x58]
               	fcmpe	s1, s0
               	cset	x5, gt
               	neg	x5, x5
               	ldur	s1, [x29, #-0x54]
               	fcmpe	s1, s0
               	cset	x6, gt
               	neg	x6, x6
               	stur	w2, [x29, #-0x50]
               	stur	w4, [x29, #-0x4c]
               	stur	w5, [x29, #-0x48]
               	stur	w6, [x29, #-0x44]
               	ldr	s1, [x3, x0, lsl #2]
               	fcmpe	s1, s0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, gt
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x0]
               	sub	x2, x29, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	d0, [x29, #-0x8]
               	stur	d0, [x29, #-0x58]
               	ldur	d1, [x29, #-0x60]
               	ldur	d2, [x29, #-0x40]
               	fcmp	d1, d2
               	cset	x4, eq
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	ldur	d1, [x29, #-0x38]
               	fcmp	d0, d1
               	cset	x5, eq
               	neg	x5, x5
               	stur	x4, [x29, #-0x50]
               	stur	x5, [x29, #-0x48]
               	ldr	d0, [x3, x0, lsl #3]
               	ldr	d1, [x2, x0, lsl #3]
               	fcmp	d1, d0
               	mov	x16, #-0x1              // =-1
               	csel	x4, x16, xzr, eq
               	str	x4, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x40
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x40]
               	fcmp	d0, d1
               	cset	x2, ne
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	d0, [x29, #-0x58]
               	ldur	d1, [x29, #-0x38]
               	fcmp	d0, d1
               	cset	x5, ne
               	neg	x5, x5
               	stur	x2, [x29, #-0x50]
               	stur	x5, [x29, #-0x48]
               	ldr	d0, [x4, x0, lsl #3]
               	ldr	d1, [x3, x0, lsl #3]
               	fcmp	d1, d0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ne
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x40
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x40]
               	fcmpe	d0, d1
               	cset	x2, mi
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	d0, [x29, #-0x58]
               	ldur	d1, [x29, #-0x38]
               	fcmpe	d0, d1
               	cset	x5, mi
               	neg	x5, x5
               	stur	x2, [x29, #-0x50]
               	stur	x5, [x29, #-0x48]
               	ldr	d0, [x4, x0, lsl #3]
               	ldr	d1, [x3, x0, lsl #3]
               	fcmpe	d1, d0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, mi
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x2, x29, #0x50
               	ldrb	w0, [sp]
               	cmp	w0, #0x64
               	cset	x4, hi
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x50]
               	ldrb	w4, [sp, #0x1]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4f]
               	ldrb	w4, [sp, #0x2]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4e]
               	ldrb	w4, [sp, #0x3]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4d]
               	ldrb	w4, [sp, #0x4]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4c]
               	ldrb	w4, [sp, #0x5]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4b]
               	ldrb	w4, [sp, #0x6]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4a]
               	ldrb	w4, [sp, #0x7]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x49]
               	ldrb	w4, [sp, #0x8]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x48]
               	ldrb	w4, [sp, #0x9]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x47]
               	ldrb	w4, [sp, #0xa]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x46]
               	ldrb	w4, [sp, #0xb]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x45]
               	ldrb	w4, [sp, #0xc]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x44]
               	ldrb	w4, [sp, #0xd]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x43]
               	ldrb	w4, [sp, #0xe]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x42]
               	ldrb	w4, [sp, #0xf]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x41]
               	sub	x4, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	ldrb	w2, [x3, x0]
               	cmp	w2, #0x64
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, gt
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x40
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x2, x29, #0x50
               	ldrb	w0, [sp]
               	cmp	w0, #0x3
               	cset	x4, eq
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x50]
               	ldrb	w4, [sp, #0x1]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4f]
               	ldrb	w4, [sp, #0x2]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4e]
               	ldrb	w4, [sp, #0x3]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4d]
               	ldrb	w4, [sp, #0x4]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4c]
               	ldrb	w4, [sp, #0x5]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4b]
               	ldrb	w4, [sp, #0x6]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4a]
               	ldrb	w4, [sp, #0x7]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x49]
               	ldrb	w4, [sp, #0x8]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x48]
               	ldrb	w4, [sp, #0x9]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x47]
               	ldrb	w4, [sp, #0xa]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x46]
               	ldrb	w4, [sp, #0xb]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x45]
               	ldrb	w4, [sp, #0xc]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x44]
               	ldrb	w4, [sp, #0xd]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x43]
               	ldrb	w4, [sp, #0xe]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x42]
               	ldrb	w4, [sp, #0xf]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x41]
               	sub	x4, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	ldrb	w2, [x3, x0]
               	cmp	w2, #0x3
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, eq
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x40
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x2, x29, #0x50
               	ldrb	w0, [sp]
               	cmp	w0, #0xff
               	cset	x4, lo
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x50]
               	ldrb	w4, [sp, #0x1]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4f]
               	ldrb	w4, [sp, #0x2]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4e]
               	ldrb	w4, [sp, #0x3]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4d]
               	ldrb	w4, [sp, #0x4]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4c]
               	ldrb	w4, [sp, #0x5]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4b]
               	ldrb	w4, [sp, #0x6]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4a]
               	ldrb	w4, [sp, #0x7]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x49]
               	ldrb	w4, [sp, #0x8]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x48]
               	ldrb	w4, [sp, #0x9]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x47]
               	ldrb	w4, [sp, #0xa]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x46]
               	ldrb	w4, [sp, #0xb]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x45]
               	ldrb	w4, [sp, #0xc]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x44]
               	ldrb	w4, [sp, #0xd]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x43]
               	ldrb	w4, [sp, #0xe]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x42]
               	ldrb	w4, [sp, #0xf]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x41]
               	sub	x4, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	ldrb	w2, [x3, x0]
               	cmp	w2, #0xff
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x130
               	mov	x0, #-0x5               // =-5
               	sub	x4, x29, #0x50
               	ldrsb	x1, [sp, #0x20]
               	cmp	w1, w0
               	cset	x5, gt
               	mov	x1, #0x0                // =0
               	neg	x5, x5
               	sturb	w5, [x29, #-0x50]
               	ldrsb	x5, [sp, #0x21]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x4f]
               	ldrsb	x5, [sp, #0x22]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x4e]
               	ldrsb	x5, [sp, #0x23]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x4d]
               	ldrsb	x5, [sp, #0x24]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x4c]
               	ldrsb	x5, [sp, #0x25]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x4b]
               	ldrsb	x5, [sp, #0x26]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x4a]
               	ldrsb	x5, [sp, #0x27]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x49]
               	ldrsb	x5, [sp, #0x28]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x48]
               	ldrsb	x5, [sp, #0x29]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x47]
               	ldrsb	x5, [sp, #0x2a]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x46]
               	ldrsb	x5, [sp, #0x2b]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x45]
               	ldrsb	x5, [sp, #0x2c]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x44]
               	ldrsb	x5, [sp, #0x2d]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x43]
               	ldrsb	x5, [sp, #0x2e]
               	cmp	w5, w0
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x42]
               	ldrsb	x5, [sp, #0x2f]
               	cmp	w5, w0
               	cset	x0, gt
               	neg	x0, x0
               	sturb	w0, [x29, #-0x41]
               	sub	x0, x29, #0x40
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x0]
               	ldrsb	x0, [x3, x1]
               	cmn	w0, #0x5
               	mov	x16, #-0x1              // =-1
               	csel	x0, x16, xzr, gt
               	strb	w0, [x2, x1]
               	add	x1, x1, #0x1
               	cmp	w1, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x40
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xb0
               	mov	x0, #0x0                // =0
               	ldursw	x2, [x29, #-0xb0]
               	cmp	w2, #0x0
               	cset	x2, lt
               	neg	x2, x2
               	ldursw	x4, [x29, #-0xac]
               	cmp	w4, #0x0
               	cset	x4, lt
               	neg	x4, x4
               	ldursw	x5, [x29, #-0xa8]
               	cmp	w5, #0x0
               	cset	x5, lt
               	neg	x5, x5
               	ldursw	x6, [x29, #-0xa4]
               	cmp	w6, #0x0
               	cset	x6, lt
               	neg	x6, x6
               	stur	w2, [x29, #-0x50]
               	stur	w4, [x29, #-0x4c]
               	stur	w5, [x29, #-0x48]
               	stur	w6, [x29, #-0x44]
               	ldrsw	x2, [x3, x0, lsl #2]
               	cmp	w2, #0x0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x90
               	ldur	x0, [x29, #-0x90]
               	cmp	x0, #0x5
               	cset	x2, ne
               	mov	x0, #0x0                // =0
               	neg	x2, x2
               	ldur	x4, [x29, #-0x88]
               	cmp	x4, #0x5
               	cset	x4, ne
               	neg	x4, x4
               	stur	x2, [x29, #-0x50]
               	stur	x4, [x29, #-0x48]
               	ldr	x2, [x3, x0, lsl #3]
               	cmp	x2, #0x5
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ne
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x2, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x150
               	sub	x2, x29, #0x50
               	ldrb	w0, [sp]
               	cmp	w0, #0x64
               	cset	x4, lo
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x50]
               	ldrb	w4, [sp, #0x1]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4f]
               	ldrb	w4, [sp, #0x2]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4e]
               	ldrb	w4, [sp, #0x3]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4d]
               	ldrb	w4, [sp, #0x4]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4c]
               	ldrb	w4, [sp, #0x5]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4b]
               	ldrb	w4, [sp, #0x6]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x4a]
               	ldrb	w4, [sp, #0x7]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x49]
               	ldrb	w4, [sp, #0x8]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x48]
               	ldrb	w4, [sp, #0x9]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x47]
               	ldrb	w4, [sp, #0xa]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x46]
               	ldrb	w4, [sp, #0xb]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x45]
               	ldrb	w4, [sp, #0xc]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x44]
               	ldrb	w4, [sp, #0xd]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x43]
               	ldrb	w4, [sp, #0xe]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x42]
               	ldrb	w4, [sp, #0xf]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x41]
               	sub	x4, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	ldrb	w2, [x3, x0]
               	cmp	w2, #0x64
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x40
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0xb0
               	ldursw	x2, [x29, #-0xb0]
               	cmp	w2, #0x0
               	cset	x2, ge
               	neg	x2, x2
               	ldursw	x4, [x29, #-0xac]
               	cmp	w4, #0x0
               	cset	x4, ge
               	neg	x4, x4
               	ldursw	x5, [x29, #-0xa8]
               	cmp	w5, #0x0
               	cset	x5, ge
               	neg	x5, x5
               	ldursw	x6, [x29, #-0xa4]
               	cmp	w6, #0x0
               	cset	x6, ge
               	neg	x6, x6
               	stur	w2, [x29, #-0x50]
               	stur	w4, [x29, #-0x4c]
               	stur	w5, [x29, #-0x48]
               	stur	w6, [x29, #-0x44]
               	ldrsw	x2, [x3, x0, lsl #2]
               	cmp	w2, #0x0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, ge
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	movi	v2.2d, #0x000000ffffffff
               	and	v0.16b, v2.16b, v0.16b
               	movi	v2.2d, #0xffffffff00000000
               	and	v1.16b, v2.16b, v1.16b
               	orr	v0.16b, v0.16b, v1.16b
               	smov	x0, v0.s[0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x31               // =49
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
