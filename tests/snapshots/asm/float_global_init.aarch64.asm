
float_global_init.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x2
               	fsub	d0, d0, d17
               	mov	x0, #0xa9fc             // =43516
               	movk	x0, #0xd2f1, lsl #16
               	movk	x0, #0x624d, lsl #32
               	movk	x0, #0x3f50, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	mov	x1, #0x0                // =0
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x3, gt
               	sxtw	x3, w3
               	cbnz	x3, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	s0, [x3]
               	fcvt	d0, s0
               	fmov	d17, x2
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x3, gt
               	sxtw	x3, w3
               	cbnz	x3, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	s0, [x3]
               	fcvt	d0, s0
               	mov	x3, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x3
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x4, gt
               	sxtw	x4, w4
               	cbnz	x4, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	s0, [x4]
               	fcvt	d0, s0
               	fmov	d17, x2
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x4, gt
               	sxtw	x4, w4
               	cbnz	x4, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	s0, [x4]
               	fcvt	d0, s0
               	fmov	d17, x2
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, gt
               	sxtw	x0, w1
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x0, #0xa9fc             // =43516
               	movk	x0, #0xd2f1, lsl #16
               	movk	x0, #0x624d, lsl #32
               	movk	x0, #0x3f50, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	mov	x1, #0x0                // =0
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x2, gt
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	d0, [x2]
               	fmov	d17, x3
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x2, gt
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	d0, [x2]
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x2
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, gt
               	sxtw	x0, w1
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
