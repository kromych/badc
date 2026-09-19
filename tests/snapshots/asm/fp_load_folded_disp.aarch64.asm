
fp_load_folded_disp.aarch64:	file format elf64-littleaarch64

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
               	fmov	s1, #1.25000000
               	fmov	d0, #2.50000000
               	fmov	s2, #4.75000000
               	fcmp	s1, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcmp	s2, s2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d1, #0.50000000
               	fadd	d0, d0, d1
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
