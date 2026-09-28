
hfa_struct_return.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #7.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #0.25000000
               	fmov	d1, #0.50000000
               	fcmp	d0, d0
               	b.ne	<addr>
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d2, #1.00000000
               	fmov	d3, #2.00000000
               	fmov	d4, #3.00000000
               	fcmp	d2, d2
               	b.ne	<addr>
               	fcmp	d3, d3
               	b.ne	<addr>
               	fcmp	d4, d4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d2, #10.00000000
               	fmov	d3, #20.00000000
               	fmov	d4, #30.00000000
               	mov	x16, #0x4044000000000000 // =4630826316843712512
               	fmov	d5, x16
               	fcmp	d2, d2
               	b.ne	<addr>
               	fcmp	d3, d3
               	b.ne	<addr>
               	fcmp	d4, d4
               	b.ne	<addr>
               	fcmp	d5, d5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s6, #1.50000000
               	fmov	s7, #2.50000000
               	fcmp	s6, s6
               	b.ne	<addr>
               	fcmp	s7, s7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	fadd	d0, d0, d1
               	fmov	d1, #0.75000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fadd	d0, d2, d3
               	fadd	d0, d0, d4
               	fadd	d0, d0, d5
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	s0, [x0]
               	ldr	s1, [x0, #0x4]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0x8]
               	fadd	s0, s0, s1
               	ldr	s1, [x0, #0xc]
               	fadd	s0, s0, s1
               	fmov	s1, #10.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
