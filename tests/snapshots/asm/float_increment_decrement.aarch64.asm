
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
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x8]
               	ldur	s1, [x29, #-0x8]
               	fmov	d0, #1.00000000
               	fcvt	d1, s1
               	fadd	d1, d1, d0
               	fcvt	s1, d1
               	stur	s1, [x29, #-0x8]
               	ldur	s1, [x29, #-0x8]
               	fcvt	d1, s1
               	fadd	d1, d1, d0
               	fcvt	s1, d1
               	stur	s1, [x29, #-0x8]
               	ldur	s1, [x29, #-0x8]
               	fmov	s2, #3.00000000
               	fcmp	s1, s2
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
               	ldur	s1, [x29, #-0x10]
               	fcvt	d1, s1
               	fadd	d1, d1, d0
               	fcvt	s1, d1
               	stur	s1, [x29, #-0x10]
               	ldur	d2, [x29, #-0x8]
               	fmov	d1, #-1.00000000
               	fadd	d2, d2, d1
               	stur	d2, [x29, #-0x8]
               	ldur	s2, [x29, #-0x10]
               	fmov	s3, #2.50000000
               	fcmp	s2, s3
               	b.ne	<addr>
               	ldur	d2, [x29, #-0x8]
               	fmov	d3, #1.50000000
               	fcmp	d2, d3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	d2, [x0, #0x18]
               	fadd	d2, d2, d0
               	str	d2, [x0, #0x18]
               	ldr	d2, [x0, #0x18]
               	fadd	d2, d2, d0
               	str	d2, [x0, #0x18]
               	ldr	d2, [x0, #0x18]
               	fmov	d3, #7.00000000
               	fcmp	d2, d3
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
               	ldur	d2, [x29, #-0x10]
               	fadd	d2, d2, d0
               	stur	d2, [x29, #-0x10]
               	ldur	d2, [x29, #-0x8]
               	fadd	d1, d2, d1
               	stur	d1, [x29, #-0x8]
               	ldur	d1, [x29, #-0x10]
               	fmov	d2, #2.00000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	ldur	d1, [x29, #-0x8]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
