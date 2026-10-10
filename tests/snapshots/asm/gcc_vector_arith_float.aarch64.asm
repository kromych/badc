
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
               	sub	sp, sp, #0xc0
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
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
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fadd	s0, s0, s1
               	ldur	s1, [x29, #-0xbc]
               	ldur	s2, [x29, #-0xac]
               	fadd	s1, s1, s2
               	ldur	s2, [x29, #-0xb8]
               	ldur	s3, [x29, #-0xa8]
               	fadd	s2, s2, s3
               	ldur	s3, [x29, #-0xb4]
               	ldur	s4, [x29, #-0xa4]
               	fadd	s3, s3, s4
               	sub	x1, x29, #0x40
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0xbc]
               	ldur	s1, [x29, #-0xac]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0xb8]
               	ldur	s1, [x29, #-0xa8]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0xb4]
               	ldur	s1, [x29, #-0xa4]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fsub	s0, s0, s1
               	ldur	s1, [x29, #-0xbc]
               	ldur	s2, [x29, #-0xac]
               	fsub	s1, s1, s2
               	ldur	s2, [x29, #-0xb8]
               	ldur	s3, [x29, #-0xa8]
               	fsub	s2, s2, s3
               	ldur	s3, [x29, #-0xb4]
               	ldur	s4, [x29, #-0xa4]
               	fsub	s3, s3, s4
               	sub	x1, x29, #0x40
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fsub	s0, s0, s1
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0xbc]
               	ldur	s1, [x29, #-0xac]
               	fsub	s0, s0, s1
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0xb8]
               	ldur	s1, [x29, #-0xa8]
               	fsub	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0xb4]
               	ldur	s1, [x29, #-0xa4]
               	fsub	s0, s0, s1
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fmul	s0, s0, s1
               	ldur	s1, [x29, #-0xbc]
               	ldur	s2, [x29, #-0xac]
               	fmul	s1, s1, s2
               	ldur	s2, [x29, #-0xb8]
               	ldur	s3, [x29, #-0xa8]
               	fmul	s2, s2, s3
               	ldur	s3, [x29, #-0xb4]
               	ldur	s4, [x29, #-0xa4]
               	fmul	s3, s3, s4
               	sub	x1, x29, #0x40
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0xbc]
               	ldur	s1, [x29, #-0xac]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0xb8]
               	ldur	s1, [x29, #-0xa8]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0xb4]
               	ldur	s1, [x29, #-0xa4]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fdiv	s0, s0, s1
               	ldur	s1, [x29, #-0xbc]
               	ldur	s2, [x29, #-0xac]
               	fdiv	s1, s1, s2
               	ldur	s2, [x29, #-0xb8]
               	ldur	s3, [x29, #-0xa8]
               	fdiv	s2, s2, s3
               	ldur	s3, [x29, #-0xb4]
               	ldur	s4, [x29, #-0xa4]
               	fdiv	s3, s3, s4
               	sub	x1, x29, #0x40
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fdiv	s0, s0, s1
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0xbc]
               	ldur	s1, [x29, #-0xac]
               	fdiv	s0, s0, s1
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0xb8]
               	ldur	s1, [x29, #-0xa8]
               	fdiv	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0xb4]
               	ldur	s1, [x29, #-0xa4]
               	fdiv	s0, s0, s1
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fadd	d0, d0, d1
               	ldur	d1, [x29, #-0x98]
               	ldur	d2, [x29, #-0x88]
               	fadd	d1, d1, d2
               	sub	x1, x29, #0x40
               	stur	d0, [x29, #-0x40]
               	stur	d1, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x98]
               	ldur	d1, [x29, #-0x88]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fsub	d0, d0, d1
               	ldur	d1, [x29, #-0x98]
               	ldur	d2, [x29, #-0x88]
               	fsub	d1, d1, d2
               	sub	x1, x29, #0x40
               	stur	d0, [x29, #-0x40]
               	stur	d1, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fsub	d0, d0, d1
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x98]
               	ldur	d1, [x29, #-0x88]
               	fsub	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fmul	d0, d0, d1
               	ldur	d1, [x29, #-0x98]
               	ldur	d2, [x29, #-0x88]
               	fmul	d1, d1, d2
               	sub	x1, x29, #0x40
               	stur	d0, [x29, #-0x40]
               	stur	d1, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fmul	d0, d0, d1
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x98]
               	ldur	d1, [x29, #-0x88]
               	fmul	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fdiv	d0, d0, d1
               	ldur	d1, [x29, #-0x98]
               	ldur	d2, [x29, #-0x88]
               	fdiv	d1, d1, d2
               	sub	x1, x29, #0x40
               	stur	d0, [x29, #-0x40]
               	stur	d1, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fdiv	d0, d0, d1
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x98]
               	ldur	d1, [x29, #-0x88]
               	fdiv	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	s0, [x29, #-0x80]
               	ldur	s1, [x29, #-0x60]
               	fadd	s0, s0, s1
               	ldur	s1, [x29, #-0x7c]
               	ldur	s2, [x29, #-0x5c]
               	fadd	s1, s1, s2
               	ldur	s2, [x29, #-0x78]
               	ldur	s3, [x29, #-0x58]
               	fadd	s2, s2, s3
               	ldur	s3, [x29, #-0x74]
               	ldur	s4, [x29, #-0x54]
               	fadd	s3, s3, s4
               	ldur	s4, [x29, #-0x70]
               	ldur	s5, [x29, #-0x50]
               	fadd	s4, s4, s5
               	ldur	s5, [x29, #-0x6c]
               	ldur	s6, [x29, #-0x4c]
               	fadd	s5, s5, s6
               	ldur	s6, [x29, #-0x68]
               	ldur	s7, [x29, #-0x48]
               	fadd	s6, s6, s7
               	ldur	s7, [x29, #-0x64]
               	ldur	s19, [x29, #-0x44]
               	fadd	s7, s7, s19
               	sub	x1, x29, #0x40
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	stur	s4, [x29, #-0x30]
               	stur	s5, [x29, #-0x2c]
               	stur	s6, [x29, #-0x28]
               	stur	s7, [x29, #-0x24]
               	sub	x2, x29, #0x20
               	ldur	s0, [x29, #-0x80]
               	ldur	s1, [x29, #-0x60]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x20]
               	ldur	s0, [x29, #-0x7c]
               	ldur	s1, [x29, #-0x5c]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x1c]
               	ldur	s0, [x29, #-0x78]
               	ldur	s1, [x29, #-0x58]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x18]
               	ldur	s0, [x29, #-0x74]
               	ldur	s1, [x29, #-0x54]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x14]
               	ldur	s0, [x29, #-0x70]
               	ldur	s1, [x29, #-0x50]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x6c]
               	ldur	s1, [x29, #-0x4c]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0x68]
               	ldur	s1, [x29, #-0x48]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x64]
               	ldur	s1, [x29, #-0x44]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	ldur	s0, [x29, #-0x80]
               	ldur	s1, [x29, #-0x60]
               	fmul	s0, s0, s1
               	ldur	s1, [x29, #-0x7c]
               	ldur	s2, [x29, #-0x5c]
               	fmul	s1, s1, s2
               	ldur	s2, [x29, #-0x78]
               	ldur	s3, [x29, #-0x58]
               	fmul	s2, s2, s3
               	ldur	s3, [x29, #-0x74]
               	ldur	s4, [x29, #-0x54]
               	fmul	s3, s3, s4
               	ldur	s4, [x29, #-0x70]
               	ldur	s5, [x29, #-0x50]
               	fmul	s4, s4, s5
               	ldur	s5, [x29, #-0x6c]
               	ldur	s6, [x29, #-0x4c]
               	fmul	s5, s5, s6
               	ldur	s6, [x29, #-0x68]
               	ldur	s7, [x29, #-0x48]
               	fmul	s6, s6, s7
               	ldur	s7, [x29, #-0x64]
               	ldur	s19, [x29, #-0x44]
               	fmul	s7, s7, s19
               	sub	x1, x29, #0x40
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	stur	s4, [x29, #-0x30]
               	stur	s5, [x29, #-0x2c]
               	stur	s6, [x29, #-0x28]
               	stur	s7, [x29, #-0x24]
               	sub	x2, x29, #0x20
               	ldur	s0, [x29, #-0x80]
               	ldur	s1, [x29, #-0x60]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x20]
               	ldur	s0, [x29, #-0x7c]
               	ldur	s1, [x29, #-0x5c]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x1c]
               	ldur	s0, [x29, #-0x78]
               	ldur	s1, [x29, #-0x58]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x18]
               	ldur	s0, [x29, #-0x74]
               	ldur	s1, [x29, #-0x54]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x14]
               	ldur	s0, [x29, #-0x70]
               	ldur	s1, [x29, #-0x50]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x6c]
               	ldur	s1, [x29, #-0x4c]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0x68]
               	ldur	s1, [x29, #-0x48]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x64]
               	ldur	s1, [x29, #-0x44]
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	fmov	s0, #2.50000000
               	ldur	s1, [x29, #-0xc0]
               	fmul	s1, s1, s0
               	ldur	s2, [x29, #-0xbc]
               	fmul	s2, s2, s0
               	ldur	s3, [x29, #-0xb8]
               	fmul	s3, s3, s0
               	ldur	s4, [x29, #-0xb4]
               	fmul	s4, s4, s0
               	sub	x1, x29, #0x40
               	stur	s1, [x29, #-0x40]
               	stur	s2, [x29, #-0x3c]
               	stur	s3, [x29, #-0x38]
               	stur	s4, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	ldur	s1, [x29, #-0xc0]
               	fmul	s1, s1, s0
               	stur	s1, [x29, #-0x10]
               	ldur	s1, [x29, #-0xbc]
               	fmul	s1, s1, s0
               	stur	s1, [x29, #-0xc]
               	ldur	s1, [x29, #-0xb8]
               	fmul	s1, s1, s0
               	stur	s1, [x29, #-0x8]
               	ldur	s1, [x29, #-0xb4]
               	fmul	s0, s1, s0
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x3                // =3
               	scvtf	s0, x0
               	ldur	s1, [x29, #-0xc0]
               	fmul	s1, s1, s0
               	ldur	s2, [x29, #-0xbc]
               	fmul	s2, s2, s0
               	ldur	s3, [x29, #-0xb8]
               	fmul	s3, s3, s0
               	ldur	s4, [x29, #-0xb4]
               	fmul	s0, s4, s0
               	sub	x1, x29, #0x40
               	stur	s1, [x29, #-0x40]
               	stur	s2, [x29, #-0x3c]
               	stur	s3, [x29, #-0x38]
               	stur	s0, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	ldur	s1, [x29, #-0xc0]
               	fmov	s0, #3.00000000
               	fmul	s1, s1, s0
               	stur	s1, [x29, #-0x10]
               	ldur	s1, [x29, #-0xbc]
               	fmul	s1, s1, s0
               	stur	s1, [x29, #-0xc]
               	ldur	s1, [x29, #-0xb8]
               	fmul	s1, s1, s0
               	stur	s1, [x29, #-0x8]
               	ldur	s1, [x29, #-0xb4]
               	fmul	s0, s1, s0
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	fmov	d0, #4.00000000
               	ldur	d1, [x29, #-0xa0]
               	fdiv	d1, d1, d0
               	ldur	d2, [x29, #-0x98]
               	fdiv	d2, d2, d0
               	sub	x1, x29, #0x40
               	stur	d1, [x29, #-0x40]
               	stur	d2, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	ldur	d1, [x29, #-0xa0]
               	fdiv	d1, d1, d0
               	stur	d1, [x29, #-0x10]
               	ldur	d1, [x29, #-0x98]
               	fdiv	d0, d1, d0
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x3                // =3
               	scvtf	d0, x0
               	ldur	d1, [x29, #-0xa0]
               	fadd	d1, d1, d0
               	ldur	d2, [x29, #-0x98]
               	fadd	d0, d2, d0
               	sub	x1, x29, #0x40
               	stur	d1, [x29, #-0x40]
               	stur	d0, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	ldur	d1, [x29, #-0xa0]
               	fmov	d0, #3.00000000
               	fadd	d1, d1, d0
               	stur	d1, [x29, #-0x10]
               	ldur	d1, [x29, #-0x98]
               	fadd	d0, d1, d0
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc0
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fmul	s0, s0, s1
               	ldur	s1, [x29, #-0xbc]
               	ldur	s2, [x29, #-0xac]
               	fmul	s1, s1, s2
               	ldur	s2, [x29, #-0xb8]
               	ldur	s3, [x29, #-0xa8]
               	fmul	s2, s2, s3
               	ldur	s3, [x29, #-0xb4]
               	ldur	s4, [x29, #-0xa4]
               	fmul	s3, s3, s4
               	sub	x2, x29, #0x60
               	stur	s0, [x29, #-0x60]
               	stur	s1, [x29, #-0x5c]
               	stur	s2, [x29, #-0x58]
               	stur	s3, [x29, #-0x54]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	s0, [x29, #-0x40]
               	ldur	s1, [x29, #-0xb0]
               	fmul	s0, s0, s1
               	ldur	s1, [x29, #-0x3c]
               	ldur	s2, [x29, #-0xac]
               	fmul	s1, s1, s2
               	ldur	s2, [x29, #-0x38]
               	ldur	s3, [x29, #-0xa8]
               	fmul	s2, s2, s3
               	ldur	s3, [x29, #-0x34]
               	ldur	s4, [x29, #-0xa4]
               	fmul	s3, s3, s4
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc0
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fadd	s0, s0, s1
               	ldur	s1, [x29, #-0xbc]
               	ldur	s2, [x29, #-0xac]
               	fadd	s1, s1, s2
               	ldur	s2, [x29, #-0xb8]
               	ldur	s3, [x29, #-0xa8]
               	fadd	s2, s2, s3
               	ldur	s3, [x29, #-0xb4]
               	ldur	s4, [x29, #-0xa4]
               	fadd	s3, s3, s4
               	sub	x2, x29, #0x60
               	stur	s0, [x29, #-0x60]
               	stur	s1, [x29, #-0x5c]
               	stur	s2, [x29, #-0x58]
               	stur	s3, [x29, #-0x54]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	s0, [x29, #-0x40]
               	ldur	s1, [x29, #-0xb0]
               	fadd	s0, s0, s1
               	ldur	s1, [x29, #-0x3c]
               	ldur	s2, [x29, #-0xac]
               	fadd	s1, s1, s2
               	ldur	s2, [x29, #-0x38]
               	ldur	s3, [x29, #-0xa8]
               	fadd	s2, s2, s3
               	ldur	s3, [x29, #-0x34]
               	ldur	s4, [x29, #-0xa4]
               	fadd	s3, s3, s4
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa0
               	ldur	d0, [x29, #-0xa0]
               	ldur	d1, [x29, #-0x90]
               	fdiv	d0, d0, d1
               	ldur	d1, [x29, #-0x98]
               	ldur	d2, [x29, #-0x88]
               	fdiv	d1, d1, d2
               	sub	x2, x29, #0x60
               	stur	d0, [x29, #-0x60]
               	stur	d1, [x29, #-0x58]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x90]
               	fdiv	d0, d0, d1
               	ldur	d1, [x29, #-0x38]
               	ldur	d2, [x29, #-0x88]
               	fdiv	d1, d1, d2
               	stur	d0, [x29, #-0x40]
               	stur	d1, [x29, #-0x38]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	fmov	s0, #2.00000000
               	ldur	s1, [x29, #-0x60]
               	fmul	s1, s1, s0
               	ldur	s2, [x29, #-0x5c]
               	fmul	s2, s2, s0
               	ldur	s3, [x29, #-0x58]
               	fmul	s3, s3, s0
               	ldur	s4, [x29, #-0x54]
               	fmul	s4, s4, s0
               	stur	s1, [x29, #-0x60]
               	stur	s2, [x29, #-0x5c]
               	stur	s3, [x29, #-0x58]
               	stur	s4, [x29, #-0x54]
               	ldur	s1, [x29, #-0xc0]
               	fmul	s1, s1, s0
               	ldur	s2, [x29, #-0xbc]
               	fmul	s2, s2, s0
               	ldur	s3, [x29, #-0xb8]
               	fmul	s3, s3, s0
               	ldur	s4, [x29, #-0xb4]
               	fmul	s0, s4, s0
               	sub	x2, x29, #0x40
               	stur	s1, [x29, #-0x40]
               	stur	s2, [x29, #-0x3c]
               	stur	s3, [x29, #-0x38]
               	stur	s0, [x29, #-0x34]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	s0, [x29, #-0xc0]
               	fneg	s0, s0
               	ldur	s1, [x29, #-0xbc]
               	fneg	s1, s1
               	ldur	s2, [x29, #-0xb8]
               	fneg	s2, s2
               	ldur	s3, [x29, #-0xb4]
               	fneg	s3, s3
               	sub	x1, x29, #0x40
               	stur	s0, [x29, #-0x40]
               	stur	s1, [x29, #-0x3c]
               	stur	s2, [x29, #-0x38]
               	stur	s3, [x29, #-0x34]
               	sub	x2, x29, #0x10
               	ldur	s0, [x29, #-0xc0]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0xbc]
               	fneg	s0, s0
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0xb8]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0xb4]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x4]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x31]
               	eor	x0, x0, #0x80
               	cbz	w0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0xa0]
               	fneg	d0, d0
               	ldur	d1, [x29, #-0x98]
               	fneg	d1, d1
               	sub	x1, x29, #0x40
               	stur	d0, [x29, #-0x40]
               	stur	d1, [x29, #-0x38]
               	sub	x2, x29, #0x10
               	ldur	d0, [x29, #-0xa0]
               	fneg	d0, d0
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x98]
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
               	sub	x5, x29, #0xc0
               	sub	x6, x29, #0xb0
               	ldur	s0, [x29, #-0xc0]
               	ldur	s1, [x29, #-0xb0]
               	fadd	s1, s0, s1
               	ldur	s0, [x29, #-0xbc]
               	ldur	s2, [x29, #-0xac]
               	fadd	s2, s0, s2
               	ldur	s0, [x29, #-0xb8]
               	ldur	s3, [x29, #-0xa8]
               	fadd	s3, s0, s3
               	ldur	s0, [x29, #-0xb4]
               	ldur	s4, [x29, #-0xa4]
               	fadd	s4, s0, s4
               	fmov	s0, #2.00000000
               	ldur	s5, [x29, #-0xc0]
               	fnmsub	s1, s1, s0, s5
               	ldur	s5, [x29, #-0xbc]
               	fnmsub	s2, s2, s0, s5
               	ldur	s5, [x29, #-0xb8]
               	fnmsub	s3, s3, s0, s5
               	ldur	s5, [x29, #-0xb4]
               	fnmsub	s0, s4, s0, s5
               	stur	s1, [x29, #-0x40]
               	stur	s2, [x29, #-0x3c]
               	stur	s3, [x29, #-0x38]
               	stur	s0, [x29, #-0x34]
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
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
