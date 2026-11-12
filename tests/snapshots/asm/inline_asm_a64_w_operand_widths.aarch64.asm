
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
               	sub	sp, sp, #0x70
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x28]
               	fneg	s0, s0
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x99               // =153
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x28]
               	ldur	s1, [x29, #-0x20]
               	str	d0, [sp, #0x10]
               	str	d1, [sp, #0x18]
               	ldr	d0, [sp, #0x10]
               	ldr	d1, [sp, #0x18]
               	fmul	s0, s0, s1
               	fmov	s1, #6.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9a               // =154
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s1, [x29, #-0x28]
               	ldur	s2, [x29, #-0x20]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	fadd	s0, s1, s2
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9c               // =156
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x3f800000        // =1065353216
               	str	x16, [sp, #0x10]
               	ldr	d0, [sp, #0x10]
               	fmov	w0, s0
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9e               // =158
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xfdb             // =4059
               	movk	x16, #0x4049, lsl #16
               	str	x16, [sp, #0x10]
               	ldr	d0, [sp, #0x10]
               	fmov	w0, s0
               	mov	x17, #0xfdb             // =4059
               	movk	x17, #0x4049, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9f               // =159
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #7.50000000
               	stur	d0, [x29, #-0x18]
               	ldur	d1, [x29, #-0x18]
               	str	d1, [sp, #0x10]
               	mov	x16, #0x4002000000000000 // =4612248968380809216
               	str	x16, [sp, #0x18]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	fsub	d0, d1, d2
               	fmov	d1, #5.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa1               // =161
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x18]
               	fneg	d0, d0
               	fabs	d0, d0
               	fmov	d1, #7.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa2               // =162
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x10000000000     // =1099511627776
               	str	x16, [sp, #0x10]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x18]
               	ldr	d1, [sp, #0x10]
               	ldr	d2, [sp, #0x18]
               	add	d0, d1, d2
               	mov	x0, v0.d[0]
               	mov	x17, #0x5               // =5
               	movk	x17, #0x100, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa3               // =163
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x10]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x18]
               	add	v1.8b, v0.8b, v1.8b
               	neg	v0.8b, v0.8b
               	smov	x0, v1.b[0]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	smov	x0, v1.b[7]
               	cmp	x0, #0x58
               	b.ne	<addr>
               	smov	x0, v0.b[3]
               	mov	x17, #-0x4              // =-4
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa6               // =166
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q3, [x0]
               	stur	q2, [x29, #-0x70]
               	sub	x16, x29, #0x70
               	str	x16, [sp, #0x10]
               	stur	q3, [sp, #0x18]
               	ldr	x16, [sp, #0x10]
               	ldr	q0, [x16]
               	ldur	q1, [sp, #0x18]
               	add	v0.4s, v0.4s, v1.4s
               	mov	v4.16b, v0.16b
               	str	q2, [sp, #0x10]
               	str	q3, [sp, #0x20]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	add	v0.4s, v1.4s, v2.4s
               	smov	x0, v4.s[0]
               	cmp	x0, #0x65
               	b.ne	<addr>
               	smov	x0, v4.s[3]
               	cmp	x0, #0x194
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0xca
               	b.eq	<addr>
               	mov	x0, #0xa9               // =169
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	stur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x30]
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x10]
               	mov	x16, #0x5a              // =90
               	str	x16, [sp, #0x18]
               	ldr	x0, [sp, #0x18]
               	mov	v0.b[0], w0
               	ldr	x16, [sp, #0x10]
               	str	b0, [x16]
               	ldurb	w0, [x29, #-0x38]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x37]
               	cmp	w0, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x73               // =115
               	cbz	x0, <addr>
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
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
               	str	b0, [x16]
               	ldurb	w0, [x29, #-0x38]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x37]
               	cbz	w0, <addr>
               	mov	x0, #0x8a               // =138
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	h0, [x16]
               	ldurb	w0, [x29, #-0x37]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x36]
               	cbz	w0, <addr>
               	mov	x0, #0x8c               // =140
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	s0, [x16]
               	ldurb	w0, [x29, #-0x35]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x34]
               	cbz	w0, <addr>
               	mov	x0, #0x8e               // =142
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	d0, [x16]
               	ldurb	w0, [x29, #-0x31]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x30]
               	cbz	w0, <addr>
               	mov	x0, #0x90               // =144
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	q0, [x16]
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
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0x10]
               	ldr	b0, [x16]
               	add	v0.8b, v0.8b, v0.8b
               	ldr	x16, [sp, #0x10]
               	str	b0, [x16]
               	ldurb	w0, [x29, #-0x10]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x76               // =118
               	b	<addr>
               	sub	x16, x29, #0x38
               	str	x16, [sp, #0x10]
               	mov	x16, #0x1234            // =4660
               	str	x16, [sp, #0x18]
               	ldr	x0, [sp, #0x18]
               	mov	v0.h[0], w0
               	ldr	x16, [sp, #0x10]
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
               	fmov	x0, d0
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
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0x10]
               	ldr	h0, [x16]
               	add	v0.4h, v0.4h, v0.4h
               	ldr	x16, [sp, #0x10]
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
