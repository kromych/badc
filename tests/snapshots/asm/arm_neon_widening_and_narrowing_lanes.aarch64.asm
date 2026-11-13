
arm_neon_widening_and_narrowing_lanes.aarch64:	file format elf64-littleaarch64

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

<check_s8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1b0
               	sub	x0, x29, #0x80
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x2, x29, #0x78
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x2, x29, #0x68
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x58
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x48
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x38
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0x80]
               	ldur	d2, [x29, #-0x78]
               	ldur	q3, [x29, #-0x68]
               	ldur	q1, [x29, #-0x58]
               	ldur	q4, [x29, #-0x48]
               	ldur	q5, [x29, #-0x38]
               	saddl	v6.8h, v0.8b, v2.8b
               	str	q6, [sp]
               	saddl2	v6.8h, v3.16b, v1.16b
               	str	q6, [sp, #0x10]
               	ssubl	v6.8h, v0.8b, v2.8b
               	str	q6, [sp, #0x20]
               	ssubl2	v6.8h, v3.16b, v1.16b
               	str	q6, [sp, #0x30]
               	smull	v6.8h, v0.8b, v2.8b
               	str	q6, [sp, #0x40]
               	smull2	v6.8h, v3.16b, v1.16b
               	str	q6, [sp, #0x50]
               	sabdl	v6.8h, v0.8b, v2.8b
               	str	q6, [sp, #0x60]
               	sabdl2	v6.8h, v3.16b, v1.16b
               	str	q6, [sp, #0x70]
               	saddw	v6.8h, v4.8h, v0.8b
               	str	q6, [sp, #0x80]
               	saddw2	v6.8h, v4.8h, v1.16b
               	str	q6, [sp, #0x90]
               	ssubw	v6.8h, v4.8h, v0.8b
               	str	q6, [sp, #0xa0]
               	ssubw2	v6.8h, v4.8h, v1.16b
               	stur	q6, [x29, #-0x100]
               	mov	v6.16b, v5.16b
               	smlal	v6.8h, v0.8b, v2.8b
               	stur	q6, [x29, #-0xf0]
               	mov	v6.16b, v5.16b
               	smlal2	v6.8h, v3.16b, v1.16b
               	stur	q6, [x29, #-0xe0]
               	mov	v6.16b, v5.16b
               	smlsl	v6.8h, v0.8b, v2.8b
               	stur	q6, [x29, #-0xd0]
               	mov	v6.16b, v5.16b
               	smlsl2	v6.8h, v3.16b, v1.16b
               	stur	q6, [x29, #-0xc0]
               	mov	v16.16b, v5.16b
               	sabal	v16.8h, v0.8b, v2.8b
               	mov	v2.16b, v16.16b
               	stur	q2, [x29, #-0xb0]
               	mov	v16.16b, v5.16b
               	sabal2	v16.8h, v3.16b, v1.16b
               	mov	v1.16b, v16.16b
               	stur	q1, [x29, #-0xa0]
               	sshll	v0.8h, v0.8b, #0x0
               	stur	q0, [x29, #-0x90]
               	mov	x1, #0x0                // =0
               	sub	x8, x29, #0x80
               	ldrsb	x0, [x8, x1]
               	and	x0, x0, #0xffff
               	sub	x9, x29, #0x78
               	ldrsb	x2, [x9, x1]
               	and	x6, x2, #0xffff
               	sub	x10, x29, #0x68
               	add	x2, x1, #0x8
               	ldrsb	x3, [x10, x2]
               	and	x7, x3, #0xffff
               	sub	x11, x29, #0x58
               	ldrsb	x3, [x11, x2]
               	and	x4, x3, #0xffff
               	sub	x3, x29, #0x38
               	ldrsh	x3, [x3, x1, lsl #1]
               	and	x3, x3, #0xffff
               	sub	x5, x29, #0x48
               	ldrsh	x5, [x5, x1, lsl #1]
               	and	x5, x5, #0xffff
               	add	x12, x0, x6
               	sturh	w12, [x29, #-0x28]
               	add	x12, x7, x4
               	sturh	w12, [x29, #-0x26]
               	sub	x12, x0, x6
               	sturh	w12, [x29, #-0x24]
               	sub	x12, x7, x4
               	sturh	w12, [x29, #-0x22]
               	mul	x6, x0, x6
               	sturh	w6, [x29, #-0x20]
               	mul	x7, x7, x4
               	sturh	w7, [x29, #-0x1e]
               	ldrsb	x8, [x8, x1]
               	ldrsb	x9, [x9, x1]
               	cmp	w8, w9
               	b.le	<addr>
               	and	x8, x8, #0xffff
               	and	x9, x9, #0xffff
               	sub	x8, x8, x9
               	and	x8, x8, #0xffff
               	sturh	w8, [x29, #-0x1c]
               	ldrsb	x8, [x10, x2]
               	ldrsb	x9, [x11, x2]
               	cmp	w8, w9
               	b.le	<addr>
               	and	x8, x8, #0xffff
               	and	x9, x9, #0xffff
               	sub	x8, x8, x9
               	and	x8, x8, #0xffff
               	sturh	w8, [x29, #-0x1a]
               	add	x8, x5, x0
               	sturh	w8, [x29, #-0x18]
               	add	x8, x5, x4
               	sturh	w8, [x29, #-0x16]
               	sub	x8, x5, x0
               	sturh	w8, [x29, #-0x14]
               	sub	x4, x5, x4
               	sturh	w4, [x29, #-0x12]
               	add	x4, x3, x6
               	sturh	w4, [x29, #-0x10]
               	add	x4, x3, x7
               	sturh	w4, [x29, #-0xe]
               	sub	x4, x3, x6
               	sturh	w4, [x29, #-0xc]
               	sub	x4, x3, x7
               	sturh	w4, [x29, #-0xa]
               	sub	x4, x29, #0x80
               	ldrsb	x4, [x4, x1]
               	sub	x5, x29, #0x78
               	ldrsb	x5, [x5, x1]
               	cmp	w4, w5
               	b.le	<addr>
               	and	x4, x4, #0xffff
               	and	x5, x5, #0xffff
               	sub	x4, x4, x5
               	and	x4, x4, #0xffff
               	add	x4, x3, x4
               	sturh	w4, [x29, #-0x8]
               	sub	x4, x29, #0x68
               	ldrsb	x4, [x4, x2]
               	sub	x5, x29, #0x58
               	ldrsb	x2, [x5, x2]
               	cmp	w4, w2
               	b.le	<addr>
               	and	x4, x4, #0xffff
               	and	x2, x2, #0xffff
               	sub	x2, x4, x2
               	and	x2, x2, #0xffff
               	add	x2, x3, x2
               	sturh	w2, [x29, #-0x6]
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x70
               	sub	x3, x29, #0x1b0
               	add	x3, x3, x0, lsl #4
               	add	x3, x3, x1, lsl #1
               	ldrh	w16, [x3]
               	strh	w16, [x2]
               	ldurh	w2, [x29, #-0x70]
               	sub	x3, x29, #0x28
               	ldrh	w3, [x3, x0, lsl #1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x13
               	b.lt	<addr>
               	b	<addr>
               	and	x2, x2, #0xffff
               	and	x4, x4, #0xffff
               	sub	x2, x2, x4
               	b	<addr>
               	and	x5, x5, #0xffff
               	and	x4, x4, #0xffff
               	sub	x4, x5, x4
               	b	<addr>
               	and	x9, x9, #0xffff
               	and	x8, x8, #0xffff
               	sub	x8, x9, x8
               	b	<addr>
               	and	x9, x9, #0xffff
               	and	x8, x8, #0xffff
               	sub	x8, x9, x8
               	b	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	xtn	v0.8b, v4.8h
               	sqxtn	v1.8b, v4.8h
               	sub	x3, x29, #0x30
               	stur	d0, [x29, #-0x30]
               	sub	x4, x29, #0x8
               	stur	d1, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	mov	x5, #-0x80              // =-128
               	sub	x1, x29, #0x48
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w5
               	b.ge	<addr>
               	mov	x2, #-0x80              // =-128
               	ldrsb	x6, [x3, x0]
               	and	x1, x1, #0xffff
               	sxtb	x1, w1
               	cmp	w6, w1
               	b.ne	<addr>
               	ldrsb	x1, [x4, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, #0x7f               // =127
               	cmp	w1, #0x7f
               	csel	x2, x2, x1, gt
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sqxtun	v0.8b, v4.8h
               	sub	x3, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	sub	x1, x29, #0x48
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x1, x2
               	ldrb	w4, [x3, x0]
               	cmp	w4, w1
               	b.eq	<addr>
               	b	<addr>
               	mov	x4, #0xff               // =255
               	cmp	w1, #0xff
               	csel	x1, x4, x1, gt
               	ldrb	w4, [x3, x0]
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1b0
               	sub	x0, x29, #0x80
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x2, x29, #0x78
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x2, x29, #0x68
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x58
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x48
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x38
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0x80]
               	ldur	d2, [x29, #-0x78]
               	ldur	q3, [x29, #-0x68]
               	ldur	q1, [x29, #-0x58]
               	ldur	q4, [x29, #-0x48]
               	ldur	q5, [x29, #-0x38]
               	uaddl	v6.8h, v0.8b, v2.8b
               	str	q6, [sp]
               	uaddl2	v6.8h, v3.16b, v1.16b
               	str	q6, [sp, #0x10]
               	usubl	v6.8h, v0.8b, v2.8b
               	str	q6, [sp, #0x20]
               	usubl2	v6.8h, v3.16b, v1.16b
               	str	q6, [sp, #0x30]
               	umull	v6.8h, v0.8b, v2.8b
               	str	q6, [sp, #0x40]
               	umull2	v6.8h, v3.16b, v1.16b
               	str	q6, [sp, #0x50]
               	uabdl	v6.8h, v0.8b, v2.8b
               	str	q6, [sp, #0x60]
               	uabdl2	v6.8h, v3.16b, v1.16b
               	str	q6, [sp, #0x70]
               	uaddw	v6.8h, v4.8h, v0.8b
               	str	q6, [sp, #0x80]
               	uaddw2	v6.8h, v4.8h, v1.16b
               	str	q6, [sp, #0x90]
               	usubw	v6.8h, v4.8h, v0.8b
               	str	q6, [sp, #0xa0]
               	usubw2	v6.8h, v4.8h, v1.16b
               	stur	q6, [x29, #-0x100]
               	mov	v6.16b, v5.16b
               	umlal	v6.8h, v0.8b, v2.8b
               	stur	q6, [x29, #-0xf0]
               	mov	v6.16b, v5.16b
               	umlal2	v6.8h, v3.16b, v1.16b
               	stur	q6, [x29, #-0xe0]
               	mov	v6.16b, v5.16b
               	umlsl	v6.8h, v0.8b, v2.8b
               	stur	q6, [x29, #-0xd0]
               	mov	v6.16b, v5.16b
               	umlsl2	v6.8h, v3.16b, v1.16b
               	stur	q6, [x29, #-0xc0]
               	mov	v16.16b, v5.16b
               	uabal	v16.8h, v0.8b, v2.8b
               	mov	v2.16b, v16.16b
               	stur	q2, [x29, #-0xb0]
               	mov	v16.16b, v5.16b
               	uabal2	v16.8h, v3.16b, v1.16b
               	mov	v1.16b, v16.16b
               	stur	q1, [x29, #-0xa0]
               	ushll	v0.8h, v0.8b, #0x0
               	stur	q0, [x29, #-0x90]
               	mov	x1, #0x0                // =0
               	sub	x8, x29, #0x80
               	ldrb	w0, [x8, x1]
               	sub	x9, x29, #0x78
               	ldrb	w6, [x9, x1]
               	sub	x10, x29, #0x68
               	add	x2, x1, #0x8
               	ldrb	w7, [x10, x2]
               	sub	x11, x29, #0x58
               	ldrb	w4, [x11, x2]
               	sub	x3, x29, #0x38
               	ldrh	w3, [x3, x1, lsl #1]
               	sub	x5, x29, #0x48
               	ldrh	w5, [x5, x1, lsl #1]
               	add	x12, x0, x6
               	sturh	w12, [x29, #-0x28]
               	add	x12, x7, x4
               	sturh	w12, [x29, #-0x26]
               	sub	x12, x0, x6
               	sturh	w12, [x29, #-0x24]
               	sub	x12, x7, x4
               	sturh	w12, [x29, #-0x22]
               	mul	x6, x0, x6
               	sturh	w6, [x29, #-0x20]
               	mul	x7, x7, x4
               	sturh	w7, [x29, #-0x1e]
               	ldrb	w8, [x8, x1]
               	ldrb	w9, [x9, x1]
               	sub	x12, x8, x9
               	sub	x13, x9, x8
               	cmp	w8, w9
               	csel	x8, x12, x13, gt
               	and	x8, x8, #0xffff
               	sturh	w8, [x29, #-0x1c]
               	ldrb	w8, [x10, x2]
               	ldrb	w9, [x11, x2]
               	sub	x10, x8, x9
               	sub	x11, x9, x8
               	cmp	w8, w9
               	csel	x8, x10, x11, gt
               	and	x8, x8, #0xffff
               	sturh	w8, [x29, #-0x1a]
               	add	x8, x5, x0
               	sturh	w8, [x29, #-0x18]
               	add	x8, x5, x4
               	sturh	w8, [x29, #-0x16]
               	sub	x8, x5, x0
               	sturh	w8, [x29, #-0x14]
               	sub	x4, x5, x4
               	sturh	w4, [x29, #-0x12]
               	add	x4, x3, x6
               	sturh	w4, [x29, #-0x10]
               	add	x4, x3, x7
               	sturh	w4, [x29, #-0xe]
               	sub	x4, x3, x6
               	sturh	w4, [x29, #-0xc]
               	sub	x4, x3, x7
               	sturh	w4, [x29, #-0xa]
               	sub	x4, x29, #0x80
               	ldrb	w4, [x4, x1]
               	sub	x5, x29, #0x78
               	ldrb	w5, [x5, x1]
               	sub	x6, x4, x5
               	sub	x7, x5, x4
               	cmp	w4, w5
               	csel	x4, x6, x7, gt
               	and	x4, x4, #0xffff
               	add	x4, x3, x4
               	sturh	w4, [x29, #-0x8]
               	sub	x4, x29, #0x68
               	ldrb	w4, [x4, x2]
               	sub	x5, x29, #0x58
               	ldrb	w2, [x5, x2]
               	sub	x5, x4, x2
               	sub	x6, x2, x4
               	cmp	w4, w2
               	csel	x2, x5, x6, gt
               	and	x2, x2, #0xffff
               	add	x2, x3, x2
               	sturh	w2, [x29, #-0x6]
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x70
               	sub	x3, x29, #0x1b0
               	add	x3, x3, x0, lsl #4
               	add	x3, x3, x1, lsl #1
               	ldrh	w16, [x3]
               	strh	w16, [x2]
               	ldurh	w2, [x29, #-0x70]
               	sub	x3, x29, #0x28
               	ldrh	w3, [x3, x0, lsl #1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x13
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	xtn	v0.8b, v4.8h
               	uqxtn	v1.8b, v4.8h
               	sub	x2, x29, #0x30
               	stur	d0, [x29, #-0x30]
               	sub	x3, x29, #0x8
               	stur	d1, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x48
               	ldrh	w1, [x1, x0, lsl #1]
               	mov	x4, #0xff               // =255
               	cmp	w1, #0xff
               	csel	x4, x4, x1, gt
               	ldrb	w5, [x2, x0]
               	and	x1, x1, #0xff
               	cmp	w5, w1
               	b.ne	<addr>
               	ldrb	w1, [x3, x0]
               	cmp	w1, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1e0
               	sub	x0, x29, #0xa8
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x2, x29, #0xa0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x70
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0xa8]
               	ldur	d2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	ldur	q1, [x29, #-0x80]
               	ldur	q4, [x29, #-0x70]
               	ldur	q5, [x29, #-0x60]
               	saddl	v6.4s, v0.4h, v2.4h
               	str	q6, [sp]
               	saddl2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0x10]
               	ssubl	v6.4s, v0.4h, v2.4h
               	str	q6, [sp, #0x20]
               	ssubl2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0x30]
               	smull	v6.4s, v0.4h, v2.4h
               	str	q6, [sp, #0x40]
               	smull2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0x50]
               	sabdl	v6.4s, v0.4h, v2.4h
               	str	q6, [sp, #0x60]
               	sabdl2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0x70]
               	saddw	v6.4s, v4.4s, v0.4h
               	str	q6, [sp, #0x80]
               	saddw2	v6.4s, v4.4s, v1.8h
               	str	q6, [sp, #0x90]
               	ssubw	v6.4s, v4.4s, v0.4h
               	str	q6, [sp, #0xa0]
               	ssubw2	v6.4s, v4.4s, v1.8h
               	str	q6, [sp, #0xb0]
               	mov	v6.16b, v5.16b
               	smlal	v6.4s, v0.4h, v2.4h
               	str	q6, [sp, #0xc0]
               	mov	v6.16b, v5.16b
               	smlal2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0xd0]
               	mov	v6.16b, v5.16b
               	smlsl	v6.4s, v0.4h, v2.4h
               	stur	q6, [x29, #-0x100]
               	mov	v6.16b, v5.16b
               	smlsl2	v6.4s, v3.8h, v1.8h
               	stur	q6, [x29, #-0xf0]
               	mov	v16.16b, v5.16b
               	sabal	v16.4s, v0.4h, v2.4h
               	mov	v2.16b, v16.16b
               	stur	q2, [x29, #-0xe0]
               	mov	v16.16b, v5.16b
               	sabal2	v16.4s, v3.8h, v1.8h
               	mov	v1.16b, v16.16b
               	stur	q1, [x29, #-0xd0]
               	sshll	v0.4s, v0.4h, #0x0
               	stur	q0, [x29, #-0xc0]
               	mov	x1, #0x0                // =0
               	sub	x8, x29, #0xa8
               	ldrsh	x0, [x8, x1, lsl #1]
               	sub	x9, x29, #0xa0
               	ldrsh	x6, [x9, x1, lsl #1]
               	sub	x10, x29, #0x90
               	add	x2, x1, #0x4
               	ldrsh	x7, [x10, x2, lsl #1]
               	sub	x11, x29, #0x80
               	ldrsh	x4, [x11, x2, lsl #1]
               	sub	x3, x29, #0x60
               	ldrsw	x3, [x3, x1, lsl #2]
               	sub	x5, x29, #0x70
               	ldrsw	x5, [x5, x1, lsl #2]
               	add	x12, x0, x6
               	stur	w12, [x29, #-0x50]
               	add	x12, x7, x4
               	stur	w12, [x29, #-0x4c]
               	sub	x12, x0, x6
               	stur	w12, [x29, #-0x48]
               	sub	x12, x7, x4
               	stur	w12, [x29, #-0x44]
               	mul	x6, x0, x6
               	stur	w6, [x29, #-0x40]
               	mul	x7, x7, x4
               	stur	w7, [x29, #-0x3c]
               	ldrsh	x8, [x8, x1, lsl #1]
               	ldrsh	x9, [x9, x1, lsl #1]
               	sub	x12, x8, x9
               	sub	x13, x9, x8
               	cmp	w8, w9
               	csel	x8, x12, x13, gt
               	stur	w8, [x29, #-0x38]
               	ldrsh	x8, [x10, x2, lsl #1]
               	ldrsh	x9, [x11, x2, lsl #1]
               	sub	x10, x8, x9
               	sub	x11, x9, x8
               	cmp	w8, w9
               	csel	x8, x10, x11, gt
               	stur	w8, [x29, #-0x34]
               	add	x8, x5, x0
               	stur	w8, [x29, #-0x30]
               	add	x8, x5, x4
               	stur	w8, [x29, #-0x2c]
               	sub	x8, x5, x0
               	stur	w8, [x29, #-0x28]
               	sub	x4, x5, x4
               	stur	w4, [x29, #-0x24]
               	add	x4, x3, x6
               	stur	w4, [x29, #-0x20]
               	add	x4, x3, x7
               	stur	w4, [x29, #-0x1c]
               	sub	x4, x3, x6
               	stur	w4, [x29, #-0x18]
               	sub	x4, x3, x7
               	stur	w4, [x29, #-0x14]
               	sub	x4, x29, #0xa8
               	ldrsh	x4, [x4, x1, lsl #1]
               	sub	x5, x29, #0xa0
               	ldrsh	x5, [x5, x1, lsl #1]
               	sub	x6, x4, x5
               	sub	x7, x5, x4
               	cmp	w4, w5
               	csel	x4, x6, x7, gt
               	add	x4, x3, x4
               	stur	w4, [x29, #-0x10]
               	sub	x4, x29, #0x90
               	ldrsh	x4, [x4, x2, lsl #1]
               	sub	x5, x29, #0x80
               	ldrsh	x2, [x5, x2, lsl #1]
               	sub	x5, x4, x2
               	sub	x6, x2, x4
               	cmp	w4, w2
               	csel	x2, x5, x6, gt
               	add	x2, x3, x2
               	stur	w2, [x29, #-0xc]
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x98
               	sub	x3, x29, #0x1e0
               	add	x3, x3, x0, lsl #4
               	add	x3, x3, x1, lsl #2
               	ldr	w16, [x3]
               	str	w16, [x2]
               	ldur	w2, [x29, #-0x98]
               	sub	x3, x29, #0x50
               	ldr	w3, [x3, x0, lsl #2]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x13
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	xtn	v0.4h, v4.4s
               	sqxtn	v1.4h, v4.4s
               	sub	x3, x29, #0x58
               	stur	d0, [x29, #-0x58]
               	sub	x4, x29, #0x8
               	stur	d1, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	mov	x5, #-0x8000            // =-32768
               	mov	x6, #0x7fff             // =32767
               	sub	x1, x29, #0x70
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w5
               	b.ge	<addr>
               	mov	x2, #-0x8000            // =-32768
               	ldrsh	x7, [x3, x0, lsl #1]
               	sxth	x1, w1
               	cmp	w7, w1
               	b.ne	<addr>
               	ldrsh	x1, [x4, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, #0x7fff             // =32767
               	cmp	w1, w6
               	csel	x2, x2, x1, gt
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sqxtun	v0.4h, v4.4s
               	sub	x3, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	mov	x4, #0xffff             // =65535
               	mov	x0, x2
               	sub	x1, x29, #0x70
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x1, x2
               	ldrh	w5, [x3, x0, lsl #1]
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	mov	x5, #0xffff             // =65535
               	cmp	w1, w4
               	csel	x1, x5, x1, gt
               	ldrh	w5, [x3, x0, lsl #1]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1e0
               	sub	x0, x29, #0xa8
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x2, x29, #0xa0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x70
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0xa8]
               	ldur	d2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	ldur	q1, [x29, #-0x80]
               	ldur	q4, [x29, #-0x70]
               	ldur	q5, [x29, #-0x60]
               	uaddl	v6.4s, v0.4h, v2.4h
               	str	q6, [sp]
               	uaddl2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0x10]
               	usubl	v6.4s, v0.4h, v2.4h
               	str	q6, [sp, #0x20]
               	usubl2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0x30]
               	umull	v6.4s, v0.4h, v2.4h
               	str	q6, [sp, #0x40]
               	umull2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0x50]
               	uabdl	v6.4s, v0.4h, v2.4h
               	str	q6, [sp, #0x60]
               	uabdl2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0x70]
               	uaddw	v6.4s, v4.4s, v0.4h
               	str	q6, [sp, #0x80]
               	uaddw2	v6.4s, v4.4s, v1.8h
               	str	q6, [sp, #0x90]
               	usubw	v6.4s, v4.4s, v0.4h
               	str	q6, [sp, #0xa0]
               	usubw2	v6.4s, v4.4s, v1.8h
               	str	q6, [sp, #0xb0]
               	mov	v6.16b, v5.16b
               	umlal	v6.4s, v0.4h, v2.4h
               	str	q6, [sp, #0xc0]
               	mov	v6.16b, v5.16b
               	umlal2	v6.4s, v3.8h, v1.8h
               	str	q6, [sp, #0xd0]
               	mov	v6.16b, v5.16b
               	umlsl	v6.4s, v0.4h, v2.4h
               	stur	q6, [x29, #-0x100]
               	mov	v6.16b, v5.16b
               	umlsl2	v6.4s, v3.8h, v1.8h
               	stur	q6, [x29, #-0xf0]
               	mov	v16.16b, v5.16b
               	uabal	v16.4s, v0.4h, v2.4h
               	mov	v2.16b, v16.16b
               	stur	q2, [x29, #-0xe0]
               	mov	v16.16b, v5.16b
               	uabal2	v16.4s, v3.8h, v1.8h
               	mov	v1.16b, v16.16b
               	stur	q1, [x29, #-0xd0]
               	ushll	v0.4s, v0.4h, #0x0
               	stur	q0, [x29, #-0xc0]
               	mov	x1, #0x0                // =0
               	sub	x8, x29, #0xa8
               	ldrh	w0, [x8, x1, lsl #1]
               	sub	x9, x29, #0xa0
               	ldrh	w6, [x9, x1, lsl #1]
               	sub	x10, x29, #0x90
               	add	x2, x1, #0x4
               	ldrh	w7, [x10, x2, lsl #1]
               	sub	x11, x29, #0x80
               	ldrh	w4, [x11, x2, lsl #1]
               	sub	x3, x29, #0x60
               	ldr	w3, [x3, x1, lsl #2]
               	sub	x5, x29, #0x70
               	ldr	w5, [x5, x1, lsl #2]
               	add	x12, x0, x6
               	stur	w12, [x29, #-0x50]
               	add	x12, x7, x4
               	stur	w12, [x29, #-0x4c]
               	sub	x12, x0, x6
               	stur	w12, [x29, #-0x48]
               	sub	x12, x7, x4
               	stur	w12, [x29, #-0x44]
               	mul	x6, x0, x6
               	stur	w6, [x29, #-0x40]
               	mul	x7, x7, x4
               	stur	w7, [x29, #-0x3c]
               	ldrh	w8, [x8, x1, lsl #1]
               	ldrh	w9, [x9, x1, lsl #1]
               	sub	x12, x8, x9
               	sub	x13, x9, x8
               	cmp	w8, w9
               	csel	x8, x12, x13, hi
               	stur	w8, [x29, #-0x38]
               	ldrh	w8, [x10, x2, lsl #1]
               	ldrh	w9, [x11, x2, lsl #1]
               	sub	x10, x8, x9
               	sub	x11, x9, x8
               	cmp	w8, w9
               	csel	x8, x10, x11, hi
               	stur	w8, [x29, #-0x34]
               	add	x8, x5, x0
               	stur	w8, [x29, #-0x30]
               	add	x8, x5, x4
               	stur	w8, [x29, #-0x2c]
               	sub	x8, x5, x0
               	stur	w8, [x29, #-0x28]
               	sub	x4, x5, x4
               	stur	w4, [x29, #-0x24]
               	add	x4, x3, x6
               	stur	w4, [x29, #-0x20]
               	add	x4, x3, x7
               	stur	w4, [x29, #-0x1c]
               	sub	x4, x3, x6
               	stur	w4, [x29, #-0x18]
               	sub	x4, x3, x7
               	stur	w4, [x29, #-0x14]
               	sub	x4, x29, #0xa8
               	ldrh	w4, [x4, x1, lsl #1]
               	sub	x5, x29, #0xa0
               	ldrh	w5, [x5, x1, lsl #1]
               	sub	x6, x4, x5
               	sub	x7, x5, x4
               	cmp	w4, w5
               	csel	x4, x6, x7, hi
               	add	x4, x3, x4
               	stur	w4, [x29, #-0x10]
               	sub	x4, x29, #0x90
               	ldrh	w4, [x4, x2, lsl #1]
               	sub	x5, x29, #0x80
               	ldrh	w2, [x5, x2, lsl #1]
               	sub	x5, x4, x2
               	sub	x6, x2, x4
               	cmp	w4, w2
               	csel	x2, x5, x6, hi
               	add	x2, x3, x2
               	stur	w2, [x29, #-0xc]
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x98
               	sub	x3, x29, #0x1e0
               	add	x3, x3, x0, lsl #4
               	add	x3, x3, x1, lsl #2
               	ldr	w16, [x3]
               	str	w16, [x2]
               	ldur	w2, [x29, #-0x98]
               	sub	x3, x29, #0x50
               	ldr	w3, [x3, x0, lsl #2]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x13
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	xtn	v0.4h, v4.4s
               	uqxtn	v1.4h, v4.4s
               	sub	x2, x29, #0x58
               	stur	d0, [x29, #-0x58]
               	sub	x3, x29, #0x8
               	stur	d1, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	mov	x4, #0xffff             // =65535
               	sub	x1, x29, #0x70
               	ldr	w1, [x1, x0, lsl #2]
               	mov	x5, #0xffff             // =65535
               	cmp	w1, w4
               	csel	x5, x5, x1, hi
               	ldrh	w6, [x2, x0, lsl #1]
               	and	x1, x1, #0xffff
               	cmp	w6, w1
               	b.ne	<addr>
               	ldrh	w1, [x3, x0, lsl #1]
               	cmp	w1, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	sub	x0, x29, #0xf0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x2, x29, #0xe8
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x2, x29, #0xd8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0xc8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0xb8
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0xa8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0xf0]
               	ldur	d2, [x29, #-0xe8]
               	ldur	q3, [x29, #-0xd8]
               	ldur	q1, [x29, #-0xc8]
               	ldur	q4, [x29, #-0xb8]
               	ldur	q5, [x29, #-0xa8]
               	saddl	v6.2d, v0.2s, v2.2s
               	str	q6, [sp]
               	saddl2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0x10]
               	ssubl	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0x20]
               	ssubl2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0x30]
               	smull	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0x40]
               	smull2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0x50]
               	sabdl	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0x60]
               	sabdl2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0x70]
               	saddw	v6.2d, v4.2d, v0.2s
               	str	q6, [sp, #0x80]
               	saddw2	v6.2d, v4.2d, v1.4s
               	str	q6, [sp, #0x90]
               	ssubw	v6.2d, v4.2d, v0.2s
               	str	q6, [sp, #0xa0]
               	ssubw2	v6.2d, v4.2d, v1.4s
               	str	q6, [sp, #0xb0]
               	mov	v6.16b, v5.16b
               	smlal	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0xc0]
               	mov	v6.16b, v5.16b
               	smlal2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0xd0]
               	mov	v6.16b, v5.16b
               	smlsl	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0xe0]
               	mov	v6.16b, v5.16b
               	smlsl2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0xf0]
               	mov	v16.16b, v5.16b
               	sabal	v16.2d, v0.2s, v2.2s
               	mov	v2.16b, v16.16b
               	str	q2, [sp, #0x100]
               	mov	v16.16b, v5.16b
               	sabal2	v16.2d, v3.4s, v1.4s
               	mov	v1.16b, v16.16b
               	str	q1, [sp, #0x110]
               	sshll	v0.2d, v0.2s, #0x0
               	stur	q0, [x29, #-0x100]
               	mov	x1, #0x0                // =0
               	sub	x8, x29, #0xf0
               	ldrsw	x0, [x8, x1, lsl #2]
               	sub	x9, x29, #0xe8
               	ldrsw	x6, [x9, x1, lsl #2]
               	sub	x10, x29, #0xd8
               	add	x2, x1, #0x2
               	ldrsw	x7, [x10, x2, lsl #2]
               	sub	x11, x29, #0xc8
               	ldrsw	x4, [x11, x2, lsl #2]
               	sub	x3, x29, #0xa8
               	ldr	x3, [x3, x1, lsl #3]
               	sub	x5, x29, #0xb8
               	ldr	x5, [x5, x1, lsl #3]
               	add	x12, x0, x6
               	stur	x12, [x29, #-0x98]
               	add	x12, x7, x4
               	stur	x12, [x29, #-0x90]
               	sub	x12, x0, x6
               	stur	x12, [x29, #-0x88]
               	sub	x12, x7, x4
               	stur	x12, [x29, #-0x80]
               	mul	x6, x0, x6
               	stur	x6, [x29, #-0x78]
               	mul	x7, x7, x4
               	stur	x7, [x29, #-0x70]
               	ldrsw	x8, [x8, x1, lsl #2]
               	ldrsw	x9, [x9, x1, lsl #2]
               	sub	x12, x8, x9
               	sub	x13, x9, x8
               	cmp	w8, w9
               	csel	x8, x12, x13, gt
               	stur	x8, [x29, #-0x68]
               	ldrsw	x8, [x10, x2, lsl #2]
               	ldrsw	x9, [x11, x2, lsl #2]
               	sub	x10, x8, x9
               	sub	x11, x9, x8
               	cmp	w8, w9
               	csel	x8, x10, x11, gt
               	stur	x8, [x29, #-0x60]
               	add	x8, x5, x0
               	stur	x8, [x29, #-0x58]
               	add	x8, x5, x4
               	stur	x8, [x29, #-0x50]
               	sub	x8, x5, x0
               	stur	x8, [x29, #-0x48]
               	sub	x4, x5, x4
               	stur	x4, [x29, #-0x40]
               	add	x4, x3, x6
               	stur	x4, [x29, #-0x38]
               	add	x4, x3, x7
               	stur	x4, [x29, #-0x30]
               	sub	x4, x3, x6
               	stur	x4, [x29, #-0x28]
               	sub	x4, x3, x7
               	stur	x4, [x29, #-0x20]
               	sub	x4, x29, #0xf0
               	ldrsw	x4, [x4, x1, lsl #2]
               	sub	x5, x29, #0xe8
               	ldrsw	x5, [x5, x1, lsl #2]
               	sub	x6, x4, x5
               	sub	x7, x5, x4
               	cmp	w4, w5
               	csel	x4, x6, x7, gt
               	add	x4, x3, x4
               	stur	x4, [x29, #-0x18]
               	sub	x4, x29, #0xd8
               	ldrsw	x4, [x4, x2, lsl #2]
               	sub	x5, x29, #0xc8
               	ldrsw	x2, [x5, x2, lsl #2]
               	sub	x5, x4, x2
               	sub	x6, x2, x4
               	cmp	w4, w2
               	csel	x2, x5, x6, gt
               	add	x2, x3, x2
               	stur	x2, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xe0
               	sub	x3, x29, #0x220
               	add	x3, x3, x0, lsl #4
               	add	x3, x3, x1, lsl #3
               	ldr	x16, [x3]
               	str	x16, [x2]
               	ldur	x2, [x29, #-0xe0]
               	sub	x3, x29, #0x98
               	ldr	x3, [x3, x0, lsl #3]
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x13
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.lt	<addr>
               	xtn	v0.2s, v4.2d
               	sqxtn	v1.2s, v4.2d
               	sub	x3, x29, #0xa0
               	stur	d0, [x29, #-0xa0]
               	sub	x4, x29, #0x8
               	stur	d1, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	mov	x5, #-0x80000000        // =-2147483648
               	mov	x6, #0x7fffffff         // =2147483647
               	sub	x1, x29, #0xb8
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x5
               	b.ge	<addr>
               	mov	x2, #-0x80000000        // =-2147483648
               	ldrsw	x7, [x3, x0, lsl #2]
               	cmp	w7, w1
               	b.ne	<addr>
               	ldrsw	x1, [x4, x0, lsl #2]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, #0x7fffffff         // =2147483647
               	cmp	x1, x6
               	csel	x2, x2, x1, gt
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sqxtun	v0.2s, v4.2d
               	sub	x3, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	mov	x4, #0xffffffff         // =4294967295
               	mov	x0, x2
               	sub	x1, x29, #0xb8
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	mov	x1, x2
               	ldr	w5, [x3, x0, lsl #2]
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	mov	x5, #0xffffffff         // =4294967295
               	cmp	x1, x4
               	csel	x1, x5, x1, gt
               	ldr	w5, [x3, x0, lsl #2]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	sub	x0, x29, #0xf0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x2, x29, #0xe8
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x2, x29, #0xd8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0xc8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0xb8
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0xa8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0xf0]
               	ldur	d2, [x29, #-0xe8]
               	ldur	q3, [x29, #-0xd8]
               	ldur	q1, [x29, #-0xc8]
               	ldur	q4, [x29, #-0xb8]
               	ldur	q5, [x29, #-0xa8]
               	uaddl	v6.2d, v0.2s, v2.2s
               	str	q6, [sp]
               	uaddl2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0x10]
               	usubl	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0x20]
               	usubl2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0x30]
               	umull	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0x40]
               	umull2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0x50]
               	uabdl	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0x60]
               	uabdl2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0x70]
               	uaddw	v6.2d, v4.2d, v0.2s
               	str	q6, [sp, #0x80]
               	uaddw2	v6.2d, v4.2d, v1.4s
               	str	q6, [sp, #0x90]
               	usubw	v6.2d, v4.2d, v0.2s
               	str	q6, [sp, #0xa0]
               	usubw2	v6.2d, v4.2d, v1.4s
               	str	q6, [sp, #0xb0]
               	mov	v6.16b, v5.16b
               	umlal	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0xc0]
               	mov	v6.16b, v5.16b
               	umlal2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0xd0]
               	mov	v6.16b, v5.16b
               	umlsl	v6.2d, v0.2s, v2.2s
               	str	q6, [sp, #0xe0]
               	mov	v6.16b, v5.16b
               	umlsl2	v6.2d, v3.4s, v1.4s
               	str	q6, [sp, #0xf0]
               	mov	v16.16b, v5.16b
               	uabal	v16.2d, v0.2s, v2.2s
               	mov	v2.16b, v16.16b
               	str	q2, [sp, #0x100]
               	mov	v16.16b, v5.16b
               	uabal2	v16.2d, v3.4s, v1.4s
               	mov	v1.16b, v16.16b
               	str	q1, [sp, #0x110]
               	ushll	v0.2d, v0.2s, #0x0
               	stur	q0, [x29, #-0x100]
               	mov	x1, #0x0                // =0
               	sub	x8, x29, #0xf0
               	ldr	w0, [x8, x1, lsl #2]
               	sub	x9, x29, #0xe8
               	ldr	w6, [x9, x1, lsl #2]
               	sub	x10, x29, #0xd8
               	add	x2, x1, #0x2
               	ldr	w7, [x10, x2, lsl #2]
               	sub	x11, x29, #0xc8
               	ldr	w4, [x11, x2, lsl #2]
               	sub	x3, x29, #0xa8
               	ldr	x3, [x3, x1, lsl #3]
               	sub	x5, x29, #0xb8
               	ldr	x5, [x5, x1, lsl #3]
               	add	x12, x0, x6
               	stur	x12, [x29, #-0x98]
               	add	x12, x7, x4
               	stur	x12, [x29, #-0x90]
               	sub	x12, x0, x6
               	stur	x12, [x29, #-0x88]
               	sub	x12, x7, x4
               	stur	x12, [x29, #-0x80]
               	mul	x6, x0, x6
               	stur	x6, [x29, #-0x78]
               	mul	x7, x7, x4
               	stur	x7, [x29, #-0x70]
               	ldr	w8, [x8, x1, lsl #2]
               	ldr	w9, [x9, x1, lsl #2]
               	sub	x12, x8, x9
               	sub	x13, x9, x8
               	cmp	w8, w9
               	csel	x8, x12, x13, hi
               	stur	x8, [x29, #-0x68]
               	ldr	w8, [x10, x2, lsl #2]
               	ldr	w9, [x11, x2, lsl #2]
               	sub	x10, x8, x9
               	sub	x11, x9, x8
               	cmp	w8, w9
               	csel	x8, x10, x11, hi
               	stur	x8, [x29, #-0x60]
               	add	x8, x5, x0
               	stur	x8, [x29, #-0x58]
               	add	x8, x5, x4
               	stur	x8, [x29, #-0x50]
               	sub	x8, x5, x0
               	stur	x8, [x29, #-0x48]
               	sub	x4, x5, x4
               	stur	x4, [x29, #-0x40]
               	add	x4, x3, x6
               	stur	x4, [x29, #-0x38]
               	add	x4, x3, x7
               	stur	x4, [x29, #-0x30]
               	sub	x4, x3, x6
               	stur	x4, [x29, #-0x28]
               	sub	x4, x3, x7
               	stur	x4, [x29, #-0x20]
               	sub	x4, x29, #0xf0
               	ldr	w4, [x4, x1, lsl #2]
               	sub	x5, x29, #0xe8
               	ldr	w5, [x5, x1, lsl #2]
               	sub	x6, x4, x5
               	sub	x7, x5, x4
               	cmp	w4, w5
               	csel	x4, x6, x7, hi
               	add	x4, x3, x4
               	stur	x4, [x29, #-0x18]
               	sub	x4, x29, #0xd8
               	ldr	w4, [x4, x2, lsl #2]
               	sub	x5, x29, #0xc8
               	ldr	w2, [x5, x2, lsl #2]
               	sub	x5, x4, x2
               	sub	x6, x2, x4
               	cmp	w4, w2
               	csel	x2, x5, x6, hi
               	add	x2, x3, x2
               	stur	x2, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xe0
               	sub	x3, x29, #0x220
               	add	x3, x3, x0, lsl #4
               	add	x3, x3, x1, lsl #3
               	ldr	x16, [x3]
               	str	x16, [x2]
               	ldur	x2, [x29, #-0xe0]
               	sub	x3, x29, #0x98
               	ldr	x3, [x3, x0, lsl #3]
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x13
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.lt	<addr>
               	xtn	v0.2s, v4.2d
               	uqxtn	v1.2s, v4.2d
               	sub	x2, x29, #0xa0
               	stur	d0, [x29, #-0xa0]
               	sub	x3, x29, #0x8
               	stur	d1, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	mov	x4, #0xffffffff         // =4294967295
               	sub	x1, x29, #0xb8
               	ldr	x1, [x1, x0, lsl #3]
               	mov	x5, #0xffffffff         // =4294967295
               	cmp	x1, x4
               	csel	x5, x5, x1, hi
               	ldr	w6, [x2, x0, lsl #2]
               	cmp	w6, w1
               	b.ne	<addr>
               	ldr	w1, [x3, x0, lsl #2]
               	cmp	w1, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	orr	x20, x20, x0, lsl #1
               	bl	<addr>
               	orr	x20, x20, x0, lsl #2
               	bl	<addr>
               	orr	x20, x20, x0, lsl #3
               	bl	<addr>
               	orr	x20, x20, x0, lsl #4
               	bl	<addr>
               	orr	x0, x20, x0, lsl #5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
