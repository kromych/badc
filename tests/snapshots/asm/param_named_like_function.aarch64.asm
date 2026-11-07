
param_named_like_function.aarch64:	file format elf64-littleaarch64

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

<gp>:
               	fmov	s1, #2.00000000
               	fmul	s0, s0, s1
               	fcvt	d0, s0
               	ret

<tfi>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	fmov	d0, #2.00000000
               	fmov	d1, #0.50000000
               	fadd	d2, d0, d1
               	fmov	d1, #2.50000000
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1]
               	cmp	w0, #0x62
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d2, #10.00000000
               	fmul	d1, d1, d2
               	fcvtzs	x0, d1
               	cmp	x0, #0x19
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d1, #3.00000000
               	fdiv	d0, d1, d0
               	fcvt	s0, d0
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #2.00000000
               	fmul	s0, s0, s0
               	fcvt	d0, s0
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
