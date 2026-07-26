
win64_xmm_scratch_callee_save.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x4, #0x4008000000000000 // =4613937818241073152
               	mov	x5, #0x4010000000000000 // =4616189618054758400
               	mov	x2, #0x4014000000000000 // =4617315517961601024
               	mov	x3, #0x4018000000000000 // =4618441417868443648
               	fmov	d16, x4
               	fmov	d17, x5
               	fmul	d0, d16, d17
               	fmov	d16, x0
               	fmov	d17, x1
               	fmadd	d0, d16, d17, d0
               	fmov	d16, x2
               	fmov	d17, x3
               	fmadd	d0, d16, d17, d0
               	fcvtzs	x2, d0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fmov	d18, x0
               	fmadd	d0, d0, d17, d18
               	fcvtzs	x0, d0
               	sxtw	x1, w2
               	cmp	x1, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	sxtw	x0, w0
               	cmp	x0, #0x59
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fmul	d0, d16, d17
               	fmov	d16, x1
               	fmov	d17, x2
               	fmadd	d0, d16, d17, d0
               	fmov	d16, x0
               	fmov	d17, x0
               	fmadd	d0, d16, d17, d0
               	fcvtzs	x2, d0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fmov	d18, x1
               	fmadd	d0, d0, d17, d18
               	fcvtzs	x0, d0
               	sxtw	x1, w2
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	sxtw	x0, w0
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
