
fp_nan_unordered_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
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
               	add	x21, x21, #0xf8
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
               	add	x2, x2, #0x110
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x116
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x11d
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fdiv	d1, d0, d0
               	sub	x17, x29, #0x10
               	str	d1, [x17]
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x0
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fdiv	d0, d16, d0
               	sub	x17, x29, #0x20
               	str	d0, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	fcmp	d0, d0
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	fcmp	d0, d0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	fcmp	d0, d0
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	fcmp	d0, d0
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	fcmp	d0, d0
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	mov	x0, #0x759c             // =30108
               	movk	x0, #0x8800, lsl #16
               	movk	x0, #0xe43c, lsl #32
               	movk	x0, #0x7e37, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	fcmp	d0, d0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
