
libc_math_special.aarch64:	file format elf64-littleaarch64

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
               	str	d8, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	fmov	d0, #5.00000000
               	bl	<addr>
               	fmov	d1, #24.00000000
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	fmov	d0, #1.00000000
               	bl	<addr>
               	fmov	d1, #1.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	fmov	d0, d1
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fsub	d0, d0, d1
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	b.mi	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	fmov	d0, d1
               	bl	<addr>
               	fmov	d1, #1.00000000
               	fsub	d0, d0, d1
               	movi	d2, #0000000000000000
               	fcmp	d0, d2
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	b.mi	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	fmov	d0, d1
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, #1.00000000
               	bl	<addr>
               	fadd	d0, d8, d0
               	fmov	d1, #1.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	fmov	s0, #5.00000000
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d1, #24.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	movi	d0, #0000000000000000
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
