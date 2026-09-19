
libc_math_minmax.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #3.00000000
               	fmov	d1, #4.00000000
               	bl	<addr>
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.00000000
               	fmov	d1, #3.00000000
               	bl	<addr>
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #3.00000000
               	fmov	d17, d1
               	fmov	d1, d0
               	fmov	d0, d17
               	bl	<addr>
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	movi	d0, #0000000000000000
               	fdiv	d0, d0, d0
               	fmov	d1, #4.00000000
               	bl	<addr>
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d1, #5.00000000
               	movi	d0, #0000000000000000
               	fdiv	d0, d0, d0
               	fmov	d17, d1
               	fmov	d1, d0
               	fmov	d0, d17
               	bl	<addr>
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	fmov	s1, #4.00000000
               	bl	<addr>
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #2.00000000
               	fmov	s1, #3.00000000
               	bl	<addr>
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	fmov	d17, d1
               	fmov	d1, d0
               	fmov	d0, d17
               	bl	<addr>
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
