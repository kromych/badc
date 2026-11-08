
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
               	stp	x20, x21, [sp, #-0xf0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
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
               	str	q0, [sp, #0x60]
               	str	q1, [sp, #0x70]
               	str	q2, [sp, #0x80]
               	ldr	q0, [sp, #0x60]
               	ldr	q1, [sp, #0x70]
               	ldr	q2, [sp, #0x80]
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
               	str	x16, [sp, #0x60]
               	stur	q1, [sp, #0x68]
               	ldur	q1, [sp, #0x68]
               	sminv	b0, v1.16b
               	ldr	x16, [sp, #0x60]
               	str	b0, [x16]
               	ldursb	x0, [x29, #-0x8]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
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
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x0, v0.d[1]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	sub	x16, x29, #0x48
               	ldr	q0, [x16]
               	stur	q0, [x29, #-0xc0]
               	sub	x0, x29, #0xa0
               	ldurb	w1, [x29, #-0xc0]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0xa0]
               	ldurb	w1, [x29, #-0xbf]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x9f]
               	ldurb	w1, [x29, #-0xbe]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x9e]
               	ldurb	w1, [x29, #-0xbd]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x9d]
               	ldurb	w1, [x29, #-0xbc]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x9c]
               	ldurb	w1, [x29, #-0xbb]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x9b]
               	ldurb	w1, [x29, #-0xba]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x9a]
               	ldurb	w1, [x29, #-0xb9]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x99]
               	ldurb	w1, [x29, #-0xb8]
               	lsl	x2, x1, #1
               	add	x1, x0, #0x8
               	strb	w2, [x1]
               	ldurb	w0, [x29, #-0xb7]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x97]
               	ldurb	w0, [x29, #-0xb6]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x96]
               	ldurb	w0, [x29, #-0xb5]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x95]
               	ldurb	w0, [x29, #-0xb4]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x94]
               	ldurb	w0, [x29, #-0xb3]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x93]
               	ldurb	w0, [x29, #-0xb2]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x92]
               	ldurb	w0, [x29, #-0xb1]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x91]
               	ldursb	x2, [x29, #-0xc0]
               	ldursb	x3, [x29, #-0xbf]
               	ldursb	x4, [x29, #-0xbe]
               	ldursb	x5, [x29, #-0xbd]
               	ldursb	x6, [x29, #-0xbc]
               	ldursb	x7, [x29, #-0xbb]
               	ldursb	x8, [x29, #-0xba]
               	ldursb	x9, [x29, #-0xb9]
               	ldursb	x10, [x29, #-0xb8]
               	ldursb	x11, [x29, #-0xb7]
               	ldursb	x12, [x29, #-0xb6]
               	ldursb	x13, [x29, #-0xb5]
               	ldursb	x14, [x29, #-0xb4]
               	ldursb	x15, [x29, #-0xb3]
               	ldursb	x20, [x29, #-0xb2]
               	ldursb	x21, [x29, #-0xb1]
               	mov	x0, #0x1b               // =27
               	sub	x22, x29, #0x90
               	and	x2, x0, x2, asr #7
               	sturb	w2, [x29, #-0x90]
               	and	x2, x0, x3, asr #7
               	sturb	w2, [x29, #-0x8f]
               	and	x2, x0, x4, asr #7
               	sturb	w2, [x29, #-0x8e]
               	and	x2, x0, x5, asr #7
               	sturb	w2, [x29, #-0x8d]
               	and	x2, x0, x6, asr #7
               	sturb	w2, [x29, #-0x8c]
               	and	x2, x0, x7, asr #7
               	sturb	w2, [x29, #-0x8b]
               	and	x2, x0, x8, asr #7
               	sturb	w2, [x29, #-0x8a]
               	and	x2, x0, x9, asr #7
               	sturb	w2, [x29, #-0x89]
               	and	x3, x0, x10, asr #7
               	add	x2, x22, #0x8
               	strb	w3, [x2]
               	and	x3, x0, x11, asr #7
               	sturb	w3, [x29, #-0x87]
               	and	x3, x0, x12, asr #7
               	sturb	w3, [x29, #-0x86]
               	and	x3, x0, x13, asr #7
               	sturb	w3, [x29, #-0x85]
               	and	x3, x0, x14, asr #7
               	sturb	w3, [x29, #-0x84]
               	and	x3, x0, x15, asr #7
               	sturb	w3, [x29, #-0x83]
               	and	x3, x0, x20, asr #7
               	sturb	w3, [x29, #-0x82]
               	and	x0, x0, x21, asr #7
               	sturb	w0, [x29, #-0x81]
               	ldur	x0, [x29, #-0xa0]
               	ldur	x3, [x29, #-0x90]
               	eor	x0, x0, x3
               	ldr	x1, [x1]
               	ldr	x2, [x2]
               	eor	x1, x1, x2
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	ldur	q0, [x29, #-0xc0]
               	rev32	v0.8h, v0.8h
               	stur	q0, [x29, #-0x90]
               	ldur	x2, [x29, #-0x90]
               	eor	x0, x0, x2
               	ldur	x2, [x29, #-0x88]
               	eor	x1, x1, x2
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	ldur	x2, [x29, #-0xc0]
               	eor	x2, x2, x0
               	stur	x2, [x29, #-0x90]
               	ldur	x2, [x29, #-0xb8]
               	eor	x2, x2, x1
               	stur	x2, [x29, #-0x88]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	ldur	q1, [x29, #-0x90]
               	tbl	v0.16b, { v1.16b }, v0.16b
               	stur	q0, [x29, #-0x90]
               	ldur	x2, [x29, #-0x90]
               	eor	x0, x0, x2
               	ldur	x2, [x29, #-0x88]
               	eor	x1, x1, x2
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	ldur	q0, [x29, #-0xb0]
               	sub	x16, x29, #0x38
               	str	q0, [x16]
               	mov	x4, #0x0                // =0
               	mov	x0, x4
               	and	x2, x0, #0xc
               	and	x3, x0, #0x3
               	sub	x8, x29, #0x18
               	sub	x1, x29, #0x48
               	add	x5, x2, x3
               	ldrb	w5, [x1, x5]
               	tbz	w5, #0x7, <addr>
               	mov	x6, #0x1b               // =27
               	eor	x5, x6, x5, lsl #1
               	and	x9, x5, #0xff
               	add	x5, x3, #0x1
               	and	x5, x5, #0x3
               	add	x5, x2, x5
               	ldrb	w6, [x1, x5]
               	tbz	w6, #0x7, <addr>
               	mov	x7, #0x1b               // =27
               	b	<addr>
               	mov	x7, x4
               	b	<addr>
               	mov	x6, x4
               	b	<addr>
               	eor	x6, x7, x6, lsl #1
               	and	x6, x6, #0xff
               	eor	x6, x9, x6
               	ldrb	w5, [x1, x5]
               	eor	x5, x6, x5
               	add	x6, x3, #0x2
               	and	x6, x6, #0x3
               	add	x6, x2, x6
               	ldrb	w6, [x1, x6]
               	eor	x5, x5, x6
               	add	x3, x3, #0x3
               	and	x3, x3, #0x3
               	add	x2, x2, x3
               	ldrb	w1, [x1, x2]
               	eor	x1, x5, x1
               	strb	w1, [x8, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x38]
               	ldurb	w1, [x29, #-0x18]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
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
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
