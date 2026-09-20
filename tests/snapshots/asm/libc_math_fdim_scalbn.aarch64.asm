
libc_math_fdim_scalbn.aarch64:	file format elf64-littleaarch64

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

<scalbn>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x0, w0
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalbln>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalbnf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	fcvt	d0, s0
               	bl	<addr>
               	fcvt	s0, d0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	fmov	d1, #5.00000000
               	fmov	d0, #3.00000000
               	fcmp	d1, d0
               	b.gt	<addr>
               	fcmp	d1, d1
               	b.ne	<addr>
               	fcmp	d0, d0
               	b.eq	<addr>
               	fsub	d2, d1, d0
               	fmov	d3, #2.00000000
               	fcmp	d2, d3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d0, d1
               	b.gt	<addr>
               	fcmp	d0, d0
               	b.ne	<addr>
               	fcmp	d1, d1
               	b.eq	<addr>
               	fsub	d2, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d0, d0
               	b.gt	<addr>
               	fcmp	d0, d0
               	b.ne	<addr>
               	fcmp	d0, d0
               	b.eq	<addr>
               	fsub	d0, d0, d0
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.00000000
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #3.00000000
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.00000000
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	fmov	d1, #16.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #1.00000000
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #5.00000000
               	fmov	s1, #3.00000000
               	fcvt	d0, s0
               	fcvt	d1, s1
               	fcmp	d0, d1
               	b.gt	<addr>
               	fcmp	d0, d0
               	b.ne	<addr>
               	fcmp	d1, d1
               	b.eq	<addr>
               	fsub	d0, d0, d1
               	fcvt	s0, d0
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	movi	d0, #0000000000000000
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
               	movi	d2, #0000000000000000
               	b	<addr>
               	movi	d2, #0000000000000000
               	b	<addr>
