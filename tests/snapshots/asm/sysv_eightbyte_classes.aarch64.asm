
sysv_eightbyte_classes.aarch64:	file format elf64-littleaarch64

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

<take_b1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x2, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	fmov	d1, #10.00000000
               	fmul	d0, d0, d1
               	fcvtzs	x0, d0
               	add	x0, x0, #0xbb8
               	add	x0, x0, #0x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_b2>:
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	scvtf	d1, x0
               	fmov	d2, #10.00000000
               	fmadd	d0, d0, d2, d1
               	fcvtzs	x0, d0
               	add	x0, x0, #0x2
               	ret

<make_b1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	str	d0, [x0, #0x8]
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make_b2>:
               	mov	x1, #0x9                // =9
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	fmov	d0, #0.50000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	d2, [x2]
               	fmov	d1, #2.50000000
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3fc00000         // =1069547520
               	mov	x3, #0x4020000000000000 // =4620693217682128896
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	ldr	s1, [x0]
               	fmov	s2, #1.50000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	ldr	s1, [x0, #0xc]
               	fmov	s2, #2.50000000
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	d2, [x0]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	fmul	d2, d2, d1
               	fcvtzs	x0, d2
               	add	x0, x0, #0x2a
               	cmp	x0, #0x156
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d2, #3.00000000
               	fmul	d1, d2, d1
               	fcvtzs	x0, d1
               	add	x0, x0, #0x2a
               	cmp	x0, #0x156
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x30
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	s1, [x0]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s2, w16
               	ldr	s3, [x0, #0xc]
               	fmov	s4, #10.00000000
               	fmul	s3, s3, s4
               	fmadd	s1, s1, s2, s3
               	fcvt	d1, s1
               	fadd	d0, d1, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x40]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	fmov	d0, #4.50000000
               	str	d0, [x1, #0x8]
               	mov	x0, #0x7                // =7
               	str	x0, [x2, #0x8]
               	mov	x0, #0x3                // =3
               	mov	x3, #0x2                // =2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cmp	x0, #0xbe7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	fmov	d0, #0.50000000
               	mov	x2, #0x2                // =2
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x2c3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.50000000
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	d0, [x0, #0x8]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	cmp	x1, #0x9
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
