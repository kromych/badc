
two_d_stride_no_leak_across_exprs.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003d8 <.text+0x158>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400698 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
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
               	sub	sp, sp, #0x530
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sub	x15, x29, #0x400
               	mov	x14, #0x7               // =7
               	strh	w14, [x15]
               	sub	x13, x29, #0x400
               	add	x13, x13, #0x2
               	mov	x14, #0xb               // =11
               	strh	w14, [x13]
               	sub	x20, x29, #0x400
               	mov	x0, x20
               	bl	0x4003cc <.text+0x14c>
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	0x40043c <.text+0x1bc>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x510
               	str	w0, [x17]
               	b	0x40044c <.text+0x1cc>
               	sub	x16, x29, #0x510
               	ldrsw	x0, [x16]
               	cmp	x0, #0x40
               	b.ge	0x4004a4 <.text+0x224>
               	b	0x400474 <.text+0x1f4>
               	sub	x20, x29, #0x510
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	b	0x40044c <.text+0x1cc>
               	sub	x0, x29, #0x508
               	sub	x16, x29, #0x510
               	ldrsw	x13, [x16]
               	lsl	x20, x13, #2
               	add	x0, x0, x20
               	scvtf	d7, x13
               	mov	x13, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d1, x13
               	fmul	d7, d7, d1
               	fcvt	s0, d7
               	str	s0, [x0]
               	b	0x400460 <.text+0x1e0>
               	sub	x0, x29, #0x508
               	add	x0, x0, #0x20
               	ldr	s6, [x0]
               	fcvt	d6, s6
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x0
               	fcmp	d6, d1
               	cset	x13, ne
               	cbz	x13, 0x4004e0 <.text+0x260>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x400
               	mov	x0, x21
               	bl	0x4003cc <.text+0x14c>
               	sub	x0, x29, #0x508
               	mov	x21, #0xc00000000000    // =211106232532992
               	movk	x21, #0x4058, lsl #48
               	fmov	d0, x21
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x0, x29, #0x508
               	ldr	s6, [x0]
               	fcvt	d6, s6
               	fmov	d1, x21
               	fcmp	d6, d1
               	cset	x0, ne
               	cbz	x0, 0x40053c <.text+0x2bc>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
