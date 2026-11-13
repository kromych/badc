
vector_arithmetic_in_whole_registers.aarch64:	file format elf64-littleaarch64

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

<c_ops>:
               	add	v2.16b, v0.16b, v1.16b
               	sub	v3.16b, v0.16b, v1.16b
               	eor	v2.16b, v2.16b, v3.16b
               	and	v0.16b, v0.16b, v1.16b
               	orr	v0.16b, v2.16b, v0.16b
               	ret

<s_ops>:
               	mul	v2.8h, v0.8h, v1.8h
               	sub	v0.8h, v0.8h, v1.8h
               	add	v0.8h, v2.8h, v0.8h
               	ret

<i_ops>:
               	add	v2.4s, v0.4s, v1.4s
               	sub	v0.4s, v0.4s, v1.4s
               	mul	v0.4s, v2.4s, v0.4s
               	ret

<u_ops>:
               	sub	v2.4s, v0.4s, v1.4s
               	orr	v0.16b, v0.16b, v1.16b
               	eor	v0.16b, v2.16b, v0.16b
               	ret

<l_ops>:
               	add	v2.2d, v0.2d, v1.2d
               	and	v0.16b, v0.16b, v1.16b
               	sub	v0.2d, v2.2d, v0.2d
               	ret

<f_ops>:
               	fmul	v2.4s, v0.4s, v1.4s
               	fadd	v2.4s, v2.4s, v0.4s
               	fsub	v0.4s, v1.4s, v0.4s
               	fdiv	v0.4s, v2.4s, v0.4s
               	ret

<d_ops>:
               	fsub	v2.2d, v0.2d, v1.2d
               	fadd	v0.2d, v0.2d, v1.2d
               	fmul	v0.2d, v2.2d, v0.2d
               	fdiv	v0.2d, v0.2d, v1.2d
               	ret

<b8_ops>:
               	add	v2.8b, v0.8b, v1.8b
               	mov	x0, v0.d[0]
               	mov	x1, v1.d[0]
               	orr	x0, x0, x1
               	mov	x1, v2.d[0]
               	eor	x0, x1, x0
               	fmov	d0, x0
               	ret

<h8_ops>:
               	mul	v1.4h, v0.4h, v1.4h
               	sub	v0.4h, v1.4h, v0.4h
               	ret

<i8_ops>:
               	sub	v2.2s, v0.2s, v1.2s
               	add	v0.2s, v0.2s, v1.2s
               	mov	x0, v2.d[0]
               	mov	x1, v0.d[0]
               	and	x0, x0, x1
               	fmov	d0, x0
               	ret

