
libc_math_nextafter.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x330              // =816
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x20
               	fmov	d1, x1
               	bl	<addr>
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x0                // =0
               	fmov	d0, x20
               	fmov	d1, x1
               	bl	<addr>
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x20
               	fmov	d1, x20
               	bl	<addr>
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fmov	d0, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d0, x0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s1, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x0
               	fcvt	s0, d16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
