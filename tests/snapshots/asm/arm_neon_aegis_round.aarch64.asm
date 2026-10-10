
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
               	stp	x20, x21, [sp, #-0xe0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x40]
               	mov	x0, #0x1c               // =28
               	sturb	w0, [x29, #-0x3f]
               	mov	x0, #0x33               // =51
               	sturb	w0, [x29, #-0x3e]
               	mov	x0, #0x4a               // =74
               	sturb	w0, [x29, #-0x3d]
               	mov	x0, #0x61               // =97
               	sturb	w0, [x29, #-0x3c]
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0x3b]
               	mov	x0, #0x8f               // =143
               	sturb	w0, [x29, #-0x3a]
               	mov	x0, #0xa6               // =166
               	sturb	w0, [x29, #-0x39]
               	mov	x0, #0xbd               // =189
               	sturb	w0, [x29, #-0x38]
               	mov	x0, #0xd4               // =212
               	sturb	w0, [x29, #-0x37]
               	mov	x0, #0xeb               // =235
               	sturb	w0, [x29, #-0x36]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x35]
               	mov	x0, #0x19               // =25
               	sturb	w0, [x29, #-0x34]
               	mov	x0, #0x30               // =48
               	sturb	w0, [x29, #-0x33]
               	mov	x0, #0x47               // =71
               	sturb	w0, [x29, #-0x32]
               	mov	x0, #0x5e               // =94
               	sturb	w0, [x29, #-0x31]
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	rev32	v0.8h, v0.8h
               	sub	x1, x29, #0x10
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	sub	x3, x29, #0x40
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
               	ldurb	w0, [x29, #-0x38]
               	sturb	w0, [x29, #-0x8]
               	ldurb	w0, [x29, #-0x37]
               	sturb	w0, [x29, #-0x7]
               	ldurb	w0, [x29, #-0x36]
               	sturb	w0, [x29, #-0x6]
               	ldurb	w0, [x29, #-0x35]
               	sturb	w0, [x29, #-0x5]
               	ldurb	w0, [x29, #-0x34]
               	sturb	w0, [x29, #-0x4]
               	ldurb	w0, [x29, #-0x33]
               	sturb	w0, [x29, #-0x3]
               	ldurb	w0, [x29, #-0x32]
               	sturb	w0, [x29, #-0x2]
               	ldurb	w0, [x29, #-0x31]
               	sturb	w0, [x29, #-0x1]
               	ldurb	w0, [x29, #-0xb]
               	eor	x0, x0, #0xff
               	sturb	w0, [x29, #-0xb]
               	sub	x3, x29, #0x20
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	sub	x16, x29, #0x10
               	ldr	q1, [x16]
               	cmeq	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrb	w4, [x3, x0]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	mov	x2, x1
               	eor	x2, x4, x2
               	cbz	w2, <addr>
               	b	<addr>
               	mov	x2, #0xff               // =255
               	eor	x2, x4, x2
               	cbnz	w2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x30]
               	mov	x0, #0xc5               // =197
               	sturb	w0, [x29, #-0x2f]
               	mov	x0, #0xc2               // =194
               	sturb	w0, [x29, #-0x2e]
               	mov	x0, #0xbf               // =191
               	sturb	w0, [x29, #-0x2d]
               	mov	x0, #0xbc               // =188
               	sturb	w0, [x29, #-0x2c]
               	mov	x0, #0xb9               // =185
               	sturb	w0, [x29, #-0x2b]
               	mov	x0, #0xb6               // =182
               	sturb	w0, [x29, #-0x2a]
               	mov	x0, #0xb3               // =179
               	sturb	w0, [x29, #-0x29]
               	mov	x0, #0xb0               // =176
               	sturb	w0, [x29, #-0x28]
               	mov	x0, #0xad               // =173
               	sturb	w0, [x29, #-0x27]
               	mov	x0, #0xaa               // =170
               	sturb	w0, [x29, #-0x26]
               	mov	x0, #0xa7               // =167
               	sturb	w0, [x29, #-0x25]
               	mov	x0, #0xa4               // =164
               	sturb	w0, [x29, #-0x24]
               	mov	x0, #0xa1               // =161
               	sturb	w0, [x29, #-0x23]
               	mov	x0, #0x9e               // =158
               	sturb	w0, [x29, #-0x22]
               	mov	x0, #0x9b               // =155
               	sturb	w0, [x29, #-0x21]
               	sub	x3, x29, #0x10
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	sub	x4, x29, #0x30
               	sub	x16, x29, #0x30
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
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w5, [x3, x0]
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x2, x0]
               	ldrb	w1, [x4, x1]
               	eor	x1, x5, x1
               	cbz	w1, <addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	ldrb	w1, [x1, x0]
               	eor	x1, x5, x1
               	cbnz	w1, <addr>
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
               	ldr	q0, [x16]
               	sminv	b7, v0.16b
               	smov	w0, v7.b[0]
               	sxtb	x0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	mov	x1, #0xff00             // =65280
               	movk	x1, #0xddee, lsl #16
               	movk	x1, #0xbbcc, lsl #32
               	movk	x1, #0x99aa, lsl #48
               	stur	x0, [x29, #-0x80]
               	stur	x1, [x29, #-0x78]
               	ldur	q0, [x29, #-0x80]
               	mov	x0, v0.d[0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, v0.d[1]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	stur	q0, [x29, #-0xb0]
               	sub	x0, x29, #0x90
               	ldurb	w1, [x29, #-0xb0]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x90]
               	ldurb	w1, [x29, #-0xaf]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x8f]
               	ldurb	w1, [x29, #-0xae]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x8e]
               	ldurb	w1, [x29, #-0xad]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x8d]
               	ldurb	w1, [x29, #-0xac]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x8c]
               	ldurb	w1, [x29, #-0xab]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x8b]
               	ldurb	w1, [x29, #-0xaa]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x8a]
               	ldurb	w1, [x29, #-0xa9]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x89]
               	ldurb	w1, [x29, #-0xa8]
               	lsl	x2, x1, #1
               	add	x1, x0, #0x8
               	strb	w2, [x1]
               	ldurb	w0, [x29, #-0xa7]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x87]
               	ldurb	w0, [x29, #-0xa6]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x86]
               	ldurb	w0, [x29, #-0xa5]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x85]
               	ldurb	w0, [x29, #-0xa4]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x84]
               	ldurb	w0, [x29, #-0xa3]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x83]
               	ldurb	w0, [x29, #-0xa2]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x82]
               	ldurb	w0, [x29, #-0xa1]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x81]
               	ldursb	x0, [x29, #-0xb0]
               	asr	x2, x0, #7
               	ldursb	x0, [x29, #-0xaf]
               	asr	x3, x0, #7
               	ldursb	x0, [x29, #-0xae]
               	asr	x4, x0, #7
               	ldursb	x0, [x29, #-0xad]
               	asr	x5, x0, #7
               	ldursb	x0, [x29, #-0xac]
               	asr	x6, x0, #7
               	ldursb	x0, [x29, #-0xab]
               	asr	x7, x0, #7
               	ldursb	x0, [x29, #-0xaa]
               	asr	x8, x0, #7
               	ldursb	x0, [x29, #-0xa9]
               	asr	x9, x0, #7
               	ldursb	x0, [x29, #-0xa8]
               	asr	x10, x0, #7
               	ldursb	x0, [x29, #-0xa7]
               	asr	x11, x0, #7
               	ldursb	x0, [x29, #-0xa6]
               	asr	x12, x0, #7
               	ldursb	x0, [x29, #-0xa5]
               	asr	x13, x0, #7
               	ldursb	x0, [x29, #-0xa4]
               	asr	x14, x0, #7
               	ldursb	x0, [x29, #-0xa3]
               	asr	x15, x0, #7
               	ldursb	x0, [x29, #-0xa2]
               	asr	x20, x0, #7
               	ldursb	x0, [x29, #-0xa1]
               	asr	x21, x0, #7
               	mov	x0, #0x1b               // =27
               	sub	x22, x29, #0x80
               	and	x2, x2, x0
               	sturb	w2, [x29, #-0x80]
               	and	x2, x3, x0
               	sturb	w2, [x29, #-0x7f]
               	and	x2, x4, x0
               	sturb	w2, [x29, #-0x7e]
               	and	x2, x5, x0
               	sturb	w2, [x29, #-0x7d]
               	and	x2, x6, x0
               	sturb	w2, [x29, #-0x7c]
               	and	x2, x7, x0
               	sturb	w2, [x29, #-0x7b]
               	and	x2, x8, x0
               	sturb	w2, [x29, #-0x7a]
               	and	x2, x9, x0
               	sturb	w2, [x29, #-0x79]
               	and	x3, x10, x0
               	add	x2, x22, #0x8
               	strb	w3, [x2]
               	and	x3, x11, x0
               	sturb	w3, [x29, #-0x77]
               	and	x3, x12, x0
               	sturb	w3, [x29, #-0x76]
               	and	x3, x13, x0
               	sturb	w3, [x29, #-0x75]
               	and	x3, x14, x0
               	sturb	w3, [x29, #-0x74]
               	and	x3, x15, x0
               	sturb	w3, [x29, #-0x73]
               	and	x3, x20, x0
               	sturb	w3, [x29, #-0x72]
               	and	x0, x21, x0
               	sturb	w0, [x29, #-0x71]
               	ldur	x0, [x29, #-0x90]
               	ldur	x3, [x29, #-0x80]
               	eor	x0, x0, x3
               	ldr	x1, [x1]
               	ldr	x2, [x2]
               	eor	x1, x1, x2
               	stur	x0, [x29, #-0xa0]
               	stur	x1, [x29, #-0x98]
               	ldur	q0, [x29, #-0xb0]
               	rev32	v0.8h, v0.8h
               	stur	q0, [x29, #-0x80]
               	ldur	x2, [x29, #-0x80]
               	eor	x0, x0, x2
               	ldur	x2, [x29, #-0x78]
               	eor	x1, x1, x2
               	stur	x0, [x29, #-0xa0]
               	stur	x1, [x29, #-0x98]
               	ldur	x2, [x29, #-0xb0]
               	eor	x2, x2, x0
               	stur	x2, [x29, #-0x80]
               	ldur	x2, [x29, #-0xa8]
               	eor	x2, x2, x1
               	stur	x2, [x29, #-0x78]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	ldur	q1, [x29, #-0x80]
               	tbl	v0.16b, { v1.16b }, v0.16b
               	stur	q0, [x29, #-0x80]
               	ldur	x2, [x29, #-0x80]
               	eor	x0, x0, x2
               	ldur	x2, [x29, #-0x78]
               	eor	x1, x1, x2
               	stur	x0, [x29, #-0xa0]
               	stur	x1, [x29, #-0x98]
               	ldur	q0, [x29, #-0xa0]
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	mov	x4, #0x0                // =0
               	mov	x0, x4
               	and	x2, x0, #0xc
               	and	x3, x0, #0x3
               	sub	x7, x29, #0x10
               	sub	x1, x29, #0x40
               	add	x5, x2, x3
               	ldrb	w5, [x1, x5]
               	lsl	x6, x5, #1
               	tbz	w5, #0x7, <addr>
               	mov	x5, #0x1b               // =27
               	eor	x5, x6, x5
               	and	x8, x5, #0xff
               	add	x5, x3, #0x1
               	and	x5, x5, #0x3
               	add	x5, x2, x5
               	ldrb	w6, [x1, x5]
               	lsl	x9, x6, #1
               	tbz	w6, #0x7, <addr>
               	mov	x6, #0x1b               // =27
               	b	<addr>
               	mov	x6, x4
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	eor	x6, x9, x6
               	and	x6, x6, #0xff
               	eor	x6, x8, x6
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
               	strb	w1, [x7, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x30]
               	ldurb	w1, [x29, #-0x10]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
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
               	ldurb	w0, [x29, #-0x28]
               	ldurb	w1, [x29, #-0x8]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x27]
               	ldurb	w1, [x29, #-0x7]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x26]
               	ldurb	w1, [x29, #-0x6]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x25]
               	ldurb	w1, [x29, #-0x5]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x24]
               	ldurb	w1, [x29, #-0x4]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x23]
               	ldurb	w1, [x29, #-0x3]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x22]
               	ldurb	w1, [x29, #-0x2]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x21]
               	ldurb	w1, [x29, #-0x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
