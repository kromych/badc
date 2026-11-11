
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
               	sub	x2, x29, #0x70
               	ldrsb	x3, [x0]
               	ldrsb	x4, [x1]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x70]
               	ldrsb	x3, [x0, #0x1]
               	ldrsb	x4, [x1, #0x1]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x6f]
               	ldrsb	x3, [x0, #0x2]
               	ldrsb	x4, [x1, #0x2]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x6e]
               	ldrsb	x3, [x0, #0x3]
               	ldrsb	x4, [x1, #0x3]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x6d]
               	ldrsb	x3, [x0, #0x4]
               	ldrsb	x4, [x1, #0x4]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x6c]
               	ldrsb	x3, [x0, #0x5]
               	ldrsb	x4, [x1, #0x5]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x6b]
               	ldrsb	x3, [x0, #0x6]
               	ldrsb	x4, [x1, #0x6]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x6a]
               	ldrsb	x3, [x0, #0x7]
               	ldrsb	x4, [x1, #0x7]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x69]
               	ldrsb	x3, [x0, #0x8]
               	ldrsb	x4, [x1, #0x8]
               	add	x4, x3, x4
               	add	x3, x2, #0x8
               	strb	w4, [x3]
               	ldrsb	x4, [x0, #0x9]
               	ldrsb	x5, [x1, #0x9]
               	add	x4, x4, x5
               	sturb	w4, [x29, #-0x67]
               	ldrsb	x4, [x0, #0xa]
               	ldrsb	x5, [x1, #0xa]
               	add	x4, x4, x5
               	sturb	w4, [x29, #-0x66]
               	ldrsb	x4, [x0, #0xb]
               	ldrsb	x5, [x1, #0xb]
               	add	x4, x4, x5
               	sturb	w4, [x29, #-0x65]
               	ldrsb	x4, [x0, #0xc]
               	ldrsb	x5, [x1, #0xc]
               	add	x4, x4, x5
               	sturb	w4, [x29, #-0x64]
               	ldrsb	x4, [x0, #0xd]
               	ldrsb	x5, [x1, #0xd]
               	add	x4, x4, x5
               	sturb	w4, [x29, #-0x63]
               	ldrsb	x4, [x0, #0xe]
               	ldrsb	x5, [x1, #0xe]
               	add	x4, x4, x5
               	sturb	w4, [x29, #-0x62]
               	ldrsb	x4, [x0, #0xf]
               	ldrsb	x5, [x1, #0xf]
               	add	x4, x4, x5
               	sturb	w4, [x29, #-0x61]
               	ldrsb	x4, [x0, #0x10]
               	ldrsb	x5, [x1, #0x10]
               	add	x5, x4, x5
               	add	x4, x2, #0x10
               	strb	w5, [x4]
               	ldrsb	x5, [x0, #0x11]
               	ldrsb	x6, [x1, #0x11]
               	add	x5, x5, x6
               	sturb	w5, [x29, #-0x5f]
               	ldrsb	x5, [x0, #0x12]
               	ldrsb	x6, [x1, #0x12]
               	add	x5, x5, x6
               	sturb	w5, [x29, #-0x5e]
               	ldrsb	x5, [x0, #0x13]
               	ldrsb	x6, [x1, #0x13]
               	add	x5, x5, x6
               	sturb	w5, [x29, #-0x5d]
               	ldrsb	x5, [x0, #0x14]
               	ldrsb	x6, [x1, #0x14]
               	add	x5, x5, x6
               	sturb	w5, [x29, #-0x5c]
               	ldrsb	x5, [x0, #0x15]
               	ldrsb	x6, [x1, #0x15]
               	add	x5, x5, x6
               	sturb	w5, [x29, #-0x5b]
               	ldrsb	x5, [x0, #0x16]
               	ldrsb	x6, [x1, #0x16]
               	add	x5, x5, x6
               	sturb	w5, [x29, #-0x5a]
               	ldrsb	x5, [x0, #0x17]
               	ldrsb	x6, [x1, #0x17]
               	add	x5, x5, x6
               	sturb	w5, [x29, #-0x59]
               	ldrsb	x5, [x0, #0x18]
               	ldrsb	x6, [x1, #0x18]
               	add	x6, x5, x6
               	add	x5, x2, #0x18
               	strb	w6, [x5]
               	ldrsb	x2, [x0, #0x19]
               	ldrsb	x6, [x1, #0x19]
               	add	x2, x2, x6
               	sturb	w2, [x29, #-0x57]
               	ldrsb	x2, [x0, #0x1a]
               	ldrsb	x6, [x1, #0x1a]
               	add	x2, x2, x6
               	sturb	w2, [x29, #-0x56]
               	ldrsb	x2, [x0, #0x1b]
               	ldrsb	x6, [x1, #0x1b]
               	add	x2, x2, x6
               	sturb	w2, [x29, #-0x55]
               	ldrsb	x2, [x0, #0x1c]
               	ldrsb	x6, [x1, #0x1c]
               	add	x2, x2, x6
               	sturb	w2, [x29, #-0x54]
               	ldrsb	x2, [x0, #0x1d]
               	ldrsb	x6, [x1, #0x1d]
               	add	x2, x2, x6
               	sturb	w2, [x29, #-0x53]
               	ldrsb	x2, [x0, #0x1e]
               	ldrsb	x6, [x1, #0x1e]
               	add	x2, x2, x6
               	sturb	w2, [x29, #-0x52]
               	ldrsb	x2, [x0, #0x1f]
               	ldrsb	x6, [x1, #0x1f]
               	add	x2, x2, x6
               	sturb	w2, [x29, #-0x51]
               	sub	x2, x29, #0x50
               	ldrsb	x6, [x0]
               	ldrsb	x7, [x1]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x50]
               	ldrsb	x6, [x0, #0x1]
               	ldrsb	x7, [x1, #0x1]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x4f]
               	ldrsb	x6, [x0, #0x2]
               	ldrsb	x7, [x1, #0x2]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x4e]
               	ldrsb	x6, [x0, #0x3]
               	ldrsb	x7, [x1, #0x3]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x4d]
               	ldrsb	x6, [x0, #0x4]
               	ldrsb	x7, [x1, #0x4]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x4c]
               	ldrsb	x6, [x0, #0x5]
               	ldrsb	x7, [x1, #0x5]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x4b]
               	ldrsb	x6, [x0, #0x6]
               	ldrsb	x7, [x1, #0x6]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x4a]
               	ldrsb	x6, [x0, #0x7]
               	ldrsb	x7, [x1, #0x7]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x49]
               	ldrsb	x6, [x0, #0x8]
               	ldrsb	x7, [x1, #0x8]
               	sub	x7, x6, x7
               	add	x6, x2, #0x8
               	strb	w7, [x6]
               	ldrsb	x7, [x0, #0x9]
               	ldrsb	x8, [x1, #0x9]
               	sub	x7, x7, x8
               	sturb	w7, [x29, #-0x47]
               	ldrsb	x7, [x0, #0xa]
               	ldrsb	x8, [x1, #0xa]
               	sub	x7, x7, x8
               	sturb	w7, [x29, #-0x46]
               	ldrsb	x7, [x0, #0xb]
               	ldrsb	x8, [x1, #0xb]
               	sub	x7, x7, x8
               	sturb	w7, [x29, #-0x45]
               	ldrsb	x7, [x0, #0xc]
               	ldrsb	x8, [x1, #0xc]
               	sub	x7, x7, x8
               	sturb	w7, [x29, #-0x44]
               	ldrsb	x7, [x0, #0xd]
               	ldrsb	x8, [x1, #0xd]
               	sub	x7, x7, x8
               	sturb	w7, [x29, #-0x43]
               	ldrsb	x7, [x0, #0xe]
               	ldrsb	x8, [x1, #0xe]
               	sub	x7, x7, x8
               	sturb	w7, [x29, #-0x42]
               	ldrsb	x7, [x0, #0xf]
               	ldrsb	x8, [x1, #0xf]
               	sub	x7, x7, x8
               	sturb	w7, [x29, #-0x41]
               	ldrsb	x7, [x0, #0x10]
               	ldrsb	x8, [x1, #0x10]
               	sub	x8, x7, x8
               	add	x7, x2, #0x10
               	strb	w8, [x7]
               	ldrsb	x8, [x0, #0x11]
               	ldrsb	x9, [x1, #0x11]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x3f]
               	ldrsb	x8, [x0, #0x12]
               	ldrsb	x9, [x1, #0x12]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x3e]
               	ldrsb	x8, [x0, #0x13]
               	ldrsb	x9, [x1, #0x13]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x3d]
               	ldrsb	x8, [x0, #0x14]
               	ldrsb	x9, [x1, #0x14]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x3c]
               	ldrsb	x8, [x0, #0x15]
               	ldrsb	x9, [x1, #0x15]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x3b]
               	ldrsb	x8, [x0, #0x16]
               	ldrsb	x9, [x1, #0x16]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x3a]
               	ldrsb	x8, [x0, #0x17]
               	ldrsb	x9, [x1, #0x17]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x39]
               	ldrsb	x8, [x0, #0x18]
               	ldrsb	x9, [x1, #0x18]
               	sub	x8, x8, x9
               	add	x2, x2, #0x18
               	strb	w8, [x2]
               	ldrsb	x8, [x0, #0x19]
               	ldrsb	x9, [x1, #0x19]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x37]
               	ldrsb	x8, [x0, #0x1a]
               	ldrsb	x9, [x1, #0x1a]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x36]
               	ldrsb	x8, [x0, #0x1b]
               	ldrsb	x9, [x1, #0x1b]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x35]
               	ldrsb	x8, [x0, #0x1c]
               	ldrsb	x9, [x1, #0x1c]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x34]
               	ldrsb	x8, [x0, #0x1d]
               	ldrsb	x9, [x1, #0x1d]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x33]
               	ldrsb	x8, [x0, #0x1e]
               	ldrsb	x9, [x1, #0x1e]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x32]
               	ldrsb	x8, [x0, #0x1f]
               	ldrsb	x9, [x1, #0x1f]
               	sub	x8, x8, x9
               	sturb	w8, [x29, #-0x31]
               	ldur	x8, [x29, #-0x70]
               	ldur	x9, [x29, #-0x50]
               	eor	x8, x8, x9
               	ldr	x3, [x3]
               	ldr	x6, [x6]
               	eor	x3, x3, x6
               	ldr	x4, [x4]
               	ldr	x6, [x7]
               	eor	x4, x4, x6
               	ldr	x5, [x5]
               	ldr	x2, [x2]
               	eor	x2, x5, x2
               	ldr	x5, [x0]
               	ldr	x6, [x1]
               	and	x5, x5, x6
               	ldr	x6, [x0, #0x8]
               	ldr	x7, [x1, #0x8]
               	and	x6, x6, x7
               	ldr	x7, [x0, #0x10]
               	ldr	x9, [x1, #0x10]
               	and	x7, x7, x9
               	ldr	x0, [x0, #0x18]
               	ldr	x1, [x1, #0x18]
               	and	x1, x0, x1
               	sub	x0, x29, #0x30
               	orr	x5, x8, x5
               	stur	x5, [x29, #-0x30]
               	orr	x3, x3, x6
               	stur	x3, [x29, #-0x28]
               	orr	x3, x4, x7
               	stur	x3, [x29, #-0x20]
               	orr	x1, x2, x1
               	stur	x1, [x29, #-0x18]
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
               	stp	x20, x21, [sp, #-0xe0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	stur	x8, [x29, #-0x8]
               	ldrsh	x2, [x0]
               	ldrsh	x3, [x1]
               	mul	x2, x2, x3
               	ldrsh	x3, [x0, #0x2]
               	ldrsh	x4, [x1, #0x2]
               	mul	x3, x3, x4
               	ldrsh	x4, [x0, #0x4]
               	ldrsh	x5, [x1, #0x4]
               	mul	x4, x4, x5
               	ldrsh	x5, [x0, #0x6]
               	ldrsh	x6, [x1, #0x6]
               	mul	x5, x5, x6
               	ldrsh	x6, [x0, #0x8]
               	ldrsh	x7, [x1, #0x8]
               	mul	x6, x6, x7
               	ldrsh	x7, [x0, #0xa]
               	ldrsh	x8, [x1, #0xa]
               	mul	x7, x7, x8
               	ldrsh	x8, [x0, #0xc]
               	ldrsh	x9, [x1, #0xc]
               	mul	x8, x8, x9
               	ldrsh	x9, [x0, #0xe]
               	ldrsh	x10, [x1, #0xe]
               	mul	x9, x9, x10
               	ldrsh	x10, [x0, #0x10]
               	ldrsh	x11, [x1, #0x10]
               	mul	x10, x10, x11
               	ldrsh	x11, [x0, #0x12]
               	ldrsh	x12, [x1, #0x12]
               	mul	x11, x11, x12
               	ldrsh	x12, [x0, #0x14]
               	ldrsh	x13, [x1, #0x14]
               	mul	x12, x12, x13
               	ldrsh	x13, [x0, #0x16]
               	ldrsh	x14, [x1, #0x16]
               	mul	x13, x13, x14
               	ldrsh	x14, [x0, #0x18]
               	ldrsh	x15, [x1, #0x18]
               	mul	x14, x14, x15
               	ldrsh	x15, [x0, #0x1a]
               	ldrsh	x20, [x1, #0x1a]
               	mul	x15, x15, x20
               	ldrsh	x20, [x0, #0x1c]
               	ldrsh	x21, [x1, #0x1c]
               	mul	x20, x20, x21
               	ldrsh	x21, [x0, #0x1e]
               	ldrsh	x22, [x1, #0x1e]
               	mul	x21, x21, x22
               	ldrsh	x22, [x0]
               	ldrsh	x23, [x1]
               	sub	x22, x22, x23
               	ldrsh	x23, [x0, #0x2]
               	ldrsh	x24, [x1, #0x2]
               	sub	x23, x23, x24
               	ldrsh	x24, [x0, #0x4]
               	ldrsh	x25, [x1, #0x4]
               	sub	x24, x24, x25
               	ldrsh	x25, [x0, #0x6]
               	ldrsh	x26, [x1, #0x6]
               	sub	x25, x25, x26
               	ldrsh	x26, [x0, #0x8]
               	ldrsh	x27, [x1, #0x8]
               	sub	x26, x26, x27
               	ldrsh	x27, [x0, #0xa]
               	ldrsh	x28, [x1, #0xa]
               	sub	x27, x27, x28
               	ldrsh	x28, [x0, #0xc]
               	ldrsh	x17, [x1, #0xc]
               	str	x17, [sp, #0xb8]
               	ldr	x17, [sp, #0xb8]
               	sub	x28, x28, x17
               	ldrsh	x17, [x0, #0xe]
               	str	x17, [sp, #0xb8]
               	ldrsh	x17, [x1, #0xe]
               	str	x17, [sp, #0xb0]
               	ldr	x16, [sp, #0xb8]
               	ldr	x17, [sp, #0xb0]
               	sub	x16, x16, x17
               	str	x16, [sp, #0xb8]
               	ldrsh	x17, [x0, #0x10]
               	str	x17, [sp, #0xb0]
               	ldrsh	x17, [x1, #0x10]
               	str	x17, [sp, #0xa8]
               	ldr	x16, [sp, #0xb0]
               	ldr	x17, [sp, #0xa8]
               	sub	x16, x16, x17
               	str	x16, [sp, #0xb0]
               	ldrsh	x17, [x0, #0x12]
               	str	x17, [sp, #0xa8]
               	ldrsh	x17, [x1, #0x12]
               	str	x17, [sp, #0xa0]
               	ldr	x16, [sp, #0xa8]
               	ldr	x17, [sp, #0xa0]
               	sub	x16, x16, x17
               	str	x16, [sp, #0xa8]
               	ldrsh	x17, [x0, #0x14]
               	str	x17, [sp, #0xa0]
               	ldrsh	x17, [x1, #0x14]
               	str	x17, [sp, #0x98]
               	ldr	x16, [sp, #0xa0]
               	ldr	x17, [sp, #0x98]
               	sub	x16, x16, x17
               	str	x16, [sp, #0xa0]
               	ldrsh	x17, [x0, #0x16]
               	str	x17, [sp, #0x98]
               	ldrsh	x17, [x1, #0x16]
               	str	x17, [sp, #0x90]
               	ldr	x16, [sp, #0x98]
               	ldr	x17, [sp, #0x90]
               	sub	x16, x16, x17
               	str	x16, [sp, #0x98]
               	ldrsh	x17, [x0, #0x18]
               	str	x17, [sp, #0x90]
               	ldrsh	x17, [x1, #0x18]
               	str	x17, [sp, #0x88]
               	ldr	x16, [sp, #0x90]
               	ldr	x17, [sp, #0x88]
               	sub	x16, x16, x17
               	str	x16, [sp, #0x90]
               	ldrsh	x17, [x0, #0x1a]
               	str	x17, [sp, #0x88]
               	ldrsh	x17, [x1, #0x1a]
               	str	x17, [sp, #0x80]
               	ldr	x16, [sp, #0x88]
               	ldr	x17, [sp, #0x80]
               	sub	x16, x16, x17
               	str	x16, [sp, #0x88]
               	ldrsh	x17, [x0, #0x1c]
               	str	x17, [sp, #0x80]
               	ldrsh	x17, [x1, #0x1c]
               	str	x17, [sp, #0x78]
               	ldr	x16, [sp, #0x80]
               	ldr	x17, [sp, #0x78]
               	sub	x16, x16, x17
               	str	x16, [sp, #0x80]
               	ldrsh	x0, [x0, #0x1e]
               	ldrsh	x1, [x1, #0x1e]
               	sub	x1, x0, x1
               	sub	x0, x29, #0x80
               	sxth	x2, w2
               	sxth	x22, w22
               	add	x2, x2, x22
               	sturh	w2, [x29, #-0x80]
               	sxth	x2, w3
               	sxth	x3, w23
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x7e]
               	sxth	x2, w4
               	sxth	x3, w24
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x7c]
               	sxth	x2, w5
               	sxth	x3, w25
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x7a]
               	sxth	x2, w6
               	sxth	x3, w26
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x78]
               	sxth	x2, w7
               	sxth	x3, w27
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x76]
               	sxth	x2, w8
               	sxth	x3, w28
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x74]
               	sxth	x2, w9
               	ldr	x16, [sp, #0xb8]
               	sxth	x3, w16
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x72]
               	sxth	x2, w10
               	ldr	x16, [sp, #0xb0]
               	sxth	x3, w16
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x70]
               	sxth	x2, w11
               	ldr	x16, [sp, #0xa8]
               	sxth	x3, w16
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x6e]
               	sxth	x2, w12
               	ldr	x16, [sp, #0xa0]
               	sxth	x3, w16
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x6c]
               	sxth	x2, w13
               	ldr	x16, [sp, #0x98]
               	sxth	x3, w16
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x6a]
               	sxth	x2, w14
               	ldr	x16, [sp, #0x90]
               	sxth	x3, w16
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x68]
               	sxth	x2, w15
               	ldr	x16, [sp, #0x88]
               	sxth	x3, w16
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x66]
               	sxth	x2, w20
               	ldr	x16, [sp, #0x80]
               	sxth	x3, w16
               	add	x2, x2, x3
               	sturh	w2, [x29, #-0x64]
               	sxth	x2, w21
               	sxth	x1, w1
               	add	x1, x2, x1
               	sturh	w1, [x29, #-0x62]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret

<i_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	stur	x8, [x29, #-0x8]
               	sub	x2, x29, #0x70
               	ldrsw	x3, [x0]
               	ldrsw	x4, [x1]
               	add	x3, x3, x4
               	stur	w3, [x29, #-0x70]
               	ldrsw	x3, [x0, #0x4]
               	ldrsw	x4, [x1, #0x4]
               	add	x3, x3, x4
               	stur	w3, [x29, #-0x6c]
               	ldrsw	x3, [x0, #0x8]
               	ldrsw	x4, [x1, #0x8]
               	add	x4, x3, x4
               	add	x3, x2, #0x8
               	str	w4, [x3]
               	ldrsw	x4, [x0, #0xc]
               	ldrsw	x5, [x1, #0xc]
               	add	x4, x4, x5
               	stur	w4, [x29, #-0x64]
               	ldrsw	x4, [x0, #0x10]
               	ldrsw	x5, [x1, #0x10]
               	add	x5, x4, x5
               	add	x4, x2, #0x10
               	str	w5, [x4]
               	ldrsw	x5, [x0, #0x14]
               	ldrsw	x6, [x1, #0x14]
               	add	x5, x5, x6
               	stur	w5, [x29, #-0x5c]
               	ldrsw	x5, [x0, #0x18]
               	ldrsw	x6, [x1, #0x18]
               	add	x6, x5, x6
               	add	x5, x2, #0x18
               	str	w6, [x5]
               	ldrsw	x2, [x0, #0x1c]
               	ldrsw	x6, [x1, #0x1c]
               	add	x2, x2, x6
               	stur	w2, [x29, #-0x54]
               	sub	x2, x29, #0x50
               	ldrsw	x6, [x0]
               	ldrsw	x7, [x1]
               	sub	x6, x6, x7
               	stur	w6, [x29, #-0x50]
               	ldrsw	x6, [x0, #0x4]
               	ldrsw	x7, [x1, #0x4]
               	sub	x6, x6, x7
               	stur	w6, [x29, #-0x4c]
               	ldrsw	x6, [x0, #0x8]
               	ldrsw	x7, [x1, #0x8]
               	sub	x7, x6, x7
               	add	x6, x2, #0x8
               	str	w7, [x6]
               	ldrsw	x7, [x0, #0xc]
               	ldrsw	x8, [x1, #0xc]
               	sub	x7, x7, x8
               	stur	w7, [x29, #-0x44]
               	ldrsw	x7, [x0, #0x10]
               	ldrsw	x8, [x1, #0x10]
               	sub	x8, x7, x8
               	add	x7, x2, #0x10
               	str	w8, [x7]
               	ldrsw	x8, [x0, #0x14]
               	ldrsw	x9, [x1, #0x14]
               	sub	x8, x8, x9
               	stur	w8, [x29, #-0x3c]
               	ldrsw	x8, [x0, #0x18]
               	ldrsw	x9, [x1, #0x18]
               	sub	x8, x8, x9
               	add	x2, x2, #0x18
               	str	w8, [x2]
               	ldrsw	x0, [x0, #0x1c]
               	ldrsw	x1, [x1, #0x1c]
               	sub	x0, x0, x1
               	stur	w0, [x29, #-0x34]
               	sub	x0, x29, #0x30
               	ldur	x1, [x29, #-0x70]
               	ldur	x8, [x29, #-0x50]
               	eor	x1, x1, x8
               	stur	x1, [x29, #-0x30]
               	ldr	x1, [x3]
               	ldr	x3, [x6]
               	eor	x1, x1, x3
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x4]
               	ldr	x3, [x7]
               	eor	x1, x1, x3
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x5]
               	ldr	x2, [x2]
               	eor	x1, x1, x2
               	stur	x1, [x29, #-0x18]
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
               	sub	sp, sp, #0x50
               	stur	x8, [x29, #-0x8]
               	sub	x2, x29, #0x50
               	ldr	w3, [x0]
               	ldr	w4, [x1]
               	sub	x3, x3, x4
               	stur	w3, [x29, #-0x50]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x1, #0x4]
               	sub	x3, x3, x4
               	stur	w3, [x29, #-0x4c]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x1, #0x8]
               	sub	x4, x3, x4
               	add	x3, x2, #0x8
               	str	w4, [x3]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x1, #0xc]
               	sub	x4, x4, x5
               	stur	w4, [x29, #-0x44]
               	ldr	w4, [x0, #0x10]
               	ldr	w5, [x1, #0x10]
               	sub	x5, x4, x5
               	add	x4, x2, #0x10
               	str	w5, [x4]
               	ldr	w5, [x0, #0x14]
               	ldr	w6, [x1, #0x14]
               	sub	x5, x5, x6
               	stur	w5, [x29, #-0x3c]
               	ldr	w5, [x0, #0x18]
               	ldr	w6, [x1, #0x18]
               	sub	x5, x5, x6
               	add	x2, x2, #0x18
               	str	w5, [x2]
               	ldr	w5, [x0, #0x1c]
               	ldr	w6, [x1, #0x1c]
               	sub	x5, x5, x6
               	stur	w5, [x29, #-0x34]
               	ldr	x5, [x0]
               	ldr	x6, [x1]
               	orr	x5, x5, x6
               	ldr	x6, [x0, #0x8]
               	ldr	x7, [x1, #0x8]
               	orr	x6, x6, x7
               	ldr	x7, [x0, #0x10]
               	ldr	x8, [x1, #0x10]
               	orr	x7, x7, x8
               	ldr	x0, [x0, #0x18]
               	ldr	x1, [x1, #0x18]
               	orr	x1, x0, x1
               	sub	x0, x29, #0x30
               	ldur	x8, [x29, #-0x50]
               	eor	x5, x8, x5
               	stur	x5, [x29, #-0x30]
               	ldr	x3, [x3]
               	eor	x3, x3, x6
               	stur	x3, [x29, #-0x28]
               	ldr	x3, [x4]
               	eor	x3, x3, x7
               	stur	x3, [x29, #-0x20]
               	ldr	x2, [x2]
               	eor	x1, x2, x1
               	stur	x1, [x29, #-0x18]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<l_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x8]
               	ldr	x4, [x1, #0x8]
               	add	x3, x3, x4
               	ldr	x4, [x0, #0x10]
               	ldr	x5, [x1, #0x10]
               	add	x4, x4, x5
               	ldr	x5, [x0, #0x18]
               	ldr	x6, [x1, #0x18]
               	add	x5, x5, x6
               	ldr	x6, [x0]
               	ldr	x7, [x1]
               	and	x6, x6, x7
               	ldr	x7, [x0, #0x8]
               	ldr	x8, [x1, #0x8]
               	and	x7, x7, x8
               	ldr	x8, [x0, #0x10]
               	ldr	x9, [x1, #0x10]
               	and	x8, x8, x9
               	ldr	x0, [x0, #0x18]
               	ldr	x1, [x1, #0x18]
               	and	x1, x0, x1
               	sub	x0, x29, #0x30
               	sub	x2, x2, x6
               	stur	x2, [x29, #-0x30]
               	sub	x2, x3, x7
               	stur	x2, [x29, #-0x28]
               	sub	x2, x4, x8
               	stur	x2, [x29, #-0x20]
               	sub	x1, x5, x1
               	stur	x1, [x29, #-0x18]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<f_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	ldr	s0, [x0]
               	ldr	s1, [x1]
               	ldr	s2, [x0, #0x4]
               	ldr	s3, [x1, #0x4]
               	ldr	s4, [x0, #0x8]
               	ldr	s5, [x1, #0x8]
               	ldr	s6, [x0, #0xc]
               	ldr	s7, [x1, #0xc]
               	ldr	s19, [x0, #0x10]
               	ldr	s20, [x1, #0x10]
               	ldr	s21, [x0, #0x14]
               	ldr	s22, [x1, #0x14]
               	ldr	s23, [x0, #0x18]
               	ldr	s24, [x1, #0x18]
               	ldr	s25, [x0, #0x1c]
               	ldr	s26, [x1, #0x1c]
               	ldr	s27, [x0]
               	fmadd	s0, s0, s1, s27
               	ldr	s1, [x0, #0x4]
               	fmadd	s1, s2, s3, s1
               	ldr	s2, [x0, #0x8]
               	fmadd	s2, s4, s5, s2
               	ldr	s3, [x0, #0xc]
               	fmadd	s3, s6, s7, s3
               	ldr	s4, [x0, #0x10]
               	fmadd	s4, s19, s20, s4
               	ldr	s5, [x0, #0x14]
               	fmadd	s5, s21, s22, s5
               	ldr	s6, [x0, #0x18]
               	fmadd	s6, s23, s24, s6
               	ldr	s7, [x0, #0x1c]
               	fmadd	s7, s25, s26, s7
               	ldr	s19, [x1]
               	ldr	s20, [x0]
               	fsub	s19, s19, s20
               	ldr	s20, [x1, #0x4]
               	ldr	s21, [x0, #0x4]
               	fsub	s20, s20, s21
               	ldr	s21, [x1, #0x8]
               	ldr	s22, [x0, #0x8]
               	fsub	s21, s21, s22
               	ldr	s22, [x1, #0xc]
               	ldr	s23, [x0, #0xc]
               	fsub	s22, s22, s23
               	ldr	s23, [x1, #0x10]
               	ldr	s24, [x0, #0x10]
               	fsub	s23, s23, s24
               	ldr	s24, [x1, #0x14]
               	ldr	s25, [x0, #0x14]
               	fsub	s24, s24, s25
               	ldr	s25, [x1, #0x18]
               	ldr	s26, [x0, #0x18]
               	fsub	s25, s25, s26
               	ldr	s26, [x1, #0x1c]
               	ldr	s27, [x0, #0x1c]
               	fsub	s26, s26, s27
               	sub	x0, x29, #0x30
               	fdiv	s0, s0, s19
               	stur	s0, [x29, #-0x30]
               	fdiv	s0, s1, s20
               	stur	s0, [x29, #-0x2c]
               	fdiv	s0, s2, s21
               	stur	s0, [x29, #-0x28]
               	fdiv	s0, s3, s22
               	stur	s0, [x29, #-0x24]
               	fdiv	s0, s4, s23
               	stur	s0, [x29, #-0x20]
               	fdiv	s0, s5, s24
               	stur	s0, [x29, #-0x1c]
               	fdiv	s0, s6, s25
               	stur	s0, [x29, #-0x18]
               	fdiv	s0, s7, s26
               	stur	s0, [x29, #-0x14]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<d_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	ldr	d0, [x0]
               	ldr	d1, [x1]
               	fsub	d0, d0, d1
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x1, #0x8]
               	fsub	d1, d1, d2
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x1, #0x10]
               	fsub	d2, d2, d3
               	ldr	d3, [x0, #0x18]
               	ldr	d4, [x1, #0x18]
               	fsub	d3, d3, d4
               	ldr	d4, [x0]
               	ldr	d5, [x1]
               	fadd	d4, d4, d5
               	ldr	d5, [x0, #0x8]
               	ldr	d6, [x1, #0x8]
               	fadd	d5, d5, d6
               	ldr	d6, [x0, #0x10]
               	ldr	d7, [x1, #0x10]
               	fadd	d6, d6, d7
               	ldr	d7, [x0, #0x18]
               	ldr	d19, [x1, #0x18]
               	fadd	d7, d7, d19
               	fmul	d0, d0, d4
               	fmul	d1, d1, d5
               	fmul	d2, d2, d6
               	fmul	d3, d3, d7
               	sub	x0, x29, #0x30
               	ldr	d4, [x1]
               	fdiv	d0, d0, d4
               	stur	d0, [x29, #-0x30]
               	ldr	d0, [x1, #0x8]
               	fdiv	d0, d1, d0
               	stur	d0, [x29, #-0x28]
               	ldr	d0, [x1, #0x10]
               	fdiv	d0, d2, d0
               	stur	d0, [x29, #-0x20]
               	ldr	d0, [x1, #0x18]
               	fdiv	d0, d3, d0
               	stur	d0, [x29, #-0x18]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<touch>:
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x30]
               	add	x0, x2, x0
               	str	w0, [x1, #0x30]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x8b0
               	stp	x20, x21, [sp]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x13               // =19
               	mov	x2, #0x25               // =37
               	sub	x3, x29, #0x8a0
               	mul	x4, x0, x2
               	sub	x4, x4, #0x64
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x880
               	mov	x4, #0x7f               // =127
               	mul	x5, x0, x1
               	sub	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #-0x7530            // =-30000
               	strh	w0, [sp, #0x50]
               	mov	x0, #0x3                // =3
               	strh	w0, [sp, #0x70]
               	mov	x0, #-0x5207            // =-20999
               	strh	w0, [sp, #0x52]
               	mov	x0, #0xa                // =10
               	strh	w0, [sp, #0x72]
               	mov	x0, #-0x2ede            // =-11998
               	strh	w0, [sp, #0x54]
               	mov	x0, #0x11               // =17
               	strh	w0, [sp, #0x74]
               	mov	x0, #-0xbb5             // =-2997
               	strh	w0, [sp, #0x56]
               	mov	x0, #0x18               // =24
               	strh	w0, [sp, #0x76]
               	mov	x0, #0x1774             // =6004
               	strh	w0, [sp, #0x58]
               	mov	x0, #0x1f               // =31
               	strh	w0, [sp, #0x78]
               	mov	x0, #0x3a9d             // =15005
               	strh	w0, [sp, #0x5a]
               	mov	x0, #0x26               // =38
               	strh	w0, [sp, #0x7a]
               	mov	x0, #0x5dc6             // =24006
               	strh	w0, [sp, #0x5c]
               	mov	x0, #0x2d               // =45
               	strh	w0, [sp, #0x7c]
               	mov	x0, #-0x7f11            // =-32529
               	strh	w0, [sp, #0x5e]
               	mov	x0, #0x34               // =52
               	strh	w0, [sp, #0x7e]
               	mov	x0, #-0x5be8            // =-23528
               	strh	w0, [sp, #0x60]
               	mov	x0, #0x3b               // =59
               	strh	w0, [sp, #0x80]
               	mov	x0, #-0x38bf            // =-14527
               	strh	w0, [sp, #0x62]
               	mov	x0, #0x42               // =66
               	strh	w0, [sp, #0x82]
               	mov	x0, #-0x1596            // =-5526
               	strh	w0, [sp, #0x64]
               	mov	x0, #0x49               // =73
               	strh	w0, [sp, #0x84]
               	mov	x0, #0xd93              // =3475
               	strh	w0, [sp, #0x66]
               	mov	x0, #0x50               // =80
               	strh	w0, [sp, #0x86]
               	mov	x0, #0x30bc             // =12476
               	strh	w0, [sp, #0x68]
               	mov	x0, #0x57               // =87
               	strh	w0, [sp, #0x88]
               	mov	x0, #0x53e5             // =21477
               	strh	w0, [sp, #0x6a]
               	mov	x0, #0x5e               // =94
               	strh	w0, [sp, #0x8a]
               	mov	x0, #0x770e             // =30478
               	strh	w0, [sp, #0x6c]
               	mov	x0, #0x65               // =101
               	strh	w0, [sp, #0x8c]
               	mov	x0, #-0x65c9            // =-26057
               	strh	w0, [sp, #0x6e]
               	mov	x0, #0x6c               // =108
               	strh	w0, [sp, #0x8e]
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
               	sub	x20, x29, #0x8a0
               	sub	x21, x29, #0x880
               	sub	x0, x29, #0x400
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x3e0
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6c0
               	bl	<addr>
               	sub	x0, x29, #0x6c0
               	sub	x3, x29, #0x6e0
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
               	sub	x20, x29, #0x860
               	sub	x21, x29, #0x840
               	sub	x0, x29, #0x3c0
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x3a0
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6c0
               	bl	<addr>
               	sub	x0, x29, #0x6c0
               	sub	x3, x29, #0x6e0
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
               	sub	x20, x29, #0x820
               	sub	x21, x29, #0x800
               	sub	x0, x29, #0x380
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x360
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6c0
               	bl	<addr>
               	sub	x0, x29, #0x6c0
               	sub	x3, x29, #0x6e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	mov	x0, #0x0                // =0
               	ldrsw	x4, [x3, x0, lsl #2]
               	ldrsw	x1, [x20, x0, lsl #2]
               	ldrsw	x2, [x21, x0, lsl #2]
               	add	x5, x1, x2
               	sxtw	x5, w5
               	sub	x1, x1, x2
               	sxtw	x1, w1
               	eor	x1, x5, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x20, x29, #0x7e0
               	sub	x21, x29, #0x7c0
               	sub	x0, x29, #0x340
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x320
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6c0
               	bl	<addr>
               	sub	x0, x29, #0x6c0
               	sub	x3, x29, #0x6e0
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
               	sub	x1, x29, #0x7a0
               	sub	x2, x29, #0x780
               	sub	x0, x29, #0x300
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2e0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6c0
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
               	add	sp, sp, #0x8b0
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
               	sub	x20, x29, #0x760
               	sub	x21, x29, #0x740
               	sub	x0, x29, #0x2c0
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2a0
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6c0
               	bl	<addr>
               	sub	x0, x29, #0x6c0
               	sub	x4, x29, #0x6e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x4, #0x10]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x2, x20, x1
               	ldr	s0, [x2]
               	add	x3, x21, x1
               	ldr	s1, [x3]
               	fmul	s1, s0, s1
               	fadd	s0, s1, s0
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	ldr	s2, [x3]
               	ldr	s3, [x2]
               	fsub	s2, s2, s3
               	fdiv	s0, s0, s2
               	fcmp	s1, s0
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x720
               	sub	x2, x29, #0x700
               	sub	x0, x29, #0x280
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x260
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x8, x29, #0x6c0
               	bl	<addr>
               	sub	x0, x29, #0x6c0
               	sub	x1, x29, #0x6e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x190]
               	ldr	d1, [sp, #0x1b0]
               	fsub	d2, d0, d1
               	fadd	d0, d0, d1
               	fmul	d0, d2, d0
               	ldr	d1, [sp, #0x1d0]
               	ldr	d2, [sp, #0x1b0]
               	fdiv	d0, d0, d2
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d0, [sp, #0x198]
               	ldr	d1, [sp, #0x1b8]
               	fsub	d2, d0, d1
               	fadd	d0, d0, d1
               	fmul	d0, d2, d0
               	ldr	d1, [sp, #0x1d8]
               	ldr	d2, [sp, #0x1b8]
               	fdiv	d0, d0, d2
               	fcmp	d1, d0
               	b.ne	<addr>
               	ldr	d0, [sp, #0x1a0]
               	ldr	d1, [sp, #0x1c0]
               	fsub	d2, d0, d1
               	fadd	d0, d0, d1
               	fmul	d0, d2, d0
               	ldr	d1, [sp, #0x1e0]
               	ldr	d2, [sp, #0x1c0]
               	fdiv	d0, d0, d2
               	fcmp	d1, d0
               	b.ne	<addr>
               	ldr	d0, [sp, #0x1a8]
               	ldr	d1, [sp, #0x1c8]
               	fsub	d2, d0, d1
               	fadd	d0, d0, d1
               	fmul	d0, d2, d0
               	ldr	d1, [sp, #0x1e8]
               	ldr	d2, [sp, #0x1c8]
               	fdiv	d0, d0, d2
               	fcmp	d1, d0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x6c0
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
               	sub	x1, x29, #0x6c0
               	add	x1, x1, x0, lsl #5
               	lsl	x2, x0, #3
               	add	x3, x2, #0x6
               	str	w3, [x1, #0x18]
               	add	x2, x2, #0x7
               	str	w2, [x1, #0x1c]
               	add	x0, x0, #0x1
               	cmp	w0, #0x12
               	b.lt	<addr>
               	sub	x0, x29, #0x6c0
               	mov	x20, #0x0               // =0
               	sub	x1, x29, #0x480
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x0, #0x20
               	sub	x2, x29, #0x460
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x40
               	sub	x2, x29, #0x440
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x60
               	sub	x2, x29, #0x420
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x80
               	sub	x2, x29, #0x8a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0xa0
               	sub	x2, x29, #0x880
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0xc0
               	sub	x2, x29, #0x860
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0xe0
               	sub	x2, x29, #0x840
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x100
               	sub	x2, x29, #0x820
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x120
               	sub	x2, x29, #0x7e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x140
               	sub	x2, x29, #0x7c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x160
               	sub	x2, x29, #0x7a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x180
               	sub	x2, x29, #0x780
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x1a0
               	sub	x2, x29, #0x760
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x1c0
               	sub	x2, x29, #0x740
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x1e0
               	sub	x2, x29, #0x720
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x200
               	sub	x2, x29, #0x700
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x0, x0, #0x220
               	sub	x1, x29, #0x6e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldrsw	x0, [sp, #0x430]
               	ldrsw	x1, [sp, #0xb0]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x434]
               	ldrsw	x2, [sp, #0xb4]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x438]
               	ldrsw	x3, [sp, #0xb8]
               	add	x2, x2, x3
               	ldrsw	x3, [sp, #0x43c]
               	ldrsw	x4, [sp, #0xbc]
               	add	x3, x3, x4
               	ldrsw	x4, [sp, #0x440]
               	ldrsw	x5, [sp, #0xc0]
               	add	x4, x4, x5
               	ldrsw	x5, [sp, #0x444]
               	ldrsw	x6, [sp, #0xc4]
               	add	x5, x5, x6
               	ldrsw	x6, [sp, #0x448]
               	ldrsw	x7, [sp, #0xc8]
               	add	x6, x6, x7
               	ldrsw	x7, [sp, #0x44c]
               	ldrsw	x8, [sp, #0xcc]
               	add	x7, x7, x8
               	str	w0, [sp, #0x430]
               	str	w1, [sp, #0x434]
               	str	w2, [sp, #0x438]
               	str	w3, [sp, #0x43c]
               	str	w4, [sp, #0x440]
               	str	w5, [sp, #0x444]
               	str	w6, [sp, #0x448]
               	str	w7, [sp, #0x44c]
               	ldr	x0, [sp, #0x450]
               	ldr	x1, [sp, #0x430]
               	eor	x0, x0, x1
               	ldr	x1, [sp, #0x458]
               	ldr	x2, [sp, #0x438]
               	eor	x1, x1, x2
               	ldr	x2, [sp, #0x460]
               	ldr	x3, [sp, #0x440]
               	eor	x2, x2, x3
               	ldr	x3, [sp, #0x468]
               	ldr	x4, [sp, #0x448]
               	eor	x3, x3, x4
               	str	x0, [sp, #0x450]
               	str	x1, [sp, #0x458]
               	str	x2, [sp, #0x460]
               	str	x3, [sp, #0x468]
               	ldrsw	x0, [sp, #0x470]
               	ldrsw	x1, [sp, #0x450]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x474]
               	ldrsw	x2, [sp, #0x454]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x478]
               	ldrsw	x3, [sp, #0x458]
               	add	x2, x2, x3
               	ldrsw	x3, [sp, #0x47c]
               	ldrsw	x4, [sp, #0x45c]
               	add	x3, x3, x4
               	ldrsw	x4, [sp, #0x480]
               	ldrsw	x5, [sp, #0x460]
               	add	x4, x4, x5
               	ldrsw	x5, [sp, #0x484]
               	ldrsw	x6, [sp, #0x464]
               	add	x5, x5, x6
               	ldrsw	x6, [sp, #0x488]
               	ldrsw	x7, [sp, #0x468]
               	add	x6, x6, x7
               	ldrsw	x7, [sp, #0x48c]
               	ldrsw	x8, [sp, #0x46c]
               	add	x7, x7, x8
               	str	w0, [sp, #0x470]
               	str	w1, [sp, #0x474]
               	str	w2, [sp, #0x478]
               	str	w3, [sp, #0x47c]
               	str	w4, [sp, #0x480]
               	str	w5, [sp, #0x484]
               	str	w6, [sp, #0x488]
               	str	w7, [sp, #0x48c]
               	ldrsw	x8, [sp, #0x490]
               	sub	x0, x8, x0
               	ldrsw	x8, [sp, #0x494]
               	sub	x1, x8, x1
               	ldrsw	x8, [sp, #0x498]
               	sub	x2, x8, x2
               	ldrsw	x8, [sp, #0x49c]
               	sub	x3, x8, x3
               	ldrsw	x8, [sp, #0x4a0]
               	sub	x4, x8, x4
               	ldrsw	x8, [sp, #0x4a4]
               	sub	x5, x8, x5
               	ldrsw	x8, [sp, #0x4a8]
               	sub	x6, x8, x6
               	ldrsw	x8, [sp, #0x4ac]
               	sub	x7, x8, x7
               	str	w0, [sp, #0x490]
               	str	w1, [sp, #0x494]
               	str	w2, [sp, #0x498]
               	str	w3, [sp, #0x49c]
               	str	w4, [sp, #0x4a0]
               	str	w5, [sp, #0x4a4]
               	str	w6, [sp, #0x4a8]
               	str	w7, [sp, #0x4ac]
               	ldrsw	x8, [sp, #0x10]
               	add	x0, x8, x0
               	ldrsw	x8, [sp, #0x14]
               	add	x1, x8, x1
               	ldrsw	x8, [sp, #0x18]
               	add	x2, x8, x2
               	ldrsw	x8, [sp, #0x1c]
               	add	x3, x8, x3
               	ldrsw	x8, [sp, #0x20]
               	add	x4, x8, x4
               	ldrsw	x8, [sp, #0x24]
               	add	x5, x8, x5
               	ldrsw	x8, [sp, #0x28]
               	add	x6, x8, x6
               	ldrsw	x8, [sp, #0x2c]
               	add	x7, x8, x7
               	str	w0, [sp, #0x10]
               	str	w1, [sp, #0x14]
               	str	w2, [sp, #0x18]
               	str	w3, [sp, #0x1c]
               	str	w4, [sp, #0x20]
               	str	w5, [sp, #0x24]
               	str	w6, [sp, #0x28]
               	str	w7, [sp, #0x2c]
               	ldr	x0, [sp, #0x30]
               	ldr	x1, [sp, #0x10]
               	eor	x0, x0, x1
               	ldr	x1, [sp, #0x38]
               	ldr	x2, [sp, #0x18]
               	eor	x1, x1, x2
               	ldr	x2, [sp, #0x40]
               	ldr	x3, [sp, #0x20]
               	eor	x2, x2, x3
               	ldr	x3, [sp, #0x48]
               	ldr	x4, [sp, #0x28]
               	eor	x3, x3, x4
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	str	x3, [sp, #0x48]
               	mov	x0, x20
               	bl	<addr>
               	ldrsw	x0, [sp, #0x50]
               	ldrsw	x1, [sp, #0x30]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x54]
               	ldrsw	x2, [sp, #0x34]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x58]
               	ldrsw	x3, [sp, #0x38]
               	add	x2, x2, x3
               	ldrsw	x3, [sp, #0x5c]
               	ldrsw	x4, [sp, #0x3c]
               	add	x3, x3, x4
               	ldrsw	x4, [sp, #0x60]
               	ldrsw	x5, [sp, #0x40]
               	add	x4, x4, x5
               	ldrsw	x5, [sp, #0x64]
               	ldrsw	x6, [sp, #0x44]
               	add	x5, x5, x6
               	ldrsw	x6, [sp, #0x68]
               	ldrsw	x7, [sp, #0x48]
               	add	x6, x6, x7
               	ldrsw	x7, [sp, #0x6c]
               	ldrsw	x8, [sp, #0x4c]
               	add	x7, x7, x8
               	str	w0, [sp, #0x50]
               	str	w1, [sp, #0x54]
               	str	w2, [sp, #0x58]
               	str	w3, [sp, #0x5c]
               	str	w4, [sp, #0x60]
               	str	w5, [sp, #0x64]
               	str	w6, [sp, #0x68]
               	str	w7, [sp, #0x6c]
               	ldrsw	x8, [sp, #0x70]
               	sub	x0, x8, x0
               	ldrsw	x8, [sp, #0x74]
               	sub	x1, x8, x1
               	ldrsw	x8, [sp, #0x78]
               	sub	x2, x8, x2
               	ldrsw	x8, [sp, #0x7c]
               	sub	x3, x8, x3
               	ldrsw	x8, [sp, #0x80]
               	sub	x4, x8, x4
               	ldrsw	x8, [sp, #0x84]
               	sub	x5, x8, x5
               	ldrsw	x8, [sp, #0x88]
               	sub	x6, x8, x6
               	ldrsw	x8, [sp, #0x8c]
               	sub	x7, x8, x7
               	str	w0, [sp, #0x70]
               	str	w1, [sp, #0x74]
               	str	w2, [sp, #0x78]
               	str	w3, [sp, #0x7c]
               	str	w4, [sp, #0x80]
               	str	w5, [sp, #0x84]
               	str	w6, [sp, #0x88]
               	str	w7, [sp, #0x8c]
               	ldrsw	x8, [sp, #0x90]
               	add	x0, x8, x0
               	ldrsw	x8, [sp, #0x94]
               	add	x1, x8, x1
               	ldrsw	x8, [sp, #0x98]
               	add	x2, x8, x2
               	ldrsw	x8, [sp, #0x9c]
               	add	x3, x8, x3
               	ldrsw	x8, [sp, #0xa0]
               	add	x4, x8, x4
               	ldrsw	x8, [sp, #0xa4]
               	add	x5, x8, x5
               	ldrsw	x8, [sp, #0xa8]
               	add	x6, x8, x6
               	ldrsw	x8, [sp, #0xac]
               	add	x7, x8, x7
               	str	w0, [sp, #0x90]
               	str	w1, [sp, #0x94]
               	str	w2, [sp, #0x98]
               	str	w3, [sp, #0x9c]
               	str	w4, [sp, #0xa0]
               	str	w5, [sp, #0xa4]
               	str	w6, [sp, #0xa8]
               	str	w7, [sp, #0xac]
               	ldr	x0, [sp, #0xd0]
               	ldr	x1, [sp, #0x90]
               	eor	x0, x0, x1
               	ldr	x1, [sp, #0xd8]
               	ldr	x2, [sp, #0x98]
               	eor	x1, x1, x2
               	ldr	x2, [sp, #0xe0]
               	ldr	x3, [sp, #0xa0]
               	eor	x2, x2, x3
               	ldr	x3, [sp, #0xe8]
               	ldr	x4, [sp, #0xa8]
               	eor	x3, x3, x4
               	str	x0, [sp, #0xd0]
               	str	x1, [sp, #0xd8]
               	str	x2, [sp, #0xe0]
               	str	x3, [sp, #0xe8]
               	ldrsw	x0, [sp, #0xf0]
               	ldrsw	x1, [sp, #0xd0]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0xf4]
               	ldrsw	x2, [sp, #0xd4]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0xf8]
               	ldrsw	x3, [sp, #0xd8]
               	add	x2, x2, x3
               	ldrsw	x3, [sp, #0xfc]
               	ldrsw	x4, [sp, #0xdc]
               	add	x3, x3, x4
               	ldrsw	x4, [sp, #0x100]
               	ldrsw	x5, [sp, #0xe0]
               	add	x4, x4, x5
               	ldrsw	x5, [sp, #0x104]
               	ldrsw	x6, [sp, #0xe4]
               	add	x5, x5, x6
               	ldrsw	x6, [sp, #0x108]
               	ldrsw	x7, [sp, #0xe8]
               	add	x6, x6, x7
               	ldrsw	x7, [sp, #0x10c]
               	ldrsw	x8, [sp, #0xec]
               	add	x7, x7, x8
               	str	w0, [sp, #0xf0]
               	str	w1, [sp, #0xf4]
               	str	w2, [sp, #0xf8]
               	str	w3, [sp, #0xfc]
               	str	w4, [sp, #0x100]
               	str	w5, [sp, #0x104]
               	str	w6, [sp, #0x108]
               	str	w7, [sp, #0x10c]
               	ldrsw	x8, [sp, #0x110]
               	sub	x0, x8, x0
               	ldrsw	x8, [sp, #0x114]
               	sub	x1, x8, x1
               	ldrsw	x8, [sp, #0x118]
               	sub	x2, x8, x2
               	ldrsw	x8, [sp, #0x11c]
               	sub	x3, x8, x3
               	ldrsw	x8, [sp, #0x120]
               	sub	x4, x8, x4
               	ldrsw	x8, [sp, #0x124]
               	sub	x5, x8, x5
               	ldrsw	x8, [sp, #0x128]
               	sub	x6, x8, x6
               	ldrsw	x8, [sp, #0x12c]
               	sub	x7, x8, x7
               	str	w0, [sp, #0x110]
               	str	w1, [sp, #0x114]
               	str	w2, [sp, #0x118]
               	str	w3, [sp, #0x11c]
               	str	w4, [sp, #0x120]
               	str	w5, [sp, #0x124]
               	str	w6, [sp, #0x128]
               	str	w7, [sp, #0x12c]
               	ldrsw	x8, [sp, #0x130]
               	add	x0, x8, x0
               	ldrsw	x8, [sp, #0x134]
               	add	x1, x8, x1
               	ldrsw	x8, [sp, #0x138]
               	add	x2, x8, x2
               	ldrsw	x8, [sp, #0x13c]
               	add	x3, x8, x3
               	ldrsw	x8, [sp, #0x140]
               	add	x4, x8, x4
               	ldrsw	x8, [sp, #0x144]
               	add	x5, x8, x5
               	ldrsw	x8, [sp, #0x148]
               	add	x6, x8, x6
               	ldrsw	x8, [sp, #0x14c]
               	add	x7, x8, x7
               	str	w0, [sp, #0x130]
               	str	w1, [sp, #0x134]
               	str	w2, [sp, #0x138]
               	str	w3, [sp, #0x13c]
               	str	w4, [sp, #0x140]
               	str	w5, [sp, #0x144]
               	str	w6, [sp, #0x148]
               	str	w7, [sp, #0x14c]
               	ldr	x0, [sp, #0x150]
               	ldr	x1, [sp, #0x130]
               	eor	x0, x0, x1
               	ldr	x1, [sp, #0x158]
               	ldr	x2, [sp, #0x138]
               	eor	x1, x1, x2
               	ldr	x2, [sp, #0x160]
               	ldr	x3, [sp, #0x140]
               	eor	x2, x2, x3
               	ldr	x3, [sp, #0x168]
               	ldr	x4, [sp, #0x148]
               	eor	x3, x3, x4
               	str	x0, [sp, #0x150]
               	str	x1, [sp, #0x158]
               	str	x2, [sp, #0x160]
               	str	x3, [sp, #0x168]
               	ldrsw	x0, [sp, #0x170]
               	ldrsw	x1, [sp, #0x150]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x174]
               	ldrsw	x2, [sp, #0x154]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x178]
               	ldrsw	x3, [sp, #0x158]
               	add	x2, x2, x3
               	ldrsw	x3, [sp, #0x17c]
               	ldrsw	x4, [sp, #0x15c]
               	add	x3, x3, x4
               	ldrsw	x4, [sp, #0x180]
               	ldrsw	x5, [sp, #0x160]
               	add	x4, x4, x5
               	ldrsw	x5, [sp, #0x184]
               	ldrsw	x6, [sp, #0x164]
               	add	x5, x5, x6
               	ldrsw	x6, [sp, #0x188]
               	ldrsw	x7, [sp, #0x168]
               	add	x6, x6, x7
               	ldrsw	x7, [sp, #0x18c]
               	ldrsw	x8, [sp, #0x16c]
               	add	x7, x7, x8
               	str	w0, [sp, #0x170]
               	str	w1, [sp, #0x174]
               	str	w2, [sp, #0x178]
               	str	w3, [sp, #0x17c]
               	str	w4, [sp, #0x180]
               	str	w5, [sp, #0x184]
               	str	w6, [sp, #0x188]
               	str	w7, [sp, #0x18c]
               	ldrsw	x8, [sp, #0x190]
               	sub	x0, x8, x0
               	ldrsw	x8, [sp, #0x194]
               	sub	x1, x8, x1
               	ldrsw	x8, [sp, #0x198]
               	sub	x2, x8, x2
               	ldrsw	x8, [sp, #0x19c]
               	sub	x3, x8, x3
               	ldrsw	x8, [sp, #0x1a0]
               	sub	x4, x8, x4
               	ldrsw	x8, [sp, #0x1a4]
               	sub	x5, x8, x5
               	ldrsw	x8, [sp, #0x1a8]
               	sub	x6, x8, x6
               	ldrsw	x8, [sp, #0x1ac]
               	sub	x7, x8, x7
               	str	w0, [sp, #0x190]
               	str	w1, [sp, #0x194]
               	str	w2, [sp, #0x198]
               	str	w3, [sp, #0x19c]
               	str	w4, [sp, #0x1a0]
               	str	w5, [sp, #0x1a4]
               	str	w6, [sp, #0x1a8]
               	str	w7, [sp, #0x1ac]
               	ldrsw	x8, [sp, #0x1b0]
               	add	x0, x8, x0
               	ldrsw	x8, [sp, #0x1b4]
               	add	x1, x8, x1
               	ldrsw	x8, [sp, #0x1b8]
               	add	x2, x8, x2
               	ldrsw	x8, [sp, #0x1bc]
               	add	x3, x8, x3
               	ldrsw	x8, [sp, #0x1c0]
               	add	x4, x8, x4
               	ldrsw	x8, [sp, #0x1c4]
               	add	x5, x8, x5
               	ldrsw	x8, [sp, #0x1c8]
               	add	x6, x8, x6
               	ldrsw	x8, [sp, #0x1cc]
               	add	x7, x8, x7
               	str	w0, [sp, #0x1b0]
               	str	w1, [sp, #0x1b4]
               	str	w2, [sp, #0x1b8]
               	str	w3, [sp, #0x1bc]
               	str	w4, [sp, #0x1c0]
               	str	w5, [sp, #0x1c4]
               	str	w6, [sp, #0x1c8]
               	str	w7, [sp, #0x1cc]
               	ldr	x0, [sp, #0x1d0]
               	ldr	x1, [sp, #0x1b0]
               	eor	x0, x0, x1
               	ldr	x1, [sp, #0x1d8]
               	ldr	x2, [sp, #0x1b8]
               	eor	x1, x1, x2
               	ldr	x2, [sp, #0x1e0]
               	ldr	x3, [sp, #0x1c0]
               	eor	x2, x2, x3
               	ldr	x3, [sp, #0x1e8]
               	ldr	x4, [sp, #0x1c8]
               	eor	x3, x3, x4
               	str	x0, [sp, #0x1d0]
               	str	x1, [sp, #0x1d8]
               	str	x2, [sp, #0x1e0]
               	str	x3, [sp, #0x1e8]
               	add	x20, x20, #0x1
               	cmp	w20, #0xa
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
               	sub	x1, x29, #0x800
               	ldrsw	x1, [x1, x2, lsl #2]
               	add	x0, x0, x1
               	str	w0, [x4, x2, lsl #2]
               	mov	x0, #0x1                // =1
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
               	str	w1, [x5, x2, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x12
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x8
               	b.lt	<addr>
               	add	x8, x8, #0x1
               	cmp	w8, #0xa
               	b.lt	<addr>
               	sub	x3, x29, #0x6c0
               	mov	x16, x3
               	add	x17, x16, #0x240
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	sub	x0, x29, #0x480
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x0, x29, #0x460
               	add	x1, x3, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x440
               	add	x1, x3, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x420
               	add	x1, x3, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x8a0
               	add	x1, x3, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x880
               	add	x1, x3, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x860
               	add	x1, x3, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x840
               	add	x1, x3, #0xe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x820
               	add	x1, x3, #0x100
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x7e0
               	add	x1, x3, #0x120
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x7c0
               	add	x1, x3, #0x140
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x7a0
               	add	x1, x3, #0x160
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x780
               	add	x1, x3, #0x180
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x760
               	add	x1, x3, #0x1a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x740
               	add	x1, x3, #0x1c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x720
               	add	x1, x3, #0x1e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x700
               	add	x1, x3, #0x200
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x6e0
               	add	x1, x3, #0x220
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	lsl	x2, x0, #5
               	add	x1, x3, x2
               	ldrsw	x4, [x1]
               	sub	x1, x29, #0x240
               	add	x1, x1, x2
               	ldrsw	x5, [x1]
               	cmp	w4, w5
               	b.ne	<addr>
               	sub	x4, x29, #0x6c0
               	add	x2, x4, x2
               	ldrsw	x4, [x2, #0x4]
               	ldrsw	x5, [x1, #0x4]
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0x8]
               	ldrsw	x5, [x1, #0x8]
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0xc]
               	ldrsw	x1, [x1, #0xc]
               	cmp	w4, w1
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0x10]
               	sub	x1, x29, #0x240
               	lsl	x2, x0, #5
               	add	x1, x1, x2
               	ldrsw	x5, [x1, #0x10]
               	cmp	w4, w5
               	b.ne	<addr>
               	sub	x4, x29, #0x6c0
               	add	x2, x4, x2
               	ldrsw	x4, [x2, #0x14]
               	ldrsw	x5, [x1, #0x14]
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0x18]
               	ldrsw	x5, [x1, #0x18]
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrsw	x2, [x2, #0x1c]
               	ldrsw	x1, [x1, #0x1c]
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x12
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x30]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1e               // =30
               	cmp	w0, #0x2d
               	csel	x0, x1, x2, eq
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0xa
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
