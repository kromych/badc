
vector_abi_arg_return.aarch64:	file format elf64-littleaarch64

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

<vec_sub>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x50
               	str	q0, [x16]
               	sub	x16, x29, #0x40
               	str	q1, [x16]
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x50
               	sub	x0, x29, #0x30
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	sub	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x2, #0x7]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x2, #0x8]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x2, #0x9]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x2, #0xa]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x2, #0xb]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x2, #0xc]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x2, #0xd]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x2, #0xe]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	ldrb	w2, [x2, #0xf]
               	sub	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<vec8_sub>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x8
               	str	d0, [x16]
               	sub	x16, x29, #0x10
               	str	d1, [x16]
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x8
               	sub	x0, x29, #0x18
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	sub	x3, x3, x4
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x2, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x2, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x2, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x2, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x2, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x2, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x0, #0x6]
               	ldrb	w1, [x1, #0x7]
               	ldrb	w2, [x2, #0x7]
               	sub	x1, x1, x2
               	strb	w1, [x0, #0x7]
               	mov	x16, x0
               	ldr	d0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<vecf_add>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x50
               	str	q0, [x16]
               	sub	x16, x29, #0x40
               	str	q1, [x16]
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x40
               	sub	x0, x29, #0x30
               	ldr	s0, [x1]
               	ldr	s1, [x2]
               	fadd	s0, s0, s1
               	str	s0, [x0]
               	ldr	s0, [x1, #0x4]
               	ldr	s1, [x2, #0x4]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x4]
               	ldr	s0, [x1, #0x8]
               	ldr	s1, [x2, #0x8]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0x8]
               	ldr	s0, [x1, #0xc]
               	ldr	s1, [x2, #0xc]
               	fadd	s0, s0, s1
               	str	s0, [x0, #0xc]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<wrap_double>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x50
               	str	q0, [x16]
               	sub	x2, x29, #0x40
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x30
               	ldrb	w3, [x0]
               	add	x3, x3, x3
               	strb	w3, [x1]
               	ldrb	w3, [x0, #0x1]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x0, #0x2]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x0, #0x3]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x0, #0x4]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x0, #0x5]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x0, #0x6]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x0, #0x7]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x0, #0x8]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x0, #0x9]
               	add	x3, x3, x3
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x0, #0xa]
               	add	x3, x3, x3
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x0, #0xb]
               	add	x3, x3, x3
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x0, #0xc]
               	add	x3, x3, x3
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x0, #0xd]
               	add	x3, x3, x3
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x0, #0xe]
               	add	x3, x3, x3
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x0, #0xf]
               	add	x0, x3, x3
               	strb	w0, [x1, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x16, x2
               	ldr	q0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<nine>:
               	stp	x20, x21, [sp, #-0x1d0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x1c0]
               	add	x29, sp, #0x1c0
               	sub	x16, x29, #0x1a0
               	str	q0, [x16]
               	sub	x16, x29, #0x190
               	str	q1, [x16]
               	sub	x16, x29, #0x180
               	str	q2, [x16]
               	sub	x16, x29, #0x170
               	str	q3, [x16]
               	sub	x16, x29, #0x160
               	str	q4, [x16]
               	sub	x16, x29, #0x150
               	str	q5, [x16]
               	sub	x16, x29, #0x140
               	str	q6, [x16]
               	sub	x16, x29, #0x130
               	str	q7, [x16]
               	sub	x16, x29, #0x120
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16, #0x8]
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x190
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	add	x3, x3, x4
               	ldrb	w4, [x0, #0x1]
               	ldrb	w5, [x1, #0x1]
               	add	x4, x4, x5
               	ldrb	w5, [x0, #0x2]
               	ldrb	w6, [x1, #0x2]
               	add	x5, x5, x6
               	ldrb	w6, [x0, #0x3]
               	ldrb	w7, [x1, #0x3]
               	add	x6, x6, x7
               	ldrb	w7, [x0, #0x4]
               	ldrb	w8, [x1, #0x4]
               	add	x7, x7, x8
               	ldrb	w8, [x0, #0x5]
               	ldrb	w9, [x1, #0x5]
               	add	x8, x8, x9
               	ldrb	w9, [x0, #0x6]
               	ldrb	w10, [x1, #0x6]
               	add	x9, x9, x10
               	ldrb	w10, [x0, #0x7]
               	ldrb	w11, [x1, #0x7]
               	add	x10, x10, x11
               	ldrb	w11, [x0, #0x8]
               	ldrb	w12, [x1, #0x8]
               	add	x11, x11, x12
               	ldrb	w12, [x0, #0x9]
               	ldrb	w13, [x1, #0x9]
               	add	x12, x12, x13
               	ldrb	w13, [x0, #0xa]
               	ldrb	w14, [x1, #0xa]
               	add	x13, x13, x14
               	ldrb	w14, [x0, #0xb]
               	ldrb	w15, [x1, #0xb]
               	add	x14, x14, x15
               	ldrb	w15, [x0, #0xc]
               	ldrb	w20, [x1, #0xc]
               	add	x15, x15, x20
               	ldrb	w20, [x0, #0xd]
               	ldrb	w21, [x1, #0xd]
               	add	x20, x20, x21
               	ldrb	w21, [x0, #0xe]
               	ldrb	w22, [x1, #0xe]
               	add	x21, x21, x22
               	ldrb	w0, [x0, #0xf]
               	ldrb	w1, [x1, #0xf]
               	add	x22, x0, x1
               	sub	x0, x29, #0x180
               	mov	x17, #0xff              // =255
               	and	x2, x3, x17
               	ldrb	w3, [x0]
               	add	x2, x2, x3
               	mov	x17, #0xff              // =255
               	and	x3, x4, x17
               	ldrb	w4, [x0, #0x1]
               	add	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x4, x5, x17
               	ldrb	w5, [x0, #0x2]
               	add	x4, x4, x5
               	mov	x17, #0xff              // =255
               	and	x5, x6, x17
               	ldrb	w6, [x0, #0x3]
               	add	x5, x5, x6
               	mov	x17, #0xff              // =255
               	and	x6, x7, x17
               	ldrb	w7, [x0, #0x4]
               	add	x6, x6, x7
               	mov	x17, #0xff              // =255
               	and	x7, x8, x17
               	ldrb	w8, [x0, #0x5]
               	add	x7, x7, x8
               	mov	x17, #0xff              // =255
               	and	x8, x9, x17
               	ldrb	w9, [x0, #0x6]
               	add	x8, x8, x9
               	mov	x17, #0xff              // =255
               	and	x9, x10, x17
               	ldrb	w10, [x0, #0x7]
               	add	x9, x9, x10
               	mov	x17, #0xff              // =255
               	and	x10, x11, x17
               	ldrb	w11, [x0, #0x8]
               	add	x10, x10, x11
               	mov	x17, #0xff              // =255
               	and	x11, x12, x17
               	ldrb	w12, [x0, #0x9]
               	add	x11, x11, x12
               	mov	x17, #0xff              // =255
               	and	x12, x13, x17
               	ldrb	w13, [x0, #0xa]
               	add	x12, x12, x13
               	mov	x17, #0xff              // =255
               	and	x13, x14, x17
               	ldrb	w14, [x0, #0xb]
               	add	x13, x13, x14
               	mov	x17, #0xff              // =255
               	and	x14, x15, x17
               	ldrb	w15, [x0, #0xc]
               	add	x14, x14, x15
               	mov	x17, #0xff              // =255
               	and	x15, x20, x17
               	ldrb	w20, [x0, #0xd]
               	add	x15, x15, x20
               	mov	x17, #0xff              // =255
               	and	x20, x21, x17
               	ldrb	w21, [x0, #0xe]
               	add	x20, x20, x21
               	mov	x17, #0xff              // =255
               	and	x21, x22, x17
               	ldrb	w0, [x0, #0xf]
               	add	x21, x21, x0
               	sub	x0, x29, #0x170
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	ldrb	w22, [x0]
               	add	x2, x2, x22
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	ldrb	w22, [x0, #0x1]
               	add	x3, x3, x22
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	ldrb	w22, [x0, #0x2]
               	add	x4, x4, x22
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	ldrb	w22, [x0, #0x3]
               	add	x5, x5, x22
               	mov	x17, #0xff              // =255
               	and	x6, x6, x17
               	ldrb	w22, [x0, #0x4]
               	add	x6, x6, x22
               	mov	x17, #0xff              // =255
               	and	x7, x7, x17
               	ldrb	w22, [x0, #0x5]
               	add	x7, x7, x22
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	ldrb	w22, [x0, #0x6]
               	add	x8, x8, x22
               	mov	x17, #0xff              // =255
               	and	x9, x9, x17
               	ldrb	w22, [x0, #0x7]
               	add	x9, x9, x22
               	mov	x17, #0xff              // =255
               	and	x10, x10, x17
               	ldrb	w22, [x0, #0x8]
               	add	x10, x10, x22
               	mov	x17, #0xff              // =255
               	and	x11, x11, x17
               	ldrb	w22, [x0, #0x9]
               	add	x11, x11, x22
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	ldrb	w22, [x0, #0xa]
               	add	x12, x12, x22
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	ldrb	w22, [x0, #0xb]
               	add	x13, x13, x22
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	ldrb	w22, [x0, #0xc]
               	add	x14, x14, x22
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	ldrb	w22, [x0, #0xd]
               	add	x15, x15, x22
               	mov	x17, #0xff              // =255
               	and	x20, x20, x17
               	ldrb	w22, [x0, #0xe]
               	add	x20, x20, x22
               	mov	x17, #0xff              // =255
               	and	x21, x21, x17
               	ldrb	w0, [x0, #0xf]
               	add	x21, x21, x0
               	sub	x0, x29, #0x160
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	ldrb	w22, [x0]
               	add	x2, x2, x22
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	ldrb	w22, [x0, #0x1]
               	add	x3, x3, x22
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	ldrb	w22, [x0, #0x2]
               	add	x4, x4, x22
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	ldrb	w22, [x0, #0x3]
               	add	x5, x5, x22
               	mov	x17, #0xff              // =255
               	and	x6, x6, x17
               	ldrb	w22, [x0, #0x4]
               	add	x6, x6, x22
               	mov	x17, #0xff              // =255
               	and	x7, x7, x17
               	ldrb	w22, [x0, #0x5]
               	add	x7, x7, x22
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	ldrb	w22, [x0, #0x6]
               	add	x8, x8, x22
               	mov	x17, #0xff              // =255
               	and	x9, x9, x17
               	ldrb	w22, [x0, #0x7]
               	add	x9, x9, x22
               	mov	x17, #0xff              // =255
               	and	x10, x10, x17
               	ldrb	w22, [x0, #0x8]
               	add	x10, x10, x22
               	mov	x17, #0xff              // =255
               	and	x11, x11, x17
               	ldrb	w22, [x0, #0x9]
               	add	x11, x11, x22
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	ldrb	w22, [x0, #0xa]
               	add	x12, x12, x22
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	ldrb	w22, [x0, #0xb]
               	add	x13, x13, x22
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	ldrb	w22, [x0, #0xc]
               	add	x14, x14, x22
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	ldrb	w22, [x0, #0xd]
               	add	x15, x15, x22
               	mov	x17, #0xff              // =255
               	and	x20, x20, x17
               	ldrb	w22, [x0, #0xe]
               	add	x20, x20, x22
               	mov	x17, #0xff              // =255
               	and	x21, x21, x17
               	ldrb	w0, [x0, #0xf]
               	add	x21, x21, x0
               	sub	x0, x29, #0x150
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	ldrb	w22, [x0]
               	add	x2, x2, x22
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	ldrb	w22, [x0, #0x1]
               	add	x3, x3, x22
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	ldrb	w22, [x0, #0x2]
               	add	x4, x4, x22
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	ldrb	w22, [x0, #0x3]
               	add	x5, x5, x22
               	mov	x17, #0xff              // =255
               	and	x6, x6, x17
               	ldrb	w22, [x0, #0x4]
               	add	x6, x6, x22
               	mov	x17, #0xff              // =255
               	and	x7, x7, x17
               	ldrb	w22, [x0, #0x5]
               	add	x7, x7, x22
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	ldrb	w22, [x0, #0x6]
               	add	x8, x8, x22
               	mov	x17, #0xff              // =255
               	and	x9, x9, x17
               	ldrb	w22, [x0, #0x7]
               	add	x9, x9, x22
               	mov	x17, #0xff              // =255
               	and	x10, x10, x17
               	ldrb	w22, [x0, #0x8]
               	add	x10, x10, x22
               	mov	x17, #0xff              // =255
               	and	x11, x11, x17
               	ldrb	w22, [x0, #0x9]
               	add	x11, x11, x22
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	ldrb	w22, [x0, #0xa]
               	add	x12, x12, x22
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	ldrb	w22, [x0, #0xb]
               	add	x13, x13, x22
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	ldrb	w22, [x0, #0xc]
               	add	x14, x14, x22
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	ldrb	w22, [x0, #0xd]
               	add	x15, x15, x22
               	mov	x17, #0xff              // =255
               	and	x20, x20, x17
               	ldrb	w22, [x0, #0xe]
               	add	x20, x20, x22
               	mov	x17, #0xff              // =255
               	and	x21, x21, x17
               	ldrb	w0, [x0, #0xf]
               	add	x21, x21, x0
               	sub	x0, x29, #0x140
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	ldrb	w22, [x0]
               	add	x2, x2, x22
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	ldrb	w22, [x0, #0x1]
               	add	x3, x3, x22
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	ldrb	w22, [x0, #0x2]
               	add	x4, x4, x22
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	ldrb	w22, [x0, #0x3]
               	add	x5, x5, x22
               	mov	x17, #0xff              // =255
               	and	x6, x6, x17
               	ldrb	w22, [x0, #0x4]
               	add	x6, x6, x22
               	mov	x17, #0xff              // =255
               	and	x7, x7, x17
               	ldrb	w22, [x0, #0x5]
               	add	x7, x7, x22
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	ldrb	w22, [x0, #0x6]
               	add	x8, x8, x22
               	mov	x17, #0xff              // =255
               	and	x9, x9, x17
               	ldrb	w22, [x0, #0x7]
               	add	x9, x9, x22
               	mov	x17, #0xff              // =255
               	and	x10, x10, x17
               	ldrb	w22, [x0, #0x8]
               	add	x10, x10, x22
               	mov	x17, #0xff              // =255
               	and	x11, x11, x17
               	ldrb	w22, [x0, #0x9]
               	add	x11, x11, x22
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	ldrb	w22, [x0, #0xa]
               	add	x12, x12, x22
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	ldrb	w22, [x0, #0xb]
               	add	x13, x13, x22
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	ldrb	w22, [x0, #0xc]
               	add	x14, x14, x22
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	ldrb	w22, [x0, #0xd]
               	add	x15, x15, x22
               	mov	x17, #0xff              // =255
               	and	x20, x20, x17
               	ldrb	w22, [x0, #0xe]
               	add	x20, x20, x22
               	mov	x17, #0xff              // =255
               	and	x21, x21, x17
               	ldrb	w0, [x0, #0xf]
               	add	x21, x21, x0
               	sub	x0, x29, #0x130
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	ldrb	w22, [x0]
               	add	x2, x2, x22
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	ldrb	w22, [x0, #0x1]
               	add	x3, x3, x22
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	ldrb	w22, [x0, #0x2]
               	add	x4, x4, x22
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	ldrb	w22, [x0, #0x3]
               	add	x5, x5, x22
               	mov	x17, #0xff              // =255
               	and	x6, x6, x17
               	ldrb	w22, [x0, #0x4]
               	add	x6, x6, x22
               	mov	x17, #0xff              // =255
               	and	x7, x7, x17
               	ldrb	w22, [x0, #0x5]
               	add	x7, x7, x22
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	ldrb	w22, [x0, #0x6]
               	add	x8, x8, x22
               	mov	x17, #0xff              // =255
               	and	x9, x9, x17
               	ldrb	w22, [x0, #0x7]
               	add	x9, x9, x22
               	mov	x17, #0xff              // =255
               	and	x10, x10, x17
               	ldrb	w22, [x0, #0x8]
               	add	x10, x10, x22
               	mov	x17, #0xff              // =255
               	and	x11, x11, x17
               	ldrb	w22, [x0, #0x9]
               	add	x11, x11, x22
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	ldrb	w22, [x0, #0xa]
               	add	x12, x12, x22
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	ldrb	w22, [x0, #0xb]
               	add	x13, x13, x22
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	ldrb	w22, [x0, #0xc]
               	add	x14, x14, x22
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	ldrb	w22, [x0, #0xd]
               	add	x15, x15, x22
               	mov	x17, #0xff              // =255
               	and	x20, x20, x17
               	ldrb	w22, [x0, #0xe]
               	add	x20, x20, x22
               	mov	x17, #0xff              // =255
               	and	x21, x21, x17
               	ldrb	w0, [x0, #0xf]
               	add	x21, x21, x0
               	sub	x1, x29, #0x120
               	sub	x0, x29, #0x110
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	ldrb	w22, [x1]
               	add	x2, x2, x22
               	strb	w2, [x0]
               	mov	x17, #0xff              // =255
               	and	x2, x3, x17
               	ldrb	w3, [x1, #0x1]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x1]
               	mov	x17, #0xff              // =255
               	and	x2, x4, x17
               	ldrb	w3, [x1, #0x2]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x2]
               	mov	x17, #0xff              // =255
               	and	x2, x5, x17
               	ldrb	w3, [x1, #0x3]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x3]
               	mov	x17, #0xff              // =255
               	and	x2, x6, x17
               	ldrb	w3, [x1, #0x4]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x4]
               	mov	x17, #0xff              // =255
               	and	x2, x7, x17
               	ldrb	w3, [x1, #0x5]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x5]
               	mov	x17, #0xff              // =255
               	and	x2, x8, x17
               	ldrb	w3, [x1, #0x6]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x6]
               	mov	x17, #0xff              // =255
               	and	x2, x9, x17
               	ldrb	w3, [x1, #0x7]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x7]
               	mov	x17, #0xff              // =255
               	and	x2, x10, x17
               	ldrb	w3, [x1, #0x8]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x11, x17
               	ldrb	w3, [x1, #0x9]
               	add	x2, x2, x3
               	strb	w2, [x0, #0x9]
               	mov	x17, #0xff              // =255
               	and	x2, x12, x17
               	ldrb	w3, [x1, #0xa]
               	add	x2, x2, x3
               	strb	w2, [x0, #0xa]
               	mov	x17, #0xff              // =255
               	and	x2, x13, x17
               	ldrb	w3, [x1, #0xb]
               	add	x2, x2, x3
               	strb	w2, [x0, #0xb]
               	mov	x17, #0xff              // =255
               	and	x2, x14, x17
               	ldrb	w3, [x1, #0xc]
               	add	x2, x2, x3
               	strb	w2, [x0, #0xc]
               	mov	x17, #0xff              // =255
               	and	x2, x15, x17
               	ldrb	w3, [x1, #0xd]
               	add	x2, x2, x3
               	strb	w2, [x0, #0xd]
               	mov	x17, #0xff              // =255
               	and	x2, x20, x17
               	ldrb	w3, [x1, #0xe]
               	add	x2, x2, x3
               	strb	w2, [x0, #0xe]
               	mov	x17, #0xff              // =255
               	and	x2, x21, x17
               	ldrb	w1, [x1, #0xf]
               	add	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	mov	x16, x0
               	ldr	q0, [x16]
               	ldp	x29, x30, [sp, #0x1c0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1d0
               	ret

<mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x16, x29, #0x40
               	str	q0, [x16]
               	sub	x16, x29, #0x30
               	str	q2, [x16]
               	fmov	d0, d1
               	fmov	d1, d3
               	sub	x0, x29, #0x40
               	ldrb	w0, [x0]
               	sub	x1, x29, #0x30
               	ldrb	w1, [x1]
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	scvtf	d2, x0
               	fmadd	d0, d0, d1, d2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<wide_sub>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	sub	x16, x29, #0x48
               	str	x8, [x16]
               	stur	x0, [x29, #-0x90]
               	stur	x1, [x29, #-0x80]
               	sub	x0, x29, #0xd0
               	ldur	x1, [x29, #-0x90]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0xb0
               	ldur	x2, [x29, #-0x80]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x68
               	ldrb	w3, [x1]
               	ldrb	w4, [x0]
               	sub	x3, x3, x4
               	strb	w3, [x2]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x0, #0x1]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x0, #0x2]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x0, #0x3]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x0, #0x4]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w4, [x0, #0x5]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w4, [x0, #0x6]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w4, [x0, #0x7]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x0, #0x8]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w4, [x0, #0x9]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w4, [x0, #0xa]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w4, [x0, #0xb]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w4, [x0, #0xc]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w4, [x0, #0xd]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w4, [x0, #0xe]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w4, [x0, #0xf]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0xf]
               	ldrb	w3, [x1, #0x10]
               	ldrb	w4, [x0, #0x10]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x10]
               	ldrb	w3, [x1, #0x11]
               	ldrb	w4, [x0, #0x11]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x11]
               	ldrb	w3, [x1, #0x12]
               	ldrb	w4, [x0, #0x12]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x12]
               	ldrb	w3, [x1, #0x13]
               	ldrb	w4, [x0, #0x13]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x13]
               	ldrb	w3, [x1, #0x14]
               	ldrb	w4, [x0, #0x14]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x14]
               	ldrb	w3, [x1, #0x15]
               	ldrb	w4, [x0, #0x15]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x15]
               	ldrb	w3, [x1, #0x16]
               	ldrb	w4, [x0, #0x16]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x16]
               	ldrb	w3, [x1, #0x17]
               	ldrb	w4, [x0, #0x17]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x17]
               	ldrb	w3, [x1, #0x18]
               	ldrb	w4, [x0, #0x18]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x18]
               	ldrb	w3, [x1, #0x19]
               	ldrb	w4, [x0, #0x19]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x19]
               	ldrb	w3, [x1, #0x1a]
               	ldrb	w4, [x0, #0x1a]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x1a]
               	ldrb	w3, [x1, #0x1b]
               	ldrb	w4, [x0, #0x1b]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x1b]
               	ldrb	w3, [x1, #0x1c]
               	ldrb	w4, [x0, #0x1c]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x1c]
               	ldrb	w3, [x1, #0x1d]
               	ldrb	w4, [x0, #0x1d]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x1d]
               	ldrb	w3, [x1, #0x1e]
               	ldrb	w4, [x0, #0x1e]
               	sub	x3, x3, x4
               	strb	w3, [x2, #0x1e]
               	ldrb	w1, [x1, #0x1f]
               	ldrb	w0, [x0, #0x1f]
               	sub	x0, x1, x0
               	strb	w0, [x2, #0x1f]
               	mov	x16, x2
               	sub	x17, x29, #0x48
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	ldr	x0, [x16, #0x18]
               	str	x0, [x17, #0x18]
               	mov	x0, x17
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret

<ramp>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, x0
               	sub	x0, x29, #0x20
               	add	x4, x0, #0x0
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	add	x3, x2, #0x0
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x4]
               	add	x3, x2, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x1]
               	add	x3, x2, #0x2
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x2]
               	add	x3, x2, #0x3
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x3]
               	add	x3, x2, #0x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x4]
               	add	x3, x2, #0x5
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x5]
               	add	x3, x2, #0x6
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x6]
               	add	x3, x2, #0x7
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x7]
               	add	x3, x2, #0x8
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x8]
               	add	x3, x2, #0x9
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x9]
               	sub	x0, x29, #0x20
               	add	x3, x2, #0xa
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0xa]
               	add	x2, x2, #0xb
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0, #0xb]
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	add	x3, x2, #0xc
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0xc]
               	add	x3, x2, #0xd
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0xd]
               	add	x3, x2, #0xe
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0xe]
               	add	x1, x2, #0xf
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0xf]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x260
               	stp	x20, x21, [sp]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x250
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x240
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x250
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x0, x29, #0x100
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w4, [x0, #0x3]
               	ldrb	w5, [x0, #0x4]
               	ldrb	w6, [x0, #0x5]
               	ldrb	w7, [x0, #0x6]
               	ldrb	w8, [x0, #0x7]
               	ldrb	w9, [x0, #0x8]
               	ldrb	w10, [x0, #0x9]
               	ldrb	w11, [x0, #0xa]
               	ldrb	w12, [x0, #0xb]
               	ldrb	w13, [x0, #0xc]
               	ldrb	w14, [x0, #0xd]
               	ldrb	w15, [x0, #0xe]
               	ldrb	w20, [x0, #0xf]
               	mov	x17, #0xff              // =255
               	and	x0, x1, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff              // =255
               	and	x0, x2, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x3, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x4, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x5, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x6, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x7, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x8, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x9, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x10, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x11, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x12, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x13, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x14, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x15, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x20, x17
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x128
               	add	x1, x0, #0x0
               	mov	x2, #0x1                // =1
               	strb	w2, [x1]
               	sub	x1, x29, #0x118
               	add	x2, x1, #0x0
               	mov	x3, #0x28               // =40
               	strb	w3, [x2]
               	mov	x2, #0x2                // =2
               	strb	w2, [x0, #0x1]
               	mov	x2, #0x29               // =41
               	strb	w2, [x1, #0x1]
               	mov	x2, #0x3                // =3
               	strb	w2, [x0, #0x2]
               	mov	x2, #0x2a               // =42
               	strb	w2, [x1, #0x2]
               	mov	x2, #0x4                // =4
               	strb	w2, [x0, #0x3]
               	mov	x2, #0x2b               // =43
               	strb	w2, [x1, #0x3]
               	mov	x2, #0x5                // =5
               	strb	w2, [x0, #0x4]
               	mov	x2, #0x2c               // =44
               	strb	w2, [x1, #0x4]
               	mov	x2, #0x6                // =6
               	strb	w2, [x0, #0x5]
               	mov	x2, #0x2d               // =45
               	strb	w2, [x1, #0x5]
               	mov	x2, #0x7                // =7
               	strb	w2, [x0, #0x6]
               	mov	x2, #0x2e               // =46
               	strb	w2, [x1, #0x6]
               	mov	x2, #0x8                // =8
               	strb	w2, [x0, #0x7]
               	mov	x2, #0x2f               // =47
               	strb	w2, [x1, #0x7]
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0xf8
               	str	d0, [x16]
               	sub	x0, x29, #0xf8
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w4, [x0, #0x3]
               	ldrb	w5, [x0, #0x4]
               	ldrb	w6, [x0, #0x5]
               	ldrb	w7, [x0, #0x6]
               	ldrb	w8, [x0, #0x7]
               	mov	x17, #0xff              // =255
               	and	x0, x1, x17
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff              // =255
               	and	x0, x2, x17
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x3, x17
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x4, x17
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x5, x17
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x6, x17
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x7, x17
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x8, x17
               	mov	x17, #0x27              // =39
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x220
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x210
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x1, x29, #0x100
               	sub	x0, x29, #0x200
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	s0, [x0]
               	mov	x1, #0x41300000         // =1093664768
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.ne	<addr>
               	ldr	s0, [x0, #0x4]
               	mov	x1, #0x41b00000         // =1102053376
               	fmov	s17, w1
               	fcmp	s0, s17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	s0, [x0, #0x8]
               	mov	x1, #0x42040000         // =1107558400
               	fmov	s17, w1
               	fcmp	s0, s17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	s0, [x0, #0xc]
               	mov	x0, #0x42300000         // =1110441984
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x1f0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x0, x29, #0x100
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1f0
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x0, x29, #0x100
               	sub	x3, x29, #0x1e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x3, x1
               	ldrb	w5, [x2]
               	add	x2, x1, #0x2
               	lsl	x2, x2, #1
               	and	x2, x2, x4
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x1, x29, #0x100
               	sub	x0, x29, #0x1d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	sp, sp, #0x10
               	mov	x16, x0
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	ldr	q0, [x0]
               	ldr	q1, [x0]
               	ldr	q2, [x0]
               	ldr	q3, [x0]
               	ldr	q4, [x0]
               	ldr	q5, [x0]
               	ldr	q6, [x0]
               	ldr	q7, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x0, x29, #0x100
               	sub	x3, x29, #0x1c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x4, #0x9                // =9
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x3, x1
               	ldrb	w6, [x2]
               	add	x2, x1, #0x1
               	mul	x2, x2, x4
               	and	x2, x2, x5
               	cmp	w6, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	sub	x16, x29, #0x120
               	str	q0, [x16]
               	sub	x21, x29, #0x120
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	sub	x16, x29, #0x100
               	str	q0, [x16]
               	sub	x1, x29, #0x100
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	ldrb	w2, [x21]
               	ldrb	w1, [x1]
               	sub	x1, x2, x1
               	sxtw	x1, w1
               	scvtf	d0, x1
               	fmov	d16, x20
               	fmov	d17, x0
               	fmadd	d0, d16, d17, d0
               	mov	x0, #0x404a000000000000 // =4632515166703976448
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x3, #0xff               // =255
               	b	<addr>
               	sub	x2, x29, #0x1b0
               	sxtw	x1, w0
               	add	x4, x2, x1
               	add	x2, x1, #0x1
               	and	x2, x2, x3
               	strb	w2, [x4]
               	sub	x2, x29, #0x190
               	add	x4, x2, x1
               	add	x2, x1, #0x46
               	and	x2, x2, x3
               	strb	w2, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x0, x29, #0x1b0
               	sub	x1, x29, #0x190
               	sub	x8, x29, #0x110
               	bl	<addr>
               	sub	x0, x29, #0x110
               	sub	x3, x29, #0x170
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x3, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x4, #0x45               // =69
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	eor	x2, x2, x4
               	mov	w2, w2
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
