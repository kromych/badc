
unary_plus_init_and_param_shadow.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x1, #0x6666             // =26214
               	movk	x1, #0x6666, lsl #16
               	movk	x1, #0x6666, lsl #32
               	movk	x1, #0x3fe6, lsl #48
               	fmov	d16, x1
               	fneg	d1, d16
               	fsub	d0, d0, d1
               	mov	x1, #0xa9fc             // =43516
               	movk	x1, #0xd2f1, lsl #16
               	movk	x1, #0x624d, lsl #32
               	movk	x1, #0x3f50, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x2, mi
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x1, #0xa9fc             // =43516
               	movk	x1, #0xd2f1, lsl #16
               	movk	x1, #0x624d, lsl #32
               	movk	x1, #0x3f50, lsl #48
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, gt
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	d0, [x0, #0x8]
               	mov	x1, #0x6666             // =26214
               	movk	x1, #0x6666, lsl #16
               	movk	x1, #0x6666, lsl #32
               	movk	x1, #0x3fe6, lsl #48
               	fmov	d17, x1
               	fsub	d0, d0, d17
               	mov	x1, #0xa9fc             // =43516
               	movk	x1, #0xd2f1, lsl #16
               	movk	x1, #0x624d, lsl #32
               	movk	x1, #0x3f50, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x2, mi
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x1, #0xa9fc             // =43516
               	movk	x1, #0xd2f1, lsl #16
               	movk	x1, #0x624d, lsl #32
               	movk	x1, #0x3f50, lsl #48
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, gt
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	d0, [x0, #0x10]
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x1
               	fsub	d0, d0, d17
               	mov	x1, #0xa9fc             // =43516
               	movk	x1, #0xd2f1, lsl #16
               	movk	x1, #0x624d, lsl #32
               	movk	x1, #0x3f50, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x2, mi
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x1, #0xa9fc             // =43516
               	movk	x1, #0xd2f1, lsl #16
               	movk	x1, #0x624d, lsl #32
               	movk	x1, #0x3f50, lsl #48
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, gt
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d0, [x0, #0x18]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fneg	d1, d16
               	fsub	d0, d0, d1
               	mov	x0, #0xa9fc             // =43516
               	movk	x0, #0xd2f1, lsl #16
               	movk	x0, #0x624d, lsl #32
               	movk	x0, #0x3f50, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, mi
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0xa9fc             // =43516
               	movk	x0, #0xd2f1, lsl #16
               	movk	x0, #0x624d, lsl #32
               	movk	x0, #0x3f50, lsl #48
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
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
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
