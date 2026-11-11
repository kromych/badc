
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
               	sub	sp, sp, #0x70
               	sub	x1, x29, #0x40
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x40]
               	mov	x0, #0x1c               // =28
               	sturb	w0, [x29, #-0x3f]
               	mov	x0, #0x33               // =51
               	sturb	w0, [x29, #-0x3e]
               	mov	x0, #0x4a               // =74
               	sturb	w0, [x29, #-0x3d]
               	mov	x0, #0x61               // =97
               	sturb	w0, [x29, #-0x3c]
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0x3b]
               	mov	x0, #0x8f               // =143
               	sturb	w0, [x29, #-0x3a]
               	mov	x0, #0xa6               // =166
               	sturb	w0, [x29, #-0x39]
               	mov	x0, #0xbd               // =189
               	sturb	w0, [x29, #-0x38]
               	mov	x0, #0xd4               // =212
               	sturb	w0, [x29, #-0x37]
               	mov	x0, #0xeb               // =235
               	sturb	w0, [x29, #-0x36]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x35]
               	mov	x0, #0x19               // =25
               	sturb	w0, [x29, #-0x34]
               	mov	x0, #0x30               // =48
               	sturb	w0, [x29, #-0x33]
               	mov	x0, #0x47               // =71
               	sturb	w0, [x29, #-0x32]
               	mov	x0, #0x5e               // =94
               	sturb	w0, [x29, #-0x31]
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	rev32	v0.8h, v0.8h
               	sub	x2, x29, #0x10
               	sub	x16, x29, #0x10
               	str	q0, [x16]
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
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldurb	w0, [x29, #-0xb]
               	eor	x0, x0, #0xff
               	sturb	w0, [x29, #-0xb]
               	sub	x2, x29, #0x20
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	sub	x16, x29, #0x10
               	ldr	q1, [x16]
               	cmeq	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x20
               	str	q0, [x16]
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
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x30]
               	mov	x0, #0xc5               // =197
               	sturb	w0, [x29, #-0x2f]
               	mov	x0, #0xc2               // =194
               	sturb	w0, [x29, #-0x2e]
               	mov	x0, #0xbf               // =191
               	sturb	w0, [x29, #-0x2d]
               	mov	x0, #0xbc               // =188
               	sturb	w0, [x29, #-0x2c]
               	mov	x0, #0xb9               // =185
               	sturb	w0, [x29, #-0x2b]
               	mov	x0, #0xb6               // =182
               	sturb	w0, [x29, #-0x2a]
               	mov	x0, #0xb3               // =179
               	sturb	w0, [x29, #-0x29]
               	mov	x0, #0xb0               // =176
               	sturb	w0, [x29, #-0x28]
               	mov	x0, #0xad               // =173
               	sturb	w0, [x29, #-0x27]
               	mov	x0, #0xaa               // =170
               	sturb	w0, [x29, #-0x26]
               	mov	x0, #0xa7               // =167
               	sturb	w0, [x29, #-0x25]
               	mov	x0, #0xa4               // =164
               	sturb	w0, [x29, #-0x24]
               	mov	x0, #0xa1               // =161
               	sturb	w0, [x29, #-0x23]
               	mov	x0, #0x9e               // =158
               	sturb	w0, [x29, #-0x22]
               	mov	x0, #0x9b               // =155
               	sturb	w0, [x29, #-0x21]
               	sub	x2, x29, #0x10
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	sub	x3, x29, #0x30
               	sub	x16, x29, #0x30
               	ldr	q1, [x16]
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q2, [x16]
               	str	q0, [sp]
               	str	q1, [sp, #0x10]
               	str	q2, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	tbx	v0.16b, { v1.16b }, v2.16b
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w5, [x2, x0]
               	ldrb	w1, [x4, x0]
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x3, x1]
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	ldrb	w1, [x1, x0]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x1, #0x7f               // =127
               	mov	x0, #0x0                // =0
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2, x0]
               	sxtb	x3, w3
               	cmp	w3, w1
               	b.ge	<addr>
               	ldrb	w1, [x2, x0]
               	sxtb	x1, w1
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	sminv	b0, v0.16b
               	umov	w0, v0.b[0]
               	sxtb	x0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
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
               	zip1	v0.2d, v0.2d, v1.2d
               	mov	x0, v0.d[0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x40
               	sub	x16, x29, #0x40
               	ldr	q1, [x16]
               	shl	v2.16b, v1.16b, #0x1
               	sshr	v0.16b, v1.16b, #0x7
               	mov	x3, #0x1b               // =27
               	smov	x0, v0.b[0]
               	and	x0, x0, x3
               	mov	x1, #0x0                // =0
               	fmov	d3, x1
               	mov	v3.b[0], w0
               	smov	x0, v0.b[1]
               	and	x0, x0, x3
               	mov	v3.b[1], w0
               	smov	x0, v0.b[2]
               	and	x0, x0, x3
               	mov	v3.b[2], w0
               	smov	x0, v0.b[3]
               	and	x0, x0, x3
               	mov	v3.b[3], w0
               	smov	x0, v0.b[4]
               	and	x0, x0, x3
               	mov	v3.b[4], w0
               	smov	x0, v0.b[5]
               	and	x0, x0, x3
               	mov	v3.b[5], w0
               	smov	x0, v0.b[6]
               	and	x0, x0, x3
               	mov	v3.b[6], w0
               	smov	x0, v0.b[7]
               	and	x0, x0, x3
               	mov	v3.b[7], w0
               	smov	x0, v0.b[8]
               	and	x0, x0, x3
               	mov	v3.b[8], w0
               	smov	x0, v0.b[9]
               	and	x0, x0, x3
               	mov	v3.b[9], w0
               	smov	x0, v0.b[10]
               	and	x0, x0, x3
               	mov	v3.b[10], w0
               	smov	x0, v0.b[11]
               	and	x0, x0, x3
               	mov	v3.b[11], w0
               	smov	x0, v0.b[12]
               	and	x0, x0, x3
               	mov	v3.b[12], w0
               	smov	x0, v0.b[13]
               	and	x0, x0, x3
               	mov	v3.b[13], w0
               	smov	x0, v0.b[14]
               	and	x0, x0, x3
               	mov	v3.b[14], w0
               	smov	x0, v0.b[15]
               	and	x0, x0, x3
               	mov	v0.16b, v3.16b
               	mov	v0.b[15], w0
               	eor	v0.16b, v2.16b, v0.16b
               	rev32	v2.8h, v1.8h
               	eor	v0.16b, v0.16b, v2.16b
               	eor	v1.16b, v1.16b, v0.16b
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q2, [x16]
               	tbl	v1.16b, { v1.16b }, v2.16b
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	and	x1, x0, #0xc
               	and	x2, x0, #0x3
               	sub	x8, x29, #0x10
               	add	x6, x1, x2
               	ldrb	w6, [x4, x6]
               	tst	x6, #0x80
               	csel	x7, x3, x5, ne
               	eor	x6, x7, x6, lsl #1
               	and	x9, x6, #0xff
               	add	x6, x2, #0x1
               	and	x6, x6, #0x3
               	add	x6, x1, x6
               	ldrb	w7, [x4, x6]
               	tst	x7, #0x80
               	csel	x10, x3, x5, ne
               	eor	x7, x10, x7, lsl #1
               	and	x7, x7, #0xff
               	eor	x7, x9, x7
               	ldrb	w6, [x4, x6]
               	eor	x7, x7, x6
               	sub	x6, x29, #0x40
               	add	x9, x2, #0x2
               	and	x9, x9, #0x3
               	add	x9, x1, x9
               	ldrb	w9, [x6, x9]
               	eor	x7, x7, x9
               	add	x2, x2, #0x3
               	and	x2, x2, #0x3
               	add	x1, x1, x2
               	ldrb	w1, [x6, x1]
               	eor	x1, x7, x1
               	strb	w1, [x8, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x30]
               	ldurb	w1, [x29, #-0x10]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x2f]
               	ldurb	w1, [x29, #-0xf]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2e]
               	ldurb	w1, [x29, #-0xe]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2d]
               	ldurb	w1, [x29, #-0xd]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2c]
               	ldurb	w1, [x29, #-0xc]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2b]
               	ldurb	w1, [x29, #-0xb]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2a]
               	ldurb	w1, [x29, #-0xa]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x29]
               	ldurb	w1, [x29, #-0x9]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x28]
               	ldurb	w1, [x29, #-0x8]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x27]
               	ldurb	w1, [x29, #-0x7]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x26]
               	ldurb	w1, [x29, #-0x6]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x25]
               	ldurb	w1, [x29, #-0x5]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x24]
               	ldurb	w1, [x29, #-0x4]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x23]
               	ldurb	w1, [x29, #-0x3]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x22]
               	ldurb	w1, [x29, #-0x2]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x21]
               	ldurb	w1, [x29, #-0x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
