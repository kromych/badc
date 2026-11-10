
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
               	str	x20, [sp, #-0xd0]!
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x48]
               	mov	x0, #0x1c               // =28
               	sturb	w0, [x29, #-0x47]
               	mov	x0, #0x33               // =51
               	sturb	w0, [x29, #-0x46]
               	mov	x0, #0x4a               // =74
               	sturb	w0, [x29, #-0x45]
               	mov	x0, #0x61               // =97
               	sturb	w0, [x29, #-0x44]
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0x43]
               	mov	x0, #0x8f               // =143
               	sturb	w0, [x29, #-0x42]
               	mov	x0, #0xa6               // =166
               	sturb	w0, [x29, #-0x41]
               	mov	x0, #0xbd               // =189
               	sturb	w0, [x29, #-0x40]
               	mov	x0, #0xd4               // =212
               	sturb	w0, [x29, #-0x3f]
               	mov	x0, #0xeb               // =235
               	sturb	w0, [x29, #-0x3e]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x3d]
               	mov	x0, #0x19               // =25
               	sturb	w0, [x29, #-0x3c]
               	mov	x0, #0x30               // =48
               	sturb	w0, [x29, #-0x3b]
               	mov	x0, #0x47               // =71
               	sturb	w0, [x29, #-0x3a]
               	mov	x0, #0x5e               // =94
               	sturb	w0, [x29, #-0x39]
               	sub	x16, x29, #0x48
               	ldr	q0, [x16]
               	rev32	v0.8h, v0.8h
               	sub	x1, x29, #0x18
               	sub	x16, x29, #0x18
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	sub	x3, x29, #0x48
               	and	x4, x0, #0xc
               	add	x5, x0, #0x2
               	and	x5, x5, #0x3
               	orr	x4, x4, x5
               	ldrb	w3, [x3, x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x48]
               	sturb	w0, [x29, #-0x18]
               	ldurb	w0, [x29, #-0x47]
               	sturb	w0, [x29, #-0x17]
               	ldurb	w0, [x29, #-0x46]
               	sturb	w0, [x29, #-0x16]
               	ldurb	w0, [x29, #-0x45]
               	sturb	w0, [x29, #-0x15]
               	ldurb	w0, [x29, #-0x44]
               	sturb	w0, [x29, #-0x14]
               	ldurb	w0, [x29, #-0x43]
               	sturb	w0, [x29, #-0x13]
               	ldurb	w0, [x29, #-0x42]
               	sturb	w0, [x29, #-0x12]
               	ldurb	w0, [x29, #-0x41]
               	sturb	w0, [x29, #-0x11]
               	ldurb	w0, [x29, #-0x40]
               	sturb	w0, [x29, #-0x10]
               	ldurb	w0, [x29, #-0x3f]
               	sturb	w0, [x29, #-0xf]
               	ldurb	w0, [x29, #-0x3e]
               	sturb	w0, [x29, #-0xe]
               	ldurb	w0, [x29, #-0x3d]
               	sturb	w0, [x29, #-0xd]
               	ldurb	w0, [x29, #-0x3c]
               	sturb	w0, [x29, #-0xc]
               	ldurb	w0, [x29, #-0x3b]
               	sturb	w0, [x29, #-0xb]
               	ldurb	w0, [x29, #-0x3a]
               	sturb	w0, [x29, #-0xa]
               	ldurb	w0, [x29, #-0x39]
               	sturb	w0, [x29, #-0x9]
               	ldurb	w0, [x29, #-0x13]
               	eor	x0, x0, #0xff
               	sturb	w0, [x29, #-0x13]
               	sub	x3, x29, #0x28
               	sub	x16, x29, #0x48
               	ldr	q0, [x16]
               	sub	x16, x29, #0x18
               	ldr	q1, [x16]
               	cmeq	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x28
               	str	q0, [x16]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrb	w4, [x3, x0]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	mov	x2, x1
               	cmp	w4, w2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, #0xff               // =255
               	cmp	w4, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x38]
               	mov	x0, #0xc5               // =197
               	sturb	w0, [x29, #-0x37]
               	mov	x0, #0xc2               // =194
               	sturb	w0, [x29, #-0x36]
               	mov	x0, #0xbf               // =191
               	sturb	w0, [x29, #-0x35]
               	mov	x0, #0xbc               // =188
               	sturb	w0, [x29, #-0x34]
               	mov	x0, #0xb9               // =185
               	sturb	w0, [x29, #-0x33]
               	mov	x0, #0xb6               // =182
               	sturb	w0, [x29, #-0x32]
               	mov	x0, #0xb3               // =179
               	sturb	w0, [x29, #-0x31]
               	mov	x0, #0xb0               // =176
               	sturb	w0, [x29, #-0x30]
               	mov	x0, #0xad               // =173
               	sturb	w0, [x29, #-0x2f]
               	mov	x0, #0xaa               // =170
               	sturb	w0, [x29, #-0x2e]
               	mov	x0, #0xa7               // =167
               	sturb	w0, [x29, #-0x2d]
               	mov	x0, #0xa4               // =164
               	sturb	w0, [x29, #-0x2c]
               	mov	x0, #0xa1               // =161
               	sturb	w0, [x29, #-0x2b]
               	mov	x0, #0x9e               // =158
               	sturb	w0, [x29, #-0x2a]
               	mov	x0, #0x9b               // =155
               	sturb	w0, [x29, #-0x29]
               	sub	x3, x29, #0x18
               	sub	x16, x29, #0x48
               	ldr	q0, [x16]
               	sub	x4, x29, #0x38
               	sub	x16, x29, #0x38
               	ldr	q1, [x16]
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q2, [x16]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	ldr	q2, [sp, #0x60]
               	tbx	v0.16b, { v1.16b }, v2.16b
               	sub	x16, x29, #0x18
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w5, [x3, x0]
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x2, x0]
               	ldrb	w1, [x4, x1]
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x48
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
               	ldr	q1, [x16]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x40]
               	stur	q1, [sp, #0x48]
               	ldur	q1, [sp, #0x48]
               	sminv	b0, v1.16b
               	ldr	x16, [sp, #0x40]
               	str	b0, [x16]
               	ldursb	x0, [x29, #-0x8]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
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
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	mov	x0, v0.d[1]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	sub	x16, x29, #0x48
               	ldr	q0, [x16]
               	stur	q0, [x29, #-0xb0]
               	ldurb	w0, [x29, #-0xb0]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0xa0]
               	ldurb	w0, [x29, #-0xaf]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x9f]
               	ldurb	w0, [x29, #-0xae]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x9e]
               	ldurb	w0, [x29, #-0xad]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x9d]
               	ldurb	w0, [x29, #-0xac]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x9c]
               	ldurb	w0, [x29, #-0xab]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x9b]
               	ldurb	w0, [x29, #-0xaa]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x9a]
               	ldurb	w0, [x29, #-0xa9]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x99]
               	ldurb	w0, [x29, #-0xa8]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x98]
               	ldurb	w0, [x29, #-0xa7]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x97]
               	ldurb	w0, [x29, #-0xa6]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x96]
               	ldurb	w0, [x29, #-0xa5]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x95]
               	ldurb	w0, [x29, #-0xa4]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x94]
               	ldurb	w0, [x29, #-0xa3]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x93]
               	ldurb	w0, [x29, #-0xa2]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x92]
               	ldurb	w0, [x29, #-0xa1]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x91]
               	ldursb	x0, [x29, #-0xb0]
               	ldursb	x1, [x29, #-0xaf]
               	ldursb	x2, [x29, #-0xae]
               	ldursb	x3, [x29, #-0xad]
               	ldursb	x4, [x29, #-0xac]
               	ldursb	x6, [x29, #-0xab]
               	ldursb	x7, [x29, #-0xaa]
               	ldursb	x8, [x29, #-0xa9]
               	ldursb	x9, [x29, #-0xa8]
               	ldursb	x10, [x29, #-0xa7]
               	ldursb	x11, [x29, #-0xa6]
               	ldursb	x12, [x29, #-0xa5]
               	ldursb	x13, [x29, #-0xa4]
               	ldursb	x14, [x29, #-0xa3]
               	ldursb	x15, [x29, #-0xa2]
               	ldursb	x20, [x29, #-0xa1]
               	mov	x5, #0x1b               // =27
               	and	x0, x5, x0, asr #7
               	sturb	w0, [x29, #-0x90]
               	and	x0, x5, x1, asr #7
               	sturb	w0, [x29, #-0x8f]
               	and	x0, x5, x2, asr #7
               	sturb	w0, [x29, #-0x8e]
               	and	x0, x5, x3, asr #7
               	sturb	w0, [x29, #-0x8d]
               	and	x0, x5, x4, asr #7
               	sturb	w0, [x29, #-0x8c]
               	and	x0, x5, x6, asr #7
               	sturb	w0, [x29, #-0x8b]
               	and	x0, x5, x7, asr #7
               	sturb	w0, [x29, #-0x8a]
               	and	x0, x5, x8, asr #7
               	sturb	w0, [x29, #-0x89]
               	and	x0, x5, x9, asr #7
               	sturb	w0, [x29, #-0x88]
               	and	x0, x5, x10, asr #7
               	sturb	w0, [x29, #-0x87]
               	and	x0, x5, x11, asr #7
               	sturb	w0, [x29, #-0x86]
               	and	x0, x5, x12, asr #7
               	sturb	w0, [x29, #-0x85]
               	and	x0, x5, x13, asr #7
               	sturb	w0, [x29, #-0x84]
               	and	x0, x5, x14, asr #7
               	sturb	w0, [x29, #-0x83]
               	and	x0, x5, x15, asr #7
               	sturb	w0, [x29, #-0x82]
               	and	x0, x5, x20, asr #7
               	sturb	w0, [x29, #-0x81]
               	ldur	q0, [x29, #-0xa0]
               	ldur	q1, [x29, #-0x90]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0xb0]
               	rev32	v1.8h, v1.8h
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0xb0]
               	eor	v1.16b, v1.16b, v0.16b
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q2, [x16]
               	tbl	v1.16b, { v1.16b }, v2.16b
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x38
               	str	q0, [x16]
               	mov	x4, #0x0                // =0
               	mov	x0, x4
               	and	x2, x0, #0xc
               	and	x3, x0, #0x3
               	sub	x9, x29, #0x18
               	sub	x1, x29, #0x48
               	add	x6, x2, x3
               	ldrb	w6, [x1, x6]
               	tbz	w6, #0x7, <addr>
               	mov	x7, x5
               	eor	x6, x7, x6, lsl #1
               	and	x10, x6, #0xff
               	add	x6, x3, #0x1
               	and	x6, x6, #0x3
               	add	x6, x2, x6
               	ldrb	w7, [x1, x6]
               	tbz	w7, #0x7, <addr>
               	mov	x8, #0x1b               // =27
               	b	<addr>
               	mov	x8, x4
               	b	<addr>
               	mov	x7, x4
               	b	<addr>
               	eor	x7, x8, x7, lsl #1
               	and	x7, x7, #0xff
               	eor	x7, x10, x7
               	ldrb	w6, [x1, x6]
               	eor	x6, x7, x6
               	add	x7, x3, #0x2
               	and	x7, x7, #0x3
               	add	x7, x2, x7
               	ldrb	w7, [x1, x7]
               	eor	x6, x6, x7
               	add	x3, x3, #0x3
               	and	x3, x3, #0x3
               	add	x2, x2, x3
               	ldrb	w1, [x1, x2]
               	eor	x1, x6, x1
               	strb	w1, [x9, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x38]
               	ldurb	w1, [x29, #-0x18]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	ldurb	w0, [x29, #-0x37]
               	ldurb	w1, [x29, #-0x17]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x36]
               	ldurb	w1, [x29, #-0x16]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x35]
               	ldurb	w1, [x29, #-0x15]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x34]
               	ldurb	w1, [x29, #-0x14]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x33]
               	ldurb	w1, [x29, #-0x13]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x32]
               	ldurb	w1, [x29, #-0x12]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x31]
               	ldurb	w1, [x29, #-0x11]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x30]
               	ldurb	w1, [x29, #-0x10]
               	cmp	w0, w1
               	b.ne	<addr>
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
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
