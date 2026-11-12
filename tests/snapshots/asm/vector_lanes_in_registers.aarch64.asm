
vector_lanes_in_registers.aarch64:	file format elf64-littleaarch64

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

<put_c>:
               	sxtb	x0, w0
               	mov	v0.b[3], w0
               	sub	x0, x0, #0x1
               	sxtb	x0, w0
               	mov	v0.b[15], w0
               	add	v0.16b, v0.16b, v0.16b
               	ret

<get_c>:
               	add	v1.16b, v0.16b, v0.16b
               	smov	x0, v1.b[5]
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	smov	x1, v0.b[15]
               	add	x0, x0, x1
               	ret

<get_uc>:
               	add	v0.16b, v0.16b, v0.16b
               	umov	w0, v0.b[9]
               	ret

<put_s>:
               	sxth	x0, w0
               	mov	v0.h[0], w0
               	mov	v0.h[7], w0
               	sub	v1.8h, v0.8h, v0.8h
               	add	v0.8h, v1.8h, v0.8h
               	ret

<get_s>:
               	mov	v0.16b, v0.16b
               	smov	x0, v0.h[6]
               	ret

<get_us>:
               	mov	v0.16b, v0.16b
               	umov	w0, v0.h[1]
               	ret

<put_i>:
               	mov	v0.s[2], w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	eor	v0.16b, v0.16b, v1.16b
               	ret

<get_i>:
               	add	v0.4s, v0.4s, v0.4s
               	smov	x0, v0.s[3]
               	ret

<get_u>:
               	add	v0.4s, v0.4s, v0.4s
               	mov	w0, v0.s[3]
               	ret

<mk_l>:
               	fmov	d0, x0
               	mov	v0.d[1], x1
               	add	v0.2d, v0.2d, v0.2d
               	ret

<get_l>:
               	mov	x0, #0x3                // =3
               	mov	x1, v0.d[1]
               	mul	x0, x1, x0
               	ret

<put_f>:
               	fmov	s2, #2.00000000
               	mov	s3, v0.s[0]
               	fmul	s3, s3, s2
               	mov	x0, #0x0                // =0
               	fmov	s3, s3
               	fmul	s1, s1, s2
               	mov	v16.16b, v3.16b
               	mov	v16.s[1], v1.s[0]
               	mov	v1.16b, v16.16b
               	mov	s3, v0.s[2]
               	fmul	s3, s3, s2
               	mov	v1.s[2], v3.s[0]
               	mov	s0, v0.s[3]
               	fmul	s0, s0, s2
               	mov	v16.16b, v1.16b
               	mov	v16.s[3], v0.s[0]
               	mov	v0.16b, v16.16b
               	ret

<get_f>:
               	fmov	s1, #1.00000000
               	mov	s0, v0.s[3]
               	fadd	s0, s0, s1
               	ret

<put_d>:
               	fmov	d2, #0.50000000
               	fsub	d0, d0, d2
               	fsub	d1, d1, d2
               	mov	v0.d[1], v1.d[0]
               	ret

<get_d>:
               	fmul	v1.2d, v0.2d, v0.2d
               	fmul	v0.2d, v0.2d, v0.2d
               	mov	d0, v0.d[1]
               	fadd	d0, d1, d0
               	ret

