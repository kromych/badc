
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	stur	q0, [x29, #-0x80]
               	stur	q1, [x29, #-0x70]
               	stur	q2, [x29, #-0x60]
               	sub	x16, x29, #0x80
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x70
               	str	x16, [sp, #0x38]
               	sub	x16, x29, #0x60
               	str	x16, [sp, #0x40]
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x280
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	sub	x1, x29, #0xc8
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
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	str	q0, [sp, #0x150]
               	ldr	q1, [sp, #0x150]
               	rev32	v0.8h, v1.8h
               	sub	x3, x29, #0xb8
               	sub	x16, x29, #0xb8
               	str	x16, [sp, #0x150]
               	add	x16, sp, #0x158
               	str	q0, [x16]
               	ldr	x0, [sp, #0x150]
               	add	x16, sp, #0x158
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sxtw	x2, w0
               	ldrb	w4, [x3, x2]
               	and	x5, x0, #0xc
               	add	x2, x0, #0x2
               	and	x2, x2, #0x3
               	orr	x2, x5, x2
               	ldrb	w2, [x1, x2]
               	cmp	w4, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x98
               	add	x2, x0, #0x0
               	sub	x1, x29, #0xc8
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
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0xa]
               	strb	w2, [x0, #0xa]
               	sub	x0, x29, #0x98
               	ldrb	w2, [x1, #0xb]
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	strb	w2, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w1, [x0, #0xf]
               	ldrb	w1, [x0, #0x5]
               	eor	x1, x1, #0xff
               	strb	w1, [x0, #0x5]
               	sub	x2, x29, #0xa8
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	mov	v1.16b, v0.16b
               	sub	x16, x29, #0x98
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	str	q1, [sp, #0x150]
               	str	q0, [sp, #0x160]
               	ldr	q1, [sp, #0x150]
               	ldr	q2, [sp, #0x160]
               	cmeq	v0.16b, v1.16b, v2.16b
               	sub	x16, x29, #0xa8
               	str	x16, [sp, #0x150]
               	add	x16, sp, #0x158
               	str	q0, [x16]
               	ldr	x0, [sp, #0x150]
               	add	x16, sp, #0x158
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldrb	w4, [x2, x1]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	mov	x1, x3
               	eor	x1, x4, x1
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, #0xff               // =255
               	eor	x1, x4, x1
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x88
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
               	sub	x0, x29, #0x88
               	mov	x1, #0x9b               // =155
               	strb	w1, [x0, #0xf]
               	sub	x20, x29, #0x78
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	sub	x1, x29, #0x108
               	str	q0, [x1]
               	sub	x21, x29, #0x88
               	sub	x16, x29, #0x88
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	sub	x2, x29, #0xf8
               	str	q0, [x2]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	sub	x7, x29, #0xe8
               	str	q0, [x7]
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0xd8]
               	sub	x0, x29, #0xd8
               	ldr	q0, [x0]
               	sub	x16, x29, #0x78
               	str	x16, [sp, #0x150]
               	add	x16, sp, #0x158
               	str	q0, [x16]
               	ldr	x0, [sp, #0x150]
               	add	x16, sp, #0x158
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldrb	w4, [x20, x1]
               	ldrb	w3, [x2, x1]
               	cmp	w3, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x2, x1]
               	ldrb	w1, [x21, x1]
               	cmp	x4, x1
               	b.eq	<addr>
               	b	<addr>
               	sub	x3, x29, #0xc8
               	ldrb	w1, [x3, x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x1, #0x7f               // =127
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrb	w4, [x2, x3]
               	sxtb	x4, w4
               	cmp	w4, w1
               	b.ge	<addr>
               	ldrb	w1, [x2, x3]
               	sxtb	x1, w1
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	sub	x16, x29, #0x18
               	str	x16, [sp, #0x150]
               	add	x16, sp, #0x158
               	str	q0, [x16]
               	add	x16, sp, #0x158
               	ldr	q0, [x16]
               	sminv	b7, v0.16b
               	smov	w0, v7.b[0]
               	ldr	x16, [sp, #0x150]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x18]
               	sxtb	x0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7788             // =30600
               	movk	x1, #0x5566, lsl #16
               	movk	x1, #0x3344, lsl #32
               	movk	x1, #0x1122, lsl #48
               	mov	x2, #0xff00             // =65280
               	movk	x2, #0xddee, lsl #16
               	movk	x2, #0xbbcc, lsl #32
               	movk	x2, #0x99aa, lsl #48
               	sub	x0, x29, #0x170
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	ldr	q1, [x0]
               	sub	x16, x29, #0x68
               	str	x16, [sp, #0x150]
               	add	x16, sp, #0x158
               	str	q1, [x16]
               	add	x16, sp, #0x158
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x150]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x68]
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x60
               	str	x16, [sp, #0x150]
               	add	x16, sp, #0x158
               	str	q1, [x16]
               	add	x16, sp, #0x158
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x150]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x60]
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	sub	x0, x29, #0x210
               	str	q0, [x0]
               	sub	x3, x29, #0x200
               	sub	x1, x29, #0xe8
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
               	add	x4, x1, #0x8
               	strb	w2, [x4]
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
               	ldrsb	x2, [x0]
               	asr	x5, x2, #7
               	ldrsb	x2, [x0, #0x1]
               	asr	x6, x2, #7
               	ldrsb	x2, [x0, #0x2]
               	asr	x7, x2, #7
               	ldrsb	x2, [x0, #0x3]
               	asr	x8, x2, #7
               	ldrsb	x2, [x0, #0x4]
               	asr	x9, x2, #7
               	ldrsb	x2, [x0, #0x5]
               	asr	x10, x2, #7
               	ldrsb	x2, [x0, #0x6]
               	asr	x11, x2, #7
               	ldrsb	x2, [x0, #0x7]
               	asr	x12, x2, #7
               	ldrsb	x2, [x0, #0x8]
               	asr	x13, x2, #7
               	ldrsb	x2, [x0, #0x9]
               	asr	x14, x2, #7
               	ldrsb	x2, [x0, #0xa]
               	asr	x15, x2, #7
               	ldrsb	x2, [x0, #0xb]
               	asr	x20, x2, #7
               	ldrsb	x2, [x0, #0xc]
               	asr	x21, x2, #7
               	ldrsb	x2, [x0, #0xd]
               	asr	x22, x2, #7
               	ldrsb	x2, [x0, #0xe]
               	asr	x23, x2, #7
               	ldrsb	x0, [x0, #0xf]
               	asr	x24, x0, #7
               	mov	x2, #0x1b               // =27
               	sub	x0, x29, #0xd8
               	and	x5, x5, x2
               	strb	w5, [x0]
               	and	x5, x6, x2
               	strb	w5, [x0, #0x1]
               	and	x5, x7, x2
               	strb	w5, [x0, #0x2]
               	and	x5, x8, x2
               	strb	w5, [x0, #0x3]
               	and	x5, x9, x2
               	strb	w5, [x0, #0x4]
               	and	x5, x10, x2
               	strb	w5, [x0, #0x5]
               	and	x5, x11, x2
               	strb	w5, [x0, #0x6]
               	and	x5, x12, x2
               	strb	w5, [x0, #0x7]
               	and	x6, x13, x2
               	add	x5, x0, #0x8
               	strb	w6, [x5]
               	and	x6, x14, x2
               	strb	w6, [x0, #0x9]
               	and	x6, x15, x2
               	strb	w6, [x0, #0xa]
               	and	x6, x20, x2
               	strb	w6, [x0, #0xb]
               	and	x6, x21, x2
               	strb	w6, [x0, #0xc]
               	and	x6, x22, x2
               	strb	w6, [x0, #0xd]
               	and	x6, x23, x2
               	strb	w6, [x0, #0xe]
               	and	x2, x24, x2
               	strb	w2, [x0, #0xf]
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	eor	x2, x1, x0
               	ldr	x0, [x4]
               	ldr	x1, [x5]
               	eor	x4, x0, x1
               	str	x2, [x3]
               	str	x4, [x3, #0x8]
               	sub	x3, x29, #0x200
               	sub	x16, x29, #0x210
               	str	x16, [sp, #0x150]
               	ldr	x16, [sp, #0x150]
               	ldr	q1, [x16]
               	rev32	v0.8h, v1.8h
               	sub	x0, x29, #0xd8
               	str	q0, [x0]
               	ldr	x5, [x0]
               	eor	x2, x2, x5
               	ldr	x0, [x0, #0x8]
               	eor	x1, x4, x0
               	str	x2, [x3]
               	str	x1, [x3, #0x8]
               	sub	x6, x29, #0x200
               	sub	x0, x29, #0x210
               	sub	x5, x29, #0x28
               	ldr	x7, [x0]
               	eor	x7, x7, x2
               	str	x7, [x5]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x0, x1
               	str	x0, [x5, #0x8]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x150]
               	ldr	x0, [sp, #0x150]
               	ldr	q0, [x0]
               	sub	x16, x29, #0x28
               	str	x16, [sp, #0x150]
               	add	x16, sp, #0x158
               	str	q0, [x16]
               	ldr	x16, [sp, #0x150]
               	ldr	q1, [x16]
               	add	x16, sp, #0x158
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	sub	x9, x29, #0xd8
               	str	q0, [x9]
               	ldr	x0, [x9]
               	eor	x0, x2, x0
               	ldr	x2, [x9, #0x8]
               	eor	x1, x1, x2
               	str	x0, [x6]
               	str	x1, [x6, #0x8]
               	sub	x0, x29, #0x200
               	ldr	q0, [x0]
               	sub	x16, x29, #0x58
               	str	x16, [sp, #0x150]
               	add	x16, sp, #0x158
               	str	q0, [x16]
               	ldr	x0, [sp, #0x150]
               	add	x16, sp, #0x158
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x7, #0x0                // =0
               	mov	x3, x7
               	cmp	w3, #0x10
               	b.ge	<addr>
               	and	x0, x3, #0xc
               	and	x1, x3, #0x3
               	sxtw	x10, w3
               	sub	x2, x29, #0xc8
               	add	x4, x0, x1
               	sxtw	x4, w4
               	ldrb	w4, [x2, x4]
               	lsl	x5, x4, #1
               	and	x4, x4, #0x80
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x13, x4, #0xff
               	add	x4, x1, #0x1
               	and	x11, x4, #0x3
               	add	x5, x0, x11
               	sxtw	x6, w5
               	ldrb	w8, [x2, x6]
               	lsl	x12, x8, #1
               	and	x8, x8, #0x80
               	cbz	x8, <addr>
               	mov	x8, #0x1b               // =27
               	eor	x8, x12, x8
               	and	x8, x8, #0xff
               	eor	x8, x13, x8
               	ldrb	w4, [x2, x6]
               	eor	x5, x8, x4
               	add	x4, x1, #0x2
               	and	x4, x4, #0x3
               	add	x4, x0, x4
               	sxtw	x4, w4
               	ldrb	w4, [x2, x4]
               	eor	x4, x5, x4
               	add	x1, x1, #0x3
               	and	x1, x1, #0x3
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldrb	w0, [x2, x0]
               	eor	x0, x4, x0
               	strb	w0, [x9, x10]
               	b	<addr>
               	mov	x8, x7
               	b	<addr>
               	mov	x4, x7
               	b	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x58
               	add	x1, x0, #0x0
               	ldrb	w2, [x1]
               	sub	x1, x29, #0xd8
               	add	x3, x1, #0x0
               	ldrb	w3, [x3]
               	cmp	w2, w3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x280
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
               	sub	x0, x29, #0xd8
               	ldrb	w2, [x0, #0xa]
               	cmp	w1, w2
               	b.ne	<addr>
               	sub	x1, x29, #0x58
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
