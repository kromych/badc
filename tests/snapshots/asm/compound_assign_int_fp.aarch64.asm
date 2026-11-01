
compound_assign_int_fp.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #10.00000000
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fadd	d1, d0, d1
               	fcvtzs	x0, d1
               	cmp	x0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d1, #2.50000000
               	fsub	d2, d0, d1
               	fcvtzs	x0, d2
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmul	d0, d0, d1
               	fcvtzs	x0, d0
               	cmp	x0, #0x19
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d0, x16
               	fmov	d1, #3.00000000
               	fdiv	d2, d0, d1
               	fcvtzs	x0, d2
               	cmp	x0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	s2, #7.00000000
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x18]
               	fadd	s2, s2, s3
               	fcvtzs	x0, s2
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d2, #-10.00000000
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x8]
               	fadd	d2, d2, d3
               	fcvtzs	x0, d2
               	cmp	x0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d2, #5.00000000
               	fmov	d3, #3.50000000
               	fmul	d2, d2, d3
               	fcvtzu	x0, d2
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x10]
               	fadd	d2, d0, d2
               	fcvtzs	x0, d2
               	sxth	x0, w0
               	cmp	w0, #0x96
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	fmov	d2, #1.00000000
               	fdiv	d2, d2, d1
               	fadd	d0, d0, d2
               	fcvtzs	x0, d0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fmov	d0, #1.50000000
               	fadd	d0, d0, d1
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	fmov	d1, #9.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x0                // =0
               	ret
