
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
               	sub	sp, sp, #0x50
               	stur	x8, [x29, #-0x8]
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	stur	w1, [x29, #-0x4c]
               	neg	x0, x1
               	stur	w0, [x29, #-0x38]
               	ldur	q0, [x29, #-0x50]
               	add	v1.4s, v0.4s, v0.4s
               	ldur	q0, [x29, #-0x40]
               	add	v0.4s, v0.4s, v0.4s
               	sub	x0, x29, #0x30
               	stur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
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

<get_i8>:
               	ldr	q0, [x0, #0x10]
               	add	v0.4s, v0.4s, v0.4s
               	smov	x1, v0.s[3]
               	ldr	q0, [x0]
               	add	v0.4s, v0.4s, v0.4s
               	smov	x0, v0.s[2]
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
               	ldur	q0, [x29, #-0x50]
               	fmul	v1.2d, v0.2d, v0.2d
               	ldur	q0, [x29, #-0x40]
               	fmul	v0.2d, v0.2d, v0.2d
               	sub	x0, x29, #0x30
               	stur	q1, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
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
               	ldr	q0, [x0, #0x10]
               	fadd	v0.2d, v0.2d, v0.2d
               	ret

<get_s16>:
               	ldr	q0, [x0, #0x10]
               	add	v0.8h, v0.8h, v0.8h
               	smov	x0, v0.h[5]
               	ret

<put_i16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	stur	x8, [x29, #-0x8]
               	sub	x2, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	stur	w1, [x29, #-0x5c]
               	ldur	q0, [x29, #-0x90]
               	add	v1.4s, v0.4s, v0.4s
               	ldur	q0, [x29, #-0x80]
               	add	v2.4s, v0.4s, v0.4s
               	ldur	q0, [x29, #-0x70]
               	add	v3.4s, v0.4s, v0.4s
               	ldur	q0, [x29, #-0x60]
               	add	v0.4s, v0.4s, v0.4s
               	sub	x0, x29, #0x50
               	stur	q1, [x29, #-0x50]
               	stur	q2, [x29, #-0x40]
               	stur	q3, [x29, #-0x30]
               	stur	q0, [x29, #-0x20]
               	mov	x16, x0
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
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret

<get_i16>:
               	ldr	q0, [x0, #0x30]
               	add	v0.4s, v0.4s, v0.4s
               	smov	x0, v0.s[2]
               	ret

<get_l8>:
               	ldr	x0, [x0, #0x28]
               	sub	x0, x0, #0x1
               	ret

<three>:
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	mov	v0.s[1], v17.s[0]
               	fmov	d17, x0
               	fmov	s3, s17
               	mov	v16.16b, v3.16b
               	mov	v16.s[1], v1.s[0]
               	fmov	d1, d16
               	fmov	d17, x0
               	mov	v2.s[1], v17.s[0]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x280
               	sub	x7, x29, #0x280
               	mov	x0, #0x2b32             // =11058
               	strh	w0, [sp]
               	mov	x0, #0x1d24             // =7460
               	strh	w0, [sp, #0x2]
               	mov	x0, #0xf16              // =3862
               	strh	w0, [sp, #0x4]
               	mov	x0, #0x108              // =264
               	strh	w0, [sp, #0x6]
               	mov	x0, #0xf3fa             // =62458
               	strh	w0, [sp, #0x8]
               	mov	x0, #0xe5ec             // =58860
               	strh	w0, [sp, #0xa]
               	mov	x0, #0xd7de             // =55262
               	strh	w0, [sp, #0xc]
               	mov	x0, #0xc9d0             // =51664
               	strh	w0, [sp, #0xe]
               	mov	x0, #-0x3c              // =-60
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x2, x29, #0x240
               	str	q0, [sp, #0x40]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x280
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
               	sub	x7, x29, #0x280
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x17, #0x74f9            // =29945
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
               	mov	x0, #0xc9c8             // =51656
               	strh	w0, [sp, #0x40]
               	mov	x0, #0xcbca             // =52170
               	strh	w0, [sp, #0x42]
               	mov	x0, #0xcdcc             // =52684
               	strh	w0, [sp, #0x44]
               	mov	x0, #0xcfce             // =53198
               	strh	w0, [sp, #0x46]
               	mov	x0, #0xd1d0             // =53712
               	strh	w0, [sp, #0x48]
               	mov	x0, #0xd3d2             // =54226
               	strh	w0, [sp, #0x4a]
               	mov	x0, #0xd5d4             // =54740
               	strh	w0, [sp, #0x4c]
               	mov	x0, #0xd7d6             // =55254
               	strh	w0, [sp, #0x4e]
               	ldr	q0, [x7]
               	bl	<addr>
               	cmp	x0, #0xa2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x280
               	mov	x0, #0x8ad0             // =35536
               	movk	x0, #0xa628, lsl #16
               	str	w0, [sp]
               	mov	x0, #0xc180             // =49536
               	movk	x0, #0xdcd8, lsl #16
               	str	w0, [sp, #0x4]
               	mov	x0, #0xf830             // =63536
               	movk	x0, #0x1388, lsl #16
               	str	w0, [sp, #0x8]
               	mov	x0, #0x2ee0             // =12000
               	movk	x0, #0x4a38, lsl #16
               	str	w0, [sp, #0xc]
               	mov	x3, #-0x3039            // =-12345
               	str	x2, [sp, #0x248]
               	str	x3, [sp, #0x240]
               	ldr	q0, [x2]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x2, [sp, #0x248]
               	ldr	x3, [sp, #0x240]
               	sub	x4, x29, #0x240
               	str	q0, [sp, #0x40]
               	mov	x0, #0x0                // =0
               	ldrsh	x5, [x4, x0, lsl #1]
               	cbz	w0, <addr>
               	cmp	w0, #0x7
               	b.ne	<addr>
               	mov	x1, x3
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	ldrsh	x1, [x2, x0, lsl #1]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x7, x29, #0x280
               	ldr	q0, [x7]
               	bl	<addr>
               	ldrsh	x1, [sp, #0xc]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xfffe, lsl #16
               	str	w0, [sp, #0x40]
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xfffc, lsl #16
               	str	w0, [sp, #0x44]
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xfffa, lsl #16
               	str	w0, [sp, #0x48]
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xfff8, lsl #16
               	str	w0, [sp, #0x4c]
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x17, #0xfffe            // =65534
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	mov	x0, #0xcd15             // =52501
               	movk	x0, #0x75b, lsl #16
               	ldr	q0, [x7]
               	bl	<addr>
               	smov	x0, v0.s[0]
               	cmn	x0, #0x7
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x17, #-0x940e           // =-37902
               	movk	x17, #0x88ca, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x5               // =-5
               	mov	x1, #0x789a             // =30874
               	movk	x1, #0x3456, lsl #16
               	movk	x1, #0x12, lsl #32
               	bl	<addr>
               	sub	x7, x29, #0x240
               	str	q0, [sp, #0x40]
               	mov	x0, v0.d[0]
               	cmn	x0, #0xa
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x17, #0xf134            // =61748
               	movk	x17, #0x68ac, lsl #16
               	movk	x17, #0x24, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x280
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
               	ldr	q0, [x7]
               	bl	<addr>
               	fmov	s1, #5.25000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x240
               	ldr	q0, [x7]
               	bl	<addr>
               	fmov	d1, #25.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x200
               	mov	x0, #0xf700             // =63232
               	movk	x0, #0xffc2, lsl #16
               	movk	x0, #0x3943, lsl #32
               	movk	x0, #0xffd2, lsl #48
               	str	x0, [sp, #0x80]
               	mov	x0, #0x7b86             // =31622
               	movk	x0, #0xffe1, lsl #16
               	movk	x0, #0xbdc9, lsl #32
               	movk	x0, #0xfff0, lsl #48
               	str	x0, [sp, #0x88]
               	mov	x0, #0xc                // =12
               	movk	x0, #0x424f, lsl #32
               	movk	x0, #0xf, lsl #48
               	str	x0, [sp, #0x90]
               	mov	x0, #0x8492             // =33938
               	movk	x0, #0x1e, lsl #16
               	movk	x0, #0xc6d5, lsl #32
               	movk	x0, #0x2d, lsl #48
               	str	x0, [sp, #0x98]
               	mov	x3, #0x4d               // =77
               	sub	x0, x29, #0x1c0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	str	x2, [sp, #0x238]
               	str	x3, [sp, #0x230]
               	mov	x1, x3
               	sub	x8, x29, #0x240
               	bl	<addr>
               	ldr	x2, [sp, #0x238]
               	ldr	x3, [sp, #0x230]
               	sub	x0, x29, #0x240
               	sub	x4, x29, #0x280
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x4, #0x10]
               	mov	x0, #0x0                // =0
               	ldrsw	x5, [x4, x0, lsl #2]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, x3
               	lsl	x1, x1, #1
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	cmp	w0, #0x6
               	b.ne	<addr>
               	mov	x1, #-0x4d              // =-77
               	b	<addr>
               	ldrsw	x1, [x2, x0, lsl #2]
               	lsl	x1, x1, #1
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x200
               	sub	x0, x29, #0x1a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	ldrsw	x1, [sp, #0x9c]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	ldrsw	x2, [sp, #0x88]
               	lsl	x2, x2, #1
               	sxtw	x2, w2
               	sub	x1, x1, x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x200
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	fmov	d0, #-6.00000000
               	sub	x0, x29, #0x180
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x8, x29, #0x240
               	bl	<addr>
               	sub	x0, x29, #0x240
               	sub	x1, x29, #0x280
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp]
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [sp, #0x8]
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [sp, #0x10]
               	fmov	d1, #9.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [sp, #0x18]
               	mov	x16, #0x4042000000000000 // =4630263366890291200
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x200
               	sub	x0, x29, #0x160
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x240
               	mov	x0, #0xfc180000         // =4229431296
               	str	w0, [sp, #0x40]
               	mov	x0, #0xf830             // =63536
               	movk	x0, #0xf448, lsl #16
               	str	w0, [sp, #0x44]
               	mov	x0, #0xf060             // =61536
               	movk	x0, #0xec78, lsl #16
               	str	w0, [sp, #0x48]
               	mov	x0, #0xe890             // =59536
               	movk	x0, #0xe4a8, lsl #16
               	str	w0, [sp, #0x4c]
               	mov	x0, #0xe0c0             // =57536
               	movk	x0, #0xdcd8, lsl #16
               	str	w0, [sp, #0x50]
               	mov	x0, #0xd8f0             // =55536
               	movk	x0, #0xd508, lsl #16
               	str	w0, [sp, #0x54]
               	mov	x0, #0xd120             // =53536
               	movk	x0, #0xcd38, lsl #16
               	str	w0, [sp, #0x58]
               	mov	x0, #0xc950             // =51536
               	movk	x0, #0xc568, lsl #16
               	str	w0, [sp, #0x5c]
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	mov	x17, #-0x6590           // =-26000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x200
               	mov	x0, #-0x32              // =-50
               	movk	x0, #0xffcf, lsl #32
               	str	x0, [sp, #0x80]
               	mov	x0, #-0x2e              // =-46
               	movk	x0, #0xffd7, lsl #32
               	str	x0, [sp, #0x88]
               	mov	x0, #-0x22              // =-34
               	movk	x0, #0xffe7, lsl #32
               	str	x0, [sp, #0x90]
               	mov	x0, #-0xe               // =-14
               	str	x0, [sp, #0x98]
               	mov	x0, #0xe                // =14
               	movk	x0, #0x1f, lsl #32
               	str	x0, [sp, #0xa0]
               	mov	x0, #0x32               // =50
               	movk	x0, #0x47, lsl #32
               	str	x0, [sp, #0xa8]
               	mov	x0, #0x5e               // =94
               	movk	x0, #0x77, lsl #32
               	str	x0, [sp, #0xb0]
               	mov	x0, #0x92               // =146
               	movk	x0, #0xaf, lsl #32
               	str	x0, [sp, #0xb8]
               	mov	x3, #-0x1f              // =-31
               	sub	x0, x29, #0x120
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	str	x2, [sp, #0x228]
               	str	x3, [sp, #0x220]
               	mov	x1, x3
               	sub	x8, x29, #0x240
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	ldr	x3, [sp, #0x220]
               	sub	x0, x29, #0x240
               	sub	x4, x29, #0x280
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x4, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x4, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x4, #0x30]
               	mov	x0, #0x0                // =0
               	ldrsw	x5, [x4, x0, lsl #2]
               	cmp	w0, #0xd
               	b.ne	<addr>
               	mov	x1, x3
               	lsl	x1, x1, #1
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	ldrsw	x1, [x2, x0, lsl #2]
               	lsl	x1, x1, #1
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x200
               	sub	x0, x29, #0xe0
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x240
               	str	xzr, [sp, #0x40]
               	mov	x0, #-0x100000000       // =-4294967296
               	str	x0, [sp, #0x48]
               	mov	x0, #-0x200000000       // =-8589934592
               	str	x0, [sp, #0x50]
               	mov	x0, #0xfffd00000000     // =281462091808768
               	movk	x0, #0xffff, lsl #48
               	str	x0, [sp, #0x58]
               	mov	x0, #-0x400000000       // =-17179869184
               	str	x0, [sp, #0x60]
               	mov	x0, #0xfffb00000000     // =281453501874176
               	movk	x0, #0xffff, lsl #48
               	str	x0, [sp, #0x68]
               	mov	x0, #0xfffa00000000     // =281449206906880
               	movk	x0, #0xffff, lsl #48
               	str	x0, [sp, #0x70]
               	mov	x0, #0xfff900000000     // =281444911939584
               	movk	x0, #0xffff, lsl #48
               	str	x0, [sp, #0x78]
               	sub	x0, x29, #0xa0
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
               	add	sp, sp, #0x280
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
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
