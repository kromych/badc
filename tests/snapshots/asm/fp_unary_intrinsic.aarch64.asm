
fp_unary_intrinsic.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #4.00000000
               	fsqrt	s0, s0
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s0, #0.25000000
               	fsqrt	s0, s0
               	fmov	s1, #0.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d0, #9.00000000
               	fsqrt	d0, d0
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s0, #3.50000000
               	fneg	s1, s0
               	fabs	s1, s1
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d0, #3.50000000
               	fneg	d1, d0
               	fabs	d1, d1
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	s0, #16.00000000
               	fsqrt	s0, s0
               	fcvt	d0, s0
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	frintm	d0, d0
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x10]
               	fneg	s0, s0
               	frintm	s0, s0
               	fmov	s1, #3.00000000
               	fneg	s1, s1
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	frintp	d0, d0
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x14]
               	fneg	s0, s0
               	frintp	s0, s0
               	fmov	s1, #2.00000000
               	fneg	s1, s1
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fneg	d0, d0
               	frintz	d0, d0
               	fmov	d1, #2.00000000
               	fneg	d1, d1
               	fcmp	d0, d1
               	b.ne	<addr>
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x18]
               	frintz	s1, s0
               	fmov	s0, #2.00000000
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fmov	s1, #16.00000000
               	fneg	s1, s1
               	fabs	s1, s1
               	fsqrt	s1, s1
               	fmov	s2, #4.00000000
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fmul	s0, s0, s0
               	fsqrt	s0, s0
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x1c]
               	fadd	s0, s0, s1
               	frintm	s0, s0
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x0                // =0
               	ret
