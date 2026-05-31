
fp_nan_unordered_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003c8 <.text+0x148>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400988 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
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
               	cset	x15, ne
               	cmp	x15, #0x0
               	b.ne	0x400434 <.text+0x1b4>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	0x400460 <.text+0x1e0>
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
               	b.ne	0x40048c <.text+0x20c>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	fmov	d0, x13
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x12, ne
               	cmp	x12, #0x0
               	b.ne	0x4004c0 <.text+0x240>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x12, eq
               	cbz	x12, 0x4004e8 <.text+0x268>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x10]
               	fmov	d0, x12
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, 0x400514 <.text+0x294>
               	mov	x12, #0xb               // =11
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x12, eq
               	cbz	x12, 0x40053c <.text+0x2bc>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	fmov	d0, x12
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, eq
               	cbz	x13, 0x400568 <.text+0x2e8>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, 0x400594 <.text+0x314>
               	mov	x13, #0x14              // =20
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, gt
               	cbz	x13, 0x4005bc <.text+0x33c>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ls
               	cbz	x0, 0x4005e8 <.text+0x368>
               	mov	x13, #0x16              // =22
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, ge
               	cbz	x13, 0x400610 <.text+0x390>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, 0x40063c <.text+0x3bc>
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
               	cbz	x13, 0x400664 <.text+0x3e4>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ls
               	cbz	x0, 0x400690 <.text+0x410>
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
               	cbz	x13, 0x4006b8 <.text+0x438>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, 0x4006e4 <.text+0x464>
               	mov	x13, #0x1c              // =28
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, ls
               	cbz	x13, 0x40070c <.text+0x48c>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ge
               	cbz	x0, 0x400738 <.text+0x4b8>
               	mov	x13, #0x1e              // =30
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, mi
               	cmp	x13, #0x0
               	b.ne	0x400768 <.text+0x4e8>
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
               	b.ne	0x400798 <.text+0x518>
               	mov	x13, #0x29              // =41
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, gt
               	cmp	x13, #0x0
               	b.ne	0x4007c8 <.text+0x548>
               	mov	x13, #0x2a              // =42
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	mov	x13, #0x759c            // =30108
               	movk	x13, #0x8800, lsl #16
               	movk	x13, #0xe43c, lsl #32
               	movk	x13, #0x7e37, lsl #48
               	fmov	d0, x0
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x14, gt
               	cmp	x14, #0x0
               	b.ne	0x400804 <.text+0x584>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x20]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400830 <.text+0x5b0>
               	mov	x13, #0x2c              // =44
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
