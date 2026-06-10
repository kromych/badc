
fp_return_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	sxtw	x0, w0
               	scvtf	d0, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	ret
               	sxtw	x0, w0
               	scvtf	d0, x0
               	fcvt	s0, d0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	fcvt	s0, d0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
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
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	scvtf	d0, x0
               	fcvt	s0, d0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	fcvt	s0, d0
               	mov	x0, #0x5                // =5
               	scvtf	d1, x0
               	fcvt	s1, d1
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fcvt	d1, s1
               	fmov	d17, x0
               	fdiv	d1, d1, d17
               	fcvt	s1, d1
               	fadd	s0, s0, s1
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	scvtf	d0, x0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x6                // =6
               	scvtf	d1, x1
               	fcvt	s1, d1
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fcvt	d1, s1
               	fmov	d17, x1
               	fdiv	d1, d1, d17
               	fcvt	s1, d1
               	fcvt	d1, s1
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	mov	x0, #0x4012000000000000 // =4616752568008179712
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
