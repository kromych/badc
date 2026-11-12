
arm_neon_permutes.aarch64:	file format elf64-littleaarch64

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

<check_s8q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #-0x7f              // =-127
               	sturb	w0, [x29, #-0x20]
               	mov	x0, #-0x3e              // =-62
               	sturb	w0, [x29, #-0x10]
               	mov	x0, #0x7e               // =126
               	sturb	w0, [x29, #-0x1f]
               	mov	x0, #0x42               // =66
               	sturb	w0, [x29, #-0xf]
               	mov	x0, #-0x2               // =-2
               	sturb	w0, [x29, #-0x1e]
               	mov	x0, #-0xd               // =-13
               	sturb	w0, [x29, #-0xe]
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0x1d]
               	mov	x0, #0xc                // =12
               	sturb	w0, [x29, #-0xd]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x1c]
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0xc]
               	sturb	wzr, [x29, #-0x1b]
               	mov	x0, #-0x79              // =-121
               	sturb	w0, [x29, #-0xb]
               	mov	x0, #-0x1               // =-1
               	sturb	w0, [x29, #-0x1a]
               	mov	x0, #-0x8               // =-8
               	sturb	w0, [x29, #-0xa]
               	mov	x1, #0x37               // =55
               	sturb	w1, [x29, #-0x19]
               	mov	x1, #0x6                // =6
               	sturb	w1, [x29, #-0x9]
               	mov	x1, #-0x63              // =-99
               	sturb	w1, [x29, #-0x18]
               	mov	x1, #0x5c               // =92
               	sturb	w1, [x29, #-0x8]
               	mov	x1, #-0x5               // =-5
               	sturb	w1, [x29, #-0x17]
               	mov	x1, #0x54               // =84
               	sturb	w1, [x29, #-0x7]
               	mov	x1, #-0x7c              // =-124
               	sturb	w1, [x29, #-0x16]
               	mov	x1, #-0x55              // =-85
               	sturb	w1, [x29, #-0x6]
               	mov	x1, #0x7b               // =123
               	sturb	w1, [x29, #-0x15]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x5]
               	mov	x1, #0x7                // =7
               	sturb	w1, [x29, #-0x14]
               	sturb	w1, [x29, #-0x4]
               	sturb	w0, [x29, #-0x13]
               	mov	x0, #-0x3               // =-3
               	sturb	w0, [x29, #-0x3]
               	mov	x0, #-0x3f              // =-63
               	sturb	w0, [x29, #-0x12]
               	mov	x0, #0x7d               // =125
               	sturb	w0, [x29, #-0x2]
               	mov	x0, #0x41               // =65
               	sturb	w0, [x29, #-0x11]
               	mov	x0, #-0x7e              // =-126
               	sturb	w0, [x29, #-0x1]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x80
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	zip1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x80]
               	zip2	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x50]
               	trn1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	trn2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldrsb	x4, [x4, x1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x8
               	ldrsb	x5, [x5, x1]
               	cmp	w3, #0x10
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldrsb	x6, [x1, x3]
               	add	x1, x3, #0x1
               	cmp	w1, #0x10
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldrsb	x3, [x3, x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldrsb	x7, [x1, x7]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrsb	x2, [x1, x0]
               	sub	x1, x29, #0x80
               	ldrsb	x8, [x1, x0]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldrsb	x3, [x3, x0]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldrsb	x2, [x1, x2]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldrsb	x7, [x1, x0]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x10
               	ldrsb	x3, [x3, x1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x10
               	ldrsb	x6, [x1, x6]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x8
               	ldrsb	x5, [x5, x1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldrsb	x4, [x4, x1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u8q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x81               // =129
               	sturb	w0, [x29, #-0x20]
               	mov	x0, #0xc2               // =194
               	sturb	w0, [x29, #-0x10]
               	mov	x0, #0x7e               // =126
               	sturb	w0, [x29, #-0x1f]
               	mov	x0, #0x42               // =66
               	sturb	w0, [x29, #-0xf]
               	mov	x0, #0xfe               // =254
               	sturb	w0, [x29, #-0x1e]
               	mov	x0, #0xf3               // =243
               	sturb	w0, [x29, #-0xe]
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0x1d]
               	mov	x0, #0xc                // =12
               	sturb	w0, [x29, #-0xd]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x1c]
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0xc]
               	sturb	wzr, [x29, #-0x1b]
               	mov	x0, #0x87               // =135
               	sturb	w0, [x29, #-0xb]
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x1a]
               	mov	x0, #0xf8               // =248
               	sturb	w0, [x29, #-0xa]
               	mov	x1, #0x37               // =55
               	sturb	w1, [x29, #-0x19]
               	mov	x1, #0x6                // =6
               	sturb	w1, [x29, #-0x9]
               	mov	x1, #0x9d               // =157
               	sturb	w1, [x29, #-0x18]
               	mov	x1, #0x5c               // =92
               	sturb	w1, [x29, #-0x8]
               	mov	x1, #0xfb               // =251
               	sturb	w1, [x29, #-0x17]
               	mov	x1, #0x54               // =84
               	sturb	w1, [x29, #-0x7]
               	mov	x1, #0x84               // =132
               	sturb	w1, [x29, #-0x16]
               	mov	x1, #0xab               // =171
               	sturb	w1, [x29, #-0x6]
               	mov	x1, #0x7b               // =123
               	sturb	w1, [x29, #-0x15]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x5]
               	mov	x1, #0x7                // =7
               	sturb	w1, [x29, #-0x14]
               	sturb	w1, [x29, #-0x4]
               	sturb	w0, [x29, #-0x13]
               	mov	x0, #0xfd               // =253
               	sturb	w0, [x29, #-0x3]
               	mov	x0, #0xc1               // =193
               	sturb	w0, [x29, #-0x12]
               	mov	x0, #0x7d               // =125
               	sturb	w0, [x29, #-0x2]
               	mov	x0, #0x41               // =65
               	sturb	w0, [x29, #-0x11]
               	mov	x0, #0x82               // =130
               	sturb	w0, [x29, #-0x1]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x80
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	zip1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x80]
               	zip2	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x50]
               	trn1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	trn2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldrb	w4, [x4, x1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x8
               	ldrb	w5, [x5, x1]
               	cmp	w3, #0x10
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldrb	w6, [x1, x3]
               	add	x1, x3, #0x1
               	cmp	w1, #0x10
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldrb	w3, [x3, x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldrb	w7, [x1, x7]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrb	w2, [x1, x0]
               	sub	x1, x29, #0x80
               	ldrb	w8, [x1, x0]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrb	w4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldrb	w4, [x4, x0]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldrb	w4, [x4, x0]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldrb	w3, [x3, x0]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldrb	w1, [x1, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldrb	w2, [x1, x2]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldrb	w7, [x1, x0]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x10
               	ldrb	w3, [x3, x1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x10
               	ldrb	w6, [x1, x6]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x8
               	ldrb	w5, [x5, x1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldrb	w4, [x4, x1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x50
               	mov	x1, #0x181              // =385
               	sturh	w1, [x29, #-0x50]
               	sub	x1, x29, #0x48
               	mov	x2, #0x3c2              // =962
               	sturh	w2, [x29, #-0x48]
               	mov	x2, #0x17e              // =382
               	sturh	w2, [x29, #-0x4e]
               	mov	x2, #0x142              // =322
               	sturh	w2, [x29, #-0x46]
               	mov	x2, #0x2fe              // =766
               	sturh	w2, [x29, #-0x4c]
               	mov	x2, #0x4f3              // =1267
               	sturh	w2, [x29, #-0x44]
               	mov	x2, #0x4                // =4
               	sturh	w2, [x29, #-0x4a]
               	mov	x2, #0xc                // =12
               	sturh	w2, [x29, #-0x42]
               	sub	x2, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0x38
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x30]
               	zip2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x28]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x20]
               	uzp2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x10]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x48
               	ldrsh	x4, [x4, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x48
               	add	x1, x1, #0x2
               	ldrsh	x5, [x5, x1, lsl #1]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	sub	x1, x29, #0x50
               	ldrsh	x6, [x1, x3, lsl #1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x50
               	ldrsh	x3, [x3, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x48
               	sub	x7, x0, #0x1
               	ldrsh	x7, [x1, x7, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x48
               	ldrsh	x2, [x1, x0, lsl #1]
               	sub	x1, x29, #0x30
               	ldrsh	x8, [x1, x0, lsl #1]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x8
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x18
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldrsh	x3, [x3, x0, lsl #1]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x50
               	add	x2, x0, #0x1
               	ldrsh	x2, [x1, x2, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x50
               	ldrsh	x7, [x1, x0, lsl #1]
               	b	<addr>
               	sub	x3, x29, #0x48
               	sub	x1, x1, #0x4
               	ldrsh	x3, [x3, x1, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x48
               	sub	x6, x3, #0x4
               	ldrsh	x6, [x1, x6, lsl #1]
               	b	<addr>
               	sub	x5, x29, #0x50
               	add	x1, x1, #0x2
               	ldrsh	x5, [x5, x1, lsl #1]
               	b	<addr>
               	sub	x4, x29, #0x50
               	ldrsh	x4, [x4, x1, lsl #1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s16q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x181              // =385
               	sturh	w0, [x29, #-0x20]
               	mov	x0, #0x3c2              // =962
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x17e              // =382
               	sturh	w0, [x29, #-0x1e]
               	mov	x0, #0x142              // =322
               	sturh	w0, [x29, #-0xe]
               	mov	x0, #0x2fe              // =766
               	sturh	w0, [x29, #-0x1c]
               	mov	x0, #0x4f3              // =1267
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x4                // =4
               	sturh	w0, [x29, #-0x1a]
               	mov	x0, #0xc                // =12
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0x1                // =1
               	sturh	w0, [x29, #-0x18]
               	mov	x0, #0x278              // =632
               	sturh	w0, [x29, #-0x8]
               	mov	x0, #0x100              // =256
               	sturh	w0, [x29, #-0x16]
               	mov	x0, #0x287              // =647
               	sturh	w0, [x29, #-0x6]
               	mov	x0, #0x1ff              // =511
               	sturh	w0, [x29, #-0x14]
               	mov	x0, #0x4f8              // =1272
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x37               // =55
               	sturh	w0, [x29, #-0x12]
               	mov	x0, #0x106              // =262
               	sturh	w0, [x29, #-0x2]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x80
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	zip1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x80]
               	zip2	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x50]
               	trn1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	trn2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldrsh	x4, [x4, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x4
               	ldrsh	x5, [x5, x1, lsl #1]
               	cmp	w3, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldrsh	x6, [x1, x3, lsl #1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldrsh	x3, [x3, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldrsh	x7, [x1, x7, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrsh	x2, [x1, x0, lsl #1]
               	sub	x1, x29, #0x80
               	ldrsh	x8, [x1, x0, lsl #1]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldrsh	x3, [x3, x0, lsl #1]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldrsh	x2, [x1, x2, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldrsh	x7, [x1, x0, lsl #1]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x8
               	ldrsh	x3, [x3, x1, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x8
               	ldrsh	x6, [x1, x6, lsl #1]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x4
               	ldrsh	x5, [x5, x1, lsl #1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldrsh	x4, [x4, x1, lsl #1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x50
               	mov	x1, #0x181              // =385
               	sturh	w1, [x29, #-0x50]
               	sub	x1, x29, #0x48
               	mov	x2, #0x3c2              // =962
               	sturh	w2, [x29, #-0x48]
               	mov	x2, #0x17e              // =382
               	sturh	w2, [x29, #-0x4e]
               	mov	x2, #0x142              // =322
               	sturh	w2, [x29, #-0x46]
               	mov	x2, #0x2fe              // =766
               	sturh	w2, [x29, #-0x4c]
               	mov	x2, #0x4f3              // =1267
               	sturh	w2, [x29, #-0x44]
               	mov	x2, #0x4                // =4
               	sturh	w2, [x29, #-0x4a]
               	mov	x2, #0xc                // =12
               	sturh	w2, [x29, #-0x42]
               	sub	x2, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0x38
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x30]
               	zip2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x28]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x20]
               	uzp2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x10]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x48
               	ldrh	w4, [x4, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x48
               	add	x1, x1, #0x2
               	ldrh	w5, [x5, x1, lsl #1]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	sub	x1, x29, #0x50
               	ldrh	w6, [x1, x3, lsl #1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x50
               	ldrh	w3, [x3, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x48
               	sub	x7, x0, #0x1
               	ldrh	w7, [x1, x7, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x48
               	ldrh	w2, [x1, x0, lsl #1]
               	sub	x1, x29, #0x30
               	ldrh	w8, [x1, x0, lsl #1]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x8
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x18
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldrh	w3, [x3, x0, lsl #1]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x50
               	add	x2, x0, #0x1
               	ldrh	w2, [x1, x2, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x50
               	ldrh	w7, [x1, x0, lsl #1]
               	b	<addr>
               	sub	x3, x29, #0x48
               	sub	x1, x1, #0x4
               	ldrh	w3, [x3, x1, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x48
               	sub	x6, x3, #0x4
               	ldrh	w6, [x1, x6, lsl #1]
               	b	<addr>
               	sub	x5, x29, #0x50
               	add	x1, x1, #0x2
               	ldrh	w5, [x5, x1, lsl #1]
               	b	<addr>
               	sub	x4, x29, #0x50
               	ldrh	w4, [x4, x1, lsl #1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u16q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x181              // =385
               	sturh	w0, [x29, #-0x20]
               	mov	x0, #0x3c2              // =962
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x17e              // =382
               	sturh	w0, [x29, #-0x1e]
               	mov	x0, #0x142              // =322
               	sturh	w0, [x29, #-0xe]
               	mov	x0, #0x2fe              // =766
               	sturh	w0, [x29, #-0x1c]
               	mov	x0, #0x4f3              // =1267
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x4                // =4
               	sturh	w0, [x29, #-0x1a]
               	mov	x0, #0xc                // =12
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0x1                // =1
               	sturh	w0, [x29, #-0x18]
               	mov	x0, #0x278              // =632
               	sturh	w0, [x29, #-0x8]
               	mov	x0, #0x100              // =256
               	sturh	w0, [x29, #-0x16]
               	mov	x0, #0x287              // =647
               	sturh	w0, [x29, #-0x6]
               	mov	x0, #0x1ff              // =511
               	sturh	w0, [x29, #-0x14]
               	mov	x0, #0x4f8              // =1272
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x37               // =55
               	sturh	w0, [x29, #-0x12]
               	mov	x0, #0x106              // =262
               	sturh	w0, [x29, #-0x2]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x80
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	zip1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x80]
               	zip2	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x50]
               	trn1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	trn2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldrh	w4, [x4, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x4
               	ldrh	w5, [x5, x1, lsl #1]
               	cmp	w3, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldrh	w6, [x1, x3, lsl #1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldrh	w3, [x3, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldrh	w7, [x1, x7, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrh	w2, [x1, x0, lsl #1]
               	sub	x1, x29, #0x80
               	ldrh	w8, [x1, x0, lsl #1]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldrh	w3, [x3, x0, lsl #1]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldrh	w2, [x1, x2, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldrh	w7, [x1, x0, lsl #1]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x8
               	ldrh	w3, [x3, x1, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x8
               	ldrh	w6, [x1, x6, lsl #1]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x4
               	ldrh	w5, [x5, x1, lsl #1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldrh	w4, [x4, x1, lsl #1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x50
               	mov	x1, #0x181              // =385
               	stur	w1, [x29, #-0x50]
               	sub	x1, x29, #0x48
               	mov	x2, #0x3c2              // =962
               	stur	w2, [x29, #-0x48]
               	mov	x2, #0x17e              // =382
               	stur	w2, [x29, #-0x4c]
               	mov	x2, #0x142              // =322
               	stur	w2, [x29, #-0x44]
               	sub	x2, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0x38
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x30]
               	zip2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x28]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	uzp1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x20]
               	uzp2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	trn1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x10]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	and	x1, x0, #0x1
               	lsl	x2, x0, #1
               	cbz	x1, <addr>
               	ldursw	x3, [x29, #-0x48]
               	cbz	x1, <addr>
               	ldursw	x4, [x29, #-0x44]
               	cmp	w2, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x50
               	ldrsw	x5, [x5, x2, lsl #2]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	ldursw	x2, [x29, #-0x4c]
               	cbz	x1, <addr>
               	sub	x6, x29, #0x48
               	sub	x7, x0, #0x1
               	ldrsw	x6, [x6, x7, lsl #2]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x48
               	ldrsw	x7, [x1, x0, lsl #2]
               	sub	x1, x29, #0x30
               	ldrsw	x8, [x1, x0, lsl #2]
               	cmp	w8, w3
               	b.ne	<addr>
               	add	x3, x1, #0x8
               	ldrsw	x3, [x3, x0, lsl #2]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	ldrsw	x3, [x3, x0, lsl #2]
               	cmp	w3, w5
               	b.ne	<addr>
               	add	x3, x1, #0x18
               	ldrsw	x3, [x3, x0, lsl #2]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x2, x1, #0x20
               	ldrsw	x2, [x2, x0, lsl #2]
               	cmp	w2, w6
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w7
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x50
               	add	x7, x0, #0x1
               	ldrsw	x7, [x1, x7, lsl #2]
               	b	<addr>
               	sub	x6, x29, #0x50
               	ldrsw	x6, [x6, x0, lsl #2]
               	b	<addr>
               	sub	x6, x29, #0x48
               	sub	x2, x2, #0x2
               	ldrsw	x2, [x6, x2, lsl #2]
               	b	<addr>
               	ldursw	x5, [x29, #-0x48]
               	b	<addr>
               	ldursw	x4, [x29, #-0x4c]
               	b	<addr>
               	ldursw	x3, [x29, #-0x50]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u32q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x181              // =385
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x3c2              // =962
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x17e              // =382
               	stur	w0, [x29, #-0x1c]
               	mov	x0, #0x142              // =322
               	stur	w0, [x29, #-0xc]
               	mov	x0, #0x2fe              // =766
               	stur	w0, [x29, #-0x18]
               	mov	x0, #0x4f3              // =1267
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x14]
               	mov	x0, #0xc                // =12
               	stur	w0, [x29, #-0x4]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x80
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	zip1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x80]
               	zip2	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x50]
               	trn1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	trn2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldr	w4, [x4, x1, lsl #2]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x2
               	ldr	w5, [x5, x1, lsl #2]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldr	w6, [x1, x3, lsl #2]
               	add	x1, x3, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldr	w3, [x3, x1, lsl #2]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldr	w7, [x1, x7, lsl #2]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldr	w2, [x1, x0, lsl #2]
               	sub	x1, x29, #0x80
               	ldr	w8, [x1, x0, lsl #2]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldr	w3, [x3, x0, lsl #2]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldr	w1, [x1, x0, lsl #2]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldr	w2, [x1, x2, lsl #2]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldr	w7, [x1, x0, lsl #2]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x4
               	ldr	w3, [x3, x1, lsl #2]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x4
               	ldr	w6, [x1, x6, lsl #2]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x2
               	ldr	w5, [x5, x1, lsl #2]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldr	w4, [x4, x1, lsl #2]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x50
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x78]
               	stur	s0, [x29, #-0x50]
               	sub	x1, x29, #0x48
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x7c]
               	stur	s0, [x29, #-0x48]
               	mov	x16, #0x43bf0000        // =1136590848
               	fmov	s0, w16
               	stur	s0, [x29, #-0x4c]
               	mov	x16, #0x43a10000        // =1134624768
               	fmov	s0, w16
               	stur	s0, [x29, #-0x44]
               	sub	x2, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0x38
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x30]
               	zip2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x28]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	uzp1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x20]
               	uzp2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	trn1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x10]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	and	x1, x0, #0x1
               	lsl	x2, x0, #1
               	cbz	x1, <addr>
               	ldur	s0, [x29, #-0x48]
               	cbz	x1, <addr>
               	ldur	s1, [x29, #-0x44]
               	cmp	w2, #0x2
               	b.ge	<addr>
               	sub	x3, x29, #0x50
               	add	x3, x3, x2, lsl #2
               	ldr	s2, [x3]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	ldur	s3, [x29, #-0x4c]
               	cbz	x1, <addr>
               	sub	x2, x29, #0x48
               	sub	x3, x0, #0x1
               	add	x2, x2, x3, lsl #2
               	ldr	s4, [x2]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x48
               	add	x1, x1, x0, lsl #2
               	ldr	s5, [x1]
               	sub	x1, x29, #0x30
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	ldr	s6, [x3]
               	fcmp	s6, s0
               	b.ne	<addr>
               	add	x3, x1, #0x8
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s1
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s2
               	b.ne	<addr>
               	add	x3, x1, #0x18
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s4
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	add	x1, x1, x2
               	ldr	s0, [x1]
               	fcmp	s0, s5
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x50
               	add	x2, x0, #0x1
               	add	x1, x1, x2, lsl #2
               	ldr	s5, [x1]
               	b	<addr>
               	sub	x2, x29, #0x50
               	add	x2, x2, x0, lsl #2
               	ldr	s4, [x2]
               	b	<addr>
               	sub	x3, x29, #0x48
               	sub	x2, x2, #0x2
               	add	x2, x3, x2, lsl #2
               	ldr	s3, [x2]
               	b	<addr>
               	ldur	s2, [x29, #-0x48]
               	b	<addr>
               	ldur	s1, [x29, #-0x4c]
               	b	<addr>
               	ldur	s0, [x29, #-0x50]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f32q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x78]
               	stur	s0, [x29, #-0x20]
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x7c]
               	stur	s0, [x29, #-0x10]
               	mov	x16, #0x43bf0000        // =1136590848
               	fmov	s0, w16
               	stur	s0, [x29, #-0x1c]
               	mov	x16, #0x43a10000        // =1134624768
               	fmov	s0, w16
               	stur	s0, [x29, #-0xc]
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x80]
               	stur	s0, [x29, #-0x18]
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x84]
               	stur	s0, [x29, #-0x8]
               	fmov	s0, #4.00000000
               	stur	s0, [x29, #-0x14]
               	fmov	s0, #12.00000000
               	stur	s0, [x29, #-0x4]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x80
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	zip1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x80]
               	zip2	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x50]
               	trn1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	trn2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	add	x4, x4, x1, lsl #2
               	ldr	s0, [x4]
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	add	x1, x1, #0x2
               	add	x1, x4, x1, lsl #2
               	ldr	s1, [x1]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	add	x1, x1, x3, lsl #2
               	ldr	s2, [x1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	add	x1, x3, x1, lsl #2
               	ldr	s3, [x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x3, x0, #0x1
               	add	x1, x1, x3, lsl #2
               	ldr	s4, [x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	add	x1, x1, x0, lsl #2
               	ldr	s5, [x1]
               	sub	x1, x29, #0x80
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	ldr	s6, [x3]
               	fcmp	s6, s0
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s1
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s2
               	b.ne	<addr>
               	add	x3, x1, #0x30
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s4
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	add	x1, x1, x2
               	ldr	s0, [x1]
               	fcmp	s0, s5
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	add	x1, x1, x2, lsl #2
               	ldr	s5, [x1]
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x1, x1, x0, lsl #2
               	ldr	s4, [x1]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x4
               	add	x1, x3, x1, lsl #2
               	ldr	s3, [x1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x4, x3, #0x4
               	add	x1, x1, x4, lsl #2
               	ldr	s2, [x1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	add	x1, x1, #0x2
               	add	x1, x4, x1, lsl #2
               	ldr	s1, [x1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	add	x4, x4, x1, lsl #2
               	ldr	s0, [x4]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s64q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x181              // =385
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x3c2              // =962
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x17e              // =382
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x142              // =322
               	stur	x0, [x29, #-0x8]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x80
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	zip1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x80]
               	zip2	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x50]
               	trn1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x40]
               	trn2	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	and	x1, x0, #0x1
               	lsl	x2, x0, #1
               	cbz	x1, <addr>
               	ldur	x3, [x29, #-0x10]
               	cbz	x1, <addr>
               	ldur	x4, [x29, #-0x8]
               	cmp	w2, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x20
               	ldr	x5, [x5, x2, lsl #3]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	ldur	x2, [x29, #-0x18]
               	cbz	x1, <addr>
               	sub	x6, x29, #0x10
               	sub	x7, x0, #0x1
               	ldr	x6, [x6, x7, lsl #3]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x10
               	ldr	x7, [x1, x0, lsl #3]
               	sub	x1, x29, #0x80
               	ldr	x8, [x1, x0, lsl #3]
               	cmp	x8, x3
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	ldr	x3, [x3, x0, lsl #3]
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldr	x3, [x3, x0, lsl #3]
               	cmp	x3, x5
               	b.ne	<addr>
               	add	x3, x1, #0x30
               	ldr	x3, [x3, x0, lsl #3]
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x2, x1, #0x40
               	ldr	x2, [x2, x0, lsl #3]
               	cmp	x2, x6
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x7, x0, #0x1
               	ldr	x7, [x1, x7, lsl #3]
               	b	<addr>
               	sub	x6, x29, #0x20
               	ldr	x6, [x6, x0, lsl #3]
               	b	<addr>
               	sub	x6, x29, #0x10
               	sub	x2, x2, #0x2
               	ldr	x2, [x6, x2, lsl #3]
               	b	<addr>
               	ldur	x5, [x29, #-0x10]
               	b	<addr>
               	ldur	x4, [x29, #-0x18]
               	b	<addr>
               	ldur	x3, [x29, #-0x20]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f64q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x58]
               	stur	d0, [x29, #-0x20]
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x60]
               	stur	d0, [x29, #-0x10]
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x68]
               	stur	d0, [x29, #-0x18]
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x70]
               	stur	d0, [x29, #-0x8]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x80
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	zip1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x80]
               	zip2	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x50]
               	trn1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x40]
               	trn2	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	and	x1, x0, #0x1
               	lsl	x2, x0, #1
               	cbz	x1, <addr>
               	ldur	d0, [x29, #-0x10]
               	cbz	x1, <addr>
               	ldur	d1, [x29, #-0x8]
               	cmp	w2, #0x2
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	add	x3, x3, x2, lsl #3
               	ldr	d2, [x3]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	ldur	d3, [x29, #-0x18]
               	cbz	x1, <addr>
               	sub	x2, x29, #0x10
               	sub	x3, x0, #0x1
               	add	x2, x2, x3, lsl #3
               	ldr	d4, [x2]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x10
               	add	x1, x1, x0, lsl #3
               	ldr	d5, [x1]
               	sub	x1, x29, #0x80
               	lsl	x2, x0, #3
               	add	x3, x1, x2
               	ldr	d6, [x3]
               	fcmp	d6, d0
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	add	x3, x3, x2
               	ldr	d0, [x3]
               	fcmp	d0, d1
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	add	x3, x3, x2
               	ldr	d0, [x3]
               	fcmp	d0, d2
               	b.ne	<addr>
               	add	x3, x1, #0x30
               	add	x3, x3, x2
               	ldr	d0, [x3]
               	fcmp	d0, d3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	add	x3, x3, x2
               	ldr	d0, [x3]
               	fcmp	d0, d4
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	add	x1, x1, x2
               	ldr	d0, [x1]
               	fcmp	d0, d5
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	add	x1, x1, x2, lsl #3
               	ldr	d5, [x1]
               	b	<addr>
               	sub	x2, x29, #0x20
               	add	x2, x2, x0, lsl #3
               	ldr	d4, [x2]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x2, x2, #0x2
               	add	x2, x3, x2, lsl #3
               	ldr	d3, [x2]
               	b	<addr>
               	ldur	d2, [x29, #-0x10]
               	b	<addr>
               	ldur	d1, [x29, #-0x18]
               	b	<addr>
               	ldur	d0, [x29, #-0x20]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_pairs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x10]
               	adrp	x0, <addr>
               	ldr	d1, [x0, #0x18]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x10]
               	zip2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x2, [x29, #-0x10]
               	ldur	x3, [x29, #-0x8]
               	sub	x1, x29, #0x90
               	stur	x2, [x29, #-0x90]
               	stur	x3, [x29, #-0x88]
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x10]
               	uzp2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x3, [x29, #-0x10]
               	ldur	x4, [x29, #-0x8]
               	sub	x2, x29, #0x80
               	stur	x3, [x29, #-0x80]
               	stur	x4, [x29, #-0x78]
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x10]
               	trn2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x8]
               	ldur	x4, [x29, #-0x10]
               	ldur	x5, [x29, #-0x8]
               	sub	x3, x29, #0x70
               	stur	x4, [x29, #-0x70]
               	stur	x5, [x29, #-0x68]
               	sub	x5, x29, #0x60
               	stp	xzr, xzr, [x5]
               	stp	xzr, xzr, [x5, #0x10]
               	stp	xzr, xzr, [x5, #0x20]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x60]
               	zip2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x58]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x50]
               	uzp2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x48]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x40]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x38]
               	sub	x4, x29, #0x30
               	stp	xzr, xzr, [x4]
               	stp	xzr, xzr, [x4, #0x10]
               	stp	xzr, xzr, [x4, #0x20]
               	ldr	x16, [x1]
               	str	x16, [x4]
               	add	x1, x1, #0x8
               	add	x6, x4, #0x8
               	ldr	x16, [x1]
               	str	x16, [x6]
               	add	x1, x4, #0x10
               	ldr	x16, [x2]
               	str	x16, [x1]
               	add	x1, x2, #0x8
               	add	x2, x4, #0x18
               	ldr	x16, [x1]
               	str	x16, [x2]
               	add	x1, x4, #0x20
               	ldr	x16, [x3]
               	str	x16, [x1]
               	add	x1, x3, #0x8
               	add	x2, x4, #0x28
               	ldr	x16, [x1]
               	str	x16, [x2]
               	lsl	x2, x0, #3
               	add	x1, x4, x2
               	ldrsh	x6, [x1]
               	add	x3, x5, x2
               	ldrsh	x7, [x3]
               	cmp	w6, w7
               	b.ne	<addr>
               	ldrsh	x6, [x1, #0x2]
               	ldrsh	x7, [x3, #0x2]
               	cmp	w6, w7
               	b.ne	<addr>
               	ldrsh	x6, [x1, #0x4]
               	ldrsh	x3, [x3, #0x4]
               	cmp	w6, w3
               	b.ne	<addr>
               	ldrsh	x1, [x1, #0x6]
               	sub	x3, x29, #0x60
               	add	x2, x3, x2
               	ldrsh	x2, [x2, #0x6]
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_ext>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x80               // =128
               	sturb	w0, [x29, #-0x20]
               	mov	x1, #0x81               // =129
               	sturb	w1, [x29, #-0x10]
               	mov	x1, #0x7f               // =127
               	sturb	w1, [x29, #-0x1f]
               	sturb	w0, [x29, #-0xf]
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x1e]
               	sturb	wzr, [x29, #-0xe]
               	mov	x3, #0x1                // =1
               	sturb	w3, [x29, #-0x1d]
               	mov	x4, #0x2                // =2
               	sturb	w4, [x29, #-0xd]
               	sturb	wzr, [x29, #-0x1c]
               	sturb	w3, [x29, #-0xc]
               	mov	x2, #0x55               // =85
               	sturb	w2, [x29, #-0x1b]
               	mov	x2, #0x56               // =86
               	sturb	w2, [x29, #-0xb]
               	mov	x2, #0xaa               // =170
               	sturb	w2, [x29, #-0x1a]
               	mov	x2, #0xab               // =171
               	sturb	w2, [x29, #-0xa]
               	mov	x2, #0x12               // =18
               	sturb	w2, [x29, #-0x19]
               	mov	x2, #0x13               // =19
               	sturb	w2, [x29, #-0x9]
               	mov	x2, #0x34               // =52
               	sturb	w2, [x29, #-0x18]
               	mov	x2, #0x35               // =53
               	sturb	w2, [x29, #-0x8]
               	mov	x2, #0xfe               // =254
               	sturb	w2, [x29, #-0x17]
               	sturb	w0, [x29, #-0x7]
               	sub	x0, x29, #0x20
               	mov	x3, #0x81               // =129
               	sturb	w3, [x29, #-0x16]
               	sub	x3, x29, #0x10
               	mov	x5, #0x82               // =130
               	sturb	w5, [x29, #-0x6]
               	mov	x5, #0x7e               // =126
               	sturb	w5, [x29, #-0x15]
               	sturb	w1, [x29, #-0x5]
               	sturb	w4, [x29, #-0x14]
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x4]
               	mov	x1, #0xfd               // =253
               	sturb	w1, [x29, #-0x13]
               	sturb	w2, [x29, #-0x3]
               	mov	x1, #0x40               // =64
               	sturb	w1, [x29, #-0x12]
               	mov	x1, #0x41               // =65
               	sturb	w1, [x29, #-0x2]
               	mov	x1, #0xc0               // =192
               	sturb	w1, [x29, #-0x11]
               	mov	x1, #0xc1               // =193
               	sturb	w1, [x29, #-0x1]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	sub	x5, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x5]
               	sub	x6, x29, #0x38
               	ldr	x16, [x3]
               	str	x16, [x6]
               	sub	x1, x29, #0x30
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x4, x29, #0x28
               	ldr	x16, [x3]
               	str	x16, [x4]
               	ext	v0.16b, v0.16b, v1.16b, #0x5
               	sub	x7, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	ext	v0.8b, v0.8b, v1.8b, #0x3
               	stur	d0, [x29, #-0x40]
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x28]
               	ext	v0.8b, v0.8b, v1.8b, #0x6
               	stur	d0, [x29, #-0x38]
               	sub	x2, x29, #0x20
               	ldr	x16, [x2]
               	str	x16, [x1]
               	sub	x3, x29, #0x10
               	ldr	x16, [x3]
               	str	x16, [x4]
               	mov	x0, #0x0                // =0
               	ldrb	w8, [x7, x0]
               	add	x1, x0, #0x5
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x2, x1]
               	cmp	w8, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x0, #0xb
               	ldrb	w1, [x3, x1]
               	cmp	w8, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w7, [x5, x0]
               	add	x1, x0, #0x3
               	cmp	w1, #0x8
               	b.ge	<addr>
               	ldrb	w1, [x2, x1]
               	cmp	w7, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x0, #0x5
               	ldrb	w1, [x3, x1]
               	cmp	w7, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldursh	x2, [x29, #-0x2a]
               	ldrsh	x3, [x6, x0, lsl #1]
               	add	x1, x0, #0x3
               	cmp	w1, #0x4
               	b.ge	<addr>
               	mov	x1, x2
               	cmp	w3, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x0, #0x1
               	ldrsh	x1, [x4, x1, lsl #1]
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	ext	v0.16b, v0.16b, v1.16b, #0x8
               	mov	d1, v0.d[0]
               	fmov	d2, #2.50000000
               	fcmp	d1, d2
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #3.50000000
               	fcmp	d0, d1
               	cset	x0, ne
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_dup>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x1, x29, #0x28
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	q0, [x0]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d1, [x29, #-0x28]
               	dup	v1.8b, v1.b[5]
               	sub	x1, x29, #0x20
               	stur	d1, [x29, #-0x20]
               	dup	v1.8b, v0.b[13]
               	sub	x2, x29, #0x18
               	stur	d1, [x29, #-0x18]
               	ldur	d1, [x29, #-0x28]
               	dup	v1.16b, v1.b[7]
               	sub	x3, x29, #0x70
               	stur	q1, [x29, #-0x70]
               	dup	v1.16b, v0.b[15]
               	sub	x4, x29, #0x60
               	stur	q1, [x29, #-0x60]
               	dup	v1.4h, v0.h[6]
               	sub	x5, x29, #0x8
               	stur	d1, [x29, #-0x8]
               	dup	v0.8h, v0.h[3]
               	sub	x6, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x40]
               	dup	v0.4s, v0.s[1]
               	sub	x7, x29, #0x40
               	stur	q0, [x29, #-0x40]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	dup	v2.2d, v0.d[1]
               	mov	x0, #0x0                // =0
               	mov	x8, #-0x40              // =-64
               	mov	x9, #-0x3               // =-3
               	mov	x10, #0x12aa            // =4778
               	mov	x11, #0xfd02            // =64770
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrsb	x12, [x1, x0]
               	cmp	w12, #0x55
               	b.ne	<addr>
               	ldrsb	x12, [x2, x0]
               	cmp	w12, w9
               	b.ne	<addr>
               	ldrsb	x12, [x3, x0]
               	cmp	w12, #0x12
               	b.ne	<addr>
               	ldrsb	x12, [x4, x0]
               	cmp	w12, w8
               	b.ne	<addr>
               	cmp	w0, #0x4
               	b.ge	<addr>
               	ldrh	w12, [x5, x0, lsl #1]
               	cmp	w12, w11
               	b.ne	<addr>
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrh	w12, [x6, x0, lsl #1]
               	cmp	w12, w10
               	b.ne	<addr>
               	cmp	w0, #0x4
               	b.ge	<addr>
               	add	x12, x7, x0, lsl #2
               	ldr	s0, [x12]
               	fmov	s1, #-2.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, v2.d[0]
               	mov	x17, #-0x9              // =-9
               	cmp	x0, x17
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	mov	x0, v2.d[1]
               	mov	x17, #-0x9              // =-9
               	cmp	x0, x17
               	cset	x0, ne
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sub	x1, x29, #0x50
               	mov	x0, #-0x7f              // =-127
               	sturb	w0, [x29, #-0x50]
               	sub	x2, x29, #0x48
               	mov	x0, #-0x3e              // =-62
               	sturb	w0, [x29, #-0x48]
               	mov	x0, #0x7e               // =126
               	sturb	w0, [x29, #-0x4f]
               	mov	x0, #0x42               // =66
               	sturb	w0, [x29, #-0x47]
               	mov	x0, #-0x2               // =-2
               	sturb	w0, [x29, #-0x4e]
               	mov	x0, #-0xd               // =-13
               	sturb	w0, [x29, #-0x46]
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0x4d]
               	mov	x0, #0xc                // =12
               	sturb	w0, [x29, #-0x45]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x4c]
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0x44]
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x4b]
               	mov	x3, #-0x79              // =-121
               	sturb	w3, [x29, #-0x43]
               	mov	x3, #-0x1               // =-1
               	sturb	w3, [x29, #-0x4a]
               	mov	x3, #-0x8               // =-8
               	sturb	w3, [x29, #-0x42]
               	mov	x3, #0x37               // =55
               	sturb	w3, [x29, #-0x49]
               	mov	x3, #0x6                // =6
               	sturb	w3, [x29, #-0x41]
               	sub	x3, x29, #0x40
               	ldr	x16, [x1]
               	str	x16, [x3]
               	sub	x1, x29, #0x38
               	ldr	x16, [x2]
               	str	x16, [x1]
               	sub	x1, x29, #0x30
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x30]
               	zip2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x28]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	uzp1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x20]
               	uzp2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	trn1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x10]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x48
               	ldrsb	x4, [x4, x1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x48
               	add	x1, x1, #0x4
               	ldrsb	x5, [x5, x1]
               	cmp	w3, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x50
               	ldrsb	x6, [x1, x3]
               	add	x1, x3, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x50
               	ldrsb	x3, [x3, x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x48
               	sub	x7, x0, #0x1
               	ldrsb	x7, [x1, x7]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x48
               	ldrsb	x2, [x1, x0]
               	sub	x1, x29, #0x30
               	ldrsb	x8, [x1, x0]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x8
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x18
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldrsb	x3, [x3, x0]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x50
               	add	x2, x0, #0x1
               	ldrsb	x2, [x1, x2]
               	b	<addr>
               	sub	x1, x29, #0x50
               	ldrsb	x7, [x1, x0]
               	b	<addr>
               	sub	x3, x29, #0x48
               	sub	x1, x1, #0x8
               	ldrsb	x3, [x3, x1]
               	b	<addr>
               	sub	x1, x29, #0x48
               	sub	x6, x3, #0x8
               	ldrsb	x6, [x1, x6]
               	b	<addr>
               	sub	x5, x29, #0x50
               	add	x1, x1, #0x4
               	ldrsb	x5, [x5, x1]
               	b	<addr>
               	sub	x4, x29, #0x50
               	ldrsb	x4, [x4, x1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	orr	x9, x20, x0, lsl #1
               	sub	x1, x29, #0x50
               	mov	x0, #0x81               // =129
               	sturb	w0, [x29, #-0x50]
               	sub	x2, x29, #0x48
               	mov	x0, #0xc2               // =194
               	sturb	w0, [x29, #-0x48]
               	mov	x0, #0x7e               // =126
               	sturb	w0, [x29, #-0x4f]
               	mov	x0, #0x42               // =66
               	sturb	w0, [x29, #-0x47]
               	mov	x0, #0xfe               // =254
               	sturb	w0, [x29, #-0x4e]
               	mov	x0, #0xf3               // =243
               	sturb	w0, [x29, #-0x46]
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0x4d]
               	mov	x0, #0xc                // =12
               	sturb	w0, [x29, #-0x45]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x4c]
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0x44]
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x4b]
               	mov	x3, #0x87               // =135
               	sturb	w3, [x29, #-0x43]
               	mov	x3, #0xff               // =255
               	sturb	w3, [x29, #-0x4a]
               	mov	x3, #0xf8               // =248
               	sturb	w3, [x29, #-0x42]
               	mov	x3, #0x37               // =55
               	sturb	w3, [x29, #-0x49]
               	mov	x3, #0x6                // =6
               	sturb	w3, [x29, #-0x41]
               	sub	x3, x29, #0x40
               	ldr	x16, [x1]
               	str	x16, [x3]
               	sub	x1, x29, #0x38
               	ldr	x16, [x2]
               	str	x16, [x1]
               	sub	x1, x29, #0x30
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x30]
               	zip2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x28]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	uzp1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x20]
               	uzp2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	trn1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x10]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x48
               	ldrb	w4, [x4, x1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x48
               	add	x1, x1, #0x4
               	ldrb	w5, [x5, x1]
               	cmp	w3, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x50
               	ldrb	w6, [x1, x3]
               	add	x1, x3, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x50
               	ldrb	w3, [x3, x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x48
               	sub	x7, x0, #0x1
               	ldrb	w7, [x1, x7]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x48
               	ldrb	w2, [x1, x0]
               	sub	x1, x29, #0x30
               	ldrb	w8, [x1, x0]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x8
               	ldrb	w4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrb	w4, [x4, x0]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x18
               	ldrb	w4, [x4, x0]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldrb	w3, [x3, x0]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrb	w1, [x1, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x50
               	add	x2, x0, #0x1
               	ldrb	w2, [x1, x2]
               	b	<addr>
               	sub	x1, x29, #0x50
               	ldrb	w7, [x1, x0]
               	b	<addr>
               	sub	x3, x29, #0x48
               	sub	x1, x1, #0x8
               	ldrb	w3, [x3, x1]
               	b	<addr>
               	sub	x1, x29, #0x48
               	sub	x6, x3, #0x8
               	ldrb	w6, [x1, x6]
               	b	<addr>
               	sub	x5, x29, #0x50
               	add	x1, x1, #0x4
               	ldrb	w5, [x5, x1]
               	b	<addr>
               	sub	x4, x29, #0x50
               	ldrb	w4, [x4, x1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	orr	x20, x9, x0, lsl #2
               	bl	<addr>
               	orr	x20, x20, x0, lsl #3
               	bl	<addr>
               	orr	x20, x20, x0, lsl #4
               	bl	<addr>
               	orr	x20, x20, x0, lsl #5
               	bl	<addr>
               	orr	x20, x20, x0, lsl #6
               	bl	<addr>
               	orr	x20, x20, x0, lsl #7
               	bl	<addr>
               	orr	x20, x20, x0, lsl #8
               	bl	<addr>
               	orr	x20, x20, x0, lsl #9
               	bl	<addr>
               	orr	x20, x20, x0, lsl #10
               	bl	<addr>
               	orr	x20, x20, x0, lsl #11
               	bl	<addr>
               	orr	x20, x20, x0, lsl #12
               	bl	<addr>
               	orr	x20, x20, x0, lsl #13
               	bl	<addr>
               	orr	x20, x20, x0, lsl #14
               	bl	<addr>
               	orr	x20, x20, x0, lsl #15
               	bl	<addr>
               	orr	x0, x20, x0, lsl #16
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x20, #0x1               // =1
               	b	<addr>
