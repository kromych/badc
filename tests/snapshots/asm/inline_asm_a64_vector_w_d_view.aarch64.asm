
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

<sub_into>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	d0, [x29, #-0x8]
               	stur	d1, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	fmov	d16, x1
               	str	d16, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	d0, [x16]
               	ldr	d1, [sp, #0x8]
               	sub	d0, d0, d1
               	ldr	x16, [sp]
               	str	d0, [x16]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	d0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x30]
               	mov	x16, #0x3fc00000        // =1069547520
               	movk	x16, #0xc000, lsl #48
               	str	x16, [sp, #0x38]
               	mov	x16, #0x3f000000        // =1056964608
               	movk	x16, #0x4080, lsl #48
               	str	x16, [sp, #0x40]
               	ldr	d1, [sp, #0x38]
               	ldr	d2, [sp, #0x40]
               	fadd	v0.2s, v1.2s, v2.2s
               	ldr	x16, [sp, #0x30]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x18]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x30]
               	mov	x16, #0x3f000000        // =1056964608
               	movk	x16, #0x4080, lsl #48
               	str	x16, [sp, #0x38]
               	mov	x16, #0x3fc00000        // =1069547520
               	movk	x16, #0xc000, lsl #48
               	str	x16, [sp, #0x40]
               	ldr	d1, [sp, #0x38]
               	ldr	d0, [sp, #0x40]
               	fmul	v0.2s, v0.2s, v1.2s
               	ldr	x16, [sp, #0x30]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x10]
               	ldur	s1, [x29, #-0x18]
               	fmov	s0, #2.00000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x14]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x10]
               	fmov	s1, #0.75000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0xc]
               	fmov	s1, #-8.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x30]
               	mov	x16, #0x201             // =513
               	movk	x16, #0x403, lsl #16
               	movk	x16, #0x605, lsl #32
               	movk	x16, #0x807, lsl #48
               	str	x16, [sp, #0x38]
               	mov	x16, #0xff              // =255
               	movk	x16, #0xff0, lsl #16
               	movk	x16, #0x8000, lsl #48
               	str	x16, [sp, #0x40]
               	ldr	d1, [sp, #0x38]
               	ldr	d2, [sp, #0x40]
               	eor	v0.8b, v1.8b, v2.8b
               	ldr	x16, [sp, #0x30]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x10
               	stur	x0, [x29, #-0x10]
               	ldurb	w0, [x29, #-0x10]
               	eor	x0, x0, #0xfe
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0xe]
               	mov	x17, #0xf3              // =243
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0xd]
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x9]
               	mov	x17, #0x88              // =136
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x30]
               	mov	x16, #0x28              // =40
               	str	x16, [sp, #0x38]
               	mov	x16, #0x2               // =2
               	str	x16, [sp, #0x40]
               	ldr	d1, [sp, #0x38]
               	ldr	d2, [sp, #0x40]
               	add	d0, d1, d2
               	ldr	x16, [sp, #0x30]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x10]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x30]
               	fmov	d16, x1
               	str	d16, [sp, #0x38]
               	fmov	d16, x1
               	str	d16, [sp, #0x40]
               	ldr	d1, [sp, #0x38]
               	ldr	d2, [sp, #0x40]
               	add	d0, d1, d2
               	ldr	x16, [sp, #0x30]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x18
               	sub	x0, x29, #0x10
               	ldr	d0, [x7]
               	ldr	d1, [x0]
               	bl	<addr>
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x26
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	mov	x1, #0xf0               // =240
               	sturb	w1, [x29, #-0x51]
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q1, [x29, #-0x60]
               	str	q1, [sp, #0x30]
               	sub	x16, x29, #0x50
               	str	x16, [sp, #0x40]
               	ldr	q1, [sp, #0x30]
               	ldr	x16, [sp, #0x40]
               	ldr	q0, [x16]
               	eor	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	ldurb	w0, [x29, #-0x50]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x42]
               	eor	x0, x0, #0xf
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x41]
               	eor	x0, x0, #0xe0
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
