
arm_neon_aegis_round.aarch64:	file format elf64-littleaarch64

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
               	sub	x1, x29, #0x40
               	mov	x0, #0x1c05             // =7173
               	sturh	w0, [x29, #-0x40]
               	mov	x0, #0x4a33             // =18995
               	sturh	w0, [x29, #-0x3e]
               	mov	x0, #0x7861             // =30817
               	sturh	w0, [x29, #-0x3c]
               	mov	x0, #0xa68f             // =42639
               	sturh	w0, [x29, #-0x3a]
               	mov	x0, #0xd4bd             // =54461
               	sturh	w0, [x29, #-0x38]
               	mov	x0, #0x2eb              // =747
               	sturh	w0, [x29, #-0x36]
               	mov	x0, #0x3019             // =12313
               	sturh	w0, [x29, #-0x34]
               	mov	x0, #0x5e47             // =24135
               	sturh	w0, [x29, #-0x32]
               	ldur	q0, [x29, #-0x40]
               	rev32	v0.8h, v0.8h
               	sub	x2, x29, #0x10
               	stur	q0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	and	x4, x0, #0xc
               	add	x5, x0, #0x2
               	and	x5, x5, #0x3
               	orr	x4, x4, x5
               	ldrb	w4, [x1, x4]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	q0, [x29, #-0x40]
               	umov	w0, v0.b[5]
               	eor	x0, x0, #0xff
               	mov	v1.16b, v0.16b
               	mov	v1.b[5], w0
               	sub	x2, x29, #0x20
               	cmeq	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x20]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrb	w3, [x2, x0]
               	mov	x4, #0xff               // =255
               	cmp	w0, #0x5
               	csel	x4, x1, x4, eq
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0xc5c8             // =50632
               	sturh	w0, [x29, #-0x30]
               	mov	x0, #0xbfc2             // =49090
               	sturh	w0, [x29, #-0x2e]
               	mov	x0, #0xb9bc             // =47548
               	sturh	w0, [x29, #-0x2c]
               	mov	x0, #0xb3b6             // =46006
               	sturh	w0, [x29, #-0x2a]
               	mov	x0, #0xadb0             // =44464
               	sturh	w0, [x29, #-0x28]
               	mov	x0, #0xa7aa             // =42922
               	sturh	w0, [x29, #-0x26]
               	mov	x0, #0xa1a4             // =41380
               	sturh	w0, [x29, #-0x24]
               	mov	x0, #0x9b9e             // =39838
               	sturh	w0, [x29, #-0x22]
               	sub	x6, x29, #0x10
               	sub	x3, x29, #0x40
               	ldur	q0, [x29, #-0x40]
               	sub	x4, x29, #0x30
               	ldur	q1, [x29, #-0x30]
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldr	q2, [x2]
               	tbx	v0.16b, { v1.16b }, v2.16b
               	stur	q0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	ldrb	w5, [x6, x0]
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x4, x1]
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	ldrb	w1, [x3, x0]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x1, #0x7f               // =127
               	mov	x0, #0x0                // =0
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	ldrb	w2, [x3, x0]
               	sxtb	x4, w2
               	sxtb	x2, w2
               	cmp	w4, w1
               	csel	x1, x2, x1, lt
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	sminv	b0, v0.16b
               	umov	w0, v0.b[0]
               	sxtb	x0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7788            // =30600
               	movk	x16, #0x5566, lsl #16
               	movk	x16, #0x3344, lsl #32
               	movk	x16, #0x1122, lsl #48
               	fmov	d0, x16
               	mov	x16, #0xff00            // =65280
               	movk	x16, #0xddee, lsl #16
               	movk	x16, #0xbbcc, lsl #32
               	movk	x16, #0x99aa, lsl #48
               	fmov	d1, x16
               	mov	v0.d[1], v1.d[0]
               	mov	x0, v0.d[0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v0.d[1]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x40
               	ldur	q1, [x29, #-0x40]
               	shl	v2.16b, v1.16b, #0x1
               	sshr	v0.16b, v1.16b, #0x7
               	mov	x4, #0x1b               // =27
               	smov	x0, v0.b[0]
               	and	x0, x0, x4
               	mov	v3.b[0], w0
               	smov	x0, v0.b[1]
               	and	x0, x0, x4
               	mov	v3.b[1], w0
               	smov	x0, v0.b[2]
               	and	x0, x0, x4
               	mov	v3.b[2], w0
               	smov	x0, v0.b[3]
               	and	x0, x0, x4
               	mov	v3.b[3], w0
               	smov	x0, v0.b[4]
               	and	x0, x0, x4
               	mov	v3.b[4], w0
               	smov	x0, v0.b[5]
               	and	x0, x0, x4
               	mov	v3.b[5], w0
               	smov	x0, v0.b[6]
               	and	x0, x0, x4
               	mov	v3.b[6], w0
               	smov	x0, v0.b[7]
               	and	x0, x0, x4
               	mov	v3.b[7], w0
               	smov	x0, v0.b[8]
               	and	x0, x0, x4
               	mov	v3.b[8], w0
               	smov	x0, v0.b[9]
               	and	x0, x0, x4
               	mov	v3.b[9], w0
               	smov	x0, v0.b[10]
               	and	x0, x0, x4
               	mov	v3.b[10], w0
               	smov	x0, v0.b[11]
               	and	x0, x0, x4
               	mov	v3.b[11], w0
               	smov	x0, v0.b[12]
               	and	x0, x0, x4
               	mov	v3.b[12], w0
               	smov	x0, v0.b[13]
               	and	x0, x0, x4
               	mov	v3.b[13], w0
               	smov	x0, v0.b[14]
               	and	x0, x0, x4
               	mov	v3.b[14], w0
               	smov	x0, v0.b[15]
               	and	x0, x0, x4
               	mov	v0.16b, v3.16b
               	mov	v0.b[15], w0
               	eor	v0.16b, v2.16b, v0.16b
               	rev32	v2.8h, v1.8h
               	eor	v0.16b, v0.16b, v2.16b
               	eor	v1.16b, v1.16b, v0.16b
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q2, [x0]
               	tbl	v1.16b, { v1.16b }, v2.16b
               	eor	v0.16b, v0.16b, v1.16b
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	and	x2, x0, #0xc
               	and	x3, x0, #0x3
               	add	x7, x2, x3
               	ldrb	w7, [x1, x7]
               	tst	x7, #0x80
               	csel	x8, x4, x5, ne
               	eor	x7, x8, x7, lsl #1
               	and	x9, x7, #0xff
               	add	x7, x3, #0x1
               	and	x7, x7, #0x3
               	add	x7, x2, x7
               	ldrb	w8, [x1, x7]
               	tst	x8, #0x80
               	csel	x10, x4, x5, ne
               	eor	x8, x10, x8, lsl #1
               	and	x8, x8, #0xff
               	eor	x8, x9, x8
               	ldrb	w7, [x1, x7]
               	eor	x7, x8, x7
               	add	x8, x3, #0x2
               	and	x8, x8, #0x3
               	add	x8, x2, x8
               	ldrb	w8, [x1, x8]
               	eor	x7, x7, x8
               	add	x3, x3, #0x3
               	and	x3, x3, #0x3
               	add	x2, x2, x3
               	ldrb	w2, [x1, x2]
               	eor	x2, x7, x2
               	strb	w2, [x6, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	umov	w0, v0.b[0]
               	ldurb	w1, [x29, #-0x10]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	umov	w0, v0.b[1]
               	ldurb	w1, [x29, #-0xf]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[2]
               	ldurb	w1, [x29, #-0xe]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[3]
               	ldurb	w1, [x29, #-0xd]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[4]
               	ldurb	w1, [x29, #-0xc]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[5]
               	ldurb	w1, [x29, #-0xb]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[6]
               	ldurb	w1, [x29, #-0xa]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[7]
               	ldurb	w1, [x29, #-0x9]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[8]
               	ldurb	w1, [x29, #-0x8]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[9]
               	ldurb	w1, [x29, #-0x7]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[10]
               	ldurb	w1, [x29, #-0x6]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[11]
               	ldurb	w1, [x29, #-0x5]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[12]
               	ldurb	w1, [x29, #-0x4]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[13]
               	ldurb	w1, [x29, #-0x3]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[14]
               	ldurb	w1, [x29, #-0x2]
               	cmp	x0, x1
               	b.ne	<addr>
               	umov	w0, v0.b[15]
               	ldurb	w1, [x29, #-0x1]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
