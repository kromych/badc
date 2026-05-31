
int_to_float_assign_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400408 <.text+0x148>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
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
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400878 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x15, x29, #0x8
               	mov	x14, #0xa               // =10
               	strb	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x15, x13, #0x1
               	mov	x13, #0x64              // =100
               	strb	w13, [x15]
               	sub	x12, x29, #0x8
               	add	x13, x12, #0x2
               	mov	x12, #0xc8              // =200
               	strb	w12, [x13]
               	sub	x15, x29, #0x8
               	ldrb	w12, [x15]
               	scvtf	d7, x12
               	sub	x12, x29, #0x10
               	fcvt	s0, d7
               	str	s0, [x12]
               	sub	x12, x29, #0x8
               	add	x15, x12, #0x1
               	ldrb	w12, [x15]
               	scvtf	d6, x12
               	sub	x12, x29, #0x18
               	fcvt	s0, d6
               	str	s0, [x12]
               	sub	x12, x29, #0x8
               	add	x15, x12, #0x2
               	ldrb	w12, [x15]
               	scvtf	d7, x12
               	sub	x12, x29, #0x20
               	fcvt	s0, d7
               	str	s0, [x12]
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	scvtf	d7, x14
               	fmul	d5, d6, d7
               	fcvtzs	x14, d5
               	cmp	x14, #0x64
               	b.eq	0x4004d4 <.text+0x214>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	s5, [x16]
               	fcvt	d5, s5
               	mov	x14, #0xa               // =10
               	scvtf	d7, x14
               	fmul	d6, d5, d7
               	fcvtzs	x14, d6
               	cmp	x14, #0x3e8
               	b.eq	0x400514 <.text+0x254>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x14, #0xa               // =10
               	scvtf	d7, x14
               	fmul	d5, d6, d7
               	fcvtzs	x14, d5
               	cmp	x14, #0x7d0
               	b.eq	0x400554 <.text+0x294>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x28
               	sub	x14, x29, #0x8
               	add	x15, x14, #0x1
               	ldrb	w14, [x15]
               	scvtf	d5, x14
               	fcvt	s0, d5
               	str	s0, [x12]
               	sub	x16, x29, #0x28
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x12, #0x64              // =100
               	scvtf	d5, x12
               	fmul	d6, d7, d5
               	fcvtzs	x12, d6
               	mov	x17, #0x2710            // =10000
               	cmp	x12, x17
               	b.eq	0x4005b4 <.text+0x2f4>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x4189            // =16777
               	movk	x14, #0xe560, lsl #16
               	movk	x14, #0x22d0, lsl #32
               	movk	x14, #0x3fd3, lsl #48
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fmov	d0, x14
               	fmul	d5, d0, d6
               	mov	x14, #0x1062            // =4194
               	movk	x14, #0x3958, lsl #16
               	movk	x14, #0xc8b4, lsl #32
               	movk	x14, #0x3fe2, lsl #48
               	sub	x16, x29, #0x18
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fmov	d0, x14
               	fmul	d7, d0, d6
               	fadd	d6, d5, d7
               	mov	x14, #0x76c9            // =30409
               	movk	x14, #0x9fbe, lsl #16
               	movk	x14, #0x2f1a, lsl #32
               	movk	x14, #0x3fbd, lsl #48
               	sub	x16, x29, #0x20
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fmov	d0, x14
               	fmul	d5, d0, d7
               	fadd	d7, d6, d5
               	mov	x14, #0x4060000000000000 // =4638707616191610880
               	fmov	d1, x14
               	fsub	d5, d7, d1
               	sub	x14, x29, #0x30
               	fcvt	s0, d5
               	str	s0, [x14]
               	sub	x16, x29, #0x30
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x14, #0x800000000000    // =140737488355328
               	movk	x14, #0x4045, lsl #48
               	fmov	d0, x14
               	fneg	d5, d0
               	fcmp	d7, d5
               	cset	x14, gt
               	stur	x14, [x29, #-0x50]
               	cbnz	x14, 0x400694 <.text+0x3d4>
               	sub	x16, x29, #0x30
               	ldr	s5, [x16]
               	fcvt	d5, s5
               	mov	x14, #0x4046000000000000 // =4631389266797133824
               	fmov	d0, x14
               	fneg	d7, d0
               	fcmp	d5, d7
               	cset	x14, mi
               	stur	x14, [x29, #-0x50]
               	b	0x400694 <.text+0x3d4>
               	ldur	x14, [x29, #-0x50]
               	cbz	x14, 0x4006b8 <.text+0x3f8>
               	mov	x12, #0x5               // =5
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x7               // =7
               	sxtw	x12, w14
               	scvtf	d7, x12
               	sub	x12, x29, #0x40
               	fcvt	s0, d7
               	str	s0, [x12]
               	sub	x16, x29, #0x40
               	ldr	s5, [x16]
               	fcvt	d5, s5
               	mov	x12, #0x401c000000000000 // =4619567317775286272
               	fmov	d1, x12
               	fcmp	d5, d1
               	cset	x14, ne
               	cbz	x14, 0x40070c <.text+0x44c>
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400884 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
