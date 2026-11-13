
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	fmov	d0, #5.00000000
               	bl	<addr>
               	fmov	d1, #24.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmpe	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmpe	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.00000000
               	bl	<addr>
               	fmov	d1, #1.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmpe	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fcmpe	d0, d2
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, d1
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fsub	d0, d0, d1
               	fcmpe	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fcmpe	d0, d2
               	b.mi	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, d1
               	bl	<addr>
               	fmov	d1, #1.00000000
               	fsub	d0, d0, d1
               	movi	d2, #0000000000000000
               	fcmpe	d0, d2
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fcmpe	d0, d2
               	b.mi	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, d1
               	bl	<addr>
               	str	d0, [sp, #0x8]
               	fmov	d0, #1.00000000
               	bl	<addr>
               	ldr	d16, [sp, #0x8]
               	fadd	d0, d16, d0
               	fmov	d1, #1.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmpe	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmpe	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #5.00000000
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d1, #24.00000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmpe	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmpe	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	movi	d0, #0000000000000000
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmpe	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
