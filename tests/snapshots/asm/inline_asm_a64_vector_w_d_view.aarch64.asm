
inline_asm_a64_vector_w_d_view.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	adrp	x0, <page>
               	ldr	d0, [x0]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x8]
               	fadd	v2.2s, v0.2s, v1.2s
               	str	d1, [sp, #0x20]
               	str	d0, [sp, #0x28]
               	ldr	d1, [sp, #0x20]
               	ldr	d0, [sp, #0x28]
               	fmul	v0.2s, v0.2s, v1.2s
               	mov	s3, v2.s[0]
               	fmov	s1, #2.00000000
               	fcmp	s3, s1
               	b.ne	<addr>
               	mov	s2, v2.s[1]
               	fcmp	s2, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	s1, v0.s[0]
               	fmov	s2, #0.75000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s0, v0.s[1]
               	fmov	s1, #-8.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x10]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x18]
               	eor	v0.8b, v0.8b, v1.8b
               	umov	w0, v0.b[0]
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	umov	w0, v0.b[2]
               	cmp	w0, #0xf3
               	b.ne	<addr>
               	umov	w0, v0.b[3]
               	cmp	w0, #0xb
               	b.ne	<addr>
               	umov	w0, v0.b[7]
               	cmp	w0, #0x88
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x20]
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x28]
               	add	d2, d1, d0
               	mov	x0, v2.d[0]
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	add	d2, d0, d0
               	mov	x0, v2.d[0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, d1
               	sub	d16, d16, d0
               	fmov	d0, d16
               	mov	x0, v0.d[0]
               	cmp	x0, #0x26
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x1, #0x0                // =0
               	mov	x2, #0xf0               // =240
               	fmov	d1, x1
               	mov	v1.b[15], w2
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	str	q1, [sp, #0x20]
               	sub	x16, x29, #0x30
               	str	x16, [sp, #0x30]
               	ldr	q1, [sp, #0x20]
               	ldr	x16, [sp, #0x30]
               	ldr	q0, [x16]
               	eor	v0.16b, v0.16b, v1.16b
               	umov	w0, v0.b[0]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	umov	w0, v0.b[14]
               	cmp	w0, #0xf
               	b.ne	<addr>
               	umov	w0, v0.b[15]
               	cmp	w0, #0xe0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
