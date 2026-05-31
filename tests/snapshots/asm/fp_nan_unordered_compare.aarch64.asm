
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x0, [x14]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x0, [x21]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	fmov	d0, x15
               	fmov	d1, x15
               	fdiv	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x10]
               	mov	x14, #0x4014000000000000 // =4617315517961601024
               	mov	x13, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x13
               	fmov	d1, x15
               	fdiv	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x20]
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x13, ne
               	cmp	x13, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, ne
               	cmp	x13, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	mov	x13, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x13, #0xa               // =10
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x13, #0xb               // =11
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, eq
               	cbz	x13, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	fmov	d0, x13
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, eq
               	cbz	x13, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, mi
               	cbz	x13, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, gt
               	cbz	x13, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, ls
               	cbz	x13, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, ge
               	cbz	x13, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x13, #0x18              // =24
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, gt
               	cbz	x13, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x13, #0x1a              // =26
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, ge
               	cbz	x13, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x13, mi
               	cbz	x13, <addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x13, ls
               	cbz	x13, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x13, ge
               	cbz	x13, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x4018000000000000 // =4618441417868443648
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, mi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x13, #0x28              // =40
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, eq
               	cmp	x13, #0x0
               	b.ne	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x20]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, gt
               	cmp	x13, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x20]
               	mov	x0, #0x759c             // =30108
               	movk	x0, #0x8800, lsl #16
               	movk	x0, #0xe43c, lsl #32
               	movk	x0, #0x7e37, lsl #48
               	fmov	d0, x13
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, gt
               	cmp	x13, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x20]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
