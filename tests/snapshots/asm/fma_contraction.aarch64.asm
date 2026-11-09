
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
               	fmov	d0, #10.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d2, #2.00000000
               	fcmp	d2, d2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d1, #-2.00000000
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s3, #10.00000000
               	fcmp	s3, s3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	s4, #2.00000000
               	fcmp	s4, s4
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	s1, #-2.00000000
               	fcmp	s1, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d1, #0.25000000
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fmov	s5, #0.25000000
               	fcmp	s5, s5
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	fmov	d5, #3.00000000
               	fmov	d6, #4.00000000
               	fmadd	d2, d2, d5, d6
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fmov	d5, #0.50000000
               	fmov	d6, #0.12500000
               	fmadd	d5, d5, d1, d6
               	fcmp	d5, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fmov	s1, #3.00000000
               	fmov	s5, #4.00000000
               	fmadd	s1, s4, s1, s5
               	fcmp	s1, s3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
