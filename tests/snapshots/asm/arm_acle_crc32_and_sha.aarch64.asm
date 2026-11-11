
arm_acle_crc32_and_sha.aarch64:	file format elf64-littleaarch64

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

<crc_model>:
               	mov	x0, #0xffffffff         // =4294967295
               	mov	x4, #0x0                // =0
               	cmp	w4, w2
               	b.ge	<addr>
               	ldrb	w5, [x1, x4]
               	eor	x0, x0, x5
               	mov	w0, w0
               	and	x5, x0, #0x1
               	neg	x5, x5
               	and	x5, x3, x5
               	eor	x0, x5, x0, lsr #1
               	mov	w0, w0
               	and	x5, x0, #0x1
               	neg	x5, x5
               	and	x5, x3, x5
               	eor	x0, x5, x0, lsr #1
               	mov	w0, w0
               	and	x5, x0, #0x1
               	neg	x5, x5
               	and	x5, x3, x5
               	eor	x0, x5, x0, lsr #1
               	mov	w0, w0
               	and	x5, x0, #0x1
               	neg	x5, x5
               	and	x5, x3, x5
               	eor	x0, x5, x0, lsr #1
               	mov	w0, w0
               	and	x5, x0, #0x1
               	neg	x5, x5
               	and	x5, x3, x5
               	eor	x0, x5, x0, lsr #1
               	mov	w0, w0
               	and	x5, x0, #0x1
               	neg	x5, x5
               	and	x5, x3, x5
               	eor	x0, x5, x0, lsr #1
               	mov	w0, w0
               	and	x5, x0, #0x1
               	neg	x5, x5
               	and	x5, x3, x5
               	eor	x0, x5, x0, lsr #1
               	mov	w0, w0
               	and	x5, x0, #0x1
               	neg	x5, x5
               	and	x5, x3, x5
               	eor	x0, x5, x0, lsr #1
               	add	x4, x4, #0x1
               	cmp	w4, w2
               	b.lt	<addr>
               	ret

