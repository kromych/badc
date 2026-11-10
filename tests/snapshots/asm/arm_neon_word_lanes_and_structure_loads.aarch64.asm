
arm_neon_word_lanes_and_structure_loads.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x170
               	mov	x0, #0x0                // =0
               	mov	x1, #0x25               // =37
               	sub	x2, x29, #0x40
               	mul	x3, x0, x1
               	add	x3, x3, #0xb
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x3
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x48]
               	fmov	d16, x0
               	sub	x16, x29, #0x78
               	str	d16, [x16]
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x40
               	add	x1, x1, #0x3
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xcdef            // =52719
               	movk	x16, #0x89ab, lsl #16
               	dup	v0.2s, w16
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x48]
               	ldur	w0, [x29, #-0x48]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x44]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xcdef            // =52719
               	movk	x16, #0x89ab, lsl #16
               	movk	x16, #0x4567, lsl #32
               	movk	x16, #0x123, lsl #48
               	dup	v0.2d, x16
               	mov	x0, v0.d[0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x1, v0.d[0]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x170
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q1, [sp]
               	add	v0.2d, v0.2d, v1.2d
               	mov	x0, v0.d[0]
               	mov	x17, #0xcdee            // =52718
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x17, #0xcdf0            // =52720
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x130
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x120
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	mul	v0.4s, v0.4s, v1.4s
               	mov	w0, v0.s[0]
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v0.s[1]
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v0.s[2]
               	cbnz	x0, <addr>
               	mov	w0, v0.s[3]
               	cmp	w0, #0x3f
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp, #0x40]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x68]
               	ldur	x1, [x29, #-0x68]
               	stur	x1, [x29, #-0x70]
               	ldr	q0, [sp, #0x40]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x48]
               	ldur	w0, [x29, #-0x70]
               	ldr	w2, [sp, #0x40]
               	cmp	w0, w2
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x6c]
               	ldr	w2, [sp, #0x44]
               	cmp	w0, w2
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x48]
               	ldr	w2, [sp, #0x48]
               	cmp	w0, w2
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x44]
               	ldr	w2, [sp, #0x4c]
               	cmp	w0, w2
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x170
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x50]
               	mov	d0, v0.d[0]
               	stur	d0, [x29, #-0x68]
               	ldur	x2, [x29, #-0x68]
               	ldr	q0, [sp]
               	str	q0, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xd0]
               	fmov	d16, x2
               	str	d16, [sp, #0xd8]
               	ldr	q0, [sp, #0xc0]
               	ldr	d1, [sp, #0xd0]
               	ldr	d2, [sp, #0xd8]
               	umlal	v0.2d, v1.2s, v2.2s
               	mov	x0, v0.d[0]
               	mov	x17, #0x3               // =3
               	movk	x17, #0x2, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x40]
               	ldr	q2, [sp, #0x50]
               	str	q0, [sp, #0xc0]
               	str	q1, [sp, #0xd0]
               	str	q2, [sp, #0xe0]
               	ldr	q0, [sp, #0xc0]
               	ldr	q1, [sp, #0xd0]
               	ldr	q2, [sp, #0xe0]
               	umlal2	v0.2d, v1.4s, v2.4s
               	mov	x0, v0.d[0]
               	mov	x17, #0x5               // =5
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cmp	x0, #0x45
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x170
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp]
               	xtn	v0.2s, v0.2d
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x48]
               	ldur	w0, [x29, #-0x48]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x44]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	shrn	v0.2s, v0.2d, #0x20
               	stur	d0, [x29, #-0x48]
               	ldur	w0, [x29, #-0x48]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x44]
               	mov	x17, #0xbbcc            // =48076
               	movk	x17, #0x99aa, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	ushr	v0.2d, v0.2d, #0x3c
               	mov	x0, v0.d[0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x2, x29, #0x68
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	ldur	d0, [x29, #-0x70]
               	ldur	d1, [x29, #-0x68]
               	str	d0, [sp, #0xc0]
               	str	d1, [sp, #0xc8]
               	ldr	d0, [sp, #0xc0]
               	ldr	d1, [sp, #0xc8]
               	sli	v0.8b, v1.8b, #0x4
               	sub	x3, x29, #0x48
               	stur	d0, [x29, #-0x48]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x2, x0]
               	ldrb	w6, [x1, x0]
               	and	x6, x6, #0xf
               	orr	x5, x6, x5, lsl #4
               	and	x5, x5, #0xff
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	str	q0, [sp, #0x60]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x10
               	ldr	q0, [x0]
               	sub	x1, x29, #0xf0
               	stur	q0, [x29, #-0xf0]
               	sub	x2, x29, #0x110
               	ldr	q0, [sp, #0x60]
               	ldur	q1, [x29, #-0xf0]
               	str	q0, [sp, #0xc0]
               	str	q1, [sp, #0xd0]
               	ldr	q0, [sp, #0xc0]
               	ldr	q1, [sp, #0xd0]
               	sri	v0.16b, v1.16b, #0x3
               	sub	x3, x29, #0x170
               	str	q0, [sp]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x1, x0]
               	ldrb	w6, [x2, x0]
               	and	x6, x6, #0xe0
               	orr	x5, x6, x5, lsr #3
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	sub	x0, x29, #0x170
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	str	q2, [sp]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	stur	q0, [x29, #-0xf0]
               	stur	q1, [x29, #-0xe0]
               	ldur	w0, [x29, #-0xf0]
               	ldur	w1, [x29, #-0xec]
               	ldur	w2, [x29, #-0xe8]
               	ldur	w3, [x29, #-0xe4]
               	ldur	w4, [x29, #-0xe0]
               	ldur	w5, [x29, #-0xdc]
               	ldur	w6, [x29, #-0xd8]
               	ldur	w7, [x29, #-0xd4]
               	ldr	w8, [sp, #0x40]
               	cmp	w0, w8
               	b.ne	<addr>
               	ldr	w0, [sp, #0x48]
               	cmp	w1, w0
               	b.ne	<addr>
               	ldr	w0, [sp, #0x50]
               	cmp	w2, w0
               	b.ne	<addr>
               	ldr	w0, [sp, #0x58]
               	cmp	w3, w0
               	b.eq	<addr>
               	mov	x0, #0x41               // =65
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [sp, #0x44]
               	cmp	w4, w0
               	b.ne	<addr>
               	ldr	w0, [sp, #0x4c]
               	cmp	w5, w0
               	b.ne	<addr>
               	ldr	w0, [sp, #0x54]
               	cmp	w6, w0
               	b.ne	<addr>
               	ldr	w0, [sp, #0x5c]
               	cmp	w7, w0
               	b.eq	<addr>
               	mov	x0, #0x43               // =67
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x170
               	ldurh	w1, [x29, #-0x60]
               	strh	w1, [sp]
               	ldurh	w1, [x29, #-0x5e]
               	strh	w1, [sp, #0x10]
               	ldurh	w1, [x29, #-0x5c]
               	strh	w1, [sp, #0x2]
               	add	x0, x0, #0x10
               	ldurh	w1, [x29, #-0x5a]
               	strh	w1, [x0, #0x2]
               	ldurh	w1, [x29, #-0x58]
               	strh	w1, [sp, #0x4]
               	ldurh	w1, [x29, #-0x56]
               	strh	w1, [x0, #0x4]
               	ldurh	w1, [x29, #-0x54]
               	strh	w1, [sp, #0x6]
               	ldurh	w1, [x29, #-0x52]
               	strh	w1, [x0, #0x6]
               	ldurh	w1, [x29, #-0x50]
               	strh	w1, [sp, #0x8]
               	ldurh	w1, [x29, #-0x4e]
               	strh	w1, [x0, #0x8]
               	ldurh	w1, [x29, #-0x4c]
               	strh	w1, [sp, #0xa]
               	ldurh	w1, [x29, #-0x4a]
               	strh	w1, [x0, #0xa]
               	ldurh	w1, [x29, #-0x48]
               	strh	w1, [sp, #0xc]
               	ldurh	w1, [x29, #-0x46]
               	strh	w1, [x0, #0xc]
               	ldurh	w1, [x29, #-0x44]
               	strh	w1, [sp, #0xe]
               	ldurh	w1, [x29, #-0x42]
               	strh	w1, [x0, #0xe]
               	sub	x0, x29, #0xf0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	stur	q0, [x29, #-0xf0]
               	stur	q1, [x29, #-0xe0]
               	sub	x1, x29, #0x110
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	ldrh	w4, [x1, x0, lsl #1]
               	sub	x2, x29, #0x60
               	lsl	x3, x0, #1
               	ldrh	w5, [x2, x3, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrh	w4, [x4, x0, lsl #1]
               	add	x3, x3, #0x1
               	ldrh	w2, [x2, x3, lsl #1]
               	cmp	w4, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x170
               	lsl	x3, x0, #2
               	ldrb	w4, [x2, x3]
               	strb	w4, [x1, x0]
               	add	x4, x1, #0x10
               	add	x5, x3, #0x1
               	ldrb	w5, [x2, x5]
               	strb	w5, [x4, x0]
               	add	x4, x1, #0x20
               	add	x5, x3, #0x2
               	ldrb	w5, [x2, x5]
               	strb	w5, [x4, x0]
               	add	x1, x1, #0x30
               	add	x3, x3, #0x3
               	ldrb	w3, [x2, x3]
               	strb	w3, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xf0
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	ldr	q3, [sp, #0x30]
               	stur	q0, [x29, #-0xf0]
               	stur	q1, [x29, #-0xe0]
               	stur	q2, [x29, #-0xd0]
               	stur	q3, [x29, #-0xc0]
               	sub	x1, x29, #0x170
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x170
               	add	x3, x3, x0, lsl #4
               	ldrb	w3, [x3, x1]
               	add	x4, x0, x1, lsl #2
               	ldrb	w4, [x2, x4]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x10
               	b.lt	<addr>
               	ldr	q0, [sp, #0x40]
               	mov	x0, v0.d[0]
               	mov	x17, #0x3ffffffff       // =17179869183
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x51               // =81
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, v0.s[1]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x53               // =83
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp, #0x60]
               	umov	w0, v0.b[0]
               	ldurb	w1, [x29, #-0x40]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[1]
               	ldurb	w1, [x29, #-0x3f]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[2]
               	ldurb	w1, [x29, #-0x3c]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x55               // =85
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4e               // =78
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4a               // =74
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3e               // =62
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3a               // =58
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
