
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
               	sub	sp, sp, #0xd0
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	sub	x0, x29, #0xd0
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0xb0
               	ldur	x1, [x29, #-0x20]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x90
               	ldursb	x1, [x29, #-0xd0]
               	ldursb	x2, [x29, #-0xb0]
               	add	x1, x1, x2
               	sturb	w1, [x29, #-0x90]
               	ldursb	x1, [x29, #-0xcf]
               	ldursb	x2, [x29, #-0xaf]
               	add	x1, x1, x2
               	sturb	w1, [x29, #-0x8f]
               	ldursb	x1, [x29, #-0xce]
               	ldursb	x2, [x29, #-0xae]
               	add	x1, x1, x2
               	sturb	w1, [x29, #-0x8e]
               	ldursb	x1, [x29, #-0xcd]
               	ldursb	x2, [x29, #-0xad]
               	add	x1, x1, x2
               	sturb	w1, [x29, #-0x8d]
               	ldursb	x1, [x29, #-0xcc]
               	ldursb	x2, [x29, #-0xac]
               	add	x1, x1, x2
               	sturb	w1, [x29, #-0x8c]
               	ldursb	x1, [x29, #-0xcb]
               	ldursb	x2, [x29, #-0xab]
               	add	x1, x1, x2
               	sturb	w1, [x29, #-0x8b]
               	ldursb	x1, [x29, #-0xca]
               	ldursb	x2, [x29, #-0xaa]
               	add	x1, x1, x2
               	sturb	w1, [x29, #-0x8a]
               	ldursb	x1, [x29, #-0xc9]
               	ldursb	x2, [x29, #-0xa9]
               	add	x1, x1, x2
               	sturb	w1, [x29, #-0x89]
               	ldursb	x1, [x29, #-0xc8]
               	ldursb	x2, [x29, #-0xa8]
               	add	x2, x1, x2
               	add	x1, x0, #0x8
               	strb	w2, [x1]
               	ldursb	x2, [x29, #-0xc7]
               	ldursb	x3, [x29, #-0xa7]
               	add	x2, x2, x3
               	sturb	w2, [x29, #-0x87]
               	ldursb	x2, [x29, #-0xc6]
               	ldursb	x3, [x29, #-0xa6]
               	add	x2, x2, x3
               	sturb	w2, [x29, #-0x86]
               	ldursb	x2, [x29, #-0xc5]
               	ldursb	x3, [x29, #-0xa5]
               	add	x2, x2, x3
               	sturb	w2, [x29, #-0x85]
               	ldursb	x2, [x29, #-0xc4]
               	ldursb	x3, [x29, #-0xa4]
               	add	x2, x2, x3
               	sturb	w2, [x29, #-0x84]
               	ldursb	x2, [x29, #-0xc3]
               	ldursb	x3, [x29, #-0xa3]
               	add	x2, x2, x3
               	sturb	w2, [x29, #-0x83]
               	ldursb	x2, [x29, #-0xc2]
               	ldursb	x3, [x29, #-0xa2]
               	add	x2, x2, x3
               	sturb	w2, [x29, #-0x82]
               	ldursb	x2, [x29, #-0xc1]
               	ldursb	x3, [x29, #-0xa1]
               	add	x2, x2, x3
               	sturb	w2, [x29, #-0x81]
               	ldursb	x2, [x29, #-0xc0]
               	ldursb	x3, [x29, #-0xa0]
               	add	x3, x2, x3
               	add	x2, x0, #0x10
               	strb	w3, [x2]
               	ldursb	x3, [x29, #-0xbf]
               	ldursb	x4, [x29, #-0x9f]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x7f]
               	ldursb	x3, [x29, #-0xbe]
               	ldursb	x4, [x29, #-0x9e]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x7e]
               	ldursb	x3, [x29, #-0xbd]
               	ldursb	x4, [x29, #-0x9d]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x7d]
               	ldursb	x3, [x29, #-0xbc]
               	ldursb	x4, [x29, #-0x9c]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x7c]
               	ldursb	x3, [x29, #-0xbb]
               	ldursb	x4, [x29, #-0x9b]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x7b]
               	ldursb	x3, [x29, #-0xba]
               	ldursb	x4, [x29, #-0x9a]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x7a]
               	ldursb	x3, [x29, #-0xb9]
               	ldursb	x4, [x29, #-0x99]
               	add	x3, x3, x4
               	sturb	w3, [x29, #-0x79]
               	ldursb	x3, [x29, #-0xb8]
               	ldursb	x4, [x29, #-0x98]
               	add	x4, x3, x4
               	add	x3, x0, #0x18
               	strb	w4, [x3]
               	ldursb	x0, [x29, #-0xb7]
               	ldursb	x4, [x29, #-0x97]
               	add	x0, x0, x4
               	sturb	w0, [x29, #-0x77]
               	ldursb	x0, [x29, #-0xb6]
               	ldursb	x4, [x29, #-0x96]
               	add	x0, x0, x4
               	sturb	w0, [x29, #-0x76]
               	ldursb	x0, [x29, #-0xb5]
               	ldursb	x4, [x29, #-0x95]
               	add	x0, x0, x4
               	sturb	w0, [x29, #-0x75]
               	ldursb	x0, [x29, #-0xb4]
               	ldursb	x4, [x29, #-0x94]
               	add	x0, x0, x4
               	sturb	w0, [x29, #-0x74]
               	ldursb	x0, [x29, #-0xb3]
               	ldursb	x4, [x29, #-0x93]
               	add	x0, x0, x4
               	sturb	w0, [x29, #-0x73]
               	ldursb	x0, [x29, #-0xb2]
               	ldursb	x4, [x29, #-0x92]
               	add	x0, x0, x4
               	sturb	w0, [x29, #-0x72]
               	ldursb	x0, [x29, #-0xb1]
               	ldursb	x4, [x29, #-0x91]
               	add	x0, x0, x4
               	sturb	w0, [x29, #-0x71]
               	sub	x0, x29, #0x70
               	ldursb	x4, [x29, #-0xd0]
               	ldursb	x5, [x29, #-0xb0]
               	sub	x4, x4, x5
               	sturb	w4, [x29, #-0x70]
               	ldursb	x4, [x29, #-0xcf]
               	ldursb	x5, [x29, #-0xaf]
               	sub	x4, x4, x5
               	sturb	w4, [x29, #-0x6f]
               	ldursb	x4, [x29, #-0xce]
               	ldursb	x5, [x29, #-0xae]
               	sub	x4, x4, x5
               	sturb	w4, [x29, #-0x6e]
               	ldursb	x4, [x29, #-0xcd]
               	ldursb	x5, [x29, #-0xad]
               	sub	x4, x4, x5
               	sturb	w4, [x29, #-0x6d]
               	ldursb	x4, [x29, #-0xcc]
               	ldursb	x5, [x29, #-0xac]
               	sub	x4, x4, x5
               	sturb	w4, [x29, #-0x6c]
               	ldursb	x4, [x29, #-0xcb]
               	ldursb	x5, [x29, #-0xab]
               	sub	x4, x4, x5
               	sturb	w4, [x29, #-0x6b]
               	ldursb	x4, [x29, #-0xca]
               	ldursb	x5, [x29, #-0xaa]
               	sub	x4, x4, x5
               	sturb	w4, [x29, #-0x6a]
               	ldursb	x4, [x29, #-0xc9]
               	ldursb	x5, [x29, #-0xa9]
               	sub	x4, x4, x5
               	sturb	w4, [x29, #-0x69]
               	ldursb	x4, [x29, #-0xc8]
               	ldursb	x5, [x29, #-0xa8]
               	sub	x5, x4, x5
               	add	x4, x0, #0x8
               	strb	w5, [x4]
               	ldursb	x5, [x29, #-0xc7]
               	ldursb	x6, [x29, #-0xa7]
               	sub	x5, x5, x6
               	sturb	w5, [x29, #-0x67]
               	ldursb	x5, [x29, #-0xc6]
               	ldursb	x6, [x29, #-0xa6]
               	sub	x5, x5, x6
               	sturb	w5, [x29, #-0x66]
               	ldursb	x5, [x29, #-0xc5]
               	ldursb	x6, [x29, #-0xa5]
               	sub	x5, x5, x6
               	sturb	w5, [x29, #-0x65]
               	ldursb	x5, [x29, #-0xc4]
               	ldursb	x6, [x29, #-0xa4]
               	sub	x5, x5, x6
               	sturb	w5, [x29, #-0x64]
               	ldursb	x5, [x29, #-0xc3]
               	ldursb	x6, [x29, #-0xa3]
               	sub	x5, x5, x6
               	sturb	w5, [x29, #-0x63]
               	ldursb	x5, [x29, #-0xc2]
               	ldursb	x6, [x29, #-0xa2]
               	sub	x5, x5, x6
               	sturb	w5, [x29, #-0x62]
               	ldursb	x5, [x29, #-0xc1]
               	ldursb	x6, [x29, #-0xa1]
               	sub	x5, x5, x6
               	sturb	w5, [x29, #-0x61]
               	ldursb	x5, [x29, #-0xc0]
               	ldursb	x6, [x29, #-0xa0]
               	sub	x6, x5, x6
               	add	x5, x0, #0x10
               	strb	w6, [x5]
               	ldursb	x6, [x29, #-0xbf]
               	ldursb	x7, [x29, #-0x9f]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x5f]
               	ldursb	x6, [x29, #-0xbe]
               	ldursb	x7, [x29, #-0x9e]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x5e]
               	ldursb	x6, [x29, #-0xbd]
               	ldursb	x7, [x29, #-0x9d]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x5d]
               	ldursb	x6, [x29, #-0xbc]
               	ldursb	x7, [x29, #-0x9c]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x5c]
               	ldursb	x6, [x29, #-0xbb]
               	ldursb	x7, [x29, #-0x9b]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x5b]
               	ldursb	x6, [x29, #-0xba]
               	ldursb	x7, [x29, #-0x9a]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x5a]
               	ldursb	x6, [x29, #-0xb9]
               	ldursb	x7, [x29, #-0x99]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x59]
               	ldursb	x6, [x29, #-0xb8]
               	ldursb	x7, [x29, #-0x98]
               	sub	x6, x6, x7
               	add	x0, x0, #0x18
               	strb	w6, [x0]
               	ldursb	x6, [x29, #-0xb7]
               	ldursb	x7, [x29, #-0x97]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x57]
               	ldursb	x6, [x29, #-0xb6]
               	ldursb	x7, [x29, #-0x96]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x56]
               	ldursb	x6, [x29, #-0xb5]
               	ldursb	x7, [x29, #-0x95]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x55]
               	ldursb	x6, [x29, #-0xb4]
               	ldursb	x7, [x29, #-0x94]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x54]
               	ldursb	x6, [x29, #-0xb3]
               	ldursb	x7, [x29, #-0x93]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x53]
               	ldursb	x6, [x29, #-0xb2]
               	ldursb	x7, [x29, #-0x92]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x52]
               	ldursb	x6, [x29, #-0xb1]
               	ldursb	x7, [x29, #-0x91]
               	sub	x6, x6, x7
               	sturb	w6, [x29, #-0x51]
               	ldur	x6, [x29, #-0x90]
               	ldur	x7, [x29, #-0x70]
               	eor	x6, x6, x7
               	ldr	x1, [x1]
               	ldr	x4, [x4]
               	eor	x1, x1, x4
               	ldr	x2, [x2]
               	ldr	x4, [x5]
               	eor	x2, x2, x4
               	ldr	x3, [x3]
               	ldr	x0, [x0]
               	eor	x3, x3, x0
               	ldur	x0, [x29, #-0xd0]
               	ldur	x4, [x29, #-0xb0]
               	and	x4, x0, x4
               	ldur	x0, [x29, #-0xc8]
               	ldur	x5, [x29, #-0xa8]
               	and	x5, x0, x5
               	ldur	x0, [x29, #-0xc0]
               	ldur	x7, [x29, #-0xa0]
               	and	x7, x0, x7
               	ldur	x0, [x29, #-0xb8]
               	ldur	x8, [x29, #-0x98]
               	and	x8, x0, x8
               	sub	x0, x29, #0x50
               	orr	x4, x6, x4
               	stur	x4, [x29, #-0x50]
               	orr	x1, x1, x5
               	stur	x1, [x29, #-0x48]
               	orr	x1, x2, x7
               	stur	x1, [x29, #-0x40]
               	orr	x1, x3, x8
               	stur	x1, [x29, #-0x38]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret

<s_ops>:
               	stp	x20, x21, [sp, #-0x170]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x160]
               	add	x29, sp, #0x160
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	ldur	x0, [x29, #-0x30]
               	ldrh	w1, [x0]
               	ldrh	w2, [x0, #0x2]
               	ldrh	w4, [x0, #0x4]
               	ldrh	w6, [x0, #0x6]
               	ldrh	w8, [x0, #0x8]
               	ldrh	w10, [x0, #0xa]
               	ldrh	w12, [x0, #0xc]
               	ldrh	w14, [x0, #0xe]
               	ldrh	w20, [x0, #0x10]
               	ldrh	w22, [x0, #0x12]
               	ldrh	w24, [x0, #0x14]
               	ldrh	w26, [x0, #0x16]
               	ldrh	w28, [x0, #0x18]
               	ldrh	w17, [x0, #0x1a]
               	str	x17, [sp, #0x120]
               	ldrh	w17, [x0, #0x1c]
               	str	x17, [sp, #0x110]
               	ldrh	w17, [x0, #0x1e]
               	str	x17, [sp, #0x100]
               	ldur	x0, [x29, #-0x20]
               	ldrh	w3, [x0]
               	ldrh	w5, [x0, #0x2]
               	ldrh	w7, [x0, #0x4]
               	ldrh	w9, [x0, #0x6]
               	ldrh	w11, [x0, #0x8]
               	ldrh	w13, [x0, #0xa]
               	ldrh	w15, [x0, #0xc]
               	ldrh	w21, [x0, #0xe]
               	ldrh	w23, [x0, #0x10]
               	ldrh	w25, [x0, #0x12]
               	ldrh	w27, [x0, #0x14]
               	ldrh	w17, [x0, #0x16]
               	str	x17, [sp, #0x128]
               	ldrh	w17, [x0, #0x18]
               	str	x17, [sp, #0x118]
               	ldrh	w17, [x0, #0x1a]
               	str	x17, [sp, #0x108]
               	ldrh	w17, [x0, #0x1c]
               	str	x17, [sp, #0xf8]
               	ldrh	w17, [x0, #0x1e]
               	str	x17, [sp, #0xf0]
               	sxth	x0, w1
               	sxth	x1, w3
               	mul	x16, x0, x1
               	str	x16, [sp, #0xe8]
               	sxth	x2, w2
               	sxth	x3, w5
               	mul	x16, x2, x3
               	str	x16, [sp, #0xe0]
               	sxth	x4, w4
               	sxth	x5, w7
               	mul	x16, x4, x5
               	str	x16, [sp, #0xd8]
               	sxth	x6, w6
               	sxth	x7, w9
               	mul	x16, x6, x7
               	str	x16, [sp, #0xd0]
               	sxth	x8, w8
               	sxth	x9, w11
               	mul	x16, x8, x9
               	str	x16, [sp, #0xc8]
               	sxth	x10, w10
               	sxth	x11, w13
               	mul	x16, x10, x11
               	str	x16, [sp, #0xc0]
               	sxth	x12, w12
               	sxth	x13, w15
               	mul	x16, x12, x13
               	str	x16, [sp, #0xb8]
               	sxth	x14, w14
               	sxth	x15, w21
               	mul	x16, x14, x15
               	str	x16, [sp, #0xb0]
               	sxth	x20, w20
               	sxth	x21, w23
               	mul	x16, x20, x21
               	str	x16, [sp, #0xa8]
               	sxth	x22, w22
               	sxth	x23, w25
               	mul	x16, x22, x23
               	str	x16, [sp, #0xa0]
               	sxth	x24, w24
               	sxth	x25, w27
               	mul	x16, x24, x25
               	str	x16, [sp, #0x98]
               	sxth	x26, w26
               	ldr	x16, [sp, #0x128]
               	sxth	x27, w16
               	mul	x16, x26, x27
               	str	x16, [sp, #0x90]
               	sxth	x28, w28
               	ldr	x16, [sp, #0x118]
               	sxth	x16, w16
               	str	x16, [sp, #0x128]
               	ldr	x17, [sp, #0x128]
               	mul	x16, x28, x17
               	str	x16, [sp, #0x88]
               	ldr	x16, [sp, #0x120]
               	sxth	x16, w16
               	str	x16, [sp, #0x120]
               	ldr	x16, [sp, #0x108]
               	sxth	x16, w16
               	str	x16, [sp, #0x118]
               	ldr	x16, [sp, #0x120]
               	ldr	x17, [sp, #0x118]
               	mul	x16, x16, x17
               	str	x16, [sp, #0x80]
               	ldr	x16, [sp, #0x110]
               	sxth	x16, w16
               	str	x16, [sp, #0x110]
               	ldr	x16, [sp, #0xf8]
               	sxth	x16, w16
               	str	x16, [sp, #0x108]
               	ldr	x16, [sp, #0x110]
               	ldr	x17, [sp, #0x108]
               	mul	x16, x16, x17
               	str	x16, [sp, #0x78]
               	ldr	x16, [sp, #0x100]
               	sxth	x16, w16
               	str	x16, [sp, #0x100]
               	ldr	x16, [sp, #0xf0]
               	sxth	x16, w16
               	str	x16, [sp, #0xf8]
               	ldr	x16, [sp, #0x100]
               	ldr	x17, [sp, #0xf8]
               	mul	x16, x16, x17
               	str	x16, [sp, #0xf0]
               	sub	x1, x0, x1
               	sub	x2, x2, x3
               	sub	x3, x4, x5
               	sub	x4, x6, x7
               	sub	x5, x8, x9
               	sub	x6, x10, x11
               	sub	x7, x12, x13
               	sub	x8, x14, x15
               	sub	x9, x20, x21
               	sub	x10, x22, x23
               	sub	x11, x24, x25
               	sub	x12, x26, x27
               	ldr	x17, [sp, #0x128]
               	sub	x13, x28, x17
               	ldr	x16, [sp, #0x120]
               	ldr	x17, [sp, #0x118]
               	sub	x14, x16, x17
               	ldr	x16, [sp, #0x110]
               	ldr	x17, [sp, #0x108]
               	sub	x15, x16, x17
               	ldr	x16, [sp, #0x100]
               	ldr	x17, [sp, #0xf8]
               	sub	x0, x16, x17
               	sub	x20, x29, #0x110
               	ldr	x16, [sp, #0xe8]
               	sxth	x21, w16
               	sxth	x1, w1
               	add	x1, x21, x1
               	strh	w1, [sp, #0x50]
               	ldr	x16, [sp, #0xe0]
               	sxth	x1, w16
               	sxth	x2, w2
               	add	x1, x1, x2
               	strh	w1, [sp, #0x52]
               	ldr	x16, [sp, #0xd8]
               	sxth	x1, w16
               	sxth	x2, w3
               	add	x1, x1, x2
               	strh	w1, [sp, #0x54]
               	ldr	x16, [sp, #0xd0]
               	sxth	x1, w16
               	sxth	x2, w4
               	add	x1, x1, x2
               	strh	w1, [sp, #0x56]
               	ldr	x16, [sp, #0xc8]
               	sxth	x1, w16
               	sxth	x2, w5
               	add	x1, x1, x2
               	strh	w1, [sp, #0x58]
               	ldr	x16, [sp, #0xc0]
               	sxth	x1, w16
               	sxth	x2, w6
               	add	x1, x1, x2
               	strh	w1, [sp, #0x5a]
               	ldr	x16, [sp, #0xb8]
               	sxth	x1, w16
               	sxth	x2, w7
               	add	x1, x1, x2
               	strh	w1, [sp, #0x5c]
               	ldr	x16, [sp, #0xb0]
               	sxth	x1, w16
               	sxth	x2, w8
               	add	x1, x1, x2
               	strh	w1, [sp, #0x5e]
               	ldr	x16, [sp, #0xa8]
               	sxth	x1, w16
               	sxth	x2, w9
               	add	x1, x1, x2
               	sturh	w1, [x29, #-0x100]
               	ldr	x16, [sp, #0xa0]
               	sxth	x1, w16
               	sxth	x2, w10
               	add	x1, x1, x2
               	sturh	w1, [x29, #-0xfe]
               	ldr	x16, [sp, #0x98]
               	sxth	x1, w16
               	sxth	x2, w11
               	add	x1, x1, x2
               	sturh	w1, [x29, #-0xfc]
               	ldr	x16, [sp, #0x90]
               	sxth	x1, w16
               	sxth	x2, w12
               	add	x1, x1, x2
               	sturh	w1, [x29, #-0xfa]
               	ldr	x16, [sp, #0x88]
               	sxth	x1, w16
               	sxth	x2, w13
               	add	x1, x1, x2
               	sturh	w1, [x29, #-0xf8]
               	ldr	x16, [sp, #0x80]
               	sxth	x1, w16
               	sxth	x2, w14
               	add	x1, x1, x2
               	sturh	w1, [x29, #-0xf6]
               	ldr	x16, [sp, #0x78]
               	sxth	x1, w16
               	sxth	x2, w15
               	add	x1, x1, x2
               	sturh	w1, [x29, #-0xf4]
               	ldr	x16, [sp, #0xf0]
               	sxth	x1, w16
               	sxth	x0, w0
               	add	x0, x1, x0
               	sturh	w0, [x29, #-0xf2]
               	mov	x16, x20
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	ldp	x29, x30, [sp, #0x160]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x170
               	ret

<i_ops>:
               	stp	x20, x21, [sp, #-0xd0]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	ldur	x0, [x29, #-0x30]
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldur	x0, [x29, #-0x20]
               	ldr	w9, [x0]
               	ldr	w10, [x0, #0x4]
               	ldr	w11, [x0, #0x8]
               	ldr	w12, [x0, #0xc]
               	ldr	w13, [x0, #0x10]
               	ldr	w14, [x0, #0x14]
               	ldr	w15, [x0, #0x18]
               	ldr	w20, [x0, #0x1c]
               	sub	x0, x29, #0x90
               	add	x21, x1, x9
               	stur	w21, [x29, #-0x90]
               	add	x21, x2, x10
               	stur	w21, [x29, #-0x8c]
               	add	x22, x3, x11
               	add	x21, x0, #0x8
               	str	w22, [x21]
               	add	x22, x4, x12
               	stur	w22, [x29, #-0x84]
               	add	x23, x5, x13
               	add	x22, x0, #0x10
               	str	w23, [x22]
               	add	x23, x6, x14
               	stur	w23, [x29, #-0x7c]
               	add	x24, x7, x15
               	add	x23, x0, #0x18
               	str	w24, [x23]
               	add	x0, x8, x20
               	stur	w0, [x29, #-0x74]
               	sub	x0, x29, #0x70
               	sub	x1, x1, x9
               	stur	w1, [x29, #-0x70]
               	sub	x1, x2, x10
               	stur	w1, [x29, #-0x6c]
               	sub	x2, x3, x11
               	add	x1, x0, #0x8
               	str	w2, [x1]
               	sub	x2, x4, x12
               	stur	w2, [x29, #-0x64]
               	sub	x3, x5, x13
               	add	x2, x0, #0x10
               	str	w3, [x2]
               	sub	x3, x6, x14
               	stur	w3, [x29, #-0x5c]
               	sub	x4, x7, x15
               	add	x3, x0, #0x18
               	str	w4, [x3]
               	sub	x0, x8, x20
               	stur	w0, [x29, #-0x54]
               	sub	x0, x29, #0x50
               	ldur	x4, [x29, #-0x90]
               	ldur	x5, [x29, #-0x70]
               	eor	x4, x4, x5
               	stur	x4, [x29, #-0x50]
               	ldr	x4, [x21]
               	ldr	x1, [x1]
               	eor	x1, x4, x1
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x22]
               	ldr	x2, [x2]
               	eor	x1, x1, x2
               	stur	x1, [x29, #-0x40]
               	ldr	x1, [x23]
               	ldr	x2, [x3]
               	eor	x1, x1, x2
               	stur	x1, [x29, #-0x38]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret

<u_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	sub	x0, x29, #0xb0
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x90
               	ldur	x1, [x29, #-0x20]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x70
               	ldur	w1, [x29, #-0xb0]
               	ldur	w2, [x29, #-0x90]
               	sub	x1, x1, x2
               	stur	w1, [x29, #-0x70]
               	ldur	w1, [x29, #-0xac]
               	ldur	w2, [x29, #-0x8c]
               	sub	x1, x1, x2
               	stur	w1, [x29, #-0x6c]
               	ldur	w1, [x29, #-0xa8]
               	ldur	w2, [x29, #-0x88]
               	sub	x2, x1, x2
               	add	x1, x0, #0x8
               	str	w2, [x1]
               	ldur	w2, [x29, #-0xa4]
               	ldur	w3, [x29, #-0x84]
               	sub	x2, x2, x3
               	stur	w2, [x29, #-0x64]
               	ldur	w2, [x29, #-0xa0]
               	ldur	w3, [x29, #-0x80]
               	sub	x3, x2, x3
               	add	x2, x0, #0x10
               	str	w3, [x2]
               	ldur	w3, [x29, #-0x9c]
               	ldur	w4, [x29, #-0x7c]
               	sub	x3, x3, x4
               	stur	w3, [x29, #-0x5c]
               	ldur	w3, [x29, #-0x98]
               	ldur	w4, [x29, #-0x78]
               	sub	x4, x3, x4
               	add	x3, x0, #0x18
               	str	w4, [x3]
               	ldur	w0, [x29, #-0x94]
               	ldur	w4, [x29, #-0x74]
               	sub	x0, x0, x4
               	stur	w0, [x29, #-0x54]
               	ldur	x0, [x29, #-0xb0]
               	ldur	x4, [x29, #-0x90]
               	orr	x4, x0, x4
               	ldur	x0, [x29, #-0xa8]
               	ldur	x5, [x29, #-0x88]
               	orr	x5, x0, x5
               	ldur	x0, [x29, #-0xa0]
               	ldur	x6, [x29, #-0x80]
               	orr	x6, x0, x6
               	ldur	x0, [x29, #-0x98]
               	ldur	x7, [x29, #-0x78]
               	orr	x7, x0, x7
               	sub	x0, x29, #0x50
               	ldur	x8, [x29, #-0x70]
               	eor	x4, x8, x4
               	stur	x4, [x29, #-0x50]
               	ldr	x1, [x1]
               	eor	x1, x1, x5
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x2]
               	eor	x1, x1, x6
               	stur	x1, [x29, #-0x40]
               	ldr	x1, [x3]
               	eor	x1, x1, x7
               	stur	x1, [x29, #-0x38]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<l_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	ldur	x0, [x29, #-0x30]
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldur	x0, [x29, #-0x20]
               	ldr	x5, [x0]
               	ldr	x6, [x0, #0x8]
               	ldr	x7, [x0, #0x10]
               	ldr	x0, [x0, #0x18]
               	add	x8, x1, x5
               	add	x9, x2, x6
               	add	x10, x3, x7
               	add	x11, x4, x0
               	and	x1, x1, x5
               	and	x2, x2, x6
               	and	x3, x3, x7
               	and	x4, x4, x0
               	sub	x0, x29, #0x50
               	sub	x1, x8, x1
               	stur	x1, [x29, #-0x50]
               	sub	x1, x9, x2
               	stur	x1, [x29, #-0x48]
               	sub	x1, x10, x3
               	stur	x1, [x29, #-0x40]
               	sub	x1, x11, x4
               	stur	x1, [x29, #-0x38]
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

<f_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	sub	x0, x29, #0x90
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x70
               	ldur	x1, [x29, #-0x20]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldur	s0, [x29, #-0x90]
               	ldur	s1, [x29, #-0x70]
               	ldur	s2, [x29, #-0x8c]
               	ldur	s3, [x29, #-0x6c]
               	ldur	s4, [x29, #-0x88]
               	ldur	s5, [x29, #-0x68]
               	ldur	s6, [x29, #-0x84]
               	ldur	s7, [x29, #-0x64]
               	ldur	s19, [x29, #-0x80]
               	ldur	s20, [x29, #-0x60]
               	ldur	s21, [x29, #-0x7c]
               	ldur	s22, [x29, #-0x5c]
               	ldur	s23, [x29, #-0x78]
               	ldur	s24, [x29, #-0x58]
               	ldur	s25, [x29, #-0x74]
               	ldur	s26, [x29, #-0x54]
               	ldur	s27, [x29, #-0x90]
               	fmadd	s0, s0, s1, s27
               	ldur	s1, [x29, #-0x8c]
               	fmadd	s1, s2, s3, s1
               	ldur	s2, [x29, #-0x88]
               	fmadd	s2, s4, s5, s2
               	ldur	s3, [x29, #-0x84]
               	fmadd	s3, s6, s7, s3
               	ldur	s4, [x29, #-0x80]
               	fmadd	s4, s19, s20, s4
               	ldur	s5, [x29, #-0x7c]
               	fmadd	s5, s21, s22, s5
               	ldur	s6, [x29, #-0x78]
               	fmadd	s6, s23, s24, s6
               	ldur	s7, [x29, #-0x74]
               	fmadd	s7, s25, s26, s7
               	ldur	s19, [x29, #-0x70]
               	ldur	s20, [x29, #-0x90]
               	fsub	s19, s19, s20
               	ldur	s20, [x29, #-0x6c]
               	ldur	s21, [x29, #-0x8c]
               	fsub	s20, s20, s21
               	ldur	s21, [x29, #-0x68]
               	ldur	s22, [x29, #-0x88]
               	fsub	s21, s21, s22
               	ldur	s22, [x29, #-0x64]
               	ldur	s23, [x29, #-0x84]
               	fsub	s22, s22, s23
               	ldur	s23, [x29, #-0x60]
               	ldur	s24, [x29, #-0x80]
               	fsub	s23, s23, s24
               	ldur	s24, [x29, #-0x5c]
               	ldur	s25, [x29, #-0x7c]
               	fsub	s24, s24, s25
               	ldur	s25, [x29, #-0x58]
               	ldur	s26, [x29, #-0x78]
               	fsub	s25, s25, s26
               	ldur	s26, [x29, #-0x54]
               	ldur	s27, [x29, #-0x74]
               	fsub	s26, s26, s27
               	sub	x0, x29, #0x50
               	fdiv	s0, s0, s19
               	stur	s0, [x29, #-0x50]
               	fdiv	s0, s1, s20
               	stur	s0, [x29, #-0x4c]
               	fdiv	s0, s2, s21
               	stur	s0, [x29, #-0x48]
               	fdiv	s0, s3, s22
               	stur	s0, [x29, #-0x44]
               	fdiv	s0, s4, s23
               	stur	s0, [x29, #-0x40]
               	fdiv	s0, s5, s24
               	stur	s0, [x29, #-0x3c]
               	fdiv	s0, s6, s25
               	stur	s0, [x29, #-0x38]
               	fdiv	s0, s7, s26
               	stur	s0, [x29, #-0x34]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret

<d_ops>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x20]
               	sub	x0, x29, #0x90
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x70
               	ldur	x1, [x29, #-0x20]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldur	d0, [x29, #-0x90]
               	ldur	d1, [x29, #-0x70]
               	fsub	d0, d0, d1
               	ldur	d1, [x29, #-0x88]
               	ldur	d2, [x29, #-0x68]
               	fsub	d1, d1, d2
               	ldur	d2, [x29, #-0x80]
               	ldur	d3, [x29, #-0x60]
               	fsub	d2, d2, d3
               	ldur	d3, [x29, #-0x78]
               	ldur	d4, [x29, #-0x58]
               	fsub	d3, d3, d4
               	ldur	d4, [x29, #-0x90]
               	ldur	d5, [x29, #-0x70]
               	fadd	d4, d4, d5
               	ldur	d5, [x29, #-0x88]
               	ldur	d6, [x29, #-0x68]
               	fadd	d5, d5, d6
               	ldur	d6, [x29, #-0x80]
               	ldur	d7, [x29, #-0x60]
               	fadd	d6, d6, d7
               	ldur	d7, [x29, #-0x78]
               	ldur	d19, [x29, #-0x58]
               	fadd	d7, d7, d19
               	fmul	d0, d0, d4
               	fmul	d1, d1, d5
               	fmul	d2, d2, d6
               	fmul	d3, d3, d7
               	sub	x0, x29, #0x50
               	ldur	d4, [x29, #-0x70]
               	fdiv	d0, d0, d4
               	stur	d0, [x29, #-0x50]
               	ldur	d0, [x29, #-0x68]
               	fdiv	d0, d1, d0
               	stur	d0, [x29, #-0x48]
               	ldur	d0, [x29, #-0x60]
               	fdiv	d0, d2, d0
               	stur	d0, [x29, #-0x40]
               	ldur	d0, [x29, #-0x58]
               	fdiv	d0, d3, d0
               	stur	d0, [x29, #-0x38]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x90
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
               	cmp	w0, #0x2d
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x8b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	b	<addr>
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
