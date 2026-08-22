
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
               	scvtf	d0, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	mov	x2, #0x2                // =2
               	scvtf	d1, x2
               	fmov	d17, x0
               	fadd	d1, d1, d17
               	fadd	d0, d0, d1
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x3, #0x3                // =3
               	scvtf	s0, x3
               	mov	x1, #0x40800000         // =1082130432
               	fmov	s17, w1
               	fdiv	s0, s0, s17
               	mov	x4, #0x5                // =5
               	scvtf	s1, x4
               	fmov	s17, w1
               	fdiv	s1, s1, s17
               	fadd	s0, s0, s1
               	mov	x4, #0x40000000         // =1073741824
               	fmov	s17, w4
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, x2
               	ret
               	mov	x2, #0x1                // =1
               	scvtf	d0, x2
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x6                // =6
               	scvtf	s1, x2
               	fmov	s17, w1
               	fdiv	s1, s1, s17
               	fcvt	d1, s1
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	mov	x0, #0x4012000000000000 // =4616752568008179712
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, x3
               	ret
               	mov	x0, #0x0                // =0
               	ret
