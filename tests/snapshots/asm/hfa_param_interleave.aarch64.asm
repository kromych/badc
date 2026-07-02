
hfa_param_interleave.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x60
               	ldr	x16, [sp, #0x60]
               	str	x16, [sp, #0x40]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x8
               	str	s0, [x16]
               	str	s1, [x16, #0x4]
               	sub	x16, x29, #0x10
               	str	s2, [x16]
               	str	s3, [x16, #0x4]
               	sub	x16, x29, #0x18
               	str	s4, [x16]
               	str	s5, [x16, #0x4]
               	sub	x16, x29, #0x20
               	str	s6, [x16]
               	str	s7, [x16, #0x4]
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	ldr	s0, [x29, #0x50]
               	sub	x0, x29, #0x8
               	ldr	s1, [x0]
               	sub	x0, x29, #0x8
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	sub	x0, x29, #0x10
               	ldr	s2, [x0]
               	fadd	s1, s1, s2
               	sub	x0, x29, #0x10
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	sub	x0, x29, #0x18
               	ldr	s2, [x0]
               	fadd	s1, s1, s2
               	sub	x0, x29, #0x18
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	sub	x0, x29, #0x20
               	ldr	s2, [x0]
               	fadd	s1, s1, s2
               	sub	x0, x29, #0x20
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	fadd	s0, s1, s0
               	sub	x0, x29, #0x28
               	ldrb	w0, [x0]
               	sub	x1, x29, #0x28
               	ldrb	w1, [x1, #0x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x28
               	ldrb	w1, [x1, #0x2]
               	add	x0, x0, x1
               	sub	x1, x29, #0x28
               	ldrb	w1, [x1, #0x3]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	scvtf	d1, x0
               	fcvt	s1, d1
               	fadd	s0, s0, s1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x18
               	sub	x3, x29, #0x20
               	mov	x4, #0x4023000000000000 // =4621537642612260864
               	fmov	d16, x4
               	fcvt	s0, d16
               	sub	x4, x29, #0x28
               	sub	sp, sp, #0x10
               	str	d0, [sp]
               	ldr	s0, [x0]
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x1]
               	ldr	s3, [x1, #0x4]
               	ldr	s4, [x2]
               	ldr	s5, [x2, #0x4]
               	ldr	s6, [x3]
               	ldr	s7, [x3, #0x4]
               	mov	x0, x4
               	ldr	x0, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x0, #0xc00000000000     // =211106232532992
               	movk	x0, #0x404b, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x30
               	mov	x4, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x4
               	fcvt	s0, d16
               	sub	x4, x29, #0x28
               	sub	sp, sp, #0x10
               	str	d0, [sp]
               	ldr	s0, [x0]
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x1]
               	ldr	s3, [x1, #0x4]
               	ldr	s4, [x2]
               	ldr	s5, [x2, #0x4]
               	ldr	s6, [x3]
               	ldr	s7, [x3, #0x4]
               	mov	x0, x4
               	ldr	x0, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x4024, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
