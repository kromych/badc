
compound_assign_float_register_resident.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x42c80000         // =1120403456
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s16, w0
               	sub	x17, x29, #0x10
               	str	s16, [x17]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fsub	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x10
               	ldr	s1, [x16]
               	fadd	s0, s0, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fcvt	d0, s1
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	sub	x17, x29, #0x10
               	str	s0, [x17]
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.lt	<addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x42f00000         // =1123024896
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	mov	x0, #0x41100000         // =1091567616
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s16, w0
               	sub	x17, x29, #0x20
               	str	s16, [x17]
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	mov	x1, #-0x4010000000000000 // =-4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	sub	x17, x29, #0x20
               	str	s0, [x17]
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s16, w0
               	sub	x17, x29, #0x28
               	str	s16, [x17]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	fcvt	s0, d0
               	sub	x17, x29, #0x28
               	str	s0, [x17]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fdiv	s0, s0, s17
               	sub	x17, x29, #0x28
               	str	s0, [x17]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
