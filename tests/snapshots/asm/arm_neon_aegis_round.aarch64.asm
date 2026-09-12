
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

<vld1q_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x1, x29, #0x30
               	str	x1, [sp, #0x10]
               	str	x0, [sp, #0x18]
               	ldr	x0, [sp, #0x18]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	sub	x0, x29, #0x30
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<vqtbl1q_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x16, x29, #0x70
               	str	q1, [x16]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x70
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x60
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<vqtbx1q_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x16, x29, #0x70
               	str	q1, [x16]
               	sub	x16, x29, #0x60
               	str	q2, [x16]
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0x70
               	sub	x2, x29, #0x60
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	ldr	x16, [sp, #0x30]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	tbx	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x80
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<vceqq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x16, x29, #0x70
               	str	q1, [x16]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x70
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	cmeq	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x60
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<vrev32q_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x50
               	str	q0, [x16]
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x50
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	rev32	v0.8h, v1.8h
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	sub	x0, x29, #0x40
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<vmov_n_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	mov	x16, x0
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<vcombine_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x8
               	str	d0, [x16]
               	sub	x16, x29, #0x10
               	str	d1, [x16]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x8
               	ldr	x1, [x1]
               	str	x1, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	str	x1, [x0, #0x8]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	sub	x20, x29, #0x128
               	add	x0, x20, #0x0
               	mov	x1, #0x5                // =5
               	strb	w1, [x0]
               	mov	x0, #0x1c               // =28
               	strb	w0, [x20, #0x1]
               	mov	x0, #0x33               // =51
               	strb	w0, [x20, #0x2]
               	mov	x0, #0x4a               // =74
               	strb	w0, [x20, #0x3]
               	mov	x0, #0x61               // =97
               	strb	w0, [x20, #0x4]
               	mov	x0, #0x78               // =120
               	strb	w0, [x20, #0x5]
               	mov	x0, #0x8f               // =143
               	strb	w0, [x20, #0x6]
               	mov	x0, #0xa6               // =166
               	strb	w0, [x20, #0x7]
               	mov	x0, #0xbd               // =189
               	strb	w0, [x20, #0x8]
               	mov	x0, #0xd4               // =212
               	strb	w0, [x20, #0x9]
               	mov	x0, #0xeb               // =235
               	strb	w0, [x20, #0xa]
               	mov	x0, #0x2                // =2
               	strb	w0, [x20, #0xb]
               	mov	x0, #0x19               // =25
               	strb	w0, [x20, #0xc]
               	mov	x0, #0x30               // =48
               	strb	w0, [x20, #0xd]
               	mov	x0, #0x47               // =71
               	strb	w0, [x20, #0xe]
               	mov	x0, #0x5e               // =94
               	strb	w0, [x20, #0xf]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x148
               	str	q0, [x16]
               	sub	x0, x29, #0x148
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x138
               	str	q0, [x16]
               	sub	x1, x29, #0x138
               	sub	x0, x29, #0x200
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x118
               	sub	x1, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x3, [sp, #0xb0]
               	str	x1, [sp, #0xb8]
               	ldr	x0, [sp, #0xb0]
               	ldr	x16, [sp, #0xb8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x3                // =3
               	mov	x5, #0xc                // =12
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x3, x1
               	ldrb	w6, [x2]
               	and	x7, x1, x5
               	add	x2, x1, #0x2
               	sxtw	x2, w2
               	and	x2, x2, x4
               	orr	x2, x7, x2
               	add	x2, x20, x2
               	ldrb	w2, [x2]
               	cmp	w6, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xe8
               	add	x2, x0, #0x0
               	sub	x1, x29, #0x128
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
               	sub	x1, x29, #0x128
               	ldrb	w2, [x1, #0xa]
               	strb	w2, [x0, #0xa]
               	sub	x0, x29, #0xe8
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
               	sub	x20, x29, #0xf8
               	mov	x0, x1
               	bl	<addr>
               	sub	x16, x29, #0x158
               	str	q0, [x16]
               	sub	x21, x29, #0x158
               	sub	x0, x29, #0xe8
               	bl	<addr>
               	sub	x16, x29, #0x148
               	str	q0, [x16]
               	sub	x1, x29, #0x148
               	ldr	q0, [x21]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x138
               	str	q0, [x16]
               	sub	x1, x29, #0x138
               	sub	x0, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x20, [sp, #0xb0]
               	str	x0, [sp, #0xb8]
               	ldr	x0, [sp, #0xb0]
               	ldr	x16, [sp, #0xb8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	sxtw	x1, w0
               	add	x3, x20, x1
               	ldrb	w4, [x3]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	mov	x3, x2
               	eor	x3, x4, x3
               	mov	w3, w3
               	cbz	x3, <addr>
               	b	<addr>
               	mov	x3, #0xff               // =255
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xd8
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
               	sub	x0, x29, #0xd8
               	mov	x1, #0x9b               // =155
               	strb	w1, [x0, #0xf]
               	sub	x20, x29, #0xc8
               	sub	x0, x29, #0x128
               	bl	<addr>
               	sub	x16, x29, #0x168
               	str	q0, [x16]
               	sub	x22, x29, #0x168
               	sub	x21, x29, #0xd8
               	mov	x0, x21
               	bl	<addr>
               	sub	x16, x29, #0x158
               	str	q0, [x16]
               	sub	x23, x29, #0x158
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sub	x16, x29, #0x148
               	str	q0, [x16]
               	sub	x2, x29, #0x148
               	ldr	q0, [x22]
               	ldr	q1, [x23]
               	ldr	q2, [x2]
               	bl	<addr>
               	sub	x16, x29, #0x138
               	str	q0, [x16]
               	sub	x1, x29, #0x138
               	sub	x0, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x20, [sp, #0xb0]
               	str	x0, [sp, #0xb8]
               	ldr	x0, [sp, #0xb0]
               	ldr	x16, [sp, #0xb8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x20, x1
               	ldrb	w4, [x2]
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	cmp	w2, #0x10
               	b.ge	<addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x2, x21, x2
               	ldrb	w2, [x2]
               	cmp	x4, x2
               	b.eq	<addr>
               	b	<addr>
               	sub	x2, x29, #0x128
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x20, #0x7f              // =127
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	sxtb	x3, w3
               	sxtb	x4, w20
               	cmp	w3, w4
               	b.ge	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	sxtb	x20, w3
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sub	x16, x29, #0x38
               	str	q0, [x16]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	str	x1, [sp, #0xb0]
               	str	x0, [sp, #0xb8]
               	ldr	x16, [sp, #0xb8]
               	ldr	q0, [x16]
               	sminv	b7, v0.16b
               	smov	w0, v7.b[0]
               	ldr	x16, [sp, #0xb0]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x8]
               	sxtb	x0, w0
               	sxtb	x1, w20
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	d0, [x16]
               	sub	x20, x29, #0x150
               	mov	x0, #0xff00             // =65280
               	movk	x0, #0xddee, lsl #16
               	movk	x0, #0xbbcc, lsl #32
               	movk	x0, #0x99aa, lsl #48
               	bl	<addr>
               	sub	x16, x29, #0x140
               	str	d0, [x16]
               	sub	x1, x29, #0x140
               	ldr	d0, [x20]
               	ldr	d1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x138
               	str	q0, [x16]
               	sub	x1, x29, #0x138
               	sub	x0, x29, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x1e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x88
               	str	x0, [sp, #0xb0]
               	str	x1, [sp, #0xb8]
               	ldr	x16, [sp, #0xb8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0xb0]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x88]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1f0
               	sub	x0, x29, #0x1d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x70
               	str	x1, [sp, #0xb0]
               	str	x0, [sp, #0xb8]
               	ldr	x16, [sp, #0xb8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0xb0]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x70]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x128
               	bl	<addr>
               	sub	x16, x29, #0x138
               	str	q0, [x16]
               	sub	x1, x29, #0x138
               	sub	x0, x29, #0x1c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x5, x29, #0x1b0
               	sub	x1, x29, #0x158
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
               	ldrsb	x6, [x0, #0x1]
               	asr	x6, x6, #7
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
               	sub	x0, x29, #0x148
               	sxtb	x4, w4
               	and	x4, x4, x2
               	strb	w4, [x0]
               	sxtb	x4, w6
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
               	and	x6, x4, x2
               	add	x4, x0, #0x8
               	strb	w6, [x4]
               	sxtb	x6, w14
               	and	x6, x6, x2
               	strb	w6, [x0, #0x9]
               	sxtb	x6, w15
               	and	x6, x6, x2
               	strb	w6, [x0, #0xa]
               	sxtb	x6, w20
               	and	x6, x6, x2
               	strb	w6, [x0, #0xb]
               	sxtb	x6, w21
               	and	x6, x6, x2
               	strb	w6, [x0, #0xc]
               	sxtb	x6, w22
               	and	x6, x6, x2
               	strb	w6, [x0, #0xd]
               	sxtb	x6, w23
               	and	x6, x6, x2
               	strb	w6, [x0, #0xe]
               	sxtb	x6, w24
               	and	x2, x6, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x138
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	eor	x21, x1, x0
               	str	x21, [x2]
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	eor	x22, x0, x1
               	str	x22, [x2, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x5]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x23, x29, #0x1b0
               	sub	x0, x29, #0x1c0
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x148
               	str	q0, [x16]
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0x138
               	ldr	x2, [x1]
               	eor	x21, x21, x2
               	str	x21, [x0]
               	ldr	x1, [x1, #0x8]
               	eor	x22, x22, x1
               	str	x22, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x24, x29, #0x1b0
               	sub	x0, x29, #0x1c0
               	sub	x20, x29, #0x158
               	ldr	x2, [x0]
               	eor	x2, x2, x21
               	str	x2, [x20]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x0, x22
               	str	x0, [x20, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sub	x16, x29, #0x138
               	str	q0, [x16]
               	sub	x1, x29, #0x138
               	ldr	q0, [x20]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x148
               	str	q0, [x16]
               	sub	x0, x29, #0x148
               	sub	x15, x29, #0x138
               	ldr	x1, [x0]
               	eor	x1, x21, x1
               	str	x1, [x15]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x22, x0
               	str	x0, [x15, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x15]
               	str	x10, [x24]
               	ldr	x10, [x15, #0x8]
               	str	x10, [x24, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x68
               	sub	x2, x29, #0x1b0
               	sub	x0, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x1, [sp, #0xb0]
               	str	x0, [sp, #0xb8]
               	ldr	x0, [sp, #0xb0]
               	ldr	x16, [sp, #0xb8]
               	ldr	q0, [x16]
               	str	q0, [x0]
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
               	sub	x5, x29, #0x128
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
               	sub	x0, x29, #0x68
               	add	x1, x0, #0x0
               	ldrb	w2, [x1]
               	sub	x1, x29, #0x138
               	add	x3, x1, #0x0
               	ldrb	w3, [x3]
               	cmp	w2, w3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x24, [sp, #0x20]
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
               	sub	x0, x29, #0x138
               	ldrb	w2, [x0, #0xa]
               	cmp	w1, w2
               	b.ne	<addr>
               	sub	x1, x29, #0x68
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
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
