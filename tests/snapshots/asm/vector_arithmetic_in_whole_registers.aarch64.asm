
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

<main>:
               	stp	x20, x21, [sp, #-0x110]!
               	stp	x29, x30, [sp, #0x100]
               	add	x29, sp, #0x100
               	mov	x0, #-0x64              // =-100
               	sturb	w0, [x29, #-0xf0]
               	mov	x0, #0x7f               // =127
               	sturb	w0, [x29, #-0xe0]
               	mov	x0, #-0x3f              // =-63
               	sturb	w0, [x29, #-0xef]
               	mov	x1, #0x6c               // =108
               	sturb	w1, [x29, #-0xdf]
               	mov	x1, #-0x1a              // =-26
               	sturb	w1, [x29, #-0xee]
               	mov	x1, #0x59               // =89
               	sturb	w1, [x29, #-0xde]
               	mov	x1, #0xb                // =11
               	sturb	w1, [x29, #-0xed]
               	mov	x1, #0x46               // =70
               	sturb	w1, [x29, #-0xdd]
               	mov	x1, #0x30               // =48
               	sturb	w1, [x29, #-0xec]
               	mov	x1, #0x33               // =51
               	sturb	w1, [x29, #-0xdc]
               	mov	x2, #0x55               // =85
               	sturb	w2, [x29, #-0xeb]
               	mov	x2, #0x20               // =32
               	sturb	w2, [x29, #-0xdb]
               	mov	x2, #0x7a               // =122
               	sturb	w2, [x29, #-0xea]
               	mov	x2, #0xd                // =13
               	sturb	w2, [x29, #-0xda]
               	mov	x2, #-0x61              // =-97
               	sturb	w2, [x29, #-0xe9]
               	mov	x2, #-0x6               // =-6
               	sturb	w2, [x29, #-0xd9]
               	mov	x2, #-0x3c              // =-60
               	sturb	w2, [x29, #-0xe8]
               	mov	x2, #-0x19              // =-25
               	sturb	w2, [x29, #-0xd8]
               	mov	x2, #-0x17              // =-23
               	sturb	w2, [x29, #-0xe7]
               	mov	x2, #-0x2c              // =-44
               	sturb	w2, [x29, #-0xd7]
               	mov	x2, #0xe                // =14
               	sturb	w2, [x29, #-0xe6]
               	sturb	w0, [x29, #-0xd6]
               	sturb	w1, [x29, #-0xe5]
               	mov	x0, #-0x52              // =-82
               	sturb	w0, [x29, #-0xd5]
               	mov	x0, #0x58               // =88
               	sturb	w0, [x29, #-0xe4]
               	mov	x0, #-0x65              // =-101
               	sturb	w0, [x29, #-0xd4]
               	mov	x0, #0x7d               // =125
               	sturb	w0, [x29, #-0xe3]
               	mov	x0, #-0x78              // =-120
               	sturb	w0, [x29, #-0xd3]
               	mov	x0, #-0x5e              // =-94
               	sturb	w0, [x29, #-0xe2]
               	mov	x0, #0x75               // =117
               	sturb	w0, [x29, #-0xd2]
               	mov	x0, #-0x39              // =-57
               	sturb	w0, [x29, #-0xe1]
               	mov	x0, #0x62               // =98
               	sturb	w0, [x29, #-0xd1]
               	mov	x0, #-0x7530            // =-30000
               	sturh	w0, [x29, #-0xd0]
               	mov	x0, #0x3                // =3
               	sturh	w0, [x29, #-0xc0]
               	mov	x0, #-0x5207            // =-20999
               	sturh	w0, [x29, #-0xce]
               	mov	x0, #0xa                // =10
               	sturh	w0, [x29, #-0xbe]
               	mov	x0, #-0x2ede            // =-11998
               	sturh	w0, [x29, #-0xcc]
               	mov	x0, #0x11               // =17
               	sturh	w0, [x29, #-0xbc]
               	mov	x0, #-0xbb5             // =-2997
               	sturh	w0, [x29, #-0xca]
               	mov	x0, #0x18               // =24
               	sturh	w0, [x29, #-0xba]
               	mov	x0, #0x1774             // =6004
               	sturh	w0, [x29, #-0xc8]
               	mov	x0, #0x1f               // =31
               	sturh	w0, [x29, #-0xb8]
               	mov	x0, #0x3a9d             // =15005
               	sturh	w0, [x29, #-0xc6]
               	mov	x0, #0x26               // =38
               	sturh	w0, [x29, #-0xb6]
               	mov	x0, #0x5dc6             // =24006
               	sturh	w0, [x29, #-0xc4]
               	mov	x0, #0x2d               // =45
               	sturh	w0, [x29, #-0xb4]
               	mov	x0, #-0x7f11            // =-32529
               	sturh	w0, [x29, #-0xc2]
               	mov	x0, #0x34               // =52
               	sturh	w0, [x29, #-0xb2]
               	mov	x0, #-0x9400            // =-37888
               	movk	x0, #0x88ca, lsl #16
               	stur	w0, [x29, #-0xb0]
               	mov	x0, #0x9c40             // =40000
               	stur	w0, [x29, #-0xa0]
               	mov	x0, #0xf0000000         // =4026531840
               	stur	w0, [x29, #-0x90]
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	stur	w0, [x29, #-0x80]
               	fmov	s0, #1.50000000
               	stur	s0, [x29, #-0x50]
               	fmov	s0, #0.50000000
               	stur	s0, [x29, #-0x40]
               	mov	x0, #-0x51bd            // =-20925
               	movk	x0, #0x88d9, lsl #16
               	stur	w0, [x29, #-0xac]
               	mov	x0, #0x9c41             // =40001
               	stur	w0, [x29, #-0x9c]
               	mov	x0, #0x1                // =1
               	movk	x0, #0xf000, lsl #16
               	stur	w0, [x29, #-0x8c]
               	mov	x0, #0xacf0             // =44272
               	movk	x0, #0x2468, lsl #16
               	stur	w0, [x29, #-0x7c]
               	fmov	s0, #2.50000000
               	stur	s0, [x29, #-0x4c]
               	fmov	s0, #0.75000000
               	stur	s0, [x29, #-0x3c]
               	mov	x0, #-0xf7a             // =-3962
               	movk	x0, #0x88e8, lsl #16
               	stur	w0, [x29, #-0xa8]
               	mov	x0, #0x9c42             // =40002
               	stur	w0, [x29, #-0x98]
               	mov	x0, #0x2                // =2
               	movk	x0, #0xf000, lsl #16
               	stur	w0, [x29, #-0x88]
               	mov	x0, #0x368              // =872
               	movk	x0, #0x369d, lsl #16
               	stur	w0, [x29, #-0x78]
               	fmov	s0, #3.50000000
               	stur	s0, [x29, #-0x48]
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x38]
               	mov	x0, #-0xcd37            // =-52535
               	movk	x0, #0x88f8, lsl #16
               	stur	w0, [x29, #-0xa4]
               	mov	x0, #0x9c43             // =40003
               	stur	w0, [x29, #-0x94]
               	mov	x0, #0x3                // =3
               	movk	x0, #0xf000, lsl #16
               	stur	w0, [x29, #-0x84]
               	mov	x0, #0x59e0             // =23008
               	movk	x0, #0x48d1, lsl #16
               	stur	w0, [x29, #-0x74]
               	fmov	s0, #4.50000000
               	stur	s0, [x29, #-0x44]
               	fmov	s0, #1.25000000
               	stur	s0, [x29, #-0x34]
               	mov	x0, #0x7ffffffffffffff0 // =9223372036854775792
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0x10               // =16
               	stur	x0, [x29, #-0x60]
               	fmov	d0, #3.00000000
               	stur	d0, [x29, #-0x30]
               	fmov	d0, #0.50000000
               	stur	d0, [x29, #-0x20]
               	mov	x0, #-0xf               // =-15
               	movk	x0, #0x7fff, lsl #48
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x11               // =17
               	stur	x0, [x29, #-0x58]
               	fmov	d0, #4.00000000
               	stur	d0, [x29, #-0x28]
               	fmov	d0, #1.50000000
               	stur	d0, [x29, #-0x18]
               	sub	x20, x29, #0xf0
               	sub	x21, x29, #0xe0
               	ldr	q0, [x20]
               	ldr	q1, [x21]
               	bl	<addr>
               	sub	x3, x29, #0x10
               	stur	q0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	ldrsb	x1, [x20, x0]
               	ldrsb	x2, [x21, x0]
               	add	x4, x1, x2
               	sxtb	x4, w4
               	sub	x1, x1, x2
               	sxtb	x1, w1
               	eor	x1, x4, x1
               	sxtb	x1, w1
               	ldrsb	x2, [x20, x0]
               	sub	x4, x29, #0xe0
               	ldrsb	x4, [x4, x0]
               	and	x2, x2, x4
               	orr	x1, x1, x2
               	ldrsb	x2, [x3, x0]
               	sxtb	x1, w1
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0xd0
               	sub	x21, x29, #0xc0
               	ldr	q0, [x20]
               	ldr	q1, [x21]
               	bl	<addr>
               	sub	x3, x29, #0x10
               	stur	q0, [x29, #-0x10]
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
               	sub	x7, x29, #0xb0
               	sub	x0, x29, #0xa0
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	ldursw	x2, [x29, #-0x10]
               	ldursw	x0, [x29, #-0xb0]
               	ldursw	x1, [x29, #-0xa0]
               	add	x3, x0, x1
               	sub	x0, x0, x1
               	mul	x0, x3, x0
               	cmp	w2, w0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x100]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldursw	x2, [x29, #-0xc]
               	ldursw	x0, [x29, #-0xac]
               	ldursw	x1, [x29, #-0x9c]
               	add	x3, x0, x1
               	sub	x0, x0, x1
               	mul	x0, x3, x0
               	cmp	w2, w0
               	b.ne	<addr>
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x0, [x29, #-0xa8]
               	ldursw	x1, [x29, #-0x98]
               	add	x3, x0, x1
               	sub	x0, x0, x1
               	mul	x0, x3, x0
               	cmp	w2, w0
               	b.ne	<addr>
               	ldursw	x2, [x29, #-0x4]
               	ldursw	x0, [x29, #-0xa4]
               	ldursw	x1, [x29, #-0x94]
               	add	x3, x0, x1
               	sub	x0, x0, x1
               	mul	x0, x3, x0
               	cmp	w2, w0
               	b.ne	<addr>
               	sub	x7, x29, #0x90
               	sub	x0, x29, #0x80
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	ldur	w2, [x29, #-0x10]
               	ldur	w0, [x29, #-0x90]
               	ldur	w1, [x29, #-0x80]
               	sub	x3, x0, x1
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	w2, w0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x100]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldur	w2, [x29, #-0xc]
               	ldur	w0, [x29, #-0x8c]
               	ldur	w1, [x29, #-0x7c]
               	sub	x3, x0, x1
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	w2, w0
               	b.ne	<addr>
               	ldur	w2, [x29, #-0x8]
               	ldur	w0, [x29, #-0x88]
               	ldur	w1, [x29, #-0x78]
               	sub	x3, x0, x1
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	w2, w0
               	b.ne	<addr>
               	ldur	w2, [x29, #-0x4]
               	ldur	w0, [x29, #-0x84]
               	ldur	w1, [x29, #-0x74]
               	sub	x3, x0, x1
               	orr	x0, x0, x1
               	eor	x0, x3, x0
               	cmp	w2, w0
               	b.ne	<addr>
               	sub	x7, x29, #0x70
               	sub	x0, x29, #0x60
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	ldur	x2, [x29, #-0x10]
               	ldur	x0, [x29, #-0x70]
               	ldur	x1, [x29, #-0x60]
               	add	x3, x0, x1
               	and	x0, x0, x1
               	sub	x0, x3, x0
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x100]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldur	x2, [x29, #-0x8]
               	ldur	x0, [x29, #-0x68]
               	ldur	x1, [x29, #-0x58]
               	add	x3, x0, x1
               	and	x0, x0, x1
               	sub	x0, x3, x0
               	cmp	x2, x0
               	b.ne	<addr>
               	sub	x7, x29, #0x50
               	sub	x0, x29, #0x40
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x50]
               	ldur	s1, [x29, #-0x40]
               	fmul	s1, s0, s1
               	fadd	s0, s1, s0
               	ldur	s1, [x29, #-0x10]
               	ldur	s2, [x29, #-0x40]
               	ldur	s3, [x29, #-0x50]
               	fsub	s2, s2, s3
               	fdiv	s0, s0, s2
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x100]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldur	s0, [x29, #-0x4c]
               	ldur	s1, [x29, #-0x3c]
               	fmul	s1, s0, s1
               	fadd	s0, s1, s0
               	ldur	s1, [x29, #-0xc]
               	ldur	s2, [x29, #-0x3c]
               	ldur	s3, [x29, #-0x4c]
               	fsub	s2, s2, s3
               	fdiv	s0, s0, s2
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x48]
               	ldur	s1, [x29, #-0x38]
               	fmul	s1, s0, s1
               	fadd	s0, s1, s0
               	ldur	s1, [x29, #-0x8]
               	ldur	s2, [x29, #-0x38]
               	ldur	s3, [x29, #-0x48]
               	fsub	s2, s2, s3
               	fdiv	s0, s0, s2
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x44]
               	ldur	s1, [x29, #-0x34]
               	fmul	s1, s0, s1
               	fadd	s0, s1, s0
               	ldur	s1, [x29, #-0x4]
               	ldur	s2, [x29, #-0x34]
               	ldur	s3, [x29, #-0x44]
               	fsub	s2, s2, s3
               	fdiv	s0, s0, s2
               	fcmp	s1, s0
               	b.ne	<addr>
               	sub	x7, x29, #0x30
               	sub	x0, x29, #0x20
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x20]
               	fsub	d2, d0, d1
               	fadd	d0, d0, d1
               	fmul	d0, d2, d0
               	ldur	d1, [x29, #-0x10]
               	ldur	d2, [x29, #-0x20]
               	fdiv	d0, d0, d2
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x100]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldur	d0, [x29, #-0x28]
               	ldur	d1, [x29, #-0x18]
               	fsub	d2, d0, d1
               	fadd	d0, d0, d1
               	fmul	d0, d2, d0
               	ldur	d1, [x29, #-0x8]
               	ldur	d2, [x29, #-0x18]
               	fdiv	d0, d0, d2
               	fcmp	d1, d0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x100]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x100]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x100]
               	ldp	x20, x21, [sp], #0x110
               	ret
