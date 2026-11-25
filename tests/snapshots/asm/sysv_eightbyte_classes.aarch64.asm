
sysv_eightbyte_classes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<take_b1>:
               	fmov	d0, x2
               	fmov	d1, #10.00000000
               	fmul	d0, d0, d1
               	fcvtzs	x0, d0
               	add	x0, x0, #0xbb8
               	add	x0, x0, #0x2
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
               	mov	x0, #0x0                // =0
               	fmov	x1, d0
               	ret

<make_b2>:
               	mov	x1, #0x9                // =9
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	ldr	d0, [x0]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	mov	s1, v0.s[0]
               	fmov	s2, #1.50000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s0, v0.s[3]
               	fmov	s1, #2.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x20]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	fmul	d0, d0, d1
               	fcvtzs	x0, d0
               	add	x0, x0, #0x2a
               	cmp	x0, #0x156
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	fmov	d1, #0.50000000
               	mov	s2, v0.s[0]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s3, w16
               	mov	s0, v0.s[3]
               	fmov	s4, #10.00000000
               	fmul	s0, s0, s4
               	fmadd	s0, s2, s3, s0
               	fcvt	d0, s0
               	fadd	d0, d0, d1
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x40]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4012000000000000 // =4616752568008179712
               	mov	x0, #0x3                // =3
               	mov	x3, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0xbe7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #0.50000000
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7                // =7
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x2c3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.50000000
               	bl	<addr>
               	fmov	d0, x1
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x1, #0x9
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
