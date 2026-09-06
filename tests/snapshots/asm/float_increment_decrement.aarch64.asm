
float_increment_decrement.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x3fc00000         // =1069547520
               	fmov	s16, w0
               	sub	x17, x29, #0x28
               	str	s16, [x17]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fcvt	d1, s0
               	fmov	d17, x1
               	fadd	d1, d1, d17
               	fcvt	s1, d1
               	sub	x17, x29, #0x28
               	str	s1, [x17]
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.ne	<addr>
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x2, #0x40200000         // =1075838976
               	fmov	s17, w2
               	fcmp	s0, s17
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s16, w0
               	sub	x17, x29, #0x28
               	str	s16, [x17]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	sub	x17, x29, #0x28
               	str	s0, [x17]
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.ne	<addr>
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	fmov	s17, w2
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	fmov	d16, x0
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x3, #-0x4010000000000000 // =-4616189618054758400
               	fmov	d17, x3
               	fadd	d1, d0, d17
               	sub	x17, x29, #0x28
               	str	d1, [x17]
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x4, #0x4002000000000000 // =4612248968380809216
               	fmov	d17, x4
               	fcmp	d0, d17
               	cset	x5, ne
               	cbz	x5, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	fmov	d17, x3
               	fadd	d0, d0, d17
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	fmov	d17, x4
               	fcmp	d0, d17
               	b.ne	<addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	fmov	d17, x4
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	sub	x0, x29, #0x8
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x0]
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x0
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x0]
               	ldr	d0, [x0, #0x8]
               	fmov	d17, x3
               	fadd	d0, d0, d17
               	str	d0, [x0, #0x8]
               	ldr	s0, [x0]
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0]
               	ldr	d0, [x0]
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0]
               	ldr	d0, [x0]
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	ldr	d0, [x0, #0x8]
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0, #0x8]
               	ldr	d0, [x0, #0x10]
               	fmov	d17, x3
               	fadd	d0, d0, d17
               	str	d0, [x0, #0x10]
               	ldr	d0, [x0, #0x8]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x0, #0x10]
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4b800000         // =1266679808
               	fmov	s16, w0
               	sub	x17, x29, #0x20
               	str	s16, [x17]
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	sub	x17, x29, #0x20
               	str	s0, [x17]
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