<put_i8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x1c]
               	neg	x8, x1
               	sub	x0, x29, #0x30
               	add	x2, x2, x2
               	stur	w2, [x29, #-0x30]
               	add	x2, x1, x1
               	stur	w2, [x29, #-0x2c]
               	add	x2, x3, x3
               	stur	w2, [x29, #-0x28]
               	add	x2, x4, x4
               	stur	w2, [x29, #-0x24]
               	add	x2, x5, x5
               	stur	w2, [x29, #-0x20]
               	add	x2, x6, x6
               	stur	w2, [x29, #-0x1c]
               	sub	x1, x8, x1
               	stur	w1, [x29, #-0x18]
               	add	x1, x7, x7
               	stur	w1, [x29, #-0x14]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<get_i8>:
               	ldrsw	x1, [x0, #0x1c]
               	add	x1, x1, x1
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x0, x0
               	sxtw	x0, w0
               	sub	x0, x1, x0
               	ret

<put_d4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	x8, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	stur	d0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	ldur	d1, [x29, #-0x50]
               	fmul	d1, d1, d1
               	stur	d1, [x29, #-0x30]
               	ldur	d1, [x29, #-0x48]
               	fmul	d1, d1, d1
               	stur	d1, [x29, #-0x28]
               	ldur	d1, [x29, #-0x40]
               	fmul	d1, d1, d1
               	stur	d1, [x29, #-0x20]
               	fmul	d0, d0, d0
               	stur	d0, [x29, #-0x18]
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

<get_d4>:
               	ldr	d0, [x0, #0x10]
               	fadd	d0, d0, d0
               	ret

<get_s16>:
               	ldrsh	x0, [x0, #0x1a]
               	add	x0, x0, x0
               	sxth	x0, w0
               	ret

<put_i16>:
               	str	x20, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	stur	x8, [x29, #-0x8]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x0, #0x8]
               	ldr	w5, [x0, #0xc]
               	ldr	w6, [x0, #0x10]
               	ldr	w7, [x0, #0x14]
               	ldr	w8, [x0, #0x18]
               	ldr	w9, [x0, #0x1c]
               	ldr	w10, [x0, #0x20]
               	ldr	w11, [x0, #0x24]
               	ldr	w12, [x0, #0x28]
               	ldr	w13, [x0, #0x2c]
               	ldr	w14, [x0, #0x30]
               	ldr	w15, [x0, #0x38]
               	ldr	w0, [x0, #0x3c]
               	sub	x20, x29, #0x50
               	add	x2, x2, x2
               	stur	w2, [x29, #-0x50]
               	add	x2, x3, x3
               	stur	w2, [x29, #-0x4c]
               	add	x2, x4, x4
               	stur	w2, [x29, #-0x48]
               	add	x2, x5, x5
               	stur	w2, [x29, #-0x44]
               	add	x2, x6, x6
               	stur	w2, [x29, #-0x40]
               	add	x2, x7, x7
               	stur	w2, [x29, #-0x3c]
               	add	x2, x8, x8
               	stur	w2, [x29, #-0x38]
               	add	x2, x9, x9
               	stur	w2, [x29, #-0x34]
               	add	x2, x10, x10
               	stur	w2, [x29, #-0x30]
               	add	x2, x11, x11
               	stur	w2, [x29, #-0x2c]
               	add	x2, x12, x12
               	stur	w2, [x29, #-0x28]
               	add	x2, x13, x13
               	stur	w2, [x29, #-0x24]
               	add	x2, x14, x14
               	stur	w2, [x29, #-0x20]
               	add	x1, x1, x1
               	stur	w1, [x29, #-0x1c]
               	add	x1, x15, x15
               	stur	w1, [x29, #-0x18]
               	add	x0, x0, x0
               	stur	w0, [x29, #-0x14]
               	mov	x16, x20
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	ldp	x0, x1, [x16, #0x30]
               	stp	x0, x1, [x17, #0x30]
               	mov	x0, x17
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret

<get_i16>:
               	ldrsw	x0, [x0, #0x38]
               	add	x0, x0, x0
               	sxtw	x0, w0
               	ret

<get_l8>:
               	ldr	x0, [x0, #0x28]
               	sub	x0, x0, #0x1
               	ret

<three>:
               	mov	x0, #0x0                // =0
               	fmov	s0, s0
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	mov	v0.s[1], v17.s[0]
               	fmov	d17, x1
               	fmov	s3, s17
               	mov	v16.16b, v3.16b
               	mov	v16.s[1], v1.s[0]
               	fmov	d1, d16
               	fmov	s2, s2
               	fmov	d17, x1
               	mov	v2.s[1], v17.s[0]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x260
               	stp	x20, x21, [sp]
               	sub	x7, x29, #0x250
               	mov	x0, #0x32               // =50
               	strb	w0, [sp, #0x10]
               	mov	x0, #0x2b               // =43
               	strb	w0, [sp, #0x11]
               	mov	x0, #0x24               // =36
               	strb	w0, [sp, #0x12]
               	mov	x0, #0x1d               // =29
               	strb	w0, [sp, #0x13]
               	mov	x0, #0x16               // =22
               	strb	w0, [sp, #0x14]
               	mov	x0, #0xf                // =15
               	strb	w0, [sp, #0x15]
               	mov	x0, #0x8                // =8
               	strb	w0, [sp, #0x16]
               	mov	x0, #0x1                // =1
               	strb	w0, [sp, #0x17]
               	mov	x0, #-0x6               // =-6
               	strb	w0, [sp, #0x18]
               	mov	x0, #-0xd               // =-13
               	strb	w0, [sp, #0x19]
               	mov	x0, #-0x14              // =-20
               	strb	w0, [sp, #0x1a]
               	mov	x0, #-0x1b              // =-27
               	strb	w0, [sp, #0x1b]
               	mov	x0, #-0x22              // =-34
               	strb	w0, [sp, #0x1c]
               	mov	x0, #-0x29              // =-41
               	strb	w0, [sp, #0x1d]
               	mov	x0, #-0x30              // =-48
               	strb	w0, [sp, #0x1e]
               	mov	x0, #-0x37              // =-55
               	strb	w0, [sp, #0x1f]
               	mov	x0, #-0x3c              // =-60
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x2, x29, #0x210
               	str	q0, [sp, #0x50]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x250
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #-0x3c              // =-60
               	sturb	w0, [x29, #-0xd]
               	mov	x0, #-0x3d              // =-61
               	sturb	w0, [x29, #-0x1]
               	mov	x0, #0x0                // =0
               	ldrsb	x3, [x2, x0]
               	ldrsb	x4, [x1, x0]
               	lsl	x4, x4, #1
               	sxtb	x4, w4
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x7, x29, #0x250
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x17, #0x74f9            // =29945
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	mov	x0, #0xc8               // =200
               	strb	w0, [sp, #0x50]
               	mov	x0, #0xc9               // =201
               	strb	w0, [sp, #0x51]
               	mov	x0, #0xca               // =202
               	strb	w0, [sp, #0x52]
               	mov	x0, #0xcb               // =203
               	strb	w0, [sp, #0x53]
               	mov	x0, #0xcc               // =204
               	strb	w0, [sp, #0x54]
               	mov	x0, #0xcd               // =205
               	strb	w0, [sp, #0x55]
               	mov	x0, #0xce               // =206
               	strb	w0, [sp, #0x56]
               	mov	x0, #0xcf               // =207
               	strb	w0, [sp, #0x57]
               	mov	x0, #0xd0               // =208
               	strb	w0, [sp, #0x58]
               	mov	x0, #0xd1               // =209
               	strb	w0, [sp, #0x59]
               	mov	x0, #0xd2               // =210
               	strb	w0, [sp, #0x5a]
               	mov	x0, #0xd3               // =211
               	strb	w0, [sp, #0x5b]
               	mov	x0, #0xd4               // =212
               	strb	w0, [sp, #0x5c]
               	mov	x0, #0xd5               // =213
               	strb	w0, [sp, #0x5d]
               	mov	x0, #0xd6               // =214
               	strb	w0, [sp, #0x5e]
               	mov	x0, #0xd7               // =215
               	strb	w0, [sp, #0x5f]
               	ldr	q0, [x7]
               	bl	<addr>
               	cmp	x0, #0xa2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x250
               	mov	x0, #-0x7530            // =-30000
               	strh	w0, [sp, #0x10]
               	mov	x0, #-0x59d8            // =-23000
               	strh	w0, [sp, #0x12]
               	mov	x0, #-0x3e80            // =-16000
               	strh	w0, [sp, #0x14]
               	mov	x0, #-0x2328            // =-9000
               	strh	w0, [sp, #0x16]
               	mov	x0, #-0x7d0             // =-2000
               	strh	w0, [sp, #0x18]
               	mov	x0, #0x1388             // =5000
               	strh	w0, [sp, #0x1a]
               	mov	x0, #0x2ee0             // =12000
               	strh	w0, [sp, #0x1c]
               	mov	x0, #0x4a38             // =19000
               	strh	w0, [sp, #0x1e]
               	mov	x21, #-0x3039           // =-12345
               	ldr	q0, [x20]
               	mov	x0, x21
               	bl	<addr>
               	sub	x2, x29, #0x210
               	str	q0, [sp, #0x50]
               	mov	x0, #0x0                // =0
               	ldrsh	x3, [x2, x0, lsl #1]
               	cbz	w0, <addr>
               	cmp	w0, #0x7
               	b.ne	<addr>
               	mov	x1, x21
               	cmp	w3, w1
               	b.eq	<addr>
               	b	<addr>
               	ldrsh	x1, [x20, x0, lsl #1]
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x7, x29, #0x250
               	ldr	q0, [x7]
               	bl	<addr>
               	ldrsh	x1, [sp, #0x1c]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	mov	x0, #0xffff             // =65535
               	strh	w0, [sp, #0x50]
               	mov	x0, #0xfffe             // =65534
               	strh	w0, [sp, #0x52]
               	mov	x0, #0xfffd             // =65533
               	strh	w0, [sp, #0x54]
               	mov	x0, #0xfffc             // =65532
               	strh	w0, [sp, #0x56]
               	mov	x0, #0xfffb             // =65531
               	strh	w0, [sp, #0x58]
               	mov	x0, #0xfffa             // =65530
               	strh	w0, [sp, #0x5a]
               	mov	x0, #0xfff9             // =65529
               	strh	w0, [sp, #0x5c]
               	mov	x0, #0xfff8             // =65528
               	strh	w0, [sp, #0x5e]
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x17, #0xfffe            // =65534
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	mov	x0, #0xcd15             // =52501
               	movk	x0, #0x75b, lsl #16
               	ldr	q0, [x7]
               	bl	<addr>
               	smov	x0, v0.s[0]
               	mov	x17, #-0x7              // =-7
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x8
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	mov	x17, #0xcd15            // =52501
               	movk	x17, #0x75b, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	mov	x17, #-0xca08           // =-51720
               	movk	x17, #0xc465, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x17, #-0x940e           // =-37902
               	movk	x17, #0x88ca, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x17, #0x2               // =2
               	movk	x17, #0x8000, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x5               // =-5
               	mov	x1, #0x789a             // =30874
               	movk	x1, #0x3456, lsl #16
               	movk	x1, #0x12, lsl #32
               	bl	<addr>
               	sub	x7, x29, #0x210
               	str	q0, [sp, #0x50]
               	mov	x0, v0.d[0]
               	mov	x17, #-0xa              // =-10
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x17, #0xf134            // =61748
               	movk	x17, #0x68ac, lsl #16
               	movk	x17, #0x24, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x17, #0xd39c            // =54172
               	movk	x17, #0x3a06, lsl #16
               	movk	x17, #0x6d, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	fmov	s0, #10.00000000
               	fmov	d1, d0
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	s1, v0.s[0]
               	fmov	s2, #3.00000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s1, v0.s[1]
               	fmov	s2, #20.00000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s1, v0.s[2]
               	fmov	s2, #-7.00000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s0, v0.s[3]
               	fmov	s1, #8.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	ldr	q0, [x7]
               	bl	<addr>
               	fmov	s1, #5.25000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x70]
               	fmov	d1, d0
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	d1, v0.d[0]
               	fmov	d2, #2.50000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #7.75000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x210
               	ldr	q0, [x7]
               	bl	<addr>
               	fmov	d1, #25.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x1d0
               	mov	x0, #-0x900             // =-2304
               	movk	x0, #0xffc2, lsl #16
               	str	w0, [sp, #0x90]
               	mov	x0, #-0xc6bd            // =-50877
               	movk	x0, #0xffd2, lsl #16
               	str	w0, [sp, #0x94]
               	mov	x0, #-0x847a            // =-33914
               	movk	x0, #0xffe1, lsl #16
               	str	w0, [sp, #0x98]
               	mov	x0, #-0x4237            // =-16951
               	movk	x0, #0xfff0, lsl #16
               	str	w0, [sp, #0x9c]
               	mov	x0, #0xc                // =12
               	str	w0, [sp, #0xa0]
               	mov	x0, #0x424f             // =16975
               	movk	x0, #0xf, lsl #16
               	str	w0, [sp, #0xa4]
               	mov	x0, #0x8492             // =33938
               	movk	x0, #0x1e, lsl #16
               	str	w0, [sp, #0xa8]
               	mov	x0, #0xc6d5             // =50901
               	movk	x0, #0x2d, lsl #16
               	str	w0, [sp, #0xac]
               	mov	x21, #0x4d              // =77
               	sub	x0, x29, #0x190
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	mov	x1, x21
               	sub	x8, x29, #0x210
               	bl	<addr>
               	sub	x0, x29, #0x210
               	sub	x2, x29, #0x250
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	mov	x0, #0x0                // =0
               	ldrsw	x3, [x2, x0, lsl #2]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, x21
               	lsl	x1, x1, #1
               	cmp	w3, w1
               	b.eq	<addr>
               	b	<addr>
               	cmp	w0, #0x6
               	b.ne	<addr>
               	mov	x1, #-0x4d              // =-77
               	b	<addr>
               	ldrsw	x1, [x20, x0, lsl #2]
               	lsl	x1, x1, #1
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x1d0
               	sub	x0, x29, #0x170
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	ldrsw	x1, [sp, #0xac]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	ldrsw	x2, [sp, #0x98]
               	lsl	x2, x2, #1
               	sxtw	x2, w2
               	sub	x1, x1, x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1d0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	fmov	d0, #-6.00000000
               	sub	x0, x29, #0x150
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x8, x29, #0x210
               	bl	<addr>
               	sub	x0, x29, #0x210
               	sub	x1, x29, #0x250
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x10]
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [sp, #0x18]
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [sp, #0x20]
               	fmov	d1, #9.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [sp, #0x28]
               	mov	x16, #0x4042000000000000 // =4630263366890291200
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1d0
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x210
               	strh	wzr, [sp, #0x50]
               	mov	x0, #-0x3e8             // =-1000
               	strh	w0, [sp, #0x52]
               	mov	x0, #-0x7d0             // =-2000
               	strh	w0, [sp, #0x54]
               	mov	x0, #-0xbb8             // =-3000
               	strh	w0, [sp, #0x56]
               	mov	x0, #-0xfa0             // =-4000
               	strh	w0, [sp, #0x58]
               	mov	x0, #-0x1388            // =-5000
               	strh	w0, [sp, #0x5a]
               	mov	x0, #-0x1770            // =-6000
               	strh	w0, [sp, #0x5c]
               	mov	x0, #-0x1b58            // =-7000
               	strh	w0, [sp, #0x5e]
               	mov	x0, #-0x1f40            // =-8000
               	strh	w0, [sp, #0x60]
               	mov	x0, #-0x2328            // =-9000
               	strh	w0, [sp, #0x62]
               	mov	x0, #-0x2710            // =-10000
               	strh	w0, [sp, #0x64]
               	mov	x0, #-0x2af8            // =-11000
               	strh	w0, [sp, #0x66]
               	mov	x0, #-0x2ee0            // =-12000
               	strh	w0, [sp, #0x68]
               	mov	x0, #-0x32c8            // =-13000
               	strh	w0, [sp, #0x6a]
               	mov	x0, #-0x36b0            // =-14000
               	strh	w0, [sp, #0x6c]
               	mov	x0, #-0x3a98            // =-15000
               	strh	w0, [sp, #0x6e]
               	sub	x0, x29, #0x110
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	mov	x17, #-0x6590           // =-26000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x1d0
               	mov	x0, #-0x32              // =-50
               	str	w0, [sp, #0x90]
               	mov	x0, #-0x31              // =-49
               	str	w0, [sp, #0x94]
               	mov	x0, #-0x2e              // =-46
               	str	w0, [sp, #0x98]
               	mov	x0, #-0x29              // =-41
               	str	w0, [sp, #0x9c]
               	mov	x0, #-0x22              // =-34
               	str	w0, [sp, #0xa0]
               	mov	x0, #-0x19              // =-25
               	str	w0, [sp, #0xa4]
               	mov	x0, #-0xe               // =-14
               	str	w0, [sp, #0xa8]
               	mov	x0, #-0x1               // =-1
               	str	w0, [sp, #0xac]
               	mov	x0, #0xe                // =14
               	str	w0, [sp, #0xb0]
               	mov	x0, #0x1f               // =31
               	str	w0, [sp, #0xb4]
               	mov	x0, #0x32               // =50
               	str	w0, [sp, #0xb8]
               	mov	x0, #0x47               // =71
               	str	w0, [sp, #0xbc]
               	mov	x0, #0x5e               // =94
               	str	w0, [sp, #0xc0]
               	mov	x0, #0x77               // =119
               	str	w0, [sp, #0xc4]
               	mov	x0, #0x92               // =146
               	str	w0, [sp, #0xc8]
               	mov	x0, #0xaf               // =175
               	str	w0, [sp, #0xcc]
               	mov	x21, #-0x1f             // =-31
               	sub	x0, x29, #0xf0
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x20, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x20, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	mov	x1, x21
               	sub	x8, x29, #0x210
               	bl	<addr>
               	sub	x0, x29, #0x210
               	sub	x2, x29, #0x250
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	mov	x0, #0x0                // =0
               	ldrsw	x3, [x2, x0, lsl #2]
               	cmp	w0, #0xd
               	b.ne	<addr>
               	mov	x1, x21
               	lsl	x1, x1, #1
               	cmp	w3, w1
               	b.eq	<addr>
               	b	<addr>
               	ldrsw	x1, [x20, x0, lsl #2]
               	lsl	x1, x1, #1
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x1d0
               	sub	x0, x29, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	bl	<addr>
               	cmp	x0, #0x124
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x210
               	str	xzr, [sp, #0x50]
               	mov	x0, #-0x100000000       // =-4294967296
               	str	x0, [sp, #0x58]
               	mov	x0, #-0x200000000       // =-8589934592
               	str	x0, [sp, #0x60]
               	mov	x0, #0xfffd00000000     // =281462091808768
               	movk	x0, #0xffff, lsl #48
               	str	x0, [sp, #0x68]
               	mov	x0, #-0x400000000       // =-17179869184
               	str	x0, [sp, #0x70]
               	mov	x0, #0xfffb00000000     // =281453501874176
               	movk	x0, #0xffff, lsl #48
               	str	x0, [sp, #0x78]
               	mov	x0, #0xfffa00000000     // =281449206906880
               	movk	x0, #0xffff, lsl #48
               	str	x0, [sp, #0x80]
               	mov	x0, #0xfff900000000     // =281444911939584
               	movk	x0, #0xffff, lsl #48
               	str	x0, [sp, #0x88]
               	sub	x0, x29, #0x70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	bl	<addr>
               	mov	x17, #-0x500000001      // =-21474836481
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	fmov	s2, #3.00000000
               	bl	<addr>
               	stur	d0, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x8]
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	ldur	s0, [x29, #-0x30]
               	fmov	s1, #1.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x2c]
               	movi	d0, #0000000000000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x28]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x24]
               	fmov	s2, #2.00000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x20]
               	fmov	s2, #3.00000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x1c]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
