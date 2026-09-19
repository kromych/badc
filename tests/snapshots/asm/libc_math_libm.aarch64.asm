
libc_math_libm.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #27.00000000
               	bl	<addr>
               	fmov	d1, #3.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #8.00000000
               	bl	<addr>
               	fmov	d1, #2.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.50000000
               	bl	<addr>
               	bl	<addr>
               	fmov	d1, #1.50000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #5.00000000
               	fmov	d1, #3.00000000
               	bl	<addr>
               	fmov	d1, #-1.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.50000000
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #3.50000000
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #-2.50000000
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #27.00000000
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	s1, #3.00000000
               	fcvt	d2, s1
               	fsub	d0, d0, d2
               	movi	d2, #0000000000000000
               	fcmp	d0, d2
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	b.mi	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #5.00000000
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d1, #-1.00000000
               	fsub	d0, d0, d1
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldp	x29, x30, [sp], #0x10
               	ret
