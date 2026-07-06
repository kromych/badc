
fma_contraction.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
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
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmadd	d0, d16, d17, d18
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fnmsub	d0, d16, d17, d18
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmsub	d0, d16, d17, d18
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x40000000         // =1073741824
               	mov	x1, #0x40400000         // =1077936128
               	mov	x2, #0x40800000         // =1082130432
               	fmov	s16, w0
               	fmov	s17, w1
               	fmov	s18, w2
               	fmadd	s0, s16, s17, s18
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x40000000         // =1073741824
               	mov	x1, #0x40400000         // =1077936128
               	mov	x2, #0x40800000         // =1082130432
               	fmov	s16, w0
               	fmov	s17, w1
               	fmov	s18, w2
               	fnmsub	s0, s16, s17, s18
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x40000000         // =1073741824
               	mov	x1, #0x40400000         // =1077936128
               	mov	x2, #0x40800000         // =1082130432
               	fmov	s16, w0
               	fmov	s17, w1
               	fmov	s18, w2
               	fmsub	s0, s16, s17, s18
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x3fd0000000000000 // =4598175219545276416
               	mov	x2, #0x3fc0000000000000 // =4593671619917905920
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmadd	d0, d16, d17, d18
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x3f000000         // =1056964608
               	mov	x1, #0x3e800000         // =1048576000
               	mov	x2, #0x3e000000         // =1040187392
               	fmov	s16, w0
               	fmov	s17, w1
               	fmov	s18, w2
               	fmadd	s0, s16, s17, s18
               	fmov	s17, w1
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmadd	d0, d16, d17, d18
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x3fd0000000000000 // =4598175219545276416
               	mov	x2, #0x3fc0000000000000 // =4593671619917905920
               	fmov	d16, x0
               	fmov	d17, x1
               	fmov	d18, x2
               	fmadd	d0, d16, d17, d18
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x40000000         // =1073741824
               	mov	x1, #0x40400000         // =1077936128
               	mov	x2, #0x40800000         // =1082130432
               	fmov	s16, w0
               	fmov	s17, w1
               	fmov	s18, w2
               	fmadd	s0, s16, s17, s18
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x2                // =2
               	scvtf	d0, x0
               	mov	x0, #0x3                // =3
               	scvtf	d1, x0
               	mov	x0, #0x4                // =4
               	scvtf	d2, x0
               	fmadd	d0, d0, d1, d2
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
