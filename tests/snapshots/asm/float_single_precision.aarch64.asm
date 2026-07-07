
float_single_precision.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x0, #0x3f800000         // =1065353216
               	mov	x1, #0x40400000         // =1077936128
               	fmov	s16, w0
               	fmov	s17, w1
               	fdiv	s0, s16, s17
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0x3eaa, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x10
               	str	s16, [x17]
               	sub	x16, x29, #0x10
               	ldr	s1, [x16]
               	fsub	s0, s0, s1
               	mov	x0, #0x0                // =0
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	s0, s0
               	mov	x0, #0xbf95             // =49045
               	movk	x0, #0x33d6, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<accumulation_rounds_in_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x3f80, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x18
               	str	s16, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x18
               	ldr	s1, [x16]
               	fsub	s0, s0, s1
               	mov	x0, #0x0                // =0
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	s0, s0
               	mov	x0, #0x37bd             // =14269
               	movk	x0, #0x3586, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<chained_mul_is_single_precision>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3f8c, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fmul	s1, s0, s0
               	fmul	s1, s1, s0
               	mov	x0, #0x67a2             // =26530
               	movk	x0, #0x3fbb, lsl #16
               	fmov	s18, w0
               	fnmsub	s0, s1, s0, s18
               	mov	x0, #0x0                // =0
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	s0, s0
               	mov	x0, #0xc5ac             // =50604
               	movk	x0, #0x3727, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
