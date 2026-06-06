
two_d_stride_no_leak_across_exprs.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
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
               	add	x21, x21, #0xe8
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x100
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x106
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x10d
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrh	w0, [x0]
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x520
               	sub	x0, x29, #0x400
               	mov	x1, #0x7                // =7
               	strh	w1, [x0]
               	sub	x0, x29, #0x400
               	add	x0, x0, #0x2
               	mov	x1, #0xb                // =11
               	strh	w1, [x0]
               	sub	x0, x29, #0x400
               	ldrh	w0, [x0]
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x510
               	str	w0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x510
               	ldrsw	x0, [x16]
               	cmp	x0, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x510
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x508
               	sub	x16, x29, #0x510
               	ldrsw	x1, [x16]
               	lsl	x2, x1, #2
               	add	x0, x0, x2
               	scvtf	d0, x1
               	fcvt	s0, d0
               	mov	x1, #0x3fd0000000000000 // =4598175219545276416
               	fcvt	d0, s0
               	fmov	d17, x1
               	fmul	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x0]
               	b	<addr>
               	sub	x0, x29, #0x508
               	add	x0, x0, #0x20
               	ldr	s0, [x0]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x508
               	mov	x1, #0xc00000000000     // =211106232532992
               	movk	x1, #0x4058, lsl #48
               	fmov	d16, x1
               	fcvt	s0, d16
               	str	s0, [x0]
               	sub	x0, x29, #0x508
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
