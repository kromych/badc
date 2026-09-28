
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
               	sub	x3, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x3]
               	sub	x1, x29, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	fmov	d2, #2.50000000
               	ldr	s1, [x0]
               	fmov	s0, #1.50000000
               	fcmp	s1, s0
               	cset	x0, eq
               	fcmp	d2, d2
               	cset	x2, eq
               	lsl	x2, x2, #1
               	sxtw	x2, w2
               	orr	x0, x0, x2
               	orr	x0, x0, #0x4
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d3, [x3]
               	fmov	d1, #1.50000000
               	fcmp	d3, d1
               	cset	x0, eq
               	orr	x0, x0, x2
               	orr	x0, x0, #0x4
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	s3, [x1]
               	fcmp	s3, s0
               	b.ne	<addr>
               	ldr	s3, [x1, #0x4]
               	fmov	s4, #3.00000000
               	fcmp	s3, s4
               	cset	x1, eq
               	orr	x1, x1, x2
               	orr	x1, x1, #0x4
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s3, w16
               	fmul	s4, s0, s3
               	fmov	d0, #10.00000000
               	fcvt	d4, s4
               	fmadd	d2, d2, d0, d4
               	fcvtzs	x1, d2
               	add	x1, x1, #0x7
               	cmp	x1, #0xb6
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d2, #2.50000000
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d4, x16
               	fmul	d5, d2, d0
               	fmadd	d1, d1, d4, d5
               	fcvtzs	x1, d1
               	add	x1, x1, #0x7
               	cmp	x1, #0xb6
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	s1, [x1]
               	ldr	s4, [x1, #0x4]
               	mov	x16, #0x447a0000        // =1148846080
               	fmov	s5, w16
               	fmul	s4, s4, s5
               	fmadd	s1, s1, s3, s4
               	fcvt	d1, s1
               	fmadd	d0, d2, d0, d1
               	fcvtzs	x1, d0
               	add	x1, x1, #0x7
               	cmp	x1, #0xc6e
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w0, [x29, #-0x8]
               	fmov	s0, #1.50000000
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
               	fmov	d0, #1.50000000
               	stur	d0, [x29, #-0x8]
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
               	mov	x1, x0
               	b	<addr>
