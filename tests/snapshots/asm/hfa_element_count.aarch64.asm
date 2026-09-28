
hfa_element_count.aarch64:	file format elf64-littleaarch64

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

<take_u1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	d0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	fmov	d2, #10.00000000
               	fmadd	d0, d0, d2, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_f3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	s0, [x29, #-0x10]
               	stur	s1, [x29, #-0xc]
               	stur	s2, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	s0, [x0]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s1, w16
               	ldr	s2, [x0, #0x4]
               	fmov	s4, #10.00000000
               	fmul	s2, s2, s4
               	fmadd	s0, s0, s1, s2
               	ldr	s1, [x0, #0x8]
               	fadd	s0, s0, s1
               	fcvt	d0, s0
               	fadd	d0, d0, d3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_d3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	d0, [x29, #-0x18]
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	ldr	d0, [x0]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	ldr	d2, [x0, #0x8]
               	fmov	d4, #10.00000000
               	fmul	d2, d2, d4
               	fmadd	d0, d0, d1, d2
               	ldr	d1, [x0, #0x10]
               	fadd	d0, d0, d1
               	fadd	d0, d0, d3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_nest>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	d0, [x29, #-0x18]
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	ldr	d0, [x0]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	ldr	d2, [x0, #0x8]
               	fmov	d4, #10.00000000
               	fmul	d2, d2, d4
               	fmadd	d0, d0, d1, d2
               	ldr	d1, [x0, #0x10]
               	fadd	d0, d0, d1
               	fadd	d0, d0, d3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_anon>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	s0, [x29, #-0x8]
               	stur	s1, [x29, #-0x4]
               	sub	x0, x29, #0x8
               	ldr	s0, [x0]
               	fmov	s1, #10.00000000
               	ldr	s3, [x0, #0x4]
               	fmadd	s0, s0, s1, s3
               	fcvt	d0, s0
               	fadd	d0, d0, d2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_fd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	fmov	d2, #10.00000000
               	fmadd	d0, d1, d2, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<after_u1>:
               	fmov	d0, d1
               	ret

<after_f3>:
               	fmov	d0, d3
               	ret

<after_d3>:
               	fmov	d0, d3
               	ret

<after_nest>:
               	fmov	d0, d3
               	ret

<after_anon>:
               	fmov	d0, d2
               	ret

<after_fd>:
               	ret

<ret_u1>:
               	fmov	d0, #2.50000000
               	fmov	d1, #-1.00000000
               	ret

<ret_f3>:
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	fmov	s2, #3.00000000
               	fmov	s3, #-1.00000000
               	ret

<ret_d3>:
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	fmov	d2, #3.00000000
               	fmov	d3, #-1.00000000
               	ret

<ret_nest>:
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	fmov	d2, #3.00000000
               	fmov	d3, #-1.00000000
               	ret

<ret_anon>:
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	fmov	s2, #-1.00000000
               	ret

<ret_fd>:
               	mov	x0, #0x3fe8000000000000 // =4604930618986332160
               	fmov	d0, #-1.00000000
               	ret

<via_u1>:
               	mov	x16, x0
               	fmov	d0, #4.00000000
               	fmov	d1, #0.50000000
               	br	x16

<via_f3>:
               	mov	x16, x0
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	fmov	s2, #3.00000000
               	fmov	d3, #0.50000000
               	br	x16

<via_d3>:
               	mov	x16, x0
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	fmov	d2, #3.00000000
               	fmov	d3, #0.50000000
               	br	x16

<via_nest>:
               	mov	x16, x0
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	fmov	d2, #3.00000000
               	fmov	d3, #0.50000000
               	br	x16

<via_anon>:
               	mov	x16, x0
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	fmov	d2, #0.50000000
               	br	x16

<via_fd>:
               	mov	x16, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, #0.25000000
               	br	x16

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x7, x29, #0x68
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x7]
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x60
               	fmov	s0, #1.00000000
               	str	s0, [x0]
               	fmov	s0, #2.00000000
               	str	s0, [x0, #0x4]
               	fmov	d0, #0.50000000
               	stur	d0, [x29, #-0x8]
               	fmov	d1, d0
               	ldr	d0, [x7]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x58
               	fmov	d3, d1
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	ldr	s2, [x7, #0x8]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x48
               	fmov	d3, d1
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x7, #0x10]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x30
               	fmov	d3, d1
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x7, #0x10]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	fmov	d2, d1
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	fmov	d0, d1
               	ldr	x0, [x0]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	d0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	s0, [x29, #-0x10]
               	stur	s1, [x29, #-0xc]
               	stur	s2, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x58
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	w16, [x0, #0x8]
               	str	w16, [x1, #0x8]
               	sub	x0, x29, #0x58
               	ldr	s0, [x0]
               	fmov	s1, #1.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	s0, [x0, #0x4]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	s0, [x0, #0x8]
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	d0, [x29, #-0x18]
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x48
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x48
               	ldr	d0, [x0]
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x10]
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	d0, [x29, #-0x18]
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x30
               	ldr	d0, [x0]
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x10]
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	s0, [x29, #-0x8]
               	stur	s1, [x29, #-0x4]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x0, x29, #0x60
               	ldr	s0, [x0]
               	fmov	s1, #1.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	s0, [x0, #0x4]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	fmov	d1, #0.75000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x48]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x50]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x50]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x50]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	fmov	d1, #12.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	fmov	d1, #5.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
