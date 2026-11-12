
vector_arguments_and_results.aarch64:	file format elf64-littleaarch64

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

<add>:
               	add	v0.4s, v0.4s, v1.4s
               	ret

<fma4>:
               	fmul	v0.4s, v0.4s, v1.4s
               	fadd	v0.4s, v0.4s, v2.4s
               	ret

<neg>:
               	neg	v0.4h, v0.4h
               	ret

<swap>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	stur	q0, [x29, #-0x40]
               	stur	q1, [x29, #-0x30]
               	add	x2, x0, #0x10
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x1, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<spin>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	mov	x20, #0x0               // =0
               	cmp	w20, w21
               	b.ge	<addr>
               	sub	x7, x29, #0x20
               	sub	x0, x29, #0x10
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x20]
               	add	x20, x20, #0x1
               	cmp	w20, w21
               	b.lt	<addr>
               	ldur	q0, [x29, #-0x20]
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x7, x29, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	smov	x0, v0.s[0]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x16
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	mov	x17, #-0x24             // =-36
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	ldr	q2, [x1]
               	bl	<addr>
               	mov	s1, v0.s[0]
               	fmov	s2, #2.50000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s0, v0.s[3]
               	fmov	s1, #8.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x7]
               	ldr	d0, [x7]
               	bl	<addr>
               	smov	x0, v0.h[0]
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.h[1]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	smov	x0, v0.h[3]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x7, #0x10]
               	ldr	q0, [x7]
               	ldr	q1, [x7, #0x10]
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	stur	q1, [x29, #-0x30]
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	s0, [x29, #-0x60]
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x44]
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x1, x29, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x5                // =5
               	ldr	q0, [x7]
               	ldr	q1, [x1]
               	bl	<addr>
               	smov	x0, v0.s[0]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
