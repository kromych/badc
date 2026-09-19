
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	mov	x2, #0x6666             // =26214
               	movk	x2, #0x6666, lsl #16
               	movk	x2, #0x6666, lsl #32
               	movk	x2, #0x3fe6, lsl #48
               	fmov	d16, x2
               	fneg	d1, d16
               	fsub	d1, d0, d1
               	mov	x0, #0xa9fc             // =43516
               	movk	x0, #0xd2f1, lsl #16
               	movk	x0, #0x624d, lsl #32
               	movk	x0, #0x3f50, lsl #48
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d0, d16
               	fcmp	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	d1, [x1, #0x8]
               	fmov	d17, x2
               	fsub	d1, d1, d17
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.pl	<addr>
               	fcmp	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	d1, [x1, #0x10]
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x2
               	fsub	d1, d1, d17
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.pl	<addr>
               	fcmp	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d1, [x1, #0x18]
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x1
               	fneg	d2, d16
               	fsub	d1, d1, d2
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.pl	<addr>
               	fcmp	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #-0x3              // =-3
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