<crc_acle>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0xffffffff         // =4294967295
               	sxtw	x2, w2
               	sxtw	x3, w3
               	cmp	w2, #0x8
               	b.lt	<addr>
               	sub	x4, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x4]
               	cbz	x3, <addr>
               	mov	w0, w0
               	ldur	x4, [x29, #-0x8]
               	crc32cx	w0, w0, x4
               	b	<addr>
               	mov	w0, w0
               	ldur	x4, [x29, #-0x8]
               	crc32x	w0, w0, x4
               	sub	x2, x2, #0x8
               	add	x1, x1, #0x8
               	cmp	w2, #0x8
               	b.ge	<addr>
               	cmp	w2, #0x4
               	b.lt	<addr>
               	sub	x4, x29, #0x8
               	ldr	w16, [x1]
               	str	w16, [x4]
               	cbz	x3, <addr>
               	mov	w0, w0
               	ldur	w4, [x29, #-0x8]
               	crc32cw	w0, w0, w4
               	add	x1, x1, #0x4
               	sub	x2, x2, #0x4
               	cmp	w2, #0x2
               	b.lt	<addr>
               	sub	x4, x29, #0x8
               	ldrh	w16, [x1]
               	strh	w16, [x4]
               	cbz	x3, <addr>
               	mov	w0, w0
               	ldurh	w4, [x29, #-0x8]
               	crc32ch	w0, w0, w4
               	add	x1, x1, #0x2
               	sub	x2, x2, #0x2
               	cbz	x2, <addr>
               	cbz	x3, <addr>
               	mov	w0, w0
               	ldrb	w1, [x1]
               	crc32cb	w0, w0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w0
               	ldrb	w1, [x1]
               	crc32b	w0, w0, w1
               	b	<addr>
               	mov	w0, w0
               	ldurh	w4, [x29, #-0x8]
               	crc32h	w0, w0, w4
               	b	<addr>
               	mov	w0, w0
               	ldur	w4, [x29, #-0x8]
               	crc32w	w0, w0, w4
               	b	<addr>

<sha256_abc>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1d0
               	sub	x0, x29, #0x80
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x2, x29, #0x40
               	stur	wzr, [x29, #-0x40]
               	stur	wzr, [x29, #-0x3c]
               	stur	wzr, [x29, #-0x38]
               	stur	wzr, [x29, #-0x34]
               	stur	wzr, [x29, #-0x30]
               	stur	wzr, [x29, #-0x2c]
               	stur	wzr, [x29, #-0x28]
               	stur	wzr, [x29, #-0x24]
               	stur	wzr, [x29, #-0x20]
               	stur	wzr, [x29, #-0x1c]
               	stur	wzr, [x29, #-0x18]
               	stur	wzr, [x29, #-0x14]
               	stur	wzr, [x29, #-0x10]
               	stur	wzr, [x29, #-0xc]
               	stur	wzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x4]
               	mov	x0, #0x6380             // =25472
               	movk	x0, #0x6162, lsl #16
               	stur	w0, [x29, #-0x40]
               	mov	x0, #0x18               // =24
               	stur	w0, [x29, #-0x4]
               	sub	x16, x29, #0x80
               	ldr	q4, [x16]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x10
               	ldr	q3, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	sub	x1, x29, #0x1d0
               	add	x4, x1, x0, lsl #4
               	cmp	w0, #0x4
               	b.ge	<addr>
               	lsl	x1, x0, #2
               	add	x1, x2, x1, lsl #2
               	ldr	q0, [x1]
               	sub	x1, x29, #0xd0
               	stur	q0, [x29, #-0xd0]
               	b	<addr>
               	sub	x5, x0, #0x4
               	add	x5, x1, x5, lsl #4
               	sub	x6, x0, #0x3
               	add	x6, x1, x6, lsl #4
               	ldr	q0, [x5]
               	ldr	q1, [x6]
               	str	q0, [sp, #0x120]
               	str	q1, [sp, #0x130]
               	ldr	q0, [sp, #0x120]
               	ldr	q1, [sp, #0x130]
               	sha256su0	v0.4s, v1.4s
               	sub	x5, x0, #0x2
               	add	x5, x1, x5, lsl #4
               	sub	x6, x0, #0x1
               	add	x1, x1, x6, lsl #4
               	ldr	q1, [x5]
               	ldr	q2, [x1]
               	str	q0, [sp, #0x120]
               	str	q1, [sp, #0x130]
               	str	q2, [sp, #0x140]
               	ldr	q0, [sp, #0x120]
               	ldr	q1, [sp, #0x130]
               	ldr	q2, [sp, #0x140]
               	sha256su1	v0.4s, v1.4s, v2.4s
               	sub	x1, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	sub	x1, x29, #0x1d0
               	add	x1, x1, x0, lsl #4
               	lsl	x4, x0, #2
               	add	x4, x3, x4, lsl #2
               	ldr	q0, [x4]
               	ldr	q1, [x1]
               	add	v5.4s, v1.4s, v0.4s
               	str	q4, [sp, #0x120]
               	str	q3, [sp, #0x130]
               	str	q5, [sp, #0x140]
               	ldr	q0, [sp, #0x120]
               	ldr	q1, [sp, #0x130]
               	ldr	q2, [sp, #0x140]
               	sha256h	q0, q1, v2.4s
               	mov	v6.16b, v0.16b
               	str	q3, [sp, #0x120]
               	str	q4, [sp, #0x130]
               	str	q5, [sp, #0x140]
               	ldr	q0, [sp, #0x120]
               	ldr	q1, [sp, #0x130]
               	ldr	q2, [sp, #0x140]
               	sha256h2	q0, q1, v2.4s
               	mov	v3.16b, v0.16b
               	add	x0, x0, #0x1
               	mov	v4.16b, v6.16b
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x16, x29, #0x80
               	ldr	q0, [x16]
               	add	v0.4s, v4.4s, v0.4s
               	sub	x16, x29, #0x60
               	str	q0, [x16]
               	sub	x0, x29, #0x60
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x80
               	add	x1, x1, #0x10
               	ldr	q0, [x1]
               	add	v0.4s, v3.4s, v0.4s
               	str	q0, [x0]
               	sub	x0, x29, #0x60
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	add	sp, sp, #0x1d0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x290
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x25               // =37
               	sub	x2, x29, #0x80
               	mul	x3, x0, x1
               	add	x3, x3, #0xb
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3d
               	b.lt	<addr>
               	mov	x0, #0xffffffff         // =4294967295
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x9                // =9
               	mov	x3, #0x8320             // =33568
               	movk	x3, #0xedb8, lsl #16
               	bl	<addr>
               	mov	x17, #0xc6d9            // =50905
               	movk	x17, #0x340b, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0xffffffff        // =4294967295
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x9                // =9
               	mov	x3, #0x3b78             // =15224
               	movk	x3, #0x82f6, lsl #16
               	mov	x0, x23
               	bl	<addr>
               	mov	x17, #0x6d7c            // =28028
               	movk	x17, #0x1cf9, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	sub	x22, x29, #0x80
               	mov	x0, x23
               	mov	x3, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x24, x0
               	mov	x0, #0xffffffff         // =4294967295
               	mov	x3, #0x8320             // =33568
               	movk	x3, #0xedb8, lsl #16
               	mov	x1, x22
               	mov	x2, x20
               	bl	<addr>
               	cmp	w24, w0
               	b.ne	<addr>
               	mov	x22, #0xffffffff        // =4294967295
               	sub	x1, x29, #0x80
               	mov	x3, #0x1                // =1
               	mov	x0, x22
               	mov	x2, x20
               	bl	<addr>
               	mov	x24, x0
               	sub	x1, x29, #0x80
               	mov	x3, #0x3b78             // =15224
               	movk	x3, #0x82f6, lsl #16
               	mov	x0, x22
               	mov	x2, x20
               	bl	<addr>
               	cmp	w24, w0
               	b.ne	<addr>
               	add	x20, x20, #0x5
               	cmp	w20, #0x3d
               	b.le	<addr>
               	mov	x16, #0x6               // =6
               	rbit	w0, w16
               	mov	x17, #0x60000000        // =1610612736
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	sub	x3, x29, #0x40
               	stur	wzr, [x29, #-0x40]
               	stur	wzr, [x29, #-0x3c]
               	stur	wzr, [x29, #-0x38]
               	stur	wzr, [x29, #-0x34]
               	stur	wzr, [x29, #-0x30]
               	stur	wzr, [x29, #-0x2c]
               	stur	wzr, [x29, #-0x28]
               	stur	wzr, [x29, #-0x24]
               	stur	wzr, [x29, #-0x20]
               	stur	wzr, [x29, #-0x1c]
               	stur	wzr, [x29, #-0x18]
               	stur	wzr, [x29, #-0x14]
               	stur	wzr, [x29, #-0x10]
               	stur	wzr, [x29, #-0xc]
               	stur	wzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x4]
               	mov	x0, #0x6380             // =25472
               	movk	x0, #0x6162, lsl #16
               	stur	w0, [x29, #-0x40]
               	mov	x0, #0x18               // =24
               	stur	w0, [x29, #-0x4]
               	sub	x16, x29, #0xb0
               	ldr	q3, [x16]
               	ldur	w1, [x29, #-0xa0]
               	mov	x4, #0x3334             // =13108
               	movk	x4, #0x3333, lsl #16
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x260
               	add	x6, x2, x0, lsl #4
               	cmp	w0, #0x4
               	b.ge	<addr>
               	lsl	x2, x0, #2
               	add	x2, x3, x2, lsl #2
               	ldr	q0, [x2]
               	sub	x2, x29, #0x120
               	str	q0, [sp, #0x170]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x6]
               	sub	x2, x29, #0x260
               	add	x2, x2, x0, lsl #4
               	mul	x6, x0, x4
               	lsr	x6, x6, #32
               	ldr	w6, [x5, x6, lsl #2]
               	dup	v0.4s, w6
               	ldr	q1, [x2]
               	add	v2.4s, v1.4s, v0.4s
               	mov	w2, v3.s[0]
               	mov	w2, w2
               	fmov	d16, x2
               	sha1h	s0, s16
               	stur	s0, [x29, #-0xb8]
               	ldur	w2, [x29, #-0xb8]
               	cmp	w0, #0x5
               	b.ge	<addr>
               	str	q3, [sp, #0x1a0]
               	fmov	d16, x1
               	str	d16, [sp, #0x1b0]
               	add	x16, sp, #0x1b8
               	str	q2, [x16]
               	ldr	q0, [sp, #0x1a0]
               	ldr	d1, [sp, #0x1b0]
               	add	x16, sp, #0x1b8
               	ldr	q2, [x16]
               	sha1c	q0, s1, v2.4s
               	sub	x1, x29, #0x100
               	stur	q0, [x29, #-0x100]
               	b	<addr>
               	cmp	w0, #0xa
               	b.lt	<addr>
               	cmp	w0, #0xf
               	b.ge	<addr>
               	str	q3, [sp, #0x1a0]
               	fmov	d16, x1
               	str	d16, [sp, #0x1b0]
               	add	x16, sp, #0x1b8
               	str	q2, [x16]
               	ldr	q0, [sp, #0x1a0]
               	ldr	d1, [sp, #0x1b0]
               	add	x16, sp, #0x1b8
               	ldr	q2, [x16]
               	sha1m	q0, s1, v2.4s
               	sub	x1, x29, #0x120
               	str	q0, [sp, #0x170]
               	b	<addr>
               	str	q3, [sp, #0x1a0]
               	fmov	d16, x1
               	str	d16, [sp, #0x1b0]
               	add	x16, sp, #0x1b8
               	str	q2, [x16]
               	ldr	q0, [sp, #0x1a0]
               	ldr	d1, [sp, #0x1b0]
               	add	x16, sp, #0x1b8
               	ldr	q2, [x16]
               	sha1p	q0, s1, v2.4s
               	sub	x1, x29, #0x110
               	str	q0, [sp, #0x180]
               	b	<addr>
               	sub	x7, x0, #0x4
               	add	x7, x2, x7, lsl #4
               	sub	x8, x0, #0x3
               	add	x8, x2, x8, lsl #4
               	sub	x9, x0, #0x2
               	add	x9, x2, x9, lsl #4
               	ldr	q0, [x7]
               	ldr	q1, [x8]
               	ldr	q2, [x9]
               	str	q0, [sp, #0x1a0]
               	str	q1, [sp, #0x1b0]
               	str	q2, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1a0]
               	ldr	q1, [sp, #0x1b0]
               	ldr	q2, [sp, #0x1c0]
               	sha1su0	v0.4s, v1.4s, v2.4s
               	sub	x7, x0, #0x1
               	add	x2, x2, x7, lsl #4
               	ldr	q1, [x2]
               	str	q0, [sp, #0x1a0]
               	str	q1, [sp, #0x1b0]
               	ldr	q0, [sp, #0x1a0]
               	ldr	q1, [sp, #0x1b0]
               	sha1su1	v0.4s, v1.4s
               	sub	x2, x29, #0x110
               	str	q0, [sp, #0x180]
               	b	<addr>
               	ldr	q3, [x1]
               	add	x0, x0, #0x1
               	mov	x1, x2
               	cmp	w0, #0x14
               	b.lt	<addr>
               	sub	x16, x29, #0xb0
               	ldr	q0, [x16]
               	add	v0.4s, v3.4s, v0.4s
               	sub	x16, x29, #0x98
               	str	q0, [x16]
               	sub	x0, x29, #0x98
               	ldur	w2, [x29, #-0xa0]
               	add	x1, x1, x2
               	stur	w1, [x29, #-0x88]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x14               // =20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	dmb	ish
               	isb
               	yield
               	mov	x0, #0x2a               // =42
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
