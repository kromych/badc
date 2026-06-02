
int_to_float_assign_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0x100
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	mov	x14, #0xa               // =10
               	strb	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x1
               	mov	x15, #0x64              // =100
               	strb	w15, [x13]
               	sub	x12, x29, #0x8
               	add	x12, x12, #0x2
               	mov	x15, #0xc8              // =200
               	strb	w15, [x12]
               	sub	x13, x29, #0x8
               	ldrb	w13, [x13]
               	scvtf	d7, x13
               	sub	x13, x29, #0x10
               	fcvt	s0, d7
               	str	s0, [x13]
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x1
               	ldrb	w13, [x13]
               	scvtf	d6, x13
               	sub	x13, x29, #0x18
               	fcvt	s0, d6
               	str	s0, [x13]
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x2
               	ldrb	w13, [x13]
               	scvtf	d7, x13
               	sub	x13, x29, #0x20
               	fcvt	s0, d7
               	str	s0, [x13]
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	scvtf	d7, x14
               	fmul	d6, d6, d7
               	fcvtzs	x14, d6
               	cmp	x14, #0x64
               	b.eq	<addr>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x13, #0xa               // =10
               	scvtf	d7, x13
               	fmul	d6, d6, d7
               	fcvtzs	x13, d6
               	cmp	x13, #0x3e8
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x14, #0xa               // =10
               	scvtf	d7, x14
               	fmul	d6, d6, d7
               	fcvtzs	x14, d6
               	cmp	x14, #0x7d0
               	b.eq	<addr>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x28
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x1
               	ldrb	w13, [x13]
               	scvtf	d6, x13
               	fcvt	s0, d6
               	str	s0, [x14]
               	sub	x16, x29, #0x28
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x14, #0x64              // =100
               	scvtf	d6, x14
               	fmul	d7, d7, d6
               	fcvtzs	x14, d7
               	mov	x17, #0x2710            // =10000
               	cmp	x14, x17
               	b.eq	<addr>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x4189            // =16777
               	movk	x14, #0xe560, lsl #16
               	movk	x14, #0x22d0, lsl #32
               	movk	x14, #0x3fd3, lsl #48
               	sub	x16, x29, #0x10
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fmov	d0, x14
               	fmul	d6, d0, d7
               	mov	x14, #0x1062            // =4194
               	movk	x14, #0x3958, lsl #16
               	movk	x14, #0xc8b4, lsl #32
               	movk	x14, #0x3fe2, lsl #48
               	sub	x16, x29, #0x18
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fmov	d0, x14
               	fmul	d5, d0, d7
               	fadd	d6, d6, d5
               	mov	x14, #0x76c9            // =30409
               	movk	x14, #0x9fbe, lsl #16
               	movk	x14, #0x2f1a, lsl #32
               	movk	x14, #0x3fbd, lsl #48
               	sub	x16, x29, #0x20
               	ldr	s5, [x16]
               	fcvt	d5, s5
               	fmov	d0, x14
               	fmul	d7, d0, d5
               	fadd	d6, d6, d7
               	mov	x14, #0x4060000000000000 // =4638707616191610880
               	fmov	d1, x14
               	fsub	d6, d6, d1
               	sub	x14, x29, #0x30
               	fcvt	s0, d6
               	str	s0, [x14]
               	sub	x16, x29, #0x30
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x14, #0x800000000000    // =140737488355328
               	movk	x14, #0x4045, lsl #48
               	fmov	d0, x14
               	fneg	d6, d0
               	fcmp	d7, d6
               	cset	x14, gt
               	stur	x14, [x29, #-0x50]
               	cbnz	x14, <addr>
               	sub	x16, x29, #0x30
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x14, #0x4046000000000000 // =4631389266797133824
               	fmov	d0, x14
               	fneg	d7, d0
               	fcmp	d6, d7
               	cset	x14, mi
               	stur	x14, [x29, #-0x50]
               	b	<addr>
               	ldur	x14, [x29, #-0x50]
               	cbz	x14, <addr>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x7               // =7
               	scvtf	d7, x14
               	sub	x14, x29, #0x40
               	fcvt	s0, d7
               	str	s0, [x14]
               	sub	x16, x29, #0x40
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x14, #0x401c000000000000 // =4619567317775286272
               	fmov	d1, x14
               	fcmp	d6, d1
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
