
sysv_single_fp_vectors.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	s1, [x29, #-0x18]
               	fmov	s0, #1.50000000
               	fcmp	s1, s0
               	cset	x1, eq
               	orr	x1, x1, #0x2
               	orr	x1, x1, #0x4
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d2, [x29, #-0x10]
               	fmov	d1, #1.50000000
               	fcmp	d2, d1
               	cset	x1, eq
               	orr	x1, x1, #0x2
               	orr	x1, x1, #0x4
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s2, [x29, #-0x8]
               	fcmp	s2, s0
               	b.ne	<addr>
               	ldur	s2, [x29, #-0x4]
               	fmov	s3, #3.00000000
               	fcmp	s2, s3
               	cset	x1, eq
               	orr	x1, x1, #0x2
               	orr	x1, x1, #0x4
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d3, x16
               	fmov	d2, #25.00000000
               	fmadd	d3, d1, d3, d2
               	fcvtzs	x1, d3
               	add	x1, x1, #0x7
               	cmp	x1, #0xb6
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	s3, [x29, #-0x8]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s4, w16
               	ldur	s5, [x29, #-0x4]
               	mov	x16, #0x447a0000        // =1148846080
               	fmov	s6, w16
               	fmul	s5, s5, s6
               	fmadd	s3, s3, s4, s5
               	fcvt	d3, s3
               	fadd	d2, d3, d2
               	fcvtzs	x0, d2
               	add	x0, x0, #0x7
               	cmp	x0, #0xc6e
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0x3fc00000        // =1069547520
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x8]
               	stur	d1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0x3ff8000000000000 // =4609434218613702656
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
