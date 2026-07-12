
math_compare_macros.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x8
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<isnan>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, eq
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	d8, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d8, d16, d17
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x1, gt
               	cbz	x1, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, ge
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ge
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ge
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x1, mi
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, mi
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, mi
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, ls
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ls
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ls
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x1, mi
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, mi
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x1, mi
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	fmov	d0, d8
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
