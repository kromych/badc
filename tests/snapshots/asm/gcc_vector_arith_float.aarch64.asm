
gcc_vector_arith_float.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	fadd	v4.4s, v2.4s, v3.4s
               	sub	x1, x29, #0x40
               	stur	q4, [x29, #-0x40]
               	sub	x2, x29, #0x10
               	mov	s4, v2.s[0]
               	mov	s5, v3.s[0]
               	fadd	s4, s4, s5
               	stur	s4, [x29, #-0x10]
               	mov	s4, v2.s[1]
               	mov	s5, v3.s[1]
               	fadd	s4, s4, s5
               	stur	s4, [x29, #-0xc]
               	mov	s2, v2.s[2]
               	mov	s3, v3.s[2]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x94]
               	ldur	s3, [x29, #-0x84]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	fsub	v4.4s, v2.4s, v3.4s
               	sub	x1, x29, #0x40
               	stur	q4, [x29, #-0x40]
               	sub	x2, x29, #0x10
               	mov	s4, v2.s[0]
               	mov	s5, v3.s[0]
               	fsub	s4, s4, s5
               	stur	s4, [x29, #-0x10]
               	mov	s4, v2.s[1]
               	mov	s5, v3.s[1]
               	fsub	s4, s4, s5
               	stur	s4, [x29, #-0xc]
               	mov	s2, v2.s[2]
               	mov	s3, v3.s[2]
               	fsub	s2, s2, s3
               	stur	s2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x94]
               	ldur	s3, [x29, #-0x84]
               	fsub	s2, s2, s3
               	stur	s2, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	fmul	v4.4s, v2.4s, v3.4s
               	sub	x1, x29, #0x40
               	stur	q4, [x29, #-0x40]
               	sub	x2, x29, #0x10
               	mov	s4, v2.s[0]
               	mov	s5, v3.s[0]
               	fmul	s4, s4, s5
               	stur	s4, [x29, #-0x10]
               	mov	s4, v2.s[1]
               	mov	s5, v3.s[1]
               	fmul	s4, s4, s5
               	stur	s4, [x29, #-0xc]
               	mov	s2, v2.s[2]
               	mov	s3, v3.s[2]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x94]
               	ldur	s3, [x29, #-0x84]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	fdiv	v4.4s, v2.4s, v3.4s
               	sub	x1, x29, #0x40
               	stur	q4, [x29, #-0x40]
               	sub	x2, x29, #0x10
               	mov	s4, v2.s[0]
               	mov	s5, v3.s[0]
               	fdiv	s4, s4, s5
               	stur	s4, [x29, #-0x10]
               	mov	s4, v2.s[1]
               	mov	s5, v3.s[1]
               	fdiv	s4, s4, s5
               	stur	s4, [x29, #-0xc]
               	mov	s2, v2.s[2]
               	mov	s3, v3.s[2]
               	fdiv	s2, s2, s3
               	stur	s2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x94]
               	ldur	s3, [x29, #-0x84]
               	fdiv	s2, s2, s3
               	stur	s2, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fadd	v2.2d, v0.2d, v1.2d
               	sub	x1, x29, #0x40
               	stur	q2, [x29, #-0x40]
               	sub	x2, x29, #0x10
               	mov	d2, v0.d[0]
               	mov	d3, v1.d[0]
               	fadd	d2, d2, d3
               	stur	d2, [x29, #-0x10]
               	mov	d2, v0.d[1]
               	mov	d3, v1.d[1]
               	fadd	d2, d2, d3
               	stur	d2, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fsub	v2.2d, v0.2d, v1.2d
               	sub	x1, x29, #0x40
               	stur	q2, [x29, #-0x40]
               	sub	x2, x29, #0x10
               	mov	d2, v0.d[0]
               	mov	d3, v1.d[0]
               	fsub	d2, d2, d3
               	stur	d2, [x29, #-0x10]
               	mov	d2, v0.d[1]
               	mov	d3, v1.d[1]
               	fsub	d2, d2, d3
               	stur	d2, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fmul	v2.2d, v0.2d, v1.2d
               	sub	x1, x29, #0x40
               	stur	q2, [x29, #-0x40]
               	sub	x2, x29, #0x10
               	mov	d2, v0.d[0]
               	mov	d3, v1.d[0]
               	fmul	d2, d2, d3
               	stur	d2, [x29, #-0x10]
               	mov	d2, v0.d[1]
               	mov	d3, v1.d[1]
               	fmul	d2, d2, d3
               	stur	d2, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fdiv	v2.2d, v0.2d, v1.2d
               	sub	x1, x29, #0x40
               	stur	q2, [x29, #-0x40]
               	sub	x2, x29, #0x10
               	mov	d2, v0.d[0]
               	mov	d3, v1.d[0]
               	fdiv	d2, d2, d3
               	stur	d2, [x29, #-0x10]
               	mov	d2, v0.d[1]
               	mov	d3, v1.d[1]
               	fdiv	d2, d2, d3
               	stur	d2, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	s2, [x29, #-0x80]
               	ldur	s3, [x29, #-0x60]
               	fadd	s2, s2, s3
               	ldur	s3, [x29, #-0x7c]
               	ldur	s4, [x29, #-0x5c]
               	fadd	s3, s3, s4
               	ldur	s4, [x29, #-0x78]
               	ldur	s5, [x29, #-0x58]
               	fadd	s4, s4, s5
               	ldur	s5, [x29, #-0x74]
               	ldur	s6, [x29, #-0x54]
               	fadd	s5, s5, s6
               	ldur	s6, [x29, #-0x70]
               	ldur	s7, [x29, #-0x50]
               	fadd	s6, s6, s7
               	ldur	s7, [x29, #-0x6c]
               	ldur	s19, [x29, #-0x4c]
               	fadd	s7, s7, s19
               	ldur	s19, [x29, #-0x68]
               	ldur	s20, [x29, #-0x48]
               	fadd	s19, s19, s20
               	ldur	s20, [x29, #-0x64]
               	ldur	s21, [x29, #-0x44]
               	fadd	s20, s20, s21
               	sub	x1, x29, #0x40
               	stur	s2, [x29, #-0x40]
               	stur	s3, [x29, #-0x3c]
               	stur	s4, [x29, #-0x38]
               	stur	s5, [x29, #-0x34]
               	stur	s6, [x29, #-0x30]
               	stur	s7, [x29, #-0x2c]
               	stur	s19, [x29, #-0x28]
               	stur	s20, [x29, #-0x24]
               	sub	x2, x29, #0x20
               	ldur	s2, [x29, #-0x80]
               	ldur	s3, [x29, #-0x60]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x20]
               	ldur	s2, [x29, #-0x7c]
               	ldur	s3, [x29, #-0x5c]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x1c]
               	ldur	s2, [x29, #-0x78]
               	ldur	s3, [x29, #-0x58]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x18]
               	ldur	s2, [x29, #-0x74]
               	ldur	s3, [x29, #-0x54]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x14]
               	ldur	s2, [x29, #-0x70]
               	ldur	s3, [x29, #-0x50]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x10]
               	ldur	s2, [x29, #-0x6c]
               	ldur	s3, [x29, #-0x4c]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0xc]
               	ldur	s2, [x29, #-0x68]
               	ldur	s3, [x29, #-0x48]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x64]
               	ldur	s3, [x29, #-0x44]
               	fadd	s2, s2, s3
               	stur	s2, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	ldur	s2, [x29, #-0x80]
               	ldur	s3, [x29, #-0x60]
               	fmul	s2, s2, s3
               	ldur	s3, [x29, #-0x7c]
               	ldur	s4, [x29, #-0x5c]
               	fmul	s3, s3, s4
               	ldur	s4, [x29, #-0x78]
               	ldur	s5, [x29, #-0x58]
               	fmul	s4, s4, s5
               	ldur	s5, [x29, #-0x74]
               	ldur	s6, [x29, #-0x54]
               	fmul	s5, s5, s6
               	ldur	s6, [x29, #-0x70]
               	ldur	s7, [x29, #-0x50]
               	fmul	s6, s6, s7
               	ldur	s7, [x29, #-0x6c]
               	ldur	s19, [x29, #-0x4c]
               	fmul	s7, s7, s19
               	ldur	s19, [x29, #-0x68]
               	ldur	s20, [x29, #-0x48]
               	fmul	s19, s19, s20
               	ldur	s20, [x29, #-0x64]
               	ldur	s21, [x29, #-0x44]
               	fmul	s20, s20, s21
               	sub	x1, x29, #0x40
               	stur	s2, [x29, #-0x40]
               	stur	s3, [x29, #-0x3c]
               	stur	s4, [x29, #-0x38]
               	stur	s5, [x29, #-0x34]
               	stur	s6, [x29, #-0x30]
               	stur	s7, [x29, #-0x2c]
               	stur	s19, [x29, #-0x28]
               	stur	s20, [x29, #-0x24]
               	sub	x2, x29, #0x20
               	ldur	s2, [x29, #-0x80]
               	ldur	s3, [x29, #-0x60]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x20]
               	ldur	s2, [x29, #-0x7c]
               	ldur	s3, [x29, #-0x5c]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x1c]
               	ldur	s2, [x29, #-0x78]
               	ldur	s3, [x29, #-0x58]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x18]
               	ldur	s2, [x29, #-0x74]
               	ldur	s3, [x29, #-0x54]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x14]
               	ldur	s2, [x29, #-0x70]
               	ldur	s3, [x29, #-0x50]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x10]
               	ldur	s2, [x29, #-0x6c]
               	ldur	s3, [x29, #-0x4c]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0xc]
               	ldur	s2, [x29, #-0x68]
               	ldur	s3, [x29, #-0x48]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x64]
               	ldur	s3, [x29, #-0x44]
               	fmul	s2, s2, s3
               	stur	s2, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	fmov	s2, #2.50000000
               	ldur	s3, [x29, #-0xa0]
               	fmul	s6, s3, s2
               	ldur	s4, [x29, #-0x9c]
               	fmul	s7, s4, s2
               	ldur	s5, [x29, #-0x98]
               	fmul	s19, s5, s2
               	ldur	s20, [x29, #-0x94]
               	fmul	s20, s20, s2
               	sub	x1, x29, #0x40
               	stur	s6, [x29, #-0x40]
               	stur	s7, [x29, #-0x3c]
               	stur	s19, [x29, #-0x38]
               	stur	s20, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	fmul	s3, s3, s2
               	stur	s3, [x29, #-0x10]
               	fmul	s3, s4, s2
               	stur	s3, [x29, #-0xc]
               	fmul	s3, s5, s2
               	stur	s3, [x29, #-0x8]
               	ldur	s3, [x29, #-0x94]
               	fmul	s2, s3, s2
               	stur	s2, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fmov	s2, #3.00000000
               	ldur	s3, [x29, #-0xa0]
               	fmul	s6, s3, s2
               	ldur	s4, [x29, #-0x9c]
               	fmul	s7, s4, s2
               	ldur	s5, [x29, #-0x98]
               	fmul	s19, s5, s2
               	ldur	s20, [x29, #-0x94]
               	fmul	s20, s20, s2
               	sub	x1, x29, #0x40
               	stur	s6, [x29, #-0x40]
               	stur	s7, [x29, #-0x3c]
               	stur	s19, [x29, #-0x38]
               	stur	s20, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	fmul	s3, s3, s2
               	stur	s3, [x29, #-0x10]
               	fmul	s3, s4, s2
               	stur	s3, [x29, #-0xc]
               	fmul	s3, s5, s2
               	stur	s3, [x29, #-0x8]
               	ldur	s3, [x29, #-0x94]
               	fmul	s2, s3, s2
               	stur	s2, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fmov	d2, #4.00000000
               	mov	d3, v0.d[0]
               	fdiv	d3, d3, d2
               	mov	d4, v0.d[1]
               	fdiv	d4, d4, d2
               	sub	x1, x29, #0x40
               	stur	d3, [x29, #-0x40]
               	stur	d4, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	mov	d3, v0.d[0]
               	fdiv	d3, d3, d2
               	stur	d3, [x29, #-0x10]
               	mov	d3, v0.d[1]
               	fdiv	d2, d3, d2
               	stur	d2, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fmov	d2, #3.00000000
               	mov	d3, v0.d[0]
               	fadd	d3, d3, d2
               	mov	d4, v0.d[1]
               	fadd	d4, d4, d2
               	sub	x1, x29, #0x40
               	stur	d3, [x29, #-0x40]
               	stur	d4, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	mov	d3, v0.d[0]
               	fadd	d3, d3, d2
               	stur	d3, [x29, #-0x10]
               	mov	d3, v0.d[1]
               	fadd	d2, d3, d2
               	stur	d2, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa0
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	fmul	v2.4s, v2.4s, v3.4s
               	sub	x2, x29, #0x60
               	stur	q2, [x29, #-0x60]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	fmul	v2.4s, v2.4s, v3.4s
               	stur	q2, [x29, #-0x40]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa0
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	fadd	v2.4s, v2.4s, v3.4s
               	sub	x2, x29, #0x60
               	stur	q2, [x29, #-0x60]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	fadd	v2.4s, v2.4s, v3.4s
               	stur	q2, [x29, #-0x40]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fdiv	v2.2d, v0.2d, v1.2d
               	sub	x1, x29, #0x60
               	stur	q2, [x29, #-0x60]
               	sub	x2, x29, #0x40
               	stur	q0, [x29, #-0x40]
               	fdiv	v1.2d, v0.2d, v1.2d
               	stur	q1, [x29, #-0x40]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	fmov	s1, #2.00000000
               	ldur	s2, [x29, #-0xa0]
               	fmul	s6, s2, s1
               	ldur	s3, [x29, #-0x9c]
               	fmul	s7, s3, s1
               	ldur	s4, [x29, #-0x98]
               	fmul	s19, s4, s1
               	ldur	s5, [x29, #-0x94]
               	fmul	s20, s5, s1
               	stur	s6, [x29, #-0x60]
               	stur	s7, [x29, #-0x5c]
               	stur	s19, [x29, #-0x58]
               	stur	s20, [x29, #-0x54]
               	fmul	s2, s2, s1
               	fmul	s3, s3, s1
               	fmul	s4, s4, s1
               	fmul	s1, s5, s1
               	sub	x2, x29, #0x40
               	stur	s2, [x29, #-0x40]
               	stur	s3, [x29, #-0x3c]
               	stur	s4, [x29, #-0x38]
               	stur	s1, [x29, #-0x34]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	s1, [x29, #-0xa0]
               	fneg	s4, s1
               	ldur	s2, [x29, #-0x9c]
               	fneg	s5, s2
               	ldur	s3, [x29, #-0x98]
               	fneg	s6, s3
               	ldur	s7, [x29, #-0x94]
               	fneg	s7, s7
               	sub	x1, x29, #0x40
               	stur	s4, [x29, #-0x40]
               	stur	s5, [x29, #-0x3c]
               	stur	s6, [x29, #-0x38]
               	stur	s7, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	fneg	s1, s1
               	stur	s1, [x29, #-0x10]
               	fneg	s1, s2
               	stur	s1, [x29, #-0xc]
               	fneg	s1, s3
               	stur	s1, [x29, #-0x8]
               	ldur	s1, [x29, #-0x94]
               	fneg	s1, s1
               	stur	s1, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x31]
               	cmp	w0, #0x80
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d1, v0.d[0]
               	fneg	d1, d1
               	mov	d2, v0.d[1]
               	fneg	d2, d2
               	sub	x1, x29, #0x40
               	stur	d1, [x29, #-0x40]
               	stur	d2, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	mov	d1, v0.d[0]
               	fneg	d1, d1
               	stur	d1, [x29, #-0x10]
               	mov	d0, v0.d[1]
               	fneg	d0, d0
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0xa0
               	sub	x6, x29, #0x90
               	ldur	q0, [x29, #-0xa0]
               	ldur	q1, [x29, #-0x90]
               	fadd	v0.4s, v0.4s, v1.4s
               	fmov	s1, #2.00000000
               	mov	s2, v0.s[0]
               	fmul	s2, s2, s1
               	fmov	s2, s2
               	mov	s3, v0.s[1]
               	fmul	s3, s3, s1
               	mov	v2.s[1], v3.s[0]
               	mov	s3, v0.s[2]
               	fmul	s3, s3, s1
               	mov	v2.s[2], v3.s[0]
               	mov	s0, v0.s[3]
               	fmul	s0, s0, s1
               	mov	v16.16b, v2.16b
               	mov	v16.s[3], v0.s[0]
               	mov	v0.16b, v16.16b
               	ldur	q1, [x29, #-0xa0]
               	fsub	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x40]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	s0, [x4]
               	add	x1, x6, x1
               	ldr	s1, [x1]
               	fadd	s1, s0, s1
               	fmov	s2, #2.00000000
               	fnmsub	s0, s1, s2, s0
               	str	s0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
