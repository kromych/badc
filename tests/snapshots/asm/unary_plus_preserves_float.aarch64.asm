
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
               	fmov	d1, #1.50000000
               	fmov	d0, #0.50000000
               	fadd	d2, d1, d0
               	fmov	d3, #2.00000000
               	fcmp	d2, d3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	movi	d2, #0000000000000000
               	fcmp	d1, d2
               	b.pl	<addr>
               	fneg	d4, d0
               	fcmp	d4, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fadd	d4, d1, d4
               	fcmp	d4, d3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	d1, d2
               	b.pl	<addr>
               	fneg	d4, d0
               	fadd	d4, d1, d4
               	fcmp	d4, d3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fcmp	d1, d2
               	b.pl	<addr>
               	fneg	d4, d0
               	fadd	d4, d1, d4
               	fcvtzs	x0, d4
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fcmp	d1, d2
               	b.pl	<addr>
               	fneg	d4, d0
               	fadd	d4, d1, d4
               	fcvtzs	x0, d4
               	scvtf	d4, x0
               	fcmp	d4, d3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fneg	d1, d1
               	fcmp	d1, d2
               	b.pl	<addr>
               	fneg	d0, d0
               	fadd	d0, d1, d0
               	fcvtzs	x0, d0
               	scvtf	d0, x0
               	fmov	d1, #2.00000000
               	fneg	d1, d1
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	fmov	d0, #0.50000000
               	b	<addr>
               	fmov	d4, #0.50000000
               	b	<addr>
               	fmov	d4, #0.50000000
               	b	<addr>
               	fmov	d4, #0.50000000
               	b	<addr>
               	fmov	d4, #0.50000000
               	b	<addr>
