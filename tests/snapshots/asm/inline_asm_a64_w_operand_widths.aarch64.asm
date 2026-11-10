
inline_asm_a64_w_operand_widths.aarch64:	file format elf64-littleaarch64

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

<run>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	fmov	s0, #2.00000000
               	stur	s0, [x29, #-0x28]
               	fmov	s0, #3.00000000
               	stur	s0, [x29, #-0x20]
               	ldur	s0, [x29, #-0x28]
               	ldur	s1, [x29, #-0x20]
               	fadd	s0, s0, s1
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x98               // =152
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x28]
               	str	d0, [sp, #0x30]
               	ldr	d0, [sp, #0x30]
               	fneg	s0, s0
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x99               // =153
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x28]
               	ldur	s1, [x29, #-0x20]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	fmul	s0, s0, s1
               	fmov	s1, #6.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9a               // =154
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s1, [x29, #-0x28]
               	ldur	s2, [x29, #-0x20]
               	str	d1, [sp, #0x30]
               	str	d2, [sp, #0x38]
               	ldr	d1, [sp, #0x30]
               	ldr	d2, [sp, #0x38]
               	fadd	s0, s1, s2
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9c               // =156
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x3f800000        // =1065353216
               	str	x16, [sp, #0x30]
               	ldr	d0, [sp, #0x30]
               	fmov	w0, s0
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9e               // =158
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xfdb             // =4059
               	movk	x16, #0x4049, lsl #16
               	str	x16, [sp, #0x30]
               	ldr	d0, [sp, #0x30]
               	fmov	w0, s0
               	mov	x17, #0xfdb             // =4059
               	movk	x17, #0x4049, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9f               // =159
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #7.50000000
               	stur	d0, [x29, #-0x18]
               	ldur	d1, [x29, #-0x18]
               	str	d1, [sp, #0x30]
               	mov	x16, #0x4002000000000000 // =4612248968380809216
               	str	x16, [sp, #0x38]
               	ldr	d1, [sp, #0x30]
               	ldr	d2, [sp, #0x38]
               	fsub	d0, d1, d2
               	fmov	d1, #5.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa1               // =161
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x18]
               	fneg	d0, d0
               	str	d0, [sp, #0x30]
               	ldr	d0, [sp, #0x30]
               	fabs	d0, d0
               	fmov	d1, #7.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa2               // =162
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x10000000000     // =1099511627776
               	str	x16, [sp, #0x30]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x38]
               	ldr	d1, [sp, #0x30]
               	ldr	d2, [sp, #0x38]
               	add	d0, d1, d2
               	stur	d0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x40]
               	mov	x17, #0x5               // =5
               	movk	x17, #0x100, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa3               // =163
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	ldr	d0, [x1, #0x18]
               	sub	x1, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x40]
               	fmov	d16, x0
               	add	v0.8b, v16.8b, v0.8b
               	stur	d0, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x48]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x40]
               	str	d0, [sp, #0x30]
               	ldr	d0, [sp, #0x30]
               	neg	v0.8b, v0.8b
               	stur	d0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x30]
               	ldursb	x0, [x29, #-0x48]
               	cmp	w0, #0xb
               	b.ne	<addr>
               	ldursb	x0, [x29, #-0x41]
               	cmp	w0, #0x58
               	b.ne	<addr>
               	ldursb	x0, [x29, #-0x2d]
               	mov	x17, #-0x4              // =-4
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xa6               // =166
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x90
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q1, [x29, #-0x90]
               	sub	x16, x29, #0x80
               	str	x16, [sp, #0x30]
               	stur	q1, [sp, #0x38]
               	ldr	x16, [sp, #0x30]
               	ldr	q0, [x16]
               	ldur	q1, [sp, #0x38]
               	add	v0.4s, v0.4s, v1.4s
               	mov	v3.16b, v0.16b
               	ldur	q1, [x29, #-0xa0]
               	ldur	q2, [x29, #-0x90]
               	str	q1, [sp, #0x30]
               	str	q2, [sp, #0x40]
               	ldr	q1, [sp, #0x30]
               	ldr	q2, [sp, #0x40]
               	add	v0.4s, v1.4s, v2.4s
               	smov	x0, v3.s[0]
               	cmp	x0, #0x65
               	b.ne	<addr>
               	smov	x0, v3.s[3]
               	cmp	x0, #0x194
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0xca
               	b.eq	<addr>
               	mov	x0, #0xa9               // =169
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	stur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x30]
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x30]
               	mov	x16, #0x5a              // =90
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	mov	v0.b[0], w0
               	ldr	x16, [sp, #0x30]
               	str	b0, [x16]
               	ldurb	w0, [x29, #-0x38]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x37]
               	cmp	w0, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x73               // =115
               	cbz	x0, <addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sturb	wzr, [x29, #-0x38]
               	sturb	wzr, [x29, #-0x37]
               	sturb	wzr, [x29, #-0x36]
               	sturb	wzr, [x29, #-0x35]
               	sturb	wzr, [x29, #-0x34]
               	sturb	wzr, [x29, #-0x33]
               	sturb	wzr, [x29, #-0x32]
               	sturb	wzr, [x29, #-0x31]
               	sturb	wzr, [x29, #-0x30]
               	sturb	wzr, [x29, #-0x2f]
               	sturb	wzr, [x29, #-0x2e]
               	sturb	wzr, [x29, #-0x2d]
               	sturb	wzr, [x29, #-0x2c]
               	sturb	wzr, [x29, #-0x2b]
               	sturb	wzr, [x29, #-0x2a]
               	sturb	wzr, [x29, #-0x29]
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x80
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	b0, [x0]
               	ldurb	w0, [x29, #-0x38]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x37]
               	cbz	w0, <addr>
               	mov	x0, #0x8a               // =138
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x80
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	h0, [x0]
               	ldurb	w0, [x29, #-0x37]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x36]
               	cbz	w0, <addr>
               	mov	x0, #0x8c               // =140
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x80
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	s0, [x0]
               	ldurb	w0, [x29, #-0x35]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x34]
               	cbz	w0, <addr>
               	mov	x0, #0x8e               // =142
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x80
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	d0, [x0]
               	ldurb	w0, [x29, #-0x31]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x30]
               	cbz	w0, <addr>
               	mov	x0, #0x90               // =144
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x80
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldurb	w0, [x29, #-0x29]
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x10]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x30]
               	ldr	x16, [sp, #0x30]
               	ldr	b0, [x16]
               	add	v0.8b, v0.8b, v0.8b
               	ldr	x16, [sp, #0x30]
               	str	b0, [x16]
               	ldurb	w0, [x29, #-0x10]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x76               // =118
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x30]
               	mov	x16, #0x1234            // =4660
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	mov	v0.h[0], w0
               	ldr	x16, [sp, #0x30]
               	str	h0, [x16]
               	ldursh	x0, [x29, #-0x38]
               	mov	x17, #0x1234            // =4660
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x36]
               	cmp	w0, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x79               // =121
               	b	<addr>
               	mov	x16, #0x2468            // =9320
               	movk	x16, #0x1357, lsl #16
               	fmov	s0, w16
               	stur	s0, [x29, #-0x38]
               	ldursw	x0, [x29, #-0x38]
               	mov	x17, #0x2468            // =9320
               	movk	x17, #0x1357, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x34]
               	cmp	w0, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x7b               // =123
               	b	<addr>
               	mov	x16, #0x708             // =1800
               	movk	x16, #0x506, lsl #16
               	movk	x16, #0x304, lsl #32
               	movk	x16, #0x102, lsl #48
               	fmov	d0, x16
               	stur	d0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	mov	x17, #0x708             // =1800
               	movk	x17, #0x506, lsl #16
               	movk	x17, #0x304, lsl #32
               	movk	x17, #0x102, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x30]
               	cmp	w0, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x7d               // =125
               	b	<addr>
               	mov	x0, #0x12c              // =300
               	sturh	w0, [x29, #-0x8]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x30]
               	ldr	x16, [sp, #0x30]
               	ldr	h0, [x16]
               	add	v0.4h, v0.4h, v0.4h
               	ldr	x16, [sp, #0x30]
               	str	h0, [x16]
               	ldursh	x0, [x29, #-0x8]
               	cmp	w0, #0x258
               	b.eq	<addr>
               	mov	x0, #0x80               // =128
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
