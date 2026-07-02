
float_ternary_promote.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x0, w0
               	fmov	d2, d0
               	cbz	x0, <addr>
               	b	<addr>
               	fmov	d2, d1
               	fmov	d0, d2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	mov	x0, #0x1                // =1
               	mov	x20, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x1
               	fneg	d1, d16
               	fcvt	s1, d1
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x1
               	fcvt	s0, d16
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x1
               	fneg	d8, d16
               	fcvt	s1, d8
               	bl	<addr>
               	fcvt	d0, s0
               	fcmp	d0, d8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	fmov	d16, x0
               	fcvt	s2, d16
               	mov	x0, #0x0                // =0
               	fcvt	d0, s2
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	fmov	d0, d2
               	b	<addr>
               	fneg	s0, s2
               	mov	x0, #0x0                // =0
               	fcvt	d1, s2
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	s2, s2
               	b	<addr>
               	fadd	s0, s0, s2
               	mov	x0, #0x401a000000000000 // =4619004367821864960
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x38
               	str	d16, [x17]
               	b	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	b	<addr>
               	sub	x16, x29, #0x38
               	ldr	d0, [x16]
               	fcvt	s0, d0
               	mov	x0, #0x4034000000000000 // =4626322717216342016
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d16, x0
               	sub	x17, x29, #0x40
               	str	d16, [x17]
               	b	<addr>
               	mov	x0, #0x4034000000000000 // =4626322717216342016
               	fmov	d16, x0
               	sub	x17, x29, #0x40
               	str	d16, [x17]
               	sub	x16, x29, #0x40
               	ldr	d0, [x16]
               	sub	x17, x29, #0x38
               	str	d0, [x17]
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
