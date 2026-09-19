
fp_const_fold_cast.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #6.00000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s0, #-3.00000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s0, w16
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d0, #6.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d0, #-3.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s0, w16
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16]
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x4]
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	fmov	s0, #2.00000000
               	fmov	s1, #3.00000000
               	fmul	s1, s1, s0
               	fmov	s2, #5.00000000
               	fmul	s2, s2, s0
               	fmadd	s0, s1, s0, s2
               	fmov	s1, #7.00000000
               	fadd	s0, s0, s1
               	fmov	s1, #29.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
