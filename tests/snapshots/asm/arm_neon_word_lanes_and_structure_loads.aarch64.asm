
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
               	sub	sp, sp, #0x120
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
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x40
               	ldur	d0, [x29, #-0x3d]
               	stur	d0, [x29, #-0x78]
               	add	x1, x1, #0x3
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xcdef            // =52719
               	movk	x16, #0x89ab, lsl #16
               	movk	x16, #0x4567, lsl #32
               	movk	x16, #0x123, lsl #48
               	dup	v0.2d, x16
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
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
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	mul	v2.4s, v0.4s, v1.4s
               	mov	w0, v2.s[0]
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v2.s[1]
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v2.s[2]
               	cbnz	x0, <addr>
               	mov	w0, v2.s[3]
               	cmp	w0, #0x3f
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d2, v0.d[0]
               	mov	d3, v0.d[1]
               	mov	w0, v2.s[0]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v2.s[1]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	w0, v3.s[0]
               	mov	x17, #0x10000           // =65536
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v3.s[1]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q3, [x0]
               	mov	d4, v1.d[0]
               	mov	v16.16b, v3.16b
               	umlal	v16.2d, v2.2s, v4.2s
               	mov	v2.16b, v16.16b
               	mov	x0, v2.d[0]
               	mov	x17, #0x3               // =3
               	movk	x17, #0x2, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v2.d[1]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v2.16b, v3.16b
               	umlal2	v2.2d, v0.4s, v1.4s
               	mov	x0, v2.d[0]
               	mov	x17, #0x5               // =5
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v2.d[1]
               	cmp	x0, #0x45
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q2, [x0]
               	xtn	v3.2s, v2.2d
               	mov	w0, v3.s[0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v3.s[1]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	shrn	v3.2s, v2.2d, #0x20
               	mov	w0, v3.s[0]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v3.s[1]
               	mov	x17, #0xbbcc            // =48076
               	movk	x17, #0x99aa, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ushr	v2.2d, v2.2d, #0x3c
               	mov	x0, v2.d[0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, v2.d[1]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	add	sp, sp, #0x120
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
               	ldur	d2, [x29, #-0x70]
               	ldur	d3, [x29, #-0x68]
               	sli	v2.8b, v3.8b, #0x4
               	sub	x3, x29, #0x48
               	stur	d2, [x29, #-0x48]
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
               	ldur	q2, [x29, #-0x40]
               	sub	x1, x29, #0x120
               	str	q2, [sp]
               	ldur	q2, [x29, #-0x30]
               	sub	x2, x29, #0x100
               	stur	q2, [x29, #-0x100]
               	ldr	q3, [sp]
               	mov	v16.16b, v3.16b
               	sri	v16.16b, v2.16b, #0x3
               	mov	v2.16b, v16.16b
               	sub	x3, x29, #0xc0
               	stur	q2, [x29, #-0xc0]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x2, x0]
               	ldrb	w6, [x1, x0]
               	and	x6, x6, #0xe0
               	orr	x5, x6, x5, lsr #3
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0xc0]
               	uzp2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0xb0]
               	stur	q2, [x29, #-0x100]
               	stur	q0, [x29, #-0xf0]
               	ldur	w0, [x29, #-0x100]
               	ldur	w1, [x29, #-0xfc]
               	ldur	w2, [x29, #-0xf8]
               	ldur	w3, [x29, #-0xf4]
               	ldur	w4, [x29, #-0xf0]
               	ldur	w5, [x29, #-0xec]
               	ldur	w6, [x29, #-0xe8]
               	ldur	w7, [x29, #-0xe4]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x17, #0x10000           // =65536
               	cmp	w1, w17
               	b.ne	<addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	mov	x17, #0x10000           // =65536
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x41               // =65
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w4, #0x3
               	b.ne	<addr>
               	cmp	w5, #0x7
               	b.ne	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w6, w17
               	b.ne	<addr>
               	cmp	w7, #0x9
               	b.eq	<addr>
               	mov	x0, #0x43               // =67
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0xc0
               	ldurh	w1, [x29, #-0x60]
               	sturh	w1, [x29, #-0xc0]
               	ldurh	w1, [x29, #-0x5e]
               	sturh	w1, [x29, #-0xb0]
               	ldurh	w1, [x29, #-0x5c]
               	sturh	w1, [x29, #-0xbe]
               	add	x0, x0, #0x10
               	ldurh	w1, [x29, #-0x5a]
               	strh	w1, [x0, #0x2]
               	ldurh	w1, [x29, #-0x58]
               	sturh	w1, [x29, #-0xbc]
               	ldurh	w1, [x29, #-0x56]
               	strh	w1, [x0, #0x4]
               	ldurh	w1, [x29, #-0x54]
               	sturh	w1, [x29, #-0xba]
               	ldurh	w1, [x29, #-0x52]
               	strh	w1, [x0, #0x6]
               	ldurh	w1, [x29, #-0x50]
               	sturh	w1, [x29, #-0xb8]
               	ldurh	w1, [x29, #-0x4e]
               	strh	w1, [x0, #0x8]
               	ldurh	w1, [x29, #-0x4c]
               	sturh	w1, [x29, #-0xb6]
               	ldurh	w1, [x29, #-0x4a]
               	strh	w1, [x0, #0xa]
               	ldurh	w1, [x29, #-0x48]
               	sturh	w1, [x29, #-0xb4]
               	ldurh	w1, [x29, #-0x46]
               	strh	w1, [x0, #0xc]
               	ldurh	w1, [x29, #-0x44]
               	sturh	w1, [x29, #-0xb2]
               	ldurh	w1, [x29, #-0x42]
               	strh	w1, [x0, #0xe]
               	sub	x0, x29, #0x100
               	ldur	q0, [x29, #-0xc0]
               	ldur	q1, [x29, #-0xb0]
               	stur	q0, [x29, #-0x100]
               	stur	q1, [x29, #-0xf0]
               	sub	x3, x29, #0x120
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	mov	x0, #0x0                // =0
               	add	x4, x3, #0x10
               	ldrh	w5, [x3, x0, lsl #1]
               	sub	x1, x29, #0x60
               	lsl	x2, x0, #1
               	ldrh	w6, [x1, x2, lsl #1]
               	cmp	w5, w6
               	b.ne	<addr>
               	ldrh	w5, [x4, x0, lsl #1]
               	add	x2, x2, #0x1
               	ldrh	w1, [x1, x2, lsl #1]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xc0
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
               	sub	x0, x29, #0x100
               	ldur	q0, [x29, #-0xc0]
               	ldur	q1, [x29, #-0xb0]
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	stur	q0, [x29, #-0x100]
               	stur	q1, [x29, #-0xf0]
               	stur	q2, [x29, #-0xe0]
               	stur	q3, [x29, #-0xd0]
               	sub	x1, x29, #0xc0
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
               	sub	x3, x29, #0xc0
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
               	ldr	q0, [sp]
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
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4e               // =78
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4a               // =74
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3e               // =62
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3a               // =58
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
