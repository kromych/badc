
unary_plus_preserves_float.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #1.50000000
               	fmov	d1, #0.50000000
               	fadd	d3, d0, d1
               	fmov	d2, #2.00000000
               	fcmp	d3, d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d3, #-0.50000000
               	fcmp	d3, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fadd	d1, d0, d3
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d1, #-0.50000000
               	fadd	d1, d0, d1
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d1, #-0.50000000
               	fadd	d1, d0, d1
               	fcvtzs	x1, d1
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d1, #-0.50000000
               	fadd	d0, d0, d1
               	fcvtzs	x1, d0
               	scvtf	d0, x1
               	fcmp	d0, d2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d0, #-1.50000000
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d1, #-0.50000000
               	fadd	d0, d0, d1
               	fcvtzs	x1, d0
               	scvtf	d0, x1
               	fmov	d1, #-2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	ret
               	fmov	d1, #0.50000000
               	b	<addr>
               	fmov	d1, #0.50000000
               	b	<addr>
               	fmov	d1, #0.50000000
               	b	<addr>
               	fmov	d1, #0.50000000
               	b	<addr>
               	fmov	d3, #0.50000000
               	b	<addr>
