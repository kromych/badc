
float_increment_decrement.aarch64:	file format elf64-littleaarch64

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
               	fmov	s1, #1.50000000
               	fmov	s0, #2.50000000
               	fcmp	s1, s1
               	b.ne	<addr>
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	s0, s0
               	b.ne	<addr>
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d2, #3.25000000
               	fmov	d1, #2.25000000
               	fcmp	d2, d2
               	b.ne	<addr>
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d1, d1
               	b.ne	<addr>
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s1, #1.00000000
               	stur	s1, [x29, #-0x8]
               	ldur	s2, [x29, #-0x8]
               	fmov	d1, #1.00000000
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	stur	s2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x8]
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	stur	s2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x8]
               	fmov	s3, #3.00000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	s2, [x29, #-0x10]
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	stur	s2, [x29, #-0x10]
               	ldur	d3, [x29, #-0x8]
               	fmov	d2, #-1.00000000
               	fadd	d3, d3, d2
               	stur	d3, [x29, #-0x8]
               	ldur	s3, [x29, #-0x10]
               	fcmp	s3, s0
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x8]
               	fmov	d3, #1.50000000
               	fcmp	d0, d3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x18]
               	fadd	d0, d0, d1
               	str	d0, [x0, #0x18]
               	ldr	d0, [x0, #0x18]
               	fadd	d0, d0, d1
               	str	d0, [x0, #0x18]
               	ldr	d0, [x0, #0x18]
               	fmov	d3, #7.00000000
               	fcmp	d0, d3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	ldur	d0, [x29, #-0x10]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x8]
               	fadd	d0, d0, d2
               	stur	d0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x10]
               	fmov	d2, #2.00000000
               	fcmp	d0, d2
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x8]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s0, w16
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
