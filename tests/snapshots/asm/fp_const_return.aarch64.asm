
fp_const_return.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x3, x1
               	sxtw	x3, w3
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	b	<addr>
               	lsl	x4, x1, #3
               	add	x4, x2, x4
               	ldr	d0, [x4]
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, x3
               	b.lt	<addr>
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ret_zero>:
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	ret

<ret_one>:
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	ret

<ret_half>:
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x0
               	ret

<ret_quarter_f>:
               	mov	x0, #0x3e800000         // =1048576000
               	fmov	d0, x0
               	ret

<sum_zero>:
               	mov	x2, x0
               	sxtw	x1, w1
               	sxtw	x3, w1
               	cmp	x3, #0x0
               	cset	x0, gt
               	cbz	x0, <addr>
               	sub	x0, x1, #0x1
               	sxtw	x0, w0
               	ldr	x0, [x2, x0, lsl #3]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x1, x3, #0x1
               	b	<addr>
               	b	<addr>
               	cmp	x3, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	ret
               	sub	x0, x1, #0x1
               	sxtw	x0, w0
               	ldr	x0, [x2, x0, lsl #3]
               	scvtf	d0, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0x3e800000         // =1048576000
               	fmov	s16, w0
               	fcvt	d0, s16
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	sub	x0, x29, #0x50
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
