
int_to_float_assign_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x8
               	mov	x1, #0xa                // =10
               	strb	w1, [x0]
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x1
               	mov	x2, #0x64               // =100
               	strb	w2, [x0]
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x2
               	mov	x2, #0xc8               // =200
               	strb	w2, [x0]
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	scvtf	d0, x0
               	fcvt	s0, d0
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x1
               	ldrb	w0, [x0]
               	scvtf	d0, x0
               	fcvt	s0, d0
               	sub	x0, x29, #0x18
               	str	s0, [x0]
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x2
               	ldrb	w0, [x0]
               	scvtf	d0, x0
               	fcvt	s0, d0
               	sub	x0, x29, #0x20
               	str	s0, [x0]
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	scvtf	d1, x1
               	fcvt	s1, d1
               	fmul	s0, s0, s1
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	mov	x0, #0xa                // =10
               	scvtf	d1, x0
               	fcvt	s1, d1
               	fmul	s0, s0, s1
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	cmp	x0, #0x3e8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	mov	x0, #0xa                // =10
               	scvtf	d1, x0
               	fcvt	s1, d1
               	fmul	s0, s0, s1
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	cmp	x0, #0x7d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x8
               	add	x1, x1, #0x1
               	ldrb	w1, [x1]
               	scvtf	d0, x1
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x0, #0x64               // =100
               	scvtf	d1, x0
               	fcvt	s1, d1
               	fmul	s0, s0, s1
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	mov	x17, #0x2710            // =10000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4189             // =16777
               	movk	x0, #0xe560, lsl #16
               	movk	x0, #0x22d0, lsl #32
               	movk	x0, #0x3fd3, lsl #48
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	mov	x1, #0x1062             // =4194
               	movk	x1, #0x3958, lsl #16
               	movk	x1, #0xc8b4, lsl #32
               	movk	x1, #0x3fe2, lsl #48
               	sub	x16, x29, #0x18
               	ldr	s1, [x16]
               	fcvt	d1, s1
               	fmov	d16, x1
               	fmul	d1, d16, d1
               	fmov	d16, x0
               	fmadd	d0, d16, d0, d1
               	mov	x0, #0x76c9             // =30409
               	movk	x0, #0x9fbe, lsl #16
               	movk	x0, #0x2f1a, lsl #32
               	movk	x0, #0x3fbd, lsl #48
               	sub	x16, x29, #0x20
               	ldr	s1, [x16]
               	fcvt	d1, s1
               	fmov	d16, x0
               	fmadd	d0, d16, d1, d0
               	mov	x0, #0x4060000000000000 // =4638707616191610880
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	fcvt	s0, d0
               	sub	x0, x29, #0x30
               	str	s0, [x0]
               	sub	x16, x29, #0x30
               	ldr	s0, [x16]
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x4045, lsl #48
               	fmov	d16, x0
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x20, gt
               	cbnz	x20, <addr>
               	sub	x16, x29, #0x30
               	ldr	s0, [x16]
               	mov	x0, #0x4046000000000000 // =4631389266797133824
               	fmov	d16, x0
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x20, mi
               	b	<addr>
               	cbz	x20, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	d0, x0
               	fcvt	s0, d0
               	sub	x0, x29, #0x40
               	str	s0, [x0]
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x11c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