<f8_ops>:
               	fsub	v0.2s, v0.2s, v1.2s
               	fdiv	v0.2s, v0.2s, v1.2s
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x150]!
               	stp	x29, x30, [sp, #0x140]
               	add	x29, sp, #0x140
               	mov	x0, #0xc19c             // =49564
               	mov	x1, #0x6c7f             // =27775
               	strh	w0, [sp, #0x10]
               	strh	w1, [sp, #0x20]
               	mov	x0, #0xbe6              // =3046
               	mov	x1, #0x4659             // =18009
               	strh	w0, [sp, #0x12]
               	strh	w1, [sp, #0x22]
               	mov	x0, #0x5530             // =21808
               	mov	x1, #0x2033             // =8243
               	strh	w0, [sp, #0x14]
               	strh	w1, [sp, #0x24]
               	mov	x0, #0x9f7a             // =40826
               	mov	x1, #0xfa0d             // =64013
               	strh	w0, [sp, #0x16]
               	strh	w1, [sp, #0x26]
               	mov	x0, #0xe9c4             // =59844
               	mov	x1, #0xd4e7             // =54503
               	strh	w0, [sp, #0x18]
               	strh	w1, [sp, #0x28]
               	mov	x0, #0x330e             // =13070
               	mov	x1, #0xaec1             // =44737
               	strh	w0, [sp, #0x1a]
               	strh	w1, [sp, #0x2a]
               	mov	x0, #0x7d58             // =32088
               	mov	x1, #0x889b             // =34971
               	strh	w0, [sp, #0x1c]
               	strh	w1, [sp, #0x2c]
               	mov	x0, #0xc7a2             // =51106
               	mov	x1, #0x6275             // =25205
               	strh	w0, [sp, #0x1e]
               	strh	w1, [sp, #0x2e]
               	mov	x0, #0x8ad0             // =35536
               	movk	x0, #0xadf9, lsl #16
               	mov	x1, #0x3                // =3
               	movk	x1, #0xa, lsl #16
               	str	w0, [sp, #0x30]
               	stur	w1, [x29, #-0x100]
               	mov	x0, #0xd122             // =53538
               	movk	x0, #0xf44b, lsl #16
               	mov	x1, #0x11               // =17
               	movk	x1, #0x18, lsl #16
               	str	w0, [sp, #0x34]
               	stur	w1, [x29, #-0xfc]
               	mov	x0, #0x1774             // =6004
               	movk	x0, #0x3a9d, lsl #16
               	mov	x1, #0x1f               // =31
               	movk	x1, #0x26, lsl #16
               	str	w0, [sp, #0x38]
               	stur	w1, [x29, #-0xf8]
               	mov	x0, #0x5dc6             // =24006
               	movk	x0, #0x80ef, lsl #16
               	mov	x1, #0x2d               // =45
               	movk	x1, #0x34, lsl #16
               	str	w0, [sp, #0x3c]
               	stur	w1, [x29, #-0xf4]
               	mov	x0, #-0x9400            // =-37888
               	movk	x0, #0x88ca, lsl #16
               	stur	w0, [x29, #-0xf0]
               	mov	x0, #0x9c40             // =40000
               	stur	w0, [x29, #-0xe0]
               	mov	x0, #0xf0000000         // =4026531840
               	stur	w0, [x29, #-0xd0]
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	stur	w0, [x29, #-0xc0]
               	fmov	s0, #1.50000000
               	stur	s0, [x29, #-0x90]
               	fmov	s0, #0.50000000
               	stur	s0, [x29, #-0x80]
               	mov	x0, #-0x51bd            // =-20925
               	movk	x0, #0x88d9, lsl #16
               	stur	w0, [x29, #-0xec]
               	mov	x0, #0x9c41             // =40001
               	stur	w0, [x29, #-0xdc]
               	mov	x0, #0x1                // =1
               	movk	x0, #0xf000, lsl #16
               	stur	w0, [x29, #-0xcc]
               	mov	x0, #0xacf0             // =44272
               	movk	x0, #0x2468, lsl #16
               	stur	w0, [x29, #-0xbc]
               	fmov	s0, #2.50000000
               	stur	s0, [x29, #-0x8c]
               	fmov	s0, #0.75000000
               	stur	s0, [x29, #-0x7c]
               	mov	x0, #-0xf7a             // =-3962
               	movk	x0, #0x88e8, lsl #16
               	stur	w0, [x29, #-0xe8]
               	mov	x0, #0x9c42             // =40002
               	stur	w0, [x29, #-0xd8]
               	mov	x0, #0x2                // =2
               	movk	x0, #0xf000, lsl #16
               	stur	w0, [x29, #-0xc8]
               	mov	x0, #0x368              // =872
               	movk	x0, #0x369d, lsl #16
               	stur	w0, [x29, #-0xb8]
               	fmov	s0, #3.50000000
               	stur	s0, [x29, #-0x88]
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x78]
               	mov	x0, #-0xcd37            // =-52535
               	movk	x0, #0x88f8, lsl #16
               	stur	w0, [x29, #-0xe4]
               	mov	x0, #0x9c43             // =40003
               	stur	w0, [x29, #-0xd4]
               	mov	x0, #0x3                // =3
               	movk	x0, #0xf000, lsl #16
               	stur	w0, [x29, #-0xc4]
               	mov	x0, #0x59e0             // =23008
               	movk	x0, #0x48d1, lsl #16
               	stur	w0, [x29, #-0xb4]
               	fmov	s0, #4.50000000
               	stur	s0, [x29, #-0x84]
               	fmov	s0, #1.25000000
               	stur	s0, [x29, #-0x74]
               	mov	x0, #0x7ffffffffffffff0 // =9223372036854775792
               	stur	x0, [x29, #-0xb0]
               	mov	x0, #0x10               // =16
               	stur	x0, [x29, #-0xa0]
               	fmov	d0, #3.00000000
               	stur	d0, [x29, #-0x70]
               	fmov	d0, #0.50000000
               	stur	d0, [x29, #-0x60]
               	mov	x0, #-0xf               // =-15
               	movk	x0, #0x7fff, lsl #48
               	stur	x0, [x29, #-0xa8]
               	mov	x0, #0x11               // =17
               	stur	x0, [x29, #-0x98]
               	fmov	d0, #4.00000000
               	stur	d0, [x29, #-0x68]
               	fmov	d0, #1.50000000
               	stur	d0, [x29, #-0x58]
               	sub	x20, x29, #0x130
               	sub	x21, x29, #0x120
               	ldr	q0, [x20]
               	ldr	q1, [x21]
               	bl	<addr>
               	sub	x3, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsb	x1, [x20, x0]
               	ldrsb	x2, [x21, x0]
               	add	x4, x1, x2
               	sxtb	x4, w4
               	sub	x2, x1, x2
               	sxtb	x2, w2
               	eor	x2, x4, x2
               	sxtb	x2, w2
               	sub	x4, x29, #0x120
               	ldrsb	x4, [x4, x0]
               	and	x1, x1, x4
               	orr	x1, x2, x1
               	ldrsb	x2, [x3, x0]
               	sxtb	x1, w1
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x110
               	sub	x21, x29, #0x100
               	ldr	q0, [x20]
               	ldr	q1, [x21]
               	bl	<addr>
               	sub	x3, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	ldrsh	x4, [x3, x0, lsl #1]
               	ldrsh	x1, [x20, x0, lsl #1]
               	ldrsh	x2, [x21, x0, lsl #1]
               	mul	x5, x1, x2
               	sxth	x5, w5
               	sub	x1, x1, x2
               	sxth	x1, w1
               	add	x1, x5, x1
               	sxth	x1, w1
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x7, x29, #0xf0
               	sub	x0, x29, #0xe0
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	smov	x2, v0.s[0]
               	ldursw	x0, [x29, #-0xf0]
               	ldursw	x1, [x29, #-0xe0]
               	add	x3, x0, x1
               	sub	x0, x0, x1
               	mul	x0, x3, x0
               	sxtw	x0, w0
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	smov	x2, v0.s[1]
               	ldursw	x0, [x29, #-0xec]
               	ldursw	x1, [x29, #-0xdc]
               	add	x3, x0, x1
               	sub	x0, x0, x1
               	mul	x0, x3, x0
               	sxtw	x0, w0
               	cmp	x2, x0
               	b.ne	<addr>
               	smov	x2, v0.s[2]
               	ldursw	x0, [x29, #-0xe8]
               	ldursw	x1, [x29, #-0xd8]
               	add	x3, x0, x1
               	sub	x0, x0, x1
               	mul	x0, x3, x0
               	sxtw	x0, w0
               	cmp	x2, x0
               	b.ne	<addr>
               	smov	x2, v0.s[3]
               	ldursw	x0, [x29, #-0xe4]
               	ldursw	x1, [x29, #-0xd4]
               	add	x3, x0, x1
               	sub	x0, x0, x1
               	mul	x0, x3, x0
               	sxtw	x0, w0
               	cmp	x2, x0
               	b.ne	<addr>
               	sub	x7, x29, #0xd0
               	sub	x0, x29, #0xc0
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	mov	w2, v0.s[0]
               	ldur	w0, [x29, #-0xd0]
               	ldur	w1, [x29, #-0xc0]
               	sub	x3, x0, x1
               	mov	w3, w3
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	w2, v0.s[1]
               	ldur	w0, [x29, #-0xcc]
               	ldur	w1, [x29, #-0xbc]
               	sub	x3, x0, x1
               	mov	w3, w3
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	mov	w2, v0.s[2]
               	ldur	w0, [x29, #-0xc8]
               	ldur	w1, [x29, #-0xb8]
               	sub	x3, x0, x1
               	mov	w3, w3
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	mov	w2, v0.s[3]
               	ldur	w0, [x29, #-0xc4]
               	ldur	w1, [x29, #-0xb4]
               	sub	x3, x0, x1
               	mov	w3, w3
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	sub	x7, x29, #0xb0
               	sub	x0, x29, #0xa0
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	mov	x2, v0.d[0]
               	ldur	x0, [x29, #-0xb0]
               	ldur	x1, [x29, #-0xa0]
               	add	x3, x0, x1
               	and	x0, x0, x1
               	sub	x0, x3, x0
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x2, v0.d[1]
               	ldur	x0, [x29, #-0xa8]
               	ldur	x1, [x29, #-0x98]
               	add	x3, x0, x1
               	and	x0, x0, x1
               	sub	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	sub	x7, x29, #0x90
               	sub	x0, x29, #0x80
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	ldur	s1, [x29, #-0x90]
               	ldur	s2, [x29, #-0x80]
               	fmul	s3, s1, s2
               	fadd	s3, s3, s1
               	mov	s4, v0.s[0]
               	fsub	s1, s2, s1
               	fdiv	s1, s3, s1
               	fcmp	s4, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	ldur	s1, [x29, #-0x8c]
               	ldur	s2, [x29, #-0x7c]
               	fmul	s3, s1, s2
               	fadd	s3, s3, s1
               	mov	s4, v0.s[1]
               	fsub	s1, s2, s1
               	fdiv	s1, s3, s1
               	fcmp	s4, s1
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x88]
               	ldur	s2, [x29, #-0x78]
               	fmul	s3, s1, s2
               	fadd	s3, s3, s1
               	mov	s4, v0.s[2]
               	fsub	s1, s2, s1
               	fdiv	s1, s3, s1
               	fcmp	s4, s1
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x84]
               	ldur	s2, [x29, #-0x74]
               	fmul	s3, s1, s2
               	fadd	s3, s3, s1
               	mov	s0, v0.s[3]
               	fsub	s1, s2, s1
               	fdiv	s1, s3, s1
               	fcmp	s0, s1
               	b.ne	<addr>
               	sub	x7, x29, #0x70
               	sub	x0, x29, #0x60
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	ldur	d2, [x29, #-0x70]
               	ldur	d1, [x29, #-0x60]
               	fsub	d3, d2, d1
               	fadd	d2, d2, d1
               	fmul	d2, d3, d2
               	mov	d3, v0.d[0]
               	fdiv	d1, d2, d1
               	fcmp	d3, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	ldur	d2, [x29, #-0x68]
               	ldur	d1, [x29, #-0x58]
               	fsub	d3, d2, d1
               	fadd	d2, d2, d1
               	fmul	d2, d3, d2
               	mov	d0, v0.d[1]
               	fdiv	d1, d2, d1
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0xf1c8             // =61896
               	mov	x1, #0x7063             // =28771
               	sturh	w0, [x29, #-0x40]
               	sturh	w1, [x29, #-0x38]
               	mov	x0, #0x431a             // =17178
               	mov	x1, #0x8a7d             // =35453
               	sturh	w0, [x29, #-0x3e]
               	sturh	w1, [x29, #-0x36]
               	mov	x0, #0x956c             // =38252
               	mov	x1, #0xa497             // =42135
               	sturh	w0, [x29, #-0x3c]
               	sturh	w1, [x29, #-0x34]
               	mov	x0, #0xe7be             // =59326
               	mov	x1, #0xbeb1             // =48817
               	sturh	w0, [x29, #-0x3a]
               	sturh	w1, [x29, #-0x32]
               	mov	x0, #0xb1e0             // =45536
               	movk	x0, #0xe219, lsl #16
               	mov	x1, #0x7                // =7
               	movk	x1, #0x8, lsl #16
               	stur	w0, [x29, #-0x30]
               	stur	w1, [x29, #-0x28]
               	mov	x0, #0x1252             // =4690
               	movk	x0, #0x428b, lsl #16
               	mov	x1, #0x9                // =9
               	movk	x1, #0xa, lsl #16
               	stur	w0, [x29, #-0x2c]
               	stur	w1, [x29, #-0x24]
               	mov	x0, #0x9400             // =37888
               	movk	x0, #0x7735, lsl #16
               	stur	w0, [x29, #-0x20]
               	mov	x0, #-0x9400            // =-37888
               	movk	x0, #0x88ca, lsl #16
               	stur	w0, [x29, #-0x18]
               	fmov	s0, #2.50000000
               	stur	s0, [x29, #-0x10]
               	fmov	s0, #0.50000000
               	stur	s0, [x29, #-0x8]
               	mov	x0, #0x9401             // =37889
               	movk	x0, #0x7735, lsl #16
               	stur	w0, [x29, #-0x1c]
               	mov	x0, #-0x9401            // =-37889
               	movk	x0, #0x88ca, lsl #16
               	stur	w0, [x29, #-0x14]
               	fmov	s0, #3.50000000
               	stur	s0, [x29, #-0xc]
               	fmov	s0, #1.50000000
               	stur	s0, [x29, #-0x4]
               	sub	x7, x29, #0x40
               	sub	x0, x29, #0x38
               	ldr	d0, [x7]
               	ldr	d1, [x0]
               	bl	<addr>
               	umov	w2, v0.b[0]
               	ldurb	w0, [x29, #-0x40]
               	ldurb	w1, [x29, #-0x38]
               	add	x3, x0, x1
               	and	x3, x3, #0xff
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	umov	w2, v0.b[1]
               	ldurb	w0, [x29, #-0x3f]
               	ldurb	w1, [x29, #-0x37]
               	add	x3, x0, x1
               	and	x3, x3, #0xff
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	umov	w2, v0.b[2]
               	ldurb	w0, [x29, #-0x3e]
               	ldurb	w1, [x29, #-0x36]
               	add	x3, x0, x1
               	and	x3, x3, #0xff
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	umov	w2, v0.b[3]
               	ldurb	w0, [x29, #-0x3d]
               	ldurb	w1, [x29, #-0x35]
               	add	x3, x0, x1
               	and	x3, x3, #0xff
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	umov	w2, v0.b[4]
               	ldurb	w0, [x29, #-0x3c]
               	ldurb	w1, [x29, #-0x34]
               	add	x3, x0, x1
               	and	x3, x3, #0xff
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	umov	w2, v0.b[5]
               	ldurb	w0, [x29, #-0x3b]
               	ldurb	w1, [x29, #-0x33]
               	add	x3, x0, x1
               	and	x3, x3, #0xff
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	umov	w2, v0.b[6]
               	ldurb	w0, [x29, #-0x3a]
               	ldurb	w1, [x29, #-0x32]
               	add	x3, x0, x1
               	and	x3, x3, #0xff
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	umov	w2, v0.b[7]
               	ldurb	w0, [x29, #-0x39]
               	ldurb	w1, [x29, #-0x31]
               	add	x3, x0, x1
               	and	x3, x3, #0xff
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	sub	x7, x29, #0x30
               	sub	x0, x29, #0x28
               	ldr	d0, [x7]
               	ldr	d1, [x0]
               	bl	<addr>
               	smov	x1, v0.h[0]
               	ldursh	x0, [x29, #-0x30]
               	ldursh	x2, [x29, #-0x28]
               	mul	x2, x0, x2
               	sxth	x2, w2
               	sub	x0, x2, x0
               	sxth	x0, w0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	smov	x1, v0.h[1]
               	ldursh	x0, [x29, #-0x2e]
               	ldursh	x2, [x29, #-0x26]
               	mul	x2, x0, x2
               	sxth	x2, w2
               	sub	x0, x2, x0
               	sxth	x0, w0
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.h[2]
               	ldursh	x0, [x29, #-0x2c]
               	ldursh	x2, [x29, #-0x24]
               	mul	x2, x0, x2
               	sxth	x2, w2
               	sub	x0, x2, x0
               	sxth	x0, w0
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.h[3]
               	ldursh	x0, [x29, #-0x2a]
               	ldursh	x2, [x29, #-0x22]
               	mul	x2, x0, x2
               	sxth	x2, w2
               	sub	x0, x2, x0
               	sxth	x0, w0
               	cmp	x1, x0
               	b.ne	<addr>
               	sub	x7, x29, #0x20
               	sub	x0, x29, #0x18
               	ldr	d0, [x7]
               	ldr	d1, [x0]
               	bl	<addr>
               	smov	x2, v0.s[0]
               	ldursw	x0, [x29, #-0x20]
               	ldursw	x1, [x29, #-0x18]
               	sub	x3, x0, x1
               	add	x0, x0, x1
               	and	x0, x3, x0
               	sxtw	x0, w0
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	smov	x2, v0.s[1]
               	ldursw	x0, [x29, #-0x1c]
               	ldursw	x1, [x29, #-0x14]
               	sub	x3, x0, x1
               	add	x0, x0, x1
               	and	x0, x3, x0
               	sxtw	x0, w0
               	cmp	x2, x0
               	b.ne	<addr>
               	sub	x7, x29, #0x10
               	sub	x0, x29, #0x8
               	ldr	d0, [x7]
               	ldr	d1, [x0]
               	bl	<addr>
               	ldur	s2, [x29, #-0x10]
               	ldur	s1, [x29, #-0x8]
               	fsub	s2, s2, s1
               	mov	s3, v0.s[0]
               	fdiv	s1, s2, s1
               	fcmp	s3, s1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	ldur	s2, [x29, #-0xc]
               	ldur	s1, [x29, #-0x4]
               	fsub	s2, s2, s1
               	mov	s0, v0.s[1]
               	fdiv	s1, s2, s1
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x20, x21, [sp], #0x150
               	ret
