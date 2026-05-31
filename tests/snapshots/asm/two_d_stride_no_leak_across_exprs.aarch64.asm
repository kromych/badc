
two_d_stride_no_leak_across_exprs.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, x0
               	ldrh	w0, [x15]
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x520
               	sub	x15, x29, #0x400
               	mov	x14, #0x7               // =7
               	strh	w14, [x15]
               	sub	x13, x29, #0x400
               	add	x13, x13, #0x2
               	mov	x14, #0xb               // =11
               	strh	w14, [x13]
               	sub	x15, x29, #0x400
               	ldrh	w15, [x15]
               	sxtw	x15, w15
               	cmp	x15, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x510
               	str	w15, [x17]
               	b	<addr>
               	sub	x16, x29, #0x510
               	ldrsw	x15, [x16]
               	cmp	x15, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x510
               	ldrsw	x15, [x0]
               	add	x15, x15, #0x1
               	str	w15, [x0]
               	b	<addr>
               	sub	x15, x29, #0x508
               	sub	x16, x29, #0x510
               	ldrsw	x13, [x16]
               	lsl	x0, x13, #2
               	add	x15, x15, x0
               	scvtf	d7, x13
               	mov	x13, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d1, x13
               	fmul	d7, d7, d1
               	fcvt	s0, d7
               	str	s0, [x15]
               	b	<addr>
               	sub	x15, x29, #0x508
               	add	x15, x15, #0x20
               	ldr	s6, [x15]
               	fcvt	d6, s6
               	mov	x15, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x15
               	fcmp	d6, d1
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x508
               	mov	x0, #0xc00000000000     // =211106232532992
               	movk	x0, #0x4058, lsl #48
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x13]
               	sub	x13, x29, #0x508
               	ldr	s6, [x13]
               	fcvt	d6, s6
               	fmov	d1, x0
               	fcmp	d6, d1
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
