
fp_const_return.aarch64:	file format elf64-littleaarch64

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

<sum_zero>:
               	mov	x2, x0
               	mov	x0, #0x8                // =8
               	sxtw	x3, w0
               	cmp	x3, #0x0
               	cset	x1, gt
               	cbz	x1, <addr>
               	sub	x1, x0, #0x1
               	sxtw	x1, w1
               	ldr	x1, [x2, x1, lsl #3]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	sub	x0, x3, #0x1
               	b	<addr>
               	b	<addr>
               	cbnz	x3, <addr>
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	ret
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	ldr	x0, [x2, x0, lsl #3]
               	scvtf	d0, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x3, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x40
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	str	x2, [x0, #0x10]
               	str	x2, [x0, #0x18]
               	str	x2, [x0, #0x20]
               	str	x2, [x0, #0x28]
               	str	x2, [x0, #0x30]
               	str	x2, [x0, #0x38]
               	fmov	d16, x2
               	sub	x17, x29, #0x58
               	str	d16, [x17]
               	mov	x0, x2
               	b	<addr>
               	lsl	x4, x1, #3
               	add	x4, x3, x4
               	ldr	d0, [x4]
               	sub	x17, x29, #0x58
               	str	d0, [x17]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x50
               	fmov	d16, x0
               	sub	x17, x29, #0x58
               	str	d16, [x17]
               	b	<addr>
               	lsl	x3, x1, #3
               	add	x3, x2, x3
               	ldr	d0, [x3]
               	sub	x17, x29, #0x58
               	str	d0, [x17]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x50
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x58
               	str	d16, [x17]
               	b	<addr>
               	lsl	x3, x1, #3
               	add	x3, x2, x3
               	ldr	d0, [x3]
               	sub	x17, x29, #0x58
               	str	d0, [x17]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x50
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x58
               	str	d16, [x17]
               	b	<addr>
               	lsl	x3, x1, #3
               	add	x3, x2, x3
               	ldr	d0, [x3]
               	sub	x17, x29, #0x58
               	str	d0, [x17]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	mov	x0, #0x3e800000         // =1048576000
               	fmov	s16, w0
               	fcvt	d0, s16
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x50
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x58
               	str	d16, [x17]
               	b	<addr>
               	lsl	x3, x1, #3
               	add	x3, x2, x3
               	ldr	d0, [x3]
               	sub	x17, x29, #0x58
               	str	d0, [x17]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
