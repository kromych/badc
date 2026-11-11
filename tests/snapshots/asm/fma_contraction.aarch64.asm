
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
               	fmadd	d0, d0, d1, d2
               	fmov	d1, #10.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fmov	d3, #0.50000000
               	fmov	d2, #0.25000000
               	fmov	d4, #0.12500000
               	fmadd	d3, d3, d2, d4
               	fcmp	d3, d2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fmov	s2, #2.00000000
               	fmov	s3, #3.00000000
               	fmov	s4, #4.00000000
               	fmadd	s2, s2, s3, s4
               	fmov	s3, #10.00000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
