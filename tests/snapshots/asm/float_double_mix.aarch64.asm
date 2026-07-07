
float_double_mix.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3fc9, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcvt	d0, s0
               	fadd	d0, d0, d1
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x34cc, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x3fd3, lsl #48
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d0, d0
               	mov	x0, #0x5616             // =22038
               	movk	x0, #0x9ee7, lsl #16
               	movk	x0, #0x3af, lsl #32
               	movk	x0, #0x3cd2, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
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

<widen_preserves_float_value>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	mov	x0, #0xa0000000         // =2684354560
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3fb9, lsl #48
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d0, d0
               	mov	x0, #0xd497             // =54423
               	movk	x0, #0x4646, lsl #16
               	movk	x0, #0xef5, lsl #32
               	movk	x0, #0x3c67, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<narrow_drops_precision>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0xf62e             // =63022
               	movk	x0, #0x3746, lsl #16
               	movk	x0, #0x9add, lsl #32
               	movk	x0, #0x3fbf, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fcvt	s1, d0
               	mov	x0, #0xd6ea             // =55018
               	movk	x0, #0x3dfc, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x18
               	str	s16, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	fsub	s0, s1, s0
               	mov	x0, #0x0                // =0
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	s0, s0
               	mov	x0, #0xcc77             // =52343
               	movk	x0, #0x322b, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvt	d0, s1
               	sub	x16, x29, #0x8
               	ldr	d1, [x16]
               	fsub	d0, d0, d1
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<assign_double_to_float_narrows>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fmov	d17, x1
               	fdiv	d0, d16, d17
               	fcvt	s0, d0
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0x3eaa, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x18
               	str	s16, [x17]
               	sub	x16, x29, #0x18
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
               	mov	x0, #0x5                // =5
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
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
