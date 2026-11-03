
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

<narrow_outputs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x20
               	mov	x1, #0xa5               // =165
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	mov	x16, #0x5a              // =90
               	str	x16, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	mov	v0.b[0], w0
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldurb	w0, [x29, #-0x20]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x1f]
               	mov	x17, #0xa5              // =165
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x73               // =115
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x10]
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	ldr	x16, [sp]
               	ldr	b0, [x16]
               	add	v0.8b, v0.8b, v0.8b
               	ldr	x16, [sp]
               	str	b0, [x16]
               	ldurb	w0, [x29, #-0x10]
               	eor	x0, x0, #0x6
               	cbz	w0, <addr>
               	mov	x0, #0x76               // =118
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	mov	x16, #0x1234            // =4660
               	str	x16, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	mov	v0.h[0], w0
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x0, [x29, #-0x20]
               	mov	x17, #0x1234            // =4660
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x1e]
               	mov	x17, #0xa5              // =165
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x79               // =121
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x2468            // =9320
               	movk	x16, #0x1357, lsl #16
               	fmov	s0, w16
               	stur	s0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	mov	x17, #0x2468            // =9320
               	movk	x17, #0x1357, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x1c]
               	mov	x17, #0xa5              // =165
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x7b               // =123
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x708             // =1800
               	movk	x16, #0x506, lsl #16
               	movk	x16, #0x304, lsl #32
               	movk	x16, #0x102, lsl #48
               	fmov	d0, x16
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	mov	x17, #0x708             // =1800
               	movk	x17, #0x506, lsl #16
               	movk	x17, #0x304, lsl #32
               	movk	x17, #0x102, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0xa5              // =165
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x7d               // =125
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12c              // =300
               	sturh	w0, [x29, #-0x8]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	ldr	x16, [sp]
               	ldr	h0, [x16]
               	add	v0.4h, v0.4h, v0.4h
               	ldr	x16, [sp]
               	str	h0, [x16]
               	ldursh	x0, [x29, #-0x8]
               	cmp	w0, #0x258
               	b.eq	<addr>
               	mov	x0, #0x80               // =128
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<views>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	sub	x16, x29, #0x30
               	str	x16, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x18]
               	ldr	q0, [x16]
               	str	b0, [x0]
               	ldurb	w0, [x29, #-0x10]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0xf]
               	cbz	w0, <addr>
               	mov	x0, #0x8a               // =138
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	sub	x16, x29, #0x30
               	str	x16, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x18]
               	ldr	q0, [x16]
               	str	h0, [x0]
               	ldurb	w0, [x29, #-0xf]
               	eor	x0, x0, #0x2
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0xe]
               	cbz	w0, <addr>
               	mov	x0, #0x8c               // =140
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	sub	x16, x29, #0x30
               	str	x16, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x18]
               	ldr	q0, [x16]
               	str	s0, [x0]
               	ldurb	w0, [x29, #-0xd]
               	eor	x0, x0, #0x4
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0xc]
               	cbz	w0, <addr>
               	mov	x0, #0x8e               // =142
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	sub	x16, x29, #0x30
               	str	x16, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x18]
               	ldr	q0, [x16]
               	str	d0, [x0]
               	ldurb	w0, [x29, #-0x9]
               	eor	x0, x0, #0x8
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cbz	w0, <addr>
               	mov	x0, #0x90               // =144
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	sub	x16, x29, #0x30
               	str	x16, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x18]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldurb	w0, [x29, #-0x1]
               	eor	x0, x0, #0x10
               	cbz	w0, <addr>
               	mov	x0, #0x92               // =146
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x270
               	fmov	s0, #2.00000000
               	stur	s0, [x29, #-0x8]
               	fmov	s0, #3.00000000
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x8]
               	ldur	s1, [x29, #-0x10]
               	fadd	s0, s0, s1
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x98               // =152
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x8]
               	str	d0, [sp, #0xc0]
               	ldr	d0, [sp, #0xc0]
               	fneg	s0, s0
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x99               // =153
               	b	<addr>
               	ldur	s0, [x29, #-0x8]
               	ldur	s1, [x29, #-0x10]
               	str	d0, [sp, #0xc0]
               	str	d1, [sp, #0xc8]
               	ldr	d0, [sp, #0xc0]
               	ldr	d1, [sp, #0xc8]
               	fmul	s0, s0, s1
               	fmov	s1, #6.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9a               // =154
               	b	<addr>
               	ldur	s1, [x29, #-0x8]
               	ldur	s2, [x29, #-0x10]
               	str	d1, [sp, #0xc0]
               	str	d2, [sp, #0xc8]
               	ldr	d1, [sp, #0xc0]
               	ldr	d2, [sp, #0xc8]
               	fadd	s0, s1, s2
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9c               // =156
               	b	<addr>
               	mov	x16, #0x3f800000        // =1065353216
               	str	x16, [sp, #0xc0]
               	ldr	d0, [sp, #0xc0]
               	fmov	w0, s0
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9e               // =158
               	b	<addr>
               	mov	x16, #0xfdb             // =4059
               	movk	x16, #0x4049, lsl #16
               	str	x16, [sp, #0xc0]
               	ldr	d0, [sp, #0xc0]
               	fmov	w0, s0
               	mov	x17, #0xfdb             // =4059
               	movk	x17, #0x4049, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9f               // =159
               	b	<addr>
               	fmov	d0, #7.50000000
               	stur	d0, [x29, #-0x18]
               	ldur	d1, [x29, #-0x18]
               	str	d1, [sp, #0xc0]
               	mov	x16, #0x4002000000000000 // =4612248968380809216
               	str	x16, [sp, #0xc8]
               	ldr	d1, [sp, #0xc0]
               	ldr	d2, [sp, #0xc8]
               	fsub	d0, d1, d2
               	fmov	d1, #5.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa1               // =161
               	b	<addr>
               	ldur	d0, [x29, #-0x18]
               	fneg	d0, d0
               	str	d0, [sp, #0xc0]
               	ldr	d0, [sp, #0xc0]
               	fabs	d0, d0
               	fmov	d1, #7.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa2               // =162
               	b	<addr>
               	mov	x16, #0x10000000000     // =1099511627776
               	str	x16, [sp, #0xc0]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0xc8]
               	ldr	d1, [sp, #0xc0]
               	ldr	d2, [sp, #0xc8]
               	add	d0, d1, d2
               	str	d0, [sp, #0x158]
               	ldr	x0, [sp, #0x158]
               	mov	x17, #0x5               // =5
               	movk	x17, #0x100, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa3               // =163
               	b	<addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	ldr	d0, [x1, #0x18]
               	sub	x1, x29, #0x118
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	x0, [sp, #0x158]
               	fmov	d16, x0
               	add	v0.8b, v16.8b, v0.8b
               	str	d0, [sp, #0x148]
               	ldr	x0, [sp, #0x148]
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x118
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	d0, [sp, #0x158]
               	str	d0, [sp, #0xc0]
               	ldr	d0, [sp, #0xc0]
               	neg	v0.8b, v0.8b
               	str	d0, [sp, #0x158]
               	ldr	x0, [sp, #0x158]
               	stur	x0, [x29, #-0x40]
               	ldursb	x0, [x29, #-0x30]
               	cmp	w0, #0xb
               	b.ne	<addr>
               	ldursb	x0, [x29, #-0x29]
               	cmp	w0, #0x58
               	b.ne	<addr>
               	ldursb	x0, [x29, #-0x3d]
               	mov	x17, #-0x4              // =-4
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xa6               // =166
               	b	<addr>
               	sub	x0, x29, #0x270
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x260
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x210
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	q1, [sp, #0x10]
               	sub	x16, x29, #0x210
               	str	x16, [sp, #0xc0]
               	stur	q1, [sp, #0xc8]
               	ldr	x16, [sp, #0xc0]
               	ldr	q0, [x16]
               	ldur	q1, [sp, #0xc8]
               	add	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x20]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	str	q1, [sp, #0xc0]
               	str	q2, [sp, #0xd0]
               	ldr	q1, [sp, #0xc0]
               	ldr	q2, [sp, #0xd0]
               	add	v0.4s, v1.4s, v2.4s
               	str	q0, [sp, #0x30]
               	ldrsw	x0, [sp, #0x20]
               	cmp	w0, #0x65
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x2c]
               	cmp	w0, #0x194
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x34]
               	cmp	w0, #0xca
               	b.eq	<addr>
               	mov	x0, #0xa9               // =169
               	b	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	b	<addr>
