
fma_contraction.aarch64:	file format elf64-littleaarch64

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

<dmadd>:
               	fmadd	d0, d0, d1, d2
               	ret

<dmsub>:
               	fnmsub	d0, d0, d1, d2
               	ret

<dnmadd>:
               	fmsub	d0, d0, d1, d2
               	ret

<fmadd_>:
               	fmadd	s0, s0, s1, s2
               	ret

<fmsub_>:
               	fnmsub	s0, s0, s1, s2
               	ret

<fnmadd_>:
               	fmsub	s0, s0, s1, s2
               	ret

<main>:
               	fmov	d0, #2.00000000
               	fmov	d1, #3.00000000
               	fmov	d2, #4.00000000
               	fmadd	d3, d0, d1, d2
               	fmov	d4, #10.00000000
               	fcmp	d3, d4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fnmsub	d5, d0, d1, d2
               	fcmp	d5, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmsub	d0, d0, d1, d2
               	fmov	d1, #-2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s0, #2.00000000
               	fmov	s1, #3.00000000
               	fmov	s2, #4.00000000
               	fmadd	s5, s0, s1, s2
               	fmov	s6, #10.00000000
               	fcmp	s5, s6
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fnmsub	s7, s0, s1, s2
               	fcmp	s7, s0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmsub	s0, s0, s1, s2
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d1, #0.50000000
               	fmov	d0, #0.25000000
               	fmov	d2, #0.12500000
               	fmadd	d1, d1, d0, d2
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fmov	s7, #0.50000000
               	fmov	s2, #0.25000000
               	fmov	s19, #0.12500000
               	fmadd	s7, s7, s2, s19
               	fcmp	s7, s2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	fcmp	d3, d4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fcmp	s5, s6
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	d0, #10.00000000
               	fcmp	d3, d0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
