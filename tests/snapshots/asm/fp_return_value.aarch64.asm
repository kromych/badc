
fp_return_value.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x7                // =7
               	scvtf	d1, x0
               	fmov	d0, #0.50000000
               	fadd	d1, d1, d0
               	mov	x0, #0x2                // =2
               	scvtf	d2, x0
               	fadd	d2, d2, d0
               	fadd	d1, d1, d2
               	fmov	d2, #10.00000000
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x3                // =3
               	scvtf	s2, x1
               	fmov	s1, #4.00000000
               	fdiv	s2, s2, s1
               	mov	x2, #0x5                // =5
               	scvtf	s3, x2
               	fdiv	s3, s3, s1
               	fadd	s2, s2, s3
               	fmov	s3, #2.00000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	ret
               	mov	x0, #0x1                // =1
               	scvtf	d2, x0
               	fadd	d0, d2, d0
               	fmov	d2, #2.00000000
               	mov	x0, #0x6                // =6
               	scvtf	s3, x0
               	fdiv	s1, s3, s1
               	fcvt	d1, s1
               	fmadd	d0, d0, d2, d1
               	fmov	d1, #4.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, x1
               	ret
               	mov	x0, #0x0                // =0
               	ret
