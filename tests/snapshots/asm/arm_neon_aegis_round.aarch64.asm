
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

<vqtbx1q_u8>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x16, x29, #0x30
               	str	x4, [x16]
               	str	x5, [x16, #0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	sub	x2, x29, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	ldr	x16, [sp]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	tbx	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	sub	x1, x29, #0x180
               	add	x0, x1, #0x0
               	mov	x2, #0x5                // =5
               	strb	w2, [x0]
               	mov	x0, #0x1c               // =28
               	strb	w0, [x1, #0x1]
               	mov	x0, #0x33               // =51
               	strb	w0, [x1, #0x2]
               	mov	x0, #0x4a               // =74
               	strb	w0, [x1, #0x3]
               	mov	x0, #0x61               // =97
               	strb	w0, [x1, #0x4]
               	mov	x0, #0x78               // =120
               	strb	w0, [x1, #0x5]
               	mov	x0, #0x8f               // =143
               	strb	w0, [x1, #0x6]
               	mov	x0, #0xa6               // =166
               	strb	w0, [x1, #0x7]
               	mov	x0, #0xbd               // =189
               	strb	w0, [x1, #0x8]
               	mov	x0, #0xd4               // =212
               	strb	w0, [x1, #0x9]
               	mov	x0, #0xeb               // =235
               	strb	w0, [x1, #0xa]
               	mov	x0, #0x2                // =2
               	strb	w0, [x1, #0xb]
               	mov	x0, #0x19               // =25
               	strb	w0, [x1, #0xc]
               	mov	x0, #0x30               // =48
               	strb	w0, [x1, #0xd]
               	mov	x0, #0x47               // =71
               	strb	w0, [x1, #0xe]
               	mov	x0, #0x5e               // =94
               	strb	w0, [x1, #0xf]
               	sub	x0, x29, #0x30
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x2, x29, #0x30
               	sub	x0, x29, #0xb0
               	ldrb	w3, [x2]
               	ldrb	w4, [x2, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w6, [x2, #0x3]
               	ldrb	w7, [x2, #0x4]
               	ldrb	w8, [x2, #0x5]
               	ldrb	w9, [x2, #0x6]
               	ldrb	w10, [x2, #0x7]
               	ldrb	w11, [x2, #0x8]
               	ldrb	w12, [x2, #0x9]
               	ldrb	w13, [x2, #0xa]
               	ldrb	w14, [x2, #0xb]
               	ldrb	w15, [x2, #0xc]
               	ldrb	w20, [x2, #0xd]
               	ldrb	w21, [x2, #0xe]
               	ldrb	w2, [x2, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x20
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x48]
               	str	x2, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	rev32	v0.8h, v1.8h
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x40]
               	ldr	d1, [sp, #0x48]
               	sub	x2, x29, #0x20
               	sub	x0, x29, #0x190
               	ldrh	w3, [x2]
               	ldrh	w4, [x2, #0x2]
               	ldrh	w5, [x2, #0x4]
               	ldrh	w6, [x2, #0x6]
               	ldrh	w7, [x2, #0x8]
               	ldrh	w8, [x2, #0xa]
               	ldrh	w9, [x2, #0xc]
               	ldrh	w2, [x2, #0xe]
               	strh	w3, [x0]
               	strh	w4, [x0, #0x2]
               	strh	w5, [x0, #0x4]
               	strh	w6, [x0, #0x6]
               	strh	w7, [x0, #0x8]
               	strh	w8, [x0, #0xa]
               	strh	w9, [x0, #0xc]
               	strh	w2, [x0, #0xe]
               	sub	x2, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x4, x29, #0x170
               	sub	x0, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x4, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x3                // =3
               	mov	x6, #0xc                // =12
               	b	<addr>
               	sxtw	x2, w0
               	add	x3, x4, x2
               	ldrb	w7, [x3]
               	and	x8, x2, x6
               	add	x3, x2, #0x2
               	sxtw	x3, w3
               	and	x3, x3, x5
               	orr	x3, x8, x3
               	add	x3, x1, x3
               	ldrb	w3, [x3]
               	cmp	w7, w3
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x150
               	add	x2, x0, #0x0
               	sub	x1, x29, #0x180
               	add	x3, x1, #0x0
               	ldrb	w3, [x3]
               	strb	w3, [x2]
               	ldrb	w2, [x1, #0x1]
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	strb	w2, [x0, #0x8]
               	ldrb	w1, [x1, #0x9]
               	strb	w1, [x0, #0x9]
               	sub	x1, x29, #0x180
               	ldrb	w2, [x1, #0xa]
               	strb	w2, [x0, #0xa]
               	sub	x0, x29, #0x150
               	ldrb	w2, [x1, #0xb]
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	strb	w2, [x0, #0xf]
               	ldrb	w2, [x0, #0x5]
               	mov	x17, #0xff              // =255
               	eor	x2, x2, x17
               	strb	w2, [x0, #0x5]
               	sub	x4, x29, #0x160
               	sub	x0, x29, #0x30
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0xa0
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w22, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w22, [x0, #0xf]
               	sub	x2, x29, #0x150
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x1, [sp, #0x30]
               	str	x2, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x2, x29, #0x30
               	sub	x1, x29, #0x90
               	ldrb	w3, [x2]
               	ldrb	w5, [x2, #0x1]
               	ldrb	w6, [x2, #0x2]
               	ldrb	w7, [x2, #0x3]
               	ldrb	w8, [x2, #0x4]
               	ldrb	w9, [x2, #0x5]
               	ldrb	w10, [x2, #0x6]
               	ldrb	w11, [x2, #0x7]
               	ldrb	w12, [x2, #0x8]
               	ldrb	w13, [x2, #0x9]
               	ldrb	w14, [x2, #0xa]
               	ldrb	w15, [x2, #0xb]
               	ldrb	w20, [x2, #0xc]
               	ldrb	w21, [x2, #0xd]
               	ldrb	w22, [x2, #0xe]
               	ldrb	w2, [x2, #0xf]
               	strb	w3, [x1]
               	strb	w5, [x1, #0x1]
               	strb	w6, [x1, #0x2]
               	strb	w7, [x1, #0x3]
               	strb	w8, [x1, #0x4]
               	strb	w9, [x1, #0x5]
               	strb	w10, [x1, #0x6]
               	strb	w11, [x1, #0x7]
               	strb	w12, [x1, #0x8]
               	strb	w13, [x1, #0x9]
               	strb	w14, [x1, #0xa]
               	strb	w15, [x1, #0xb]
               	strb	w20, [x1, #0xc]
               	strb	w21, [x1, #0xd]
               	strb	w22, [x1, #0xe]
               	strb	w2, [x1, #0xf]
               	sub	x2, x29, #0x10
               	str	d0, [sp, #0x48]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x58]
               	str	x2, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	str	x1, [sp, #0x40]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	cmeq	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x48]
               	ldr	d1, [sp, #0x50]
               	ldr	d2, [sp, #0x58]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x190
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x4, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	sxtw	x1, w0
               	add	x3, x4, x1
               	ldrb	w5, [x3]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	mov	x3, x2
               	eor	x3, x5, x3
               	mov	w3, w3
               	cbz	x3, <addr>
               	b	<addr>
               	mov	x3, #0xff               // =255
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x140
               	add	x1, x0, #0x0
               	mov	x2, #0xc8               // =200
               	strb	w2, [x1]
               	mov	x1, #0xc5               // =197
               	strb	w1, [x0, #0x1]
               	mov	x1, #0xc2               // =194
               	strb	w1, [x0, #0x2]
               	mov	x1, #0xbf               // =191
               	strb	w1, [x0, #0x3]
               	mov	x1, #0xbc               // =188
               	strb	w1, [x0, #0x4]
               	mov	x1, #0xb9               // =185
               	strb	w1, [x0, #0x5]
               	mov	x1, #0xb6               // =182
               	strb	w1, [x0, #0x6]
               	mov	x1, #0xb3               // =179
               	strb	w1, [x0, #0x7]
               	mov	x1, #0xb0               // =176
               	strb	w1, [x0, #0x8]
               	mov	x1, #0xad               // =173
               	strb	w1, [x0, #0x9]
               	mov	x1, #0xaa               // =170
               	strb	w1, [x0, #0xa]
               	mov	x1, #0xa7               // =167
               	strb	w1, [x0, #0xb]
               	mov	x1, #0xa4               // =164
               	strb	w1, [x0, #0xc]
               	mov	x1, #0xa1               // =161
               	strb	w1, [x0, #0xd]
               	mov	x1, #0x9e               // =158
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x140
               	mov	x1, #0x9b               // =155
               	strb	w1, [x0, #0xf]
               	sub	x20, x29, #0x130
               	sub	x0, x29, #0x180
               	sub	x1, x29, #0x30
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x1, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0x1c0
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w22, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w22, [x0, #0xf]
               	sub	x2, x29, #0x140
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x1, [sp, #0x30]
               	str	x2, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x2, x29, #0x30
               	sub	x1, x29, #0x1b0
               	ldrb	w3, [x2]
               	ldrb	w4, [x2, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w6, [x2, #0x3]
               	ldrb	w7, [x2, #0x4]
               	ldrb	w8, [x2, #0x5]
               	ldrb	w9, [x2, #0x6]
               	ldrb	w10, [x2, #0x7]
               	ldrb	w11, [x2, #0x8]
               	ldrb	w12, [x2, #0x9]
               	ldrb	w13, [x2, #0xa]
               	ldrb	w14, [x2, #0xb]
               	ldrb	w15, [x2, #0xc]
               	ldrb	w21, [x2, #0xd]
               	ldrb	w22, [x2, #0xe]
               	ldrb	w23, [x2, #0xf]
               	strb	w3, [x1]
               	strb	w4, [x1, #0x1]
               	strb	w5, [x1, #0x2]
               	strb	w6, [x1, #0x3]
               	strb	w7, [x1, #0x4]
               	strb	w8, [x1, #0x5]
               	strb	w9, [x1, #0x6]
               	strb	w10, [x1, #0x7]
               	strb	w11, [x1, #0x8]
               	strb	w12, [x1, #0x9]
               	strb	w13, [x1, #0xa]
               	strb	w14, [x1, #0xb]
               	strb	w15, [x1, #0xc]
               	strb	w21, [x1, #0xd]
               	strb	w22, [x1, #0xe]
               	strb	w23, [x1, #0xf]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x2, [sp, #0x30]
               	str	x3, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x3, x29, #0x30
               	sub	x2, x29, #0x1a0
               	ldrb	w4, [x3]
               	ldrb	w5, [x3, #0x1]
               	ldrb	w6, [x3, #0x2]
               	ldrb	w7, [x3, #0x3]
               	ldrb	w8, [x3, #0x4]
               	ldrb	w9, [x3, #0x5]
               	ldrb	w10, [x3, #0x6]
               	ldrb	w11, [x3, #0x7]
               	ldrb	w12, [x3, #0x8]
               	ldrb	w13, [x3, #0x9]
               	ldrb	w14, [x3, #0xa]
               	ldrb	w15, [x3, #0xb]
               	ldrb	w21, [x3, #0xc]
               	ldrb	w22, [x3, #0xd]
               	ldrb	w23, [x3, #0xe]
               	ldrb	w3, [x3, #0xf]
               	strb	w4, [x2]
               	strb	w5, [x2, #0x1]
               	strb	w6, [x2, #0x2]
               	strb	w7, [x2, #0x3]
               	strb	w8, [x2, #0x4]
               	strb	w9, [x2, #0x5]
               	strb	w10, [x2, #0x6]
               	strb	w11, [x2, #0x7]
               	strb	w12, [x2, #0x8]
               	strb	w13, [x2, #0x9]
               	strb	w14, [x2, #0xa]
               	strb	w15, [x2, #0xb]
               	strb	w21, [x2, #0xc]
               	strb	w22, [x2, #0xd]
               	strb	w23, [x2, #0xe]
               	strb	w3, [x2, #0xf]
               	mov	x4, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	x5, [x4, #0x8]
               	ldr	x4, [x4]
               	bl	<addr>
               	sub	x16, x29, #0x190
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x190
               	sub	x0, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x20, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sub	x2, x29, #0x130
               	sxtw	x1, w0
               	add	x2, x2, x1
               	ldrb	w4, [x2]
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	cmp	w2, #0x10
               	b.ge	<addr>
               	sub	x2, x29, #0x140
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	add	x2, x2, x5
               	ldrb	w2, [x2]
               	cmp	x4, x2
               	b.eq	<addr>
               	b	<addr>
               	sub	x2, x29, #0x180
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x1, #0x7f               // =127
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x2, w0
               	add	x4, x3, x2
               	ldrb	w4, [x4]
               	sxtb	x4, w4
               	sxtb	x5, w1
               	cmp	w4, w5
               	b.ge	<addr>
               	add	x1, x3, x2
               	ldrb	w1, [x1]
               	sxtb	x1, w1
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x30
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x2, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x2, x29, #0x30
               	sub	x0, x29, #0x80
               	ldrb	w3, [x2]
               	ldrb	w4, [x2, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w6, [x2, #0x3]
               	ldrb	w7, [x2, #0x4]
               	ldrb	w8, [x2, #0x5]
               	ldrb	w9, [x2, #0x6]
               	ldrb	w10, [x2, #0x7]
               	ldrb	w11, [x2, #0x8]
               	ldrb	w12, [x2, #0x9]
               	ldrb	w13, [x2, #0xa]
               	ldrb	w14, [x2, #0xb]
               	ldrb	w15, [x2, #0xc]
               	ldrb	w20, [x2, #0xd]
               	ldrb	w21, [x2, #0xe]
               	ldrb	w2, [x2, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x18
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	d7, [sp, #0x50]
               	str	x2, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	sminv	b7, v0.16b
               	smov	w0, v7.b[0]
               	ldr	x16, [sp, #0x30]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	ldr	d7, [sp, #0x50]
               	ldursw	x0, [x29, #-0x18]
               	sxtb	x0, w0
               	sxtb	x1, w1
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x7788             // =30600
               	movk	x2, #0x5566, lsl #16
               	movk	x2, #0x3344, lsl #32
               	movk	x2, #0x1122, lsl #48
               	mov	x0, #0xff00             // =65280
               	movk	x0, #0xddee, lsl #16
               	movk	x0, #0xbbcc, lsl #32
               	movk	x0, #0x99aa, lsl #48
               	sub	x1, x29, #0x30
               	str	x0, [x1]
               	sub	x0, x29, #0x20
               	str	x2, [x0]
               	ldr	x1, [x1]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x190
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	sub	x0, x29, #0x100
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x120
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xf0
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x30]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	ldur	x0, [x29, #-0xf0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x100
               	sub	x0, x29, #0xe8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0xd8
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x1, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x30]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	ldur	x0, [x29, #-0xd8]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x180
               	sub	x1, x29, #0x30
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x1, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x190
               	ldrb	w2, [x0]
               	ldrb	w3, [x0, #0x1]
               	ldrb	w4, [x0, #0x2]
               	ldrb	w5, [x0, #0x3]
               	ldrb	w6, [x0, #0x4]
               	ldrb	w7, [x0, #0x5]
               	ldrb	w8, [x0, #0x6]
               	ldrb	w9, [x0, #0x7]
               	ldrb	w10, [x0, #0x8]
               	ldrb	w11, [x0, #0x9]
               	ldrb	w12, [x0, #0xa]
               	ldrb	w13, [x0, #0xb]
               	ldrb	w14, [x0, #0xc]
               	ldrb	w15, [x0, #0xd]
               	ldrb	w20, [x0, #0xe]
               	ldrb	w0, [x0, #0xf]
               	strb	w2, [x1]
               	strb	w3, [x1, #0x1]
               	strb	w4, [x1, #0x2]
               	strb	w5, [x1, #0x3]
               	strb	w6, [x1, #0x4]
               	strb	w7, [x1, #0x5]
               	strb	w8, [x1, #0x6]
               	strb	w9, [x1, #0x7]
               	strb	w10, [x1, #0x8]
               	strb	w11, [x1, #0x9]
               	strb	w12, [x1, #0xa]
               	strb	w13, [x1, #0xb]
               	strb	w14, [x1, #0xc]
               	strb	w15, [x1, #0xd]
               	strb	w20, [x1, #0xe]
               	strb	w0, [x1, #0xf]
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x6, x29, #0x1c0
               	sub	x1, x29, #0x1b0
               	ldrb	w2, [x0]
               	lsl	x2, x2, #1
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x1]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x1]
               	ldrb	w2, [x0, #0x2]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x2]
               	ldrb	w2, [x0, #0x3]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x0, #0x4]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x4]
               	ldrb	w2, [x0, #0x5]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x5]
               	ldrb	w2, [x0, #0x6]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x6]
               	ldrb	w2, [x0, #0x7]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x7]
               	ldrb	w2, [x0, #0x8]
               	lsl	x2, x2, #1
               	add	x3, x1, #0x8
               	strb	w2, [x3]
               	ldrb	w2, [x0, #0x9]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x9]
               	ldrb	w2, [x0, #0xa]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xa]
               	ldrb	w2, [x0, #0xb]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xb]
               	ldrb	w2, [x0, #0xc]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xc]
               	ldrb	w2, [x0, #0xd]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xd]
               	ldrb	w2, [x0, #0xe]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xe]
               	ldrb	w2, [x0, #0xf]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xf]
               	ldrsb	x4, [x0]
               	asr	x4, x4, #7
               	ldrsb	x5, [x0, #0x1]
               	asr	x5, x5, #7
               	ldrsb	x7, [x0, #0x2]
               	asr	x7, x7, #7
               	ldrsb	x8, [x0, #0x3]
               	asr	x8, x8, #7
               	ldrsb	x9, [x0, #0x4]
               	asr	x9, x9, #7
               	ldrsb	x10, [x0, #0x5]
               	asr	x10, x10, #7
               	ldrsb	x11, [x0, #0x6]
               	asr	x11, x11, #7
               	ldrsb	x12, [x0, #0x7]
               	asr	x12, x12, #7
               	ldrsb	x13, [x0, #0x8]
               	asr	x13, x13, #7
               	ldrsb	x14, [x0, #0x9]
               	asr	x14, x14, #7
               	ldrsb	x15, [x0, #0xa]
               	asr	x15, x15, #7
               	ldrsb	x20, [x0, #0xb]
               	asr	x20, x20, #7
               	ldrsb	x21, [x0, #0xc]
               	asr	x21, x21, #7
               	ldrsb	x22, [x0, #0xd]
               	asr	x22, x22, #7
               	ldrsb	x23, [x0, #0xe]
               	asr	x23, x23, #7
               	ldrsb	x0, [x0, #0xf]
               	asr	x24, x0, #7
               	mov	x2, #0x1b               // =27
               	sub	x0, x29, #0x1a0
               	sxtb	x4, w4
               	and	x4, x4, x2
               	strb	w4, [x0]
               	sxtb	x4, w5
               	and	x4, x4, x2
               	strb	w4, [x0, #0x1]
               	sxtb	x4, w7
               	and	x4, x4, x2
               	strb	w4, [x0, #0x2]
               	sxtb	x4, w8
               	and	x4, x4, x2
               	strb	w4, [x0, #0x3]
               	sxtb	x4, w9
               	and	x4, x4, x2
               	strb	w4, [x0, #0x4]
               	sxtb	x4, w10
               	and	x4, x4, x2
               	strb	w4, [x0, #0x5]
               	sxtb	x4, w11
               	and	x4, x4, x2
               	strb	w4, [x0, #0x6]
               	sxtb	x4, w12
               	and	x4, x4, x2
               	strb	w4, [x0, #0x7]
               	sxtb	x4, w13
               	and	x5, x4, x2
               	add	x4, x0, #0x8
               	strb	w5, [x4]
               	sxtb	x5, w14
               	and	x5, x5, x2
               	strb	w5, [x0, #0x9]
               	sxtb	x5, w15
               	and	x5, x5, x2
               	strb	w5, [x0, #0xa]
               	sxtb	x5, w20
               	and	x5, x5, x2
               	strb	w5, [x0, #0xb]
               	sxtb	x5, w21
               	and	x5, x5, x2
               	strb	w5, [x0, #0xc]
               	sxtb	x5, w22
               	and	x5, x5, x2
               	strb	w5, [x0, #0xd]
               	sxtb	x5, w23
               	and	x5, x5, x2
               	strb	w5, [x0, #0xe]
               	sxtb	x5, w24
               	and	x2, x5, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x190
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	eor	x5, x1, x0
               	str	x5, [x2]
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	eor	x4, x0, x1
               	str	x4, [x2, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x6]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x6
               	sub	x6, x29, #0x1c0
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x20
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x48]
               	str	x1, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	rev32	v0.8h, v1.8h
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x40]
               	ldr	d1, [sp, #0x48]
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x1a0
               	ldrh	w3, [x1]
               	ldrh	w7, [x1, #0x2]
               	ldrh	w8, [x1, #0x4]
               	ldrh	w9, [x1, #0x6]
               	ldrh	w10, [x1, #0x8]
               	ldrh	w11, [x1, #0xa]
               	ldrh	w12, [x1, #0xc]
               	ldrh	w1, [x1, #0xe]
               	strh	w3, [x0]
               	strh	w7, [x0, #0x2]
               	strh	w8, [x0, #0x4]
               	strh	w9, [x0, #0x6]
               	strh	w10, [x0, #0x8]
               	strh	w11, [x0, #0xa]
               	strh	w12, [x0, #0xc]
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x190
               	ldr	x3, [x0]
               	eor	x3, x5, x3
               	str	x3, [x1]
               	ldr	x0, [x0, #0x8]
               	eor	x4, x4, x0
               	str	x4, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x6]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x6
               	sub	x6, x29, #0x1c0
               	sub	x0, x29, #0xc0
               	sub	x2, x29, #0x50
               	ldr	x7, [x0]
               	eor	x7, x7, x3
               	str	x7, [x2]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x0, x4
               	str	x0, [x2, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x30
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x1, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0x40
               	ldrb	w7, [x1]
               	ldrb	w8, [x1, #0x1]
               	ldrb	w9, [x1, #0x2]
               	ldrb	w10, [x1, #0x3]
               	ldrb	w11, [x1, #0x4]
               	ldrb	w12, [x1, #0x5]
               	ldrb	w13, [x1, #0x6]
               	ldrb	w14, [x1, #0x7]
               	ldrb	w15, [x1, #0x8]
               	ldrb	w20, [x1, #0x9]
               	ldrb	w21, [x1, #0xa]
               	ldrb	w22, [x1, #0xb]
               	ldrb	w23, [x1, #0xc]
               	ldrb	w24, [x1, #0xd]
               	ldrb	w25, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w7, [x0]
               	strb	w8, [x0, #0x1]
               	strb	w9, [x0, #0x2]
               	strb	w10, [x0, #0x3]
               	strb	w11, [x0, #0x4]
               	strb	w12, [x0, #0x5]
               	strb	w13, [x0, #0x6]
               	strb	w14, [x0, #0x7]
               	strb	w15, [x0, #0x8]
               	strb	w20, [x0, #0x9]
               	strb	w21, [x0, #0xa]
               	strb	w22, [x0, #0xb]
               	strb	w23, [x0, #0xc]
               	strb	w24, [x0, #0xd]
               	strb	w25, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x10
               	str	d0, [sp, #0x48]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x58]
               	str	x1, [sp, #0x30]
               	str	x2, [sp, #0x38]
               	str	x0, [sp, #0x40]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x48]
               	ldr	d1, [sp, #0x50]
               	ldr	d2, [sp, #0x58]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x1a0
               	ldrb	w2, [x1]
               	ldrb	w7, [x1, #0x1]
               	ldrb	w8, [x1, #0x2]
               	ldrb	w9, [x1, #0x3]
               	ldrb	w10, [x1, #0x4]
               	ldrb	w11, [x1, #0x5]
               	ldrb	w12, [x1, #0x6]
               	ldrb	w13, [x1, #0x7]
               	ldrb	w14, [x1, #0x8]
               	ldrb	w15, [x1, #0x9]
               	ldrb	w20, [x1, #0xa]
               	ldrb	w21, [x1, #0xb]
               	ldrb	w22, [x1, #0xc]
               	ldrb	w23, [x1, #0xd]
               	ldrb	w24, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w7, [x0, #0x1]
               	strb	w8, [x0, #0x2]
               	strb	w9, [x0, #0x3]
               	strb	w10, [x0, #0x4]
               	strb	w11, [x0, #0x5]
               	strb	w12, [x0, #0x6]
               	strb	w13, [x0, #0x7]
               	strb	w14, [x0, #0x8]
               	strb	w15, [x0, #0x9]
               	strb	w20, [x0, #0xa]
               	strb	w21, [x0, #0xb]
               	strb	w22, [x0, #0xc]
               	strb	w23, [x0, #0xd]
               	strb	w24, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x1a0
               	sub	x15, x29, #0x190
               	ldr	x1, [x0]
               	eor	x1, x3, x1
               	str	x1, [x15]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x4, x0
               	str	x0, [x15, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x15]
               	str	x10, [x6]
               	ldr	x10, [x15, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x6
               	sub	x1, x29, #0xd0
               	sub	x2, x29, #0x1c0
               	sub	x0, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	str	x0, [sp, #0x40]
               	str	d0, [sp, #0x48]
               	str	x1, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	mov	x8, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x20, #0xc               // =12
               	mov	x9, #0x80               // =128
               	mov	x4, #0xff               // =255
               	mov	x2, x8
               	b	<addr>
               	and	x0, x2, x20
               	and	x1, x2, x6
               	sxtw	x10, w2
               	add	x21, x15, x10
               	sub	x5, x29, #0x180
               	add	x3, x0, x1
               	sxtw	x3, w3
               	add	x3, x5, x3
               	ldrb	w3, [x3]
               	and	x3, x3, x4
               	lsl	x7, x3, #1
               	sxtw	x7, w7
               	and	x3, x3, x9
               	cbz	x3, <addr>
               	mov	x3, #0x1b               // =27
               	eor	x3, x7, x3
               	and	x22, x3, x4
               	add	x3, x1, #0x1
               	and	x11, x3, x6
               	add	x7, x0, x11
               	sxtw	x12, w7
               	add	x13, x5, x12
               	ldrb	w14, [x13]
               	and	x14, x14, x4
               	lsl	x23, x14, #1
               	sxtw	x23, w23
               	and	x14, x14, x9
               	cbz	x14, <addr>
               	mov	x14, #0x1b              // =27
               	eor	x14, x23, x14
               	and	x14, x14, x4
               	eor	x14, x22, x14
               	ldrb	w3, [x13]
               	eor	x7, x14, x3
               	add	x3, x1, #0x2
               	and	x3, x3, x6
               	add	x3, x0, x3
               	sxtw	x3, w3
               	add	x3, x5, x3
               	ldrb	w3, [x3]
               	eor	x3, x7, x3
               	add	x1, x1, #0x3
               	and	x1, x1, x6
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	x0, x5, x0
               	ldrb	w0, [x0]
               	eor	x0, x3, x0
               	and	x0, x0, x4
               	strb	w0, [x21]
               	b	<addr>
               	mov	x14, x8
               	b	<addr>
               	mov	x3, x8
               	b	<addr>
               	add	x2, x10, #0x1
               	cmp	w2, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd0
               	add	x1, x0, #0x0
               	ldrb	w2, [x1]
               	sub	x1, x29, #0x190
               	add	x3, x1, #0x0
               	ldrb	w3, [x3]
               	cmp	w2, w3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x1, #0x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x2]
               	ldrb	w3, [x1, #0x2]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x3]
               	ldrb	w3, [x1, #0x3]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x4]
               	ldrb	w3, [x1, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x5]
               	ldrb	w3, [x1, #0x5]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x6]
               	ldrb	w3, [x1, #0x6]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x7]
               	ldrb	w3, [x1, #0x7]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x8]
               	ldrb	w3, [x1, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x9]
               	ldrb	w1, [x1, #0x9]
               	cmp	w2, w1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xa]
               	sub	x0, x29, #0x190
               	ldrb	w2, [x0, #0xa]
               	cmp	w1, w2
               	b.ne	<addr>
               	sub	x1, x29, #0xd0
               	ldrb	w2, [x1, #0xb]
               	ldrb	w3, [x0, #0xb]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0xc]
               	ldrb	w3, [x0, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0xd]
               	ldrb	w3, [x0, #0xd]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0xe]
               	ldrb	w3, [x0, #0xe]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w1, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	cmp	w1, w0
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
