
fp_nan_unordered_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d1, [x16]
               	fdiv	d0, d1, d1
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x0
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fdiv	d1, d16, d1
               	fcmp	d0, d0
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d2, d0
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	fcmp	d0, d0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d2, d0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d0, d2
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d2, d0
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d2, d0
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d2, d0
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d2, [x16]
               	fcmp	d2, d0
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d0, d0
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d0, d0
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	fcmp	d1, d0
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x759c             // =30108
               	movk	x0, #0x8800, lsl #16
               	movk	x0, #0xe43c, lsl #32
               	movk	x0, #0x7e37, lsl #48
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d1, d1
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
