
fp_param_float_before_double.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ret

<pick_second>:
               	fcvt	d0, s1
               	ret

<sum4>:
               	fcvt	d0, s0
               	fadd	d0, d0, d1
               	fcvt	d1, s2
               	fadd	d0, d0, d1
               	fadd	d0, d0, d3
               	ret

<dbl_then_float>:
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fcvt	d1, s1
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	ret

<main>:
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x40d00000         // =1087373312
               	fmov	s16, w0
               	fcvt	d0, s16
               	fmov	s16, w0
               	fcvt	d1, s16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3f800000         // =1065353216
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x40400000         // =1077936128
               	mov	x3, #0x4010000000000000 // =4616189618054758400
               	fmov	s16, w0
               	fcvt	d0, s16
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fmov	s16, w2
               	fcvt	d1, s16
               	fadd	d0, d0, d1
               	fmov	d17, x3
               	fadd	d0, d0, d17
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	mov	x2, #0x40c00000         // =1086324736
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fmov	s16, w2
               	fcvt	d0, s16
               	fmov	d16, x0
               	fmov	d17, x1
               	fmadd	d0, d16, d17, d0
               	mov	x0, #0x404c000000000000 // =4633078116657397760
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
