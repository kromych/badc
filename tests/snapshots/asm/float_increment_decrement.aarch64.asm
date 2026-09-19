
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
               	fmov	d0, #1.00000000
               	fcvt	d2, s1
               	fadd	d2, d2, d0
               	fcvt	s2, d2
               	fcmp	s1, s1
               	b.ne	<addr>
               	fmov	s1, #2.50000000
               	fcmp	s2, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	s2, s1
               	b.ne	<addr>
               	fcmp	s2, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d2, #3.25000000
               	fmov	d3, #-1.00000000
               	fadd	d4, d2, d3
               	fcmp	d2, d2
               	b.ne	<addr>
               	fmov	d2, #2.25000000
               	fcmp	d4, d2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d4, d2
               	b.ne	<addr>
               	fcmp	d4, d2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s2, #1.00000000
               	stur	s2, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	s2, [x0]
               	fcvt	d2, s2
               	fadd	d2, d2, d0
               	fcvt	s2, d2
               	str	s2, [x0]
               	ldr	s2, [x0]
               	fcvt	d2, s2
               	fadd	d2, d2, d0
               	fcvt	s2, d2
               	str	s2, [x0]
               	ldur	s2, [x29, #-0x8]
               	fmov	s4, #3.00000000
               	fcmp	s2, s4
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	s2, [x0]
               	fcvt	d2, s2
               	fadd	d2, d2, d0
               	fcvt	s2, d2
               	str	s2, [x0]
               	ldr	d2, [x0, #0x8]
               	fadd	d2, d2, d3
               	str	d2, [x0, #0x8]
               	ldr	s2, [x0]
               	fcmp	s2, s1
               	b.ne	<addr>
               	ldr	d1, [x0, #0x8]
               	fmov	d2, #1.50000000
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	fadd	d1, d1, d0
               	str	d1, [x0]
               	ldr	d1, [x0]
               	fadd	d1, d1, d0
               	str	d1, [x0]
               	ldr	d1, [x0]
               	fmov	d2, #7.00000000
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	ldr	d1, [x0, #0x8]
               	fadd	d1, d1, d0
               	str	d1, [x0, #0x8]
               	ldr	d1, [x0, #0x10]
               	fadd	d1, d1, d3
               	str	d1, [x0, #0x10]
               	ldr	d1, [x0, #0x8]
               	fmov	d2, #2.00000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	ldr	d1, [x0, #0x10]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s1, w16
               	fcvt	d2, s1
               	fadd	d0, d2, d0
               	fcvt	s0, d0
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
