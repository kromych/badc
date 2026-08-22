
unary_plus_init_and_param_shadow.aarch64:	file format elf64-littleaarch64

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

<f>:
               	sxtw	x0, w0
               	ret

<main>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	d0, [x2]
               	mov	x4, #0x6666             // =26214
               	movk	x4, #0x6666, lsl #16
               	movk	x4, #0x6666, lsl #32
               	movk	x4, #0x3fe6, lsl #48
               	fmov	d16, x4
               	fneg	d1, d16
               	fsub	d0, d0, d1
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
               	ldr	d0, [x2, #0x8]
               	fmov	d17, x4
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
               	ldr	d0, [x2, #0x10]
               	mov	x3, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x3
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
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d0, [x2, #0x18]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	fneg	d1, d16
               	fsub	d0, d0, d1
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, gt
               	sxtw	x0, w1
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
