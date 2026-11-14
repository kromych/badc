
vector_arithmetic_in_ymm_registers.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	add	v0.16b, v0.16b, v1.16b
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	add	v1.16b, v1.16b, v2.16b
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	sub	v0.16b, v0.16b, v1.16b
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	sub	v1.16b, v1.16b, v2.16b
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldur	q2, [x29, #-0x70]
               	eor	v0.16b, v2.16b, v0.16b
               	ldur	q2, [x29, #-0x60]
               	eor	v1.16b, v2.16b, v1.16b
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	and	v0.16b, v0.16b, v1.16b
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	and	v1.16b, v1.16b, v2.16b
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldur	q2, [x29, #-0x70]
               	orr	v0.16b, v2.16b, v0.16b
               	ldur	q2, [x29, #-0x60]
               	orr	v1.16b, v2.16b, v1.16b
               	sub	x0, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<s_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	mul	v0.8h, v0.8h, v1.8h
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	mul	v1.8h, v1.8h, v2.8h
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	sub	v0.8h, v0.8h, v1.8h
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	sub	v1.8h, v1.8h, v2.8h
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldur	q2, [x29, #-0x70]
               	add	v0.8h, v2.8h, v0.8h
               	ldur	q2, [x29, #-0x60]
               	add	v1.8h, v2.8h, v1.8h
               	sub	x0, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<i_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	add	v0.4s, v0.4s, v1.4s
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	add	v1.4s, v1.4s, v2.4s
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	sub	v0.4s, v0.4s, v1.4s
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	sub	v1.4s, v1.4s, v2.4s
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldur	q2, [x29, #-0x70]
               	eor	v0.16b, v2.16b, v0.16b
               	ldur	q2, [x29, #-0x60]
               	eor	v1.16b, v2.16b, v1.16b
               	sub	x0, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<u_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	sub	v0.4s, v0.4s, v1.4s
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	sub	v1.4s, v1.4s, v2.4s
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	orr	v0.16b, v0.16b, v1.16b
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	orr	v1.16b, v1.16b, v2.16b
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldur	q2, [x29, #-0x70]
               	eor	v0.16b, v2.16b, v0.16b
               	ldur	q2, [x29, #-0x60]
               	eor	v1.16b, v2.16b, v1.16b
               	sub	x0, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<l_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	add	v0.2d, v0.2d, v1.2d
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	add	v1.2d, v1.2d, v2.2d
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	and	v0.16b, v0.16b, v1.16b
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	and	v1.16b, v1.16b, v2.16b
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldur	q2, [x29, #-0x70]
               	sub	v0.2d, v2.2d, v0.2d
               	ldur	q2, [x29, #-0x60]
               	sub	v1.2d, v2.2d, v1.2d
               	sub	x0, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<f_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	fmul	v0.4s, v0.4s, v1.4s
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	fmul	v1.4s, v1.4s, v2.4s
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldr	q2, [x0]
               	fadd	v0.4s, v0.4s, v2.4s
               	ldr	q2, [x0, #0x10]
               	fadd	v1.4s, v1.4s, v2.4s
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldr	q0, [x1]
               	ldr	q1, [x0]
               	fsub	v0.4s, v0.4s, v1.4s
               	ldr	q1, [x1, #0x10]
               	ldr	q2, [x0, #0x10]
               	fsub	v1.4s, v1.4s, v2.4s
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldur	q2, [x29, #-0x50]
               	fdiv	v0.4s, v2.4s, v0.4s
               	ldur	q2, [x29, #-0x40]
               	fdiv	v1.4s, v2.4s, v1.4s
               	sub	x0, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<d_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	fsub	v0.2d, v0.2d, v1.2d
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	fsub	v1.2d, v1.2d, v2.2d
               	stur	q0, [x29, #-0x70]
               	stur	q1, [x29, #-0x60]
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	fadd	v0.2d, v0.2d, v1.2d
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x1, #0x10]
               	fadd	v1.2d, v1.2d, v2.2d
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldur	q2, [x29, #-0x70]
               	fmul	v0.2d, v2.2d, v0.2d
               	ldur	q2, [x29, #-0x60]
               	fmul	v1.2d, v2.2d, v1.2d
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	ldr	q2, [x1]
               	fdiv	v0.2d, v0.2d, v2.2d
               	ldr	q2, [x1, #0x10]
               	fdiv	v1.2d, v1.2d, v2.2d
               	sub	x0, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<touch>:
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x20]
               	add	x0, x2, x0
               	str	w0, [x1, #0x20]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x8c0
               	stp	x20, x21, [sp]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x13               // =19
               	mov	x2, #0x25               // =37
               	sub	x3, x29, #0x8b0
               	mul	x4, x0, x2
               	sub	x4, x4, #0x64
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x890
               	mov	x4, #0x7f               // =127
               	mul	x5, x0, x1
               	sub	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x8ad0             // =35536
               	movk	x0, #0xadf9, lsl #16
               	mov	x1, #0x3                // =3
               	movk	x1, #0xa, lsl #16
               	str	w0, [sp, #0x50]
               	str	w1, [sp, #0x70]
               	mov	x0, #0xd122             // =53538
               	movk	x0, #0xf44b, lsl #16
               	mov	x1, #0x11               // =17
               	movk	x1, #0x18, lsl #16
               	str	w0, [sp, #0x54]
               	str	w1, [sp, #0x74]
               	mov	x0, #0x1774             // =6004
               	movk	x0, #0x3a9d, lsl #16
               	mov	x1, #0x1f               // =31
               	movk	x1, #0x26, lsl #16
               	str	w0, [sp, #0x58]
               	str	w1, [sp, #0x78]
               	mov	x0, #0x5dc6             // =24006
               	movk	x0, #0x80ef, lsl #16
               	mov	x1, #0x2d               // =45
               	movk	x1, #0x34, lsl #16
               	str	w0, [sp, #0x5c]
               	str	w1, [sp, #0x7c]
               	mov	x0, #0xa418             // =42008
               	movk	x0, #0xc741, lsl #16
               	mov	x1, #0x3b               // =59
               	movk	x1, #0x42, lsl #16
               	str	w0, [sp, #0x60]
               	str	w1, [sp, #0x80]
               	mov	x0, #0xea6a             // =60010
               	movk	x0, #0xd93, lsl #16
               	mov	x1, #0x49               // =73
               	movk	x1, #0x50, lsl #16
               	str	w0, [sp, #0x64]
               	str	w1, [sp, #0x84]
               	mov	x0, #0x30bc             // =12476
               	movk	x0, #0x53e5, lsl #16
               	mov	x1, #0x57               // =87
               	movk	x1, #0x5e, lsl #16
               	str	w0, [sp, #0x68]
               	str	w1, [sp, #0x88]
               	mov	x0, #0x770e             // =30478
               	movk	x0, #0x9a37, lsl #16
               	mov	x1, #0x65               // =101
               	movk	x1, #0x6c, lsl #16
               	str	w0, [sp, #0x6c]
               	str	w1, [sp, #0x8c]
               	mov	x0, #-0x9400            // =-37888
               	movk	x0, #0x88ca, lsl #16
               	str	w0, [sp, #0x90]
               	mov	x0, #0x9c40             // =40000
               	str	w0, [sp, #0xb0]
               	mov	x0, #0xf0000000         // =4026531840
               	str	w0, [sp, #0xd0]
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	str	w0, [sp, #0xf0]
               	fmov	s0, #1.50000000
               	str	s0, [sp, #0x150]
               	fmov	s0, #0.50000000
               	str	s0, [sp, #0x170]
               	mov	x0, #-0x51bd            // =-20925
               	movk	x0, #0x88d9, lsl #16
               	str	w0, [sp, #0x94]
               	mov	x0, #0x9c41             // =40001
               	str	w0, [sp, #0xb4]
               	mov	x0, #0x1                // =1
               	movk	x0, #0xf000, lsl #16
               	str	w0, [sp, #0xd4]
               	mov	x0, #0xacf0             // =44272
               	movk	x0, #0x2468, lsl #16
               	str	w0, [sp, #0xf4]
               	fmov	s0, #2.50000000
               	str	s0, [sp, #0x154]
               	fmov	s0, #0.75000000
               	str	s0, [sp, #0x174]
               	mov	x0, #-0xf7a             // =-3962
               	movk	x0, #0x88e8, lsl #16
               	str	w0, [sp, #0x98]
               	mov	x0, #0x9c42             // =40002
               	str	w0, [sp, #0xb8]
               	mov	x0, #0x2                // =2
               	movk	x0, #0xf000, lsl #16
               	str	w0, [sp, #0xd8]
               	mov	x0, #0x368              // =872
               	movk	x0, #0x369d, lsl #16
               	str	w0, [sp, #0xf8]
               	fmov	s0, #3.50000000
               	str	s0, [sp, #0x158]
               	fmov	s0, #1.00000000
               	str	s0, [sp, #0x178]
               	mov	x0, #-0xcd37            // =-52535
               	movk	x0, #0x88f8, lsl #16
               	str	w0, [sp, #0x9c]
               	mov	x0, #0x9c43             // =40003
               	str	w0, [sp, #0xbc]
               	mov	x0, #0x3                // =3
               	movk	x0, #0xf000, lsl #16
               	str	w0, [sp, #0xdc]
               	mov	x0, #0x59e0             // =23008
               	movk	x0, #0x48d1, lsl #16
               	str	w0, [sp, #0xfc]
               	fmov	s0, #4.50000000
               	str	s0, [sp, #0x15c]
               	fmov	s0, #1.25000000
               	str	s0, [sp, #0x17c]
               	mov	x0, #-0x8af4            // =-35572
               	movk	x0, #0x8907, lsl #16
               	str	w0, [sp, #0xa0]
               	mov	x0, #0x9c44             // =40004
               	str	w0, [sp, #0xc0]
               	mov	x0, #0x4                // =4
               	movk	x0, #0xf000, lsl #16
               	str	w0, [sp, #0xe0]
               	mov	x0, #0xb058             // =45144
               	movk	x0, #0x5b05, lsl #16
               	str	w0, [sp, #0x100]
               	fmov	s0, #5.50000000
               	str	s0, [sp, #0x160]
               	fmov	s0, #1.50000000
               	str	s0, [sp, #0x180]
               	mov	x0, #-0x48b1            // =-18609
               	movk	x0, #0x8916, lsl #16
               	str	w0, [sp, #0xa4]
               	mov	x0, #0x9c45             // =40005
               	str	w0, [sp, #0xc4]
               	mov	x0, #0x5                // =5
               	movk	x0, #0xf000, lsl #16
               	str	w0, [sp, #0xe4]
               	mov	x0, #0x6d0              // =1744
               	movk	x0, #0x6d3a, lsl #16
               	str	w0, [sp, #0x104]
               	fmov	s0, #6.50000000
               	str	s0, [sp, #0x164]
               	fmov	s0, #1.75000000
               	str	s0, [sp, #0x184]
               	mov	x0, #-0x66e             // =-1646
               	movk	x0, #0x8925, lsl #16
               	str	w0, [sp, #0xa8]
               	mov	x0, #0x9c46             // =40006
               	str	w0, [sp, #0xc8]
               	mov	x0, #0x6                // =6
               	movk	x0, #0xf000, lsl #16
               	str	w0, [sp, #0xe8]
               	mov	x0, #0x5d48             // =23880
               	movk	x0, #0x7f6e, lsl #16
               	str	w0, [sp, #0x108]
               	fmov	s0, #7.50000000
               	str	s0, [sp, #0x168]
               	fmov	s0, #2.00000000
               	str	s0, [sp, #0x188]
               	mov	x0, #-0xc42b            // =-50219
               	movk	x0, #0x8935, lsl #16
               	str	w0, [sp, #0xac]
               	mov	x0, #0x9c47             // =40007
               	str	w0, [sp, #0xcc]
               	mov	x0, #0x7                // =7
               	movk	x0, #0xf000, lsl #16
               	str	w0, [sp, #0xec]
               	mov	x0, #0xb3c0             // =46016
               	movk	x0, #0x91a2, lsl #16
               	str	w0, [sp, #0x10c]
               	fmov	s0, #8.50000000
               	str	s0, [sp, #0x16c]
               	fmov	s0, #2.25000000
               	str	s0, [sp, #0x18c]
               	mov	x0, #0x7ffffffffffffff0 // =9223372036854775792
               	str	x0, [sp, #0x110]
               	mov	x0, #0x10               // =16
               	str	x0, [sp, #0x130]
               	fmov	d0, #3.00000000
               	str	d0, [sp, #0x190]
               	fmov	d0, #0.50000000
               	str	d0, [sp, #0x1b0]
               	mov	x0, #-0xf               // =-15
               	movk	x0, #0x7fff, lsl #48
               	str	x0, [sp, #0x118]
               	mov	x0, #0x11               // =17
               	str	x0, [sp, #0x138]
               	fmov	d0, #4.00000000
               	str	d0, [sp, #0x198]
               	fmov	d0, #1.50000000
               	str	d0, [sp, #0x1b8]
               	mov	x0, #-0xe               // =-14
               	movk	x0, #0x7fff, lsl #48
               	str	x0, [sp, #0x120]
               	mov	x0, #0x12               // =18
               	str	x0, [sp, #0x140]
               	fmov	d0, #5.00000000
               	str	d0, [sp, #0x1a0]
               	fmov	d0, #2.50000000
               	str	d0, [sp, #0x1c0]
               	mov	x0, #-0xd               // =-13
               	movk	x0, #0x7fff, lsl #48
               	str	x0, [sp, #0x128]
               	mov	x0, #0x13               // =19
               	str	x0, [sp, #0x148]
               	fmov	d0, #6.00000000
               	str	d0, [sp, #0x1a8]
               	fmov	d0, #3.50000000
               	str	d0, [sp, #0x1c8]
               	sub	x20, x29, #0x8b0
               	sub	x21, x29, #0x890
               	sub	x0, x29, #0x410
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x3f0
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6d0
               	bl	<addr>
               	sub	x0, x29, #0x6d0
               	sub	x3, x29, #0x6f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	mov	x0, #0x0                // =0
               	ldrsb	x1, [x20, x0]
               	ldrsb	x2, [x21, x0]
               	ldrsb	x4, [x3, x0]
               	add	x5, x1, x2
               	sxtb	x5, w5
               	sub	x6, x1, x2
               	sxtb	x6, w6
               	eor	x5, x5, x6
               	and	x1, x1, x2
               	orr	x1, x5, x1
               	sxtb	x1, w1
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x20, x29, #0x870
               	sub	x21, x29, #0x850
               	sub	x0, x29, #0x3d0
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x3b0
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6d0
               	bl	<addr>
               	sub	x0, x29, #0x6d0
               	sub	x3, x29, #0x6f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
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
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x830
               	sub	x21, x29, #0x810
               	sub	x0, x29, #0x390
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x370
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6d0
               	bl	<addr>
               	sub	x0, x29, #0x6d0
               	sub	x3, x29, #0x6f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	mov	x0, #0x0                // =0
               	ldrsw	x4, [x3, x0, lsl #2]
               	ldrsw	x1, [x20, x0, lsl #2]
               	ldrsw	x2, [x21, x0, lsl #2]
               	add	x5, x1, x2
               	sub	x1, x1, x2
               	eor	x1, x5, x1
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x20, x29, #0x7f0
               	sub	x21, x29, #0x7d0
               	sub	x0, x29, #0x350
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x330
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6d0
               	bl	<addr>
               	sub	x0, x29, #0x6d0
               	sub	x3, x29, #0x6f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	mov	x0, #0x0                // =0
               	ldr	w4, [x3, x0, lsl #2]
               	ldr	w1, [x20, x0, lsl #2]
               	ldr	w2, [x21, x0, lsl #2]
               	sub	x5, x1, x2
               	orr	x1, x1, x2
               	eor	x1, x5, x1
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x7b0
               	sub	x2, x29, #0x790
               	sub	x0, x29, #0x310
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2f0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6d0
               	bl	<addr>
               	ldr	x0, [sp, #0x1f0]
               	ldr	x1, [sp, #0x1f8]
               	ldr	x2, [sp, #0x200]
               	ldr	x3, [sp, #0x208]
               	mov	x17, #0x7ffffffffffffff0 // =9223372036854775792
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #-0xf              // =-15
               	movk	x17, #0x7fff, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x17, #-0xe              // =-14
               	movk	x17, #0x7fff, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #-0xd              // =-13
               	movk	x17, #0x7fff, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	sub	x20, x29, #0x770
               	sub	x21, x29, #0x750
               	sub	x0, x29, #0x2d0
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2b0
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6d0
               	bl	<addr>
               	sub	x0, x29, #0x6d0
               	sub	x2, x29, #0x6f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x20, x1
               	ldr	s0, [x3]
               	add	x3, x21, x1
               	ldr	s1, [x3]
               	fmul	s2, s0, s1
               	fadd	s2, s2, s0
               	add	x1, x2, x1
               	ldr	s3, [x1]
               	fsub	s0, s1, s0
               	fdiv	s0, s2, s0
               	fcmp	s3, s0
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x730
               	sub	x2, x29, #0x710
               	sub	x0, x29, #0x290
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x270
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6d0
               	bl	<addr>
               	sub	x0, x29, #0x6d0
               	sub	x1, x29, #0x6f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d1, [sp, #0x190]
               	ldr	d0, [sp, #0x1b0]
               	fsub	d2, d1, d0
               	fadd	d1, d1, d0
               	fmul	d1, d2, d1
               	ldr	d2, [sp, #0x1d0]
               	fdiv	d0, d1, d0
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d1, [sp, #0x198]
               	ldr	d0, [sp, #0x1b8]
               	fsub	d2, d1, d0
               	fadd	d1, d1, d0
               	fmul	d1, d2, d1
               	ldr	d2, [sp, #0x1d8]
               	fdiv	d0, d1, d0
               	fcmp	d2, d0
               	b.ne	<addr>
               	ldr	d1, [sp, #0x1a0]
               	ldr	d0, [sp, #0x1c0]
               	fsub	d2, d1, d0
               	fadd	d1, d1, d0
               	fmul	d1, d2, d1
               	ldr	d2, [sp, #0x1e0]
               	fdiv	d0, d1, d0
               	fcmp	d2, d0
               	b.ne	<addr>
               	ldr	d1, [sp, #0x1a8]
               	ldr	d0, [sp, #0x1c8]
               	fsub	d2, d1, d0
               	fadd	d1, d1, d0
               	fmul	d1, d2, d1
               	ldr	d2, [sp, #0x1e8]
               	fdiv	d0, d1, d0
               	fcmp	d2, d0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x6d0
               	add	x1, x1, x0, lsl #5
               	lsl	x2, x0, #3
               	str	w2, [x1]
               	add	x3, x2, #0x1
               	str	w3, [x1, #0x4]
               	add	x3, x2, #0x2
               	str	w3, [x1, #0x8]
               	add	x3, x2, #0x3
               	str	w3, [x1, #0xc]
               	add	x3, x2, #0x4
               	str	w3, [x1, #0x10]
               	add	x2, x2, #0x5
               	str	w2, [x1, #0x14]
               	sub	x1, x29, #0x6d0
               	add	x1, x1, x0, lsl #5
               	lsl	x2, x0, #3
               	add	x3, x2, #0x6
               	str	w3, [x1, #0x18]
               	add	x2, x2, #0x7
               	str	w2, [x1, #0x1c]
               	add	x0, x0, #0x1
               	cmp	w0, #0x12
               	b.lt	<addr>
               	sub	x0, x29, #0x6d0
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x490
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x2, x0, #0x20
               	sub	x3, x29, #0x470
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x40
               	sub	x3, x29, #0x450
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x60
               	sub	x3, x29, #0x430
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x80
               	sub	x3, x29, #0x8b0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0xa0
               	sub	x3, x29, #0x890
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0xc0
               	sub	x3, x29, #0x870
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0xe0
               	sub	x3, x29, #0x850
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x100
               	sub	x3, x29, #0x830
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x120
               	sub	x3, x29, #0x7f0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x140
               	sub	x3, x29, #0x7d0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x160
               	sub	x3, x29, #0x7b0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x180
               	sub	x3, x29, #0x790
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x1a0
               	sub	x3, x29, #0x770
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x1c0
               	sub	x3, x29, #0x750
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x1e0
               	sub	x3, x29, #0x730
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x2, x0, #0x200
               	sub	x3, x29, #0x710
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	add	x0, x0, #0x220
               	sub	x2, x29, #0x6f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	q0, [sp, #0x430]
               	ldr	q1, [sp, #0xb0]
               	add	v0.4s, v0.4s, v1.4s
               	ldr	q1, [sp, #0x440]
               	ldr	q2, [sp, #0xc0]
               	add	v1.4s, v1.4s, v2.4s
               	str	q0, [sp, #0x430]
               	str	q1, [sp, #0x440]
               	ldr	q2, [sp, #0x450]
               	eor	v0.16b, v2.16b, v0.16b
               	ldr	q2, [sp, #0x460]
               	eor	v1.16b, v2.16b, v1.16b
               	str	q0, [sp, #0x450]
               	str	q1, [sp, #0x460]
               	ldr	q2, [sp, #0x470]
               	add	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x480]
               	add	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x470]
               	str	q1, [sp, #0x480]
               	ldr	q2, [sp, #0x490]
               	sub	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x4a0]
               	sub	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x490]
               	str	q1, [sp, #0x4a0]
               	ldr	q2, [sp, #0x10]
               	add	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x20]
               	add	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x10]
               	str	q1, [sp, #0x20]
               	ldr	q2, [sp, #0x30]
               	eor	v0.16b, v2.16b, v0.16b
               	ldr	q2, [sp, #0x40]
               	eor	v1.16b, v2.16b, v1.16b
               	str	q0, [sp, #0x30]
               	str	q1, [sp, #0x40]
               	str	x1, [sp, #0x678]
               	mov	x0, x1
               	bl	<addr>
               	ldr	x1, [sp, #0x678]
               	ldr	q0, [sp, #0x50]
               	ldr	q1, [sp, #0x30]
               	add	v0.4s, v0.4s, v1.4s
               	ldr	q1, [sp, #0x60]
               	ldr	q2, [sp, #0x40]
               	add	v1.4s, v1.4s, v2.4s
               	str	q0, [sp, #0x50]
               	str	q1, [sp, #0x60]
               	ldr	q2, [sp, #0x70]
               	sub	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x80]
               	sub	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x70]
               	str	q1, [sp, #0x80]
               	ldr	q2, [sp, #0x90]
               	add	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0xa0]
               	add	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x90]
               	str	q1, [sp, #0xa0]
               	ldr	q2, [sp, #0xd0]
               	eor	v0.16b, v2.16b, v0.16b
               	ldr	q2, [sp, #0xe0]
               	eor	v1.16b, v2.16b, v1.16b
               	str	q0, [sp, #0xd0]
               	str	q1, [sp, #0xe0]
               	ldr	q2, [sp, #0xf0]
               	add	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x100]
               	add	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0xf0]
               	str	q1, [sp, #0x100]
               	ldr	q2, [sp, #0x110]
               	sub	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x120]
               	sub	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x110]
               	str	q1, [sp, #0x120]
               	ldr	q2, [sp, #0x130]
               	add	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x140]
               	add	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x130]
               	str	q1, [sp, #0x140]
               	ldr	q2, [sp, #0x150]
               	eor	v0.16b, v2.16b, v0.16b
               	ldr	q2, [sp, #0x160]
               	eor	v1.16b, v2.16b, v1.16b
               	str	q0, [sp, #0x150]
               	str	q1, [sp, #0x160]
               	ldr	q2, [sp, #0x170]
               	add	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x180]
               	add	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x170]
               	str	q1, [sp, #0x180]
               	ldr	q2, [sp, #0x190]
               	sub	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x1a0]
               	sub	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x190]
               	str	q1, [sp, #0x1a0]
               	ldr	q2, [sp, #0x1b0]
               	add	v0.4s, v2.4s, v0.4s
               	ldr	q2, [sp, #0x1c0]
               	add	v1.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x1b0]
               	str	q1, [sp, #0x1c0]
               	ldr	q2, [sp, #0x1d0]
               	eor	v0.16b, v2.16b, v0.16b
               	ldr	q2, [sp, #0x1e0]
               	eor	v1.16b, v2.16b, v1.16b
               	str	q0, [sp, #0x1d0]
               	str	q1, [sp, #0x1e0]
               	add	x1, x1, #0x1
               	cmp	w1, #0xa
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x240
               	add	x1, x1, x0, lsl #5
               	lsl	x2, x0, #3
               	str	w2, [x1]
               	add	x3, x2, #0x1
               	str	w3, [x1, #0x4]
               	add	x3, x2, #0x2
               	str	w3, [x1, #0x8]
               	add	x3, x2, #0x3
               	str	w3, [x1, #0xc]
               	add	x3, x2, #0x4
               	str	w3, [x1, #0x10]
               	add	x2, x2, #0x5
               	str	w2, [x1, #0x14]
               	sub	x1, x29, #0x240
               	add	x1, x1, x0, lsl #5
               	lsl	x2, x0, #3
               	add	x3, x2, #0x6
               	str	w3, [x1, #0x18]
               	add	x2, x2, #0x7
               	str	w2, [x1, #0x1c]
               	add	x0, x0, #0x1
               	cmp	w0, #0x12
               	b.lt	<addr>
               	mov	x8, #0x0                // =0
               	mov	x2, #0x0                // =0
               	sub	x4, x29, #0x240
               	ldrsw	x0, [x4, x2, lsl #2]
               	sub	x1, x29, #0x810
               	ldrsw	x1, [x1, x2, lsl #2]
               	add	x0, x0, x1
               	str	w0, [x4, x2, lsl #2]
               	mov	x0, #0x1                // =1
               	b	<addr>
               	str	w1, [x5, x2, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x12
               	b.ge	<addr>
               	add	x5, x4, x0, lsl #5
               	ldrsw	x1, [x5, x2, lsl #2]
               	sub	x3, x0, #0x1
               	add	x3, x4, x3, lsl #5
               	ldrsw	x3, [x3, x2, lsl #2]
               	and	x6, x0, #0x3
               	cmp	w6, #0x3
               	b.lt	<addr>
               	sub	x1, x1, x3
               	b	<addr>
               	cmp	w6, #0x1
               	b.eq	<addr>
               	add	x1, x1, x3
               	b	<addr>
               	eor	x1, x1, x3
               	b	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x8
               	b.lt	<addr>
               	add	x8, x8, #0x1
               	cmp	w8, #0xa
               	b.lt	<addr>
               	sub	x0, x29, #0x490
               	sub	x3, x29, #0x6d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x0, x29, #0x470
               	add	x1, x3, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x450
               	add	x1, x3, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x430
               	add	x1, x3, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x8b0
               	add	x1, x3, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x890
               	add	x1, x3, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x870
               	add	x1, x3, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x850
               	add	x1, x3, #0xe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x830
               	add	x1, x3, #0x100
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x7f0
               	add	x1, x3, #0x120
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x7d0
               	add	x1, x3, #0x140
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x7b0
               	add	x1, x3, #0x160
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x790
               	add	x1, x3, #0x180
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x770
               	add	x1, x3, #0x1a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x750
               	add	x1, x3, #0x1c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x730
               	add	x1, x3, #0x1e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x710
               	add	x1, x3, #0x200
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x6f0
               	add	x1, x3, #0x220
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #5
               	add	x4, x3, x2
               	ldrsw	x5, [x4]
               	sub	x1, x29, #0x240
               	add	x1, x1, x2
               	ldrsw	x6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	ldrsw	x4, [x4, #0x4]
               	ldrsw	x5, [x1, #0x4]
               	cmp	w4, w5
               	b.ne	<addr>
               	sub	x4, x29, #0x6d0
               	add	x2, x4, x2
               	ldrsw	x5, [x2, #0x8]
               	ldrsw	x6, [x1, #0x8]
               	cmp	w5, w6
               	b.ne	<addr>
               	ldrsw	x5, [x2, #0xc]
               	ldrsw	x6, [x1, #0xc]
               	cmp	w5, w6
               	b.ne	<addr>
               	ldrsw	x2, [x2, #0x10]
               	ldrsw	x1, [x1, #0x10]
               	cmp	w2, w1
               	b.ne	<addr>
               	lsl	x1, x0, #5
               	add	x2, x4, x1
               	ldrsw	x4, [x2, #0x14]
               	sub	x2, x29, #0x240
               	add	x2, x2, x1
               	ldrsw	x5, [x2, #0x14]
               	cmp	w4, w5
               	b.ne	<addr>
               	sub	x4, x29, #0x6d0
               	add	x1, x4, x1
               	ldrsw	x4, [x1, #0x18]
               	ldrsw	x5, [x2, #0x18]
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x1c]
               	ldrsw	x2, [x2, #0x1c]
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x12
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1e               // =30
               	cmp	w0, #0x2d
               	csel	x0, x1, x2, eq
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0xa
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8c0
               	ldp	x29, x30, [sp], #0x10
               	ret
