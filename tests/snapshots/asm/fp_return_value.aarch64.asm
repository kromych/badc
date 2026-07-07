
fp_return_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	scvtf	d0, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	ret

<make_float>:
               	sxtw	x0, w0
               	scvtf	s0, x0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s0, s0, s17
               	ret

<main>:
               	mov	x0, #0x7                // =7
               	scvtf	d0, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	mov	x0, #0x2                // =2
               	scvtf	d1, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d1, d1, d17
               	fadd	d0, d0, d1
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x3                // =3
               	scvtf	s0, x0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s0, s0, s17
               	mov	x0, #0x5                // =5
               	scvtf	s1, x0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fdiv	s1, s1, s17
               	fadd	s0, s0, s1
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x1                // =1
               	scvtf	d0, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x6                // =6
               	scvtf	s1, x1
               	mov	x1, #0x40800000         // =1082130432
               	fmov	s17, w1
               	fdiv	s1, s1, s17
               	fcvt	d1, s1
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	mov	x0, #0x4012000000000000 // =4616752568008179712
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
