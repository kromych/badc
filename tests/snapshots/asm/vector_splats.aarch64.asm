
vector_splats.aarch64:	file format elf64-littleaarch64

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

<s8c>:
               	sxtb	x0, w0
               	dup	v0.8b, w0
               	ret

<s4s>:
               	sxth	x0, w0
               	dup	v0.4h, w0
               	ret

<s2i>:
               	dup	v0.2s, w0
               	ret

<s2f>:
               	dup	v0.2s, v0.s[0]
               	ret

<s16c>:
               	sxtb	x0, w0
               	dup	v0.16b, w0
               	ret

<s8us>:
               	and	x0, x0, #0xffff
               	dup	v0.8h, w0
               	ret

<s4i>:
               	dup	v0.4s, w0
               	ret

<s2l>:
               	dup	v0.2d, x0
               	ret

<s4f>:
               	dup	v0.4s, v0.s[0]
               	ret

<s2d>:
               	dup	v0.2d, v0.d[0]
               	ret

<s32uc>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	and	x1, x0, #0xff
               	sturb	w1, [x29, #-0x30]
               	sturb	w1, [x29, #-0x2f]
               	sturb	w1, [x29, #-0x2e]
               	sturb	w1, [x29, #-0x2d]
               	sturb	w1, [x29, #-0x2c]
               	sturb	w1, [x29, #-0x2b]
               	sturb	w1, [x29, #-0x2a]
               	sturb	w1, [x29, #-0x29]
               	sturb	w1, [x29, #-0x28]
               	sturb	w1, [x29, #-0x27]
               	sturb	w1, [x29, #-0x26]
               	sturb	w1, [x29, #-0x25]
               	sturb	w1, [x29, #-0x24]
               	sturb	w1, [x29, #-0x23]
               	sturb	w1, [x29, #-0x22]
               	sturb	w1, [x29, #-0x21]
               	sturb	w1, [x29, #-0x20]
               	sturb	w1, [x29, #-0x1f]
               	sturb	w1, [x29, #-0x1e]
               	sturb	w1, [x29, #-0x1d]
               	sub	x0, x29, #0x30
               	sturb	w1, [x29, #-0x1c]
               	sturb	w1, [x29, #-0x1b]
               	sturb	w1, [x29, #-0x1a]
               	sturb	w1, [x29, #-0x19]
               	sturb	w1, [x29, #-0x18]
               	sturb	w1, [x29, #-0x17]
               	sturb	w1, [x29, #-0x16]
               	sturb	w1, [x29, #-0x15]
               	sturb	w1, [x29, #-0x14]
               	sturb	w1, [x29, #-0x13]
               	sturb	w1, [x29, #-0x12]
               	sturb	w1, [x29, #-0x11]
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

<s8i>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	sub	x1, x29, #0x30
               	stur	w0, [x29, #-0x30]
               	stur	w0, [x29, #-0x2c]
               	stur	w0, [x29, #-0x28]
               	stur	w0, [x29, #-0x24]
               	stur	w0, [x29, #-0x20]
               	stur	w0, [x29, #-0x1c]
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x14]
               	mov	x16, x1
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<s8f>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	sub	x0, x29, #0x30
               	stur	s0, [x29, #-0x30]
               	stur	s0, [x29, #-0x2c]
               	stur	s0, [x29, #-0x28]
               	stur	s0, [x29, #-0x24]
               	stur	s0, [x29, #-0x20]
               	stur	s0, [x29, #-0x1c]
               	stur	s0, [x29, #-0x18]
               	stur	s0, [x29, #-0x14]
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

<s4d>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	sub	x0, x29, #0x30
               	stur	d0, [x29, #-0x30]
               	stur	d0, [x29, #-0x28]
               	stur	d0, [x29, #-0x20]
               	stur	d0, [x29, #-0x18]
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

<s16i>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	x8, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	stur	w0, [x29, #-0x50]
               	stur	w0, [x29, #-0x4c]
               	stur	w0, [x29, #-0x48]
               	stur	w0, [x29, #-0x44]
               	stur	w0, [x29, #-0x40]
               	stur	w0, [x29, #-0x3c]
               	stur	w0, [x29, #-0x38]
               	stur	w0, [x29, #-0x34]
               	stur	w0, [x29, #-0x30]
               	stur	w0, [x29, #-0x2c]
               	stur	w0, [x29, #-0x28]
               	stur	w0, [x29, #-0x24]
               	stur	w0, [x29, #-0x20]
               	stur	w0, [x29, #-0x1c]
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x14]
               	mov	x16, x1
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
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<s8l>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	x8, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	stur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	mov	x16, x1
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
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<k_byte>:
               	movi	v0.16b, #0x3
               	ret

<k_half>:
               	movi	v0.8h, #0x12, lsl #8
               	ret

<k_word>:
               	movi	v0.4s, #0x12, lsl #16
               	ret

<k_inv>:
               	mvni	v0.4s, #0x12, lsl #8
               	ret

<k_bytes>:
               	movi	v0.2d, #0xff00ff0000ff00ff
               	ret

<k_other>:
               	mov	x16, #0x2345            // =9029
               	movk	x16, #0x1, lsl #16
               	dup	v0.4s, w16
               	ret

<k_zero>:
               	movi	v0.2d, #0000000000000000
               	ret

<k_ones>:
               	movi	v0.2d, #0xffffffffffffffff
               	ret

<k_d8>:
               	mov	x16, #0x2345            // =9029
               	movk	x16, #0x1, lsl #16
               	dup	v0.2s, w16
               	ret

<k_y32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	mov	x1, #0x2345             // =9029
               	movk	x1, #0x1, lsl #16
               	sub	x0, x29, #0x30
               	stur	w1, [x29, #-0x30]
               	stur	w1, [x29, #-0x2c]
               	stur	w1, [x29, #-0x28]
               	stur	w1, [x29, #-0x24]
               	stur	w1, [x29, #-0x20]
               	stur	w1, [x29, #-0x1c]
               	stur	w1, [x29, #-0x18]
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

<k_y32_ones>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x8]
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x30
               	stur	w1, [x29, #-0x30]
               	stur	w1, [x29, #-0x2c]
               	stur	w1, [x29, #-0x28]
               	stur	w1, [x29, #-0x24]
               	stur	w1, [x29, #-0x20]
               	stur	w1, [x29, #-0x1c]
               	stur	w1, [x29, #-0x18]
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

<k_lanes>:
               	mov	x16, #0x201             // =513
               	movk	x16, #0x403, lsl #16
               	movk	x16, #0x605, lsl #32
               	movk	x16, #0xff07, lsl #48
               	fmov	d0, x16
               	ret

<k_lane_read>:
               	mov	x0, #0x5df3             // =24051
               	movk	x0, #0x15, lsl #16
               	ret

<add_k>:
               	dup	v1.4s, w0
               	add	v0.4s, v0.4s, v1.4s
               	ret

<lane_of>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	dup	v0.4s, w0
               	sub	x2, x29, #0x10
               	stur	q0, [x29, #-0x10]
               	and	x1, x1, #0x3
               	ldrsw	x1, [x2, x1, lsl #2]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<dlane_of>:
               	ret

<main>:
               	str	d8, [sp, #-0xd0]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	mov	x0, #0x5681             // =22145
               	movk	x0, #0x1234, lsl #16
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x4321             // =17185
               	movk	x0, #0x8765, lsl #16
               	movk	x0, #0xcba9, lsl #32
               	movk	x0, #0x7fed, lsl #48
               	stur	x0, [x29, #-0x18]
               	fmov	s0, #-2.75000000
               	stur	s0, [x29, #-0x10]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x10]
               	stur	d0, [x29, #-0x8]
               	ldursw	x20, [x29, #-0x20]
               	ldur	x21, [x29, #-0x18]
               	mov	x0, x20
               	bl	<addr>
               	smov	x1, v0.b[0]
               	sxtb	x0, w20
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x1, v0.b[1]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[2]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[3]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[4]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[5]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[6]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[7]
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	smov	x1, v0.h[0]
               	sxth	x0, w20
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x1, v0.h[1]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.h[2]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.h[3]
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	fmov	d8, d0
               	smov	x1, v8.s[0]
               	sxtw	x0, w21
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x1, v8.s[1]
               	cmp	x1, x0
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x10]
               	bl	<addr>
               	sub	x1, x29, #0x28
               	stur	d0, [x29, #-0x28]
               	mov	x0, #0x0                // =0
               	add	x2, x1, x0, lsl #2
               	ldr	s1, [x2]
               	ldur	s2, [x29, #-0x10]
               	fcmp	s1, s2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lo	<addr>
               	mov	x0, x20
               	bl	<addr>
               	smov	x1, v0.b[0]
               	sxtb	x0, w20
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x1, v0.b[1]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[2]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[3]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[4]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[5]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[6]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[7]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[8]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[9]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[10]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[11]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[12]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[13]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[14]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.b[15]
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	umov	w1, v0.h[0]
               	and	x0, x20, #0xffff
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	umov	w1, v0.h[1]
               	cmp	x1, x0
               	b.ne	<addr>
               	umov	w1, v0.h[2]
               	cmp	x1, x0
               	b.ne	<addr>
               	umov	w1, v0.h[3]
               	cmp	x1, x0
               	b.ne	<addr>
               	umov	w1, v0.h[4]
               	cmp	x1, x0
               	b.ne	<addr>
               	umov	w1, v0.h[5]
               	cmp	x1, x0
               	b.ne	<addr>
               	umov	w1, v0.h[6]
               	cmp	x1, x0
               	b.ne	<addr>
               	umov	w1, v0.h[7]
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	smov	x1, v0.s[0]
               	sxtw	x0, w21
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x1, v0.s[1]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.s[2]
               	cmp	x1, x0
               	b.ne	<addr>
               	smov	x1, v0.s[3]
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, v0.d[0]
               	cmp	x0, x21
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, v0.d[1]
               	cmp	x0, x21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x10]
               	bl	<addr>
               	sub	x1, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	add	x2, x1, x0, lsl #2
               	ldr	s1, [x2]
               	ldur	s2, [x29, #-0x10]
               	fcmp	s1, s2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	ldur	d0, [x29, #-0x8]
               	bl	<addr>
               	sub	x1, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	add	x2, x1, x0, lsl #3
               	ldr	d1, [x2]
               	ldur	d2, [x29, #-0x8]
               	fcmp	d1, d2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lo	<addr>
               	mov	x0, x20
               	sub	x8, x29, #0x80
               	bl	<addr>
               	sub	x1, x29, #0x80
               	sub	x0, x29, #0xa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	and	x2, x20, #0xff
               	ldrb	w3, [x1, x0]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	mov	x0, x20
               	sub	x8, x29, #0x80
               	bl	<addr>
               	ldur	w0, [x29, #-0x80]
               	ldur	w1, [x29, #-0x7c]
               	ldur	w2, [x29, #-0x78]
               	ldur	w3, [x29, #-0x74]
               	ldur	w4, [x29, #-0x70]
               	ldur	w5, [x29, #-0x6c]
               	ldur	w6, [x29, #-0x68]
               	ldur	w7, [x29, #-0x64]
               	cmp	w0, w20
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	cmp	w1, w20
               	b.ne	<addr>
               	cmp	w2, w20
               	b.ne	<addr>
               	cmp	w3, w20
               	b.ne	<addr>
               	cmp	w4, w20
               	b.ne	<addr>
               	cmp	w5, w20
               	b.ne	<addr>
               	cmp	w6, w20
               	b.ne	<addr>
               	cmp	w7, w20
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x10]
               	sub	x8, x29, #0x80
               	bl	<addr>
               	sub	x1, x29, #0x80
               	sub	x0, x29, #0xa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	add	x2, x1, x0, lsl #2
               	ldr	s1, [x2]
               	ldur	s2, [x29, #-0x10]
               	fcmp	s1, s2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	ldur	d0, [x29, #-0x8]
               	sub	x8, x29, #0x80
               	bl	<addr>
               	sub	x1, x29, #0x80
               	sub	x0, x29, #0xa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	add	x2, x1, x0, lsl #3
               	ldr	d1, [x2]
               	ldur	d2, [x29, #-0x8]
               	fcmp	d1, d2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	mov	x0, x20
               	sub	x8, x29, #0x80
               	bl	<addr>
               	ldur	w0, [x29, #-0x80]
               	ldur	w1, [x29, #-0x7c]
               	ldur	w2, [x29, #-0x78]
               	ldur	w3, [x29, #-0x74]
               	ldur	w4, [x29, #-0x70]
               	ldur	w5, [x29, #-0x6c]
               	ldur	w6, [x29, #-0x68]
               	ldur	w7, [x29, #-0x64]
               	ldur	w8, [x29, #-0x60]
               	ldur	w9, [x29, #-0x5c]
               	ldur	w10, [x29, #-0x58]
               	ldur	w11, [x29, #-0x54]
               	ldur	w12, [x29, #-0x50]
               	ldur	w13, [x29, #-0x4c]
               	ldur	w14, [x29, #-0x48]
               	ldur	w15, [x29, #-0x44]
               	cmp	w0, w20
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	cmp	w1, w20
               	b.ne	<addr>
               	cmp	w2, w20
               	b.ne	<addr>
               	cmp	w3, w20
               	b.ne	<addr>
               	cmp	w4, w20
               	b.ne	<addr>
               	cmp	w5, w20
               	b.ne	<addr>
               	cmp	w6, w20
               	b.ne	<addr>
               	cmp	w7, w20
               	b.ne	<addr>
               	cmp	w8, w20
               	b.ne	<addr>
               	cmp	w9, w20
               	b.ne	<addr>
               	cmp	w10, w20
               	b.ne	<addr>
               	cmp	w11, w20
               	b.ne	<addr>
               	cmp	w12, w20
               	b.ne	<addr>
               	cmp	w13, w20
               	b.ne	<addr>
               	cmp	w14, w20
               	b.ne	<addr>
               	cmp	w15, w20
               	b.ne	<addr>
               	mov	x0, x21
               	sub	x8, x29, #0x80
               	bl	<addr>
               	ldur	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x78]
               	ldur	x2, [x29, #-0x70]
               	ldur	x3, [x29, #-0x68]
               	ldur	x4, [x29, #-0x60]
               	ldur	x5, [x29, #-0x58]
               	ldur	x6, [x29, #-0x50]
               	ldur	x7, [x29, #-0x48]
               	cmp	x0, x21
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	cmp	x1, x21
               	b.ne	<addr>
               	cmp	x2, x21
               	b.ne	<addr>
               	cmp	x3, x21
               	b.ne	<addr>
               	cmp	x4, x21
               	b.ne	<addr>
               	cmp	x5, x21
               	b.ne	<addr>
               	cmp	x6, x21
               	b.ne	<addr>
               	cmp	x7, x21
               	b.ne	<addr>
               	mov	x0, v8.d[0]
               	mov	w1, w21
               	orr	x1, x1, x21, lsl #32
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	sub	x7, x29, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldr	q0, [x7]
               	mov	x0, x20
               	bl	<addr>
               	smov	x0, v0.s[0]
               	ldursw	x1, [x29, #-0x80]
               	add	x1, x1, x20
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x0, v0.s[1]
               	ldursw	x1, [x29, #-0x7c]
               	add	x1, x1, x20
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	ldursw	x1, [x29, #-0x78]
               	add	x1, x1, x20
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	ldursw	x1, [x29, #-0x74]
               	add	x1, x1, x20
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x1, #0x5                // =5
               	mov	x0, x20
               	bl	<addr>
               	lsl	x1, x20, #1
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	ldur	d0, [x29, #-0x8]
               	bl	<addr>
               	ldur	d1, [x29, #-0x8]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	bl	<addr>
               	smov	x0, v0.b[0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x0, v0.b[1]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[2]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[3]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[4]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[5]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[6]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[7]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[8]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[9]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[10]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[11]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[12]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[13]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[14]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	smov	x0, v0.b[15]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	bl	<addr>
               	umov	w0, v0.h[0]
               	mov	x17, #0x1200            // =4608
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	umov	w0, v0.h[1]
               	mov	x17, #0x1200            // =4608
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[2]
               	mov	x17, #0x1200            // =4608
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	mov	x17, #0x1200            // =4608
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	mov	x17, #0x1200            // =4608
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[5]
               	mov	x17, #0x1200            // =4608
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[6]
               	mov	x17, #0x1200            // =4608
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[7]
               	mov	x17, #0x1200            // =4608
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	smov	x0, v0.s[0]
               	mov	x17, #0x120000          // =1179648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x0, v0.s[1]
               	mov	x17, #0x120000          // =1179648
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	mov	x17, #0x120000          // =1179648
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	mov	x17, #0x120000          // =1179648
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	smov	x0, v0.s[0]
               	mov	x17, #-0x1201           // =-4609
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	smov	x0, v0.s[1]
               	mov	x17, #-0x1201           // =-4609
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	mov	x17, #-0x1201           // =-4609
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	mov	x17, #-0x1201           // =-4609
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, v0.d[0]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	movk	x17, #0xff00, lsl #32
               	movk	x17, #0xff00, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, v0.d[1]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	movk	x17, #0xff00, lsl #32
               	movk	x17, #0xff00, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	sub	x1, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x2345             // =9029
               	movk	x2, #0x1, lsl #16
               	ldrsw	x3, [x1, x0, lsl #2]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	bl	<addr>
               	sub	x1, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	ldrsw	x2, [x1, x0, lsl #2]
               	cbnz	w2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	bl	<addr>
               	sub	x1, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x1               // =-1
               	ldrsw	x3, [x1, x0, lsl #2]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	bl	<addr>
               	sub	x1, x29, #0x28
               	stur	d0, [x29, #-0x28]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x2345             // =9029
               	movk	x2, #0x1, lsl #16
               	ldrsw	x3, [x1, x0, lsl #2]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lo	<addr>
               	sub	x8, x29, #0x80
               	bl	<addr>
               	sub	x1, x29, #0x80
               	sub	x0, x29, #0xa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x2345             // =9029
               	movk	x2, #0x1, lsl #16
               	ldrsw	x3, [x1, x0, lsl #2]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x8, x29, #0x80
               	bl	<addr>
               	sub	x1, x29, #0x80
               	sub	x0, x29, #0xa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x1               // =-1
               	ldrsw	x3, [x1, x0, lsl #2]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	bl	<addr>
               	sub	x1, x29, #0x28
               	stur	d0, [x29, #-0x28]
               	mov	x0, #0x0                // =0
               	ldrsb	x2, [x1, x0]
               	add	x3, x0, #0x1
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x7
               	b.lt	<addr>
               	ldursb	x0, [x29, #-0x21]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	bl	<addr>
               	mov	x17, #0x5df3            // =24051
               	movk	x17, #0x15, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x1c               // =28
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xd0
               	ret
