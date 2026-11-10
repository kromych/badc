
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #-0x20]
               	add	x0, x0, x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x2c]
               	ldursw	x1, [x29, #-0x1c]
               	add	x0, x0, x1
               	stur	w0, [x29, #-0xc]
               	ldursw	x0, [x29, #-0x28]
               	ldursw	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x24]
               	ldursw	x1, [x29, #-0x14]
               	add	x0, x0, x1
               	stur	w0, [x29, #-0x4]
               	ldur	q0, [x29, #-0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<fma4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	q0, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	stur	q2, [x29, #-0x10]
               	ldur	s0, [x29, #-0x30]
               	ldur	s1, [x29, #-0x20]
               	ldur	s2, [x29, #-0x2c]
               	ldur	s3, [x29, #-0x1c]
               	ldur	s4, [x29, #-0x28]
               	ldur	s5, [x29, #-0x18]
               	ldur	s6, [x29, #-0x24]
               	ldur	s7, [x29, #-0x14]
               	ldur	s19, [x29, #-0x10]
               	fmadd	s0, s0, s1, s19
               	stur	s0, [x29, #-0x20]
               	ldur	s0, [x29, #-0xc]
               	fmadd	s0, s2, s3, s0
               	stur	s0, [x29, #-0x1c]
               	ldur	s0, [x29, #-0x8]
               	fmadd	s0, s4, s5, s0
               	stur	s0, [x29, #-0x18]
               	ldur	s0, [x29, #-0x4]
               	fmadd	s0, s6, s7, s0
               	stur	s0, [x29, #-0x14]
               	ldur	q0, [x29, #-0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<neg>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	d0, [x29, #-0x8]
               	ldursh	x0, [x29, #-0x8]
               	neg	x0, x0
               	sturh	w0, [x29, #-0x10]
               	ldursh	x0, [x29, #-0x6]
               	neg	x0, x0
               	sturh	w0, [x29, #-0xe]
               	ldursh	x0, [x29, #-0x4]
               	neg	x0, x0
               	sturh	w0, [x29, #-0xc]
               	ldursh	x0, [x29, #-0x2]
               	neg	x0, x0
               	sturh	w0, [x29, #-0xa]
               	ldur	d0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<swap>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x40
               	stur	q0, [x29, #-0x40]
               	stur	q1, [x29, #-0x30]
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	add	x2, x1, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	add	x0, x0, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
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
               	stur	q0, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x40]
               	cmp	w0, #0xb
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x3c]
               	cmp	w0, #0x16
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x21
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x34]
               	mov	x17, #-0x24             // =-36
               	cmp	w0, w17
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
               	stur	q0, [x29, #-0x40]
               	ldur	s0, [x29, #-0x40]
               	fmov	s1, #2.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x34]
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
               	stur	d0, [x29, #-0x8]
               	ldurh	w0, [x29, #-0x8]
               	ldurh	w1, [x29, #-0x6]
               	ldurh	w2, [x29, #-0x2]
               	sxth	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.ne	<addr>
               	sxth	x0, w1
               	cmp	w0, #0x2
               	b.ne	<addr>
               	sxth	x0, w2
               	cmp	w0, #0x4
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
               	stur	q0, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x40]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x34]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
