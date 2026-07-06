
ternary_arith_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x2, #0x1                // =1
               	scvtf	d0, x2
               	sub	x17, x29, #0x20
               	str	d0, [x17]
               	b	<addr>
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	sub	x17, x29, #0x20
               	str	d16, [x17]
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x2, #0x1                // =1
               	scvtf	d0, x2
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	b	<addr>
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x2
               	sub	x17, x29, #0x30
               	str	d16, [x17]
               	b	<addr>
               	mov	x2, #0x2                // =2
               	scvtf	d0, x2
               	sub	x17, x29, #0x30
               	str	d0, [x17]
               	sub	x16, x29, #0x30
               	ldr	d0, [x16]
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x2
               	sub	x17, x29, #0x38
               	str	d16, [x17]
               	b	<addr>
               	mov	x2, #0x2                // =2
               	scvtf	d0, x2
               	sub	x17, x29, #0x38
               	str	d0, [x17]
               	sub	x16, x29, #0x38
               	ldr	d0, [x16]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3f800000         // =1065353216
               	fmov	s16, w2
               	fcvt	d0, s16
               	sub	x17, x29, #0x40
               	str	d0, [x17]
               	b	<addr>
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	sub	x17, x29, #0x40
               	str	d16, [x17]
               	sub	x16, x29, #0x40
               	ldr	d0, [x16]
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x2, #0x3f800000         // =1065353216
               	fmov	s16, w2
               	fcvt	d0, s16
               	sub	x17, x29, #0x48
               	str	d0, [x17]
               	b	<addr>
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	sub	x17, x29, #0x48
               	str	d16, [x17]
               	sub	x16, x29, #0x48
               	ldr	d0, [x16]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3f800000         // =1065353216
               	fmov	s16, w2
               	sub	x17, x29, #0x50
               	str	s16, [x17]
               	b	<addr>
               	mov	x2, #0x2                // =2
               	scvtf	d0, x2
               	fcvt	s0, d0
               	sub	x17, x29, #0x50
               	str	s0, [x17]
               	sub	x16, x29, #0x50
               	ldr	s0, [x16]
               	mov	x2, #0x3f800000         // =1065353216
               	fmov	s17, w2
               	fcmp	s0, s17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x2, #0x3f800000         // =1065353216
               	fmov	s16, w2
               	sub	x17, x29, #0x58
               	str	s16, [x17]
               	b	<addr>
               	mov	x2, #0x2                // =2
               	scvtf	d0, x2
               	fcvt	s0, d0
               	sub	x17, x29, #0x58
               	str	s0, [x17]
               	sub	x16, x29, #0x58
               	ldr	s0, [x16]
               	mov	x2, #0x40000000         // =1073741824
               	fmov	s17, w2
               	fcmp	s0, s17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xa                // =10
               	b	<addr>
               	mov	x2, #0x14               // =20
               	cmp	x2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x2                // =2
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
