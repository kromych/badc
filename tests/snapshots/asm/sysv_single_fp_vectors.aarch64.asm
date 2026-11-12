
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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x10]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s2, [x29, #-0x10]
               	fmov	s0, #1.50000000
               	fcmp	s2, s0
               	cset	x0, eq
               	orr	x0, x0, #0x2
               	orr	x0, x0, #0x4
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x2, eq
               	orr	x2, x2, #0x2
               	orr	x2, x2, #0x4
               	cmp	x2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s1, [x29, #-0x8]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x4]
               	fmov	s2, #3.00000000
               	fcmp	s1, s2
               	cset	x2, eq
               	orr	x2, x2, #0x2
               	orr	x2, x2, #0x4
               	cmp	x2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d2, x16
               	fmov	d1, #25.00000000
               	fmov	d16, x0
               	fmadd	d2, d16, d2, d1
               	fcvtzs	x2, d2
               	add	x2, x2, #0x7
               	cmp	x2, #0xb6
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	s2, [x29, #-0x8]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s3, w16
               	ldur	s4, [x29, #-0x4]
               	mov	x16, #0x447a0000        // =1148846080
               	fmov	s5, w16
               	fmul	s4, s4, s5
               	fmadd	s2, s2, s3, s4
               	fcvt	d2, s2
               	fadd	d1, d2, d1
               	fcvtzs	x1, d1
               	add	x1, x1, #0x7
               	cmp	x1, #0xc6e
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0x3fc00000        // =1069547520
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	mov	x0, v16.d[0]
               	mov	x17, #0x3ff8000000000000 // =4609434218613702656
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
