
for_init_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4006c4 <.text+0x404>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
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
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4009e8 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	0x400428 <.text+0x168>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0xa
               	b.ge	0x400464 <.text+0x1a4>
               	b	0x40044c <.text+0x18c>
               	sub	x14, x29, #0x10
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x400428 <.text+0x168>
               	sub	x15, x29, #0x8
               	ldrsw	x13, [x15]
               	ldursw	x14, [x29, #-0x10]
               	add	x13, x13, x14
               	str	w13, [x15]
               	b	0x400438 <.text+0x178>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0xa               // =10
               	stur	w14, [x29, #-0x18]
               	b	0x400494 <.text+0x1d4>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x15, [x29, #-0x18]
               	cmp	x14, x15
               	b.ge	0x400500 <.text+0x240>
               	b	0x4004dc <.text+0x21c>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	sub	x13, x29, #0x18
               	ldrsw	x14, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x14, x14, x17
               	str	w14, [x13]
               	b	0x400494 <.text+0x1d4>
               	sub	x14, x29, #0x8
               	ldrsw	x15, [x14]
               	ldursw	x13, [x29, #-0x10]
               	ldursw	x12, [x29, #-0x18]
               	add	x13, x13, x12
               	sxtw	x13, w13
               	add	x15, x15, x13
               	str	w15, [x14]
               	b	0x4004a8 <.text+0x1e8>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x2a              // =42
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	b	0x40052c <.text+0x26c>
               	ldursw	x14, [x29, #-0x10]
               	cmp	x14, #0x3
               	b.ge	0x400554 <.text+0x294>
               	b	0x400550 <.text+0x290>
               	sub	x13, x29, #0x10
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	0x40052c <.text+0x26c>
               	b	0x40053c <.text+0x27c>
               	sxtw	x0, w15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	0x400580 <.text+0x2c0>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0x5
               	b.ge	0x4005bc <.text+0x2fc>
               	b	0x4005a4 <.text+0x2e4>
               	sub	x14, x29, #0x10
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x400580 <.text+0x2c0>
               	sub	x15, x29, #0x8
               	ldrsw	x13, [x15]
               	ldursw	x14, [x29, #-0x10]
               	add	x13, x13, x14
               	str	w13, [x15]
               	b	0x400590 <.text+0x2d0>
               	mov	x13, #0xa               // =10
               	stur	w13, [x29, #-0x18]
               	b	0x4005c8 <.text+0x308>
               	ldursw	x13, [x29, #-0x18]
               	cmp	x13, #0xd
               	b.ge	0x400604 <.text+0x344>
               	b	0x4005ec <.text+0x32c>
               	sub	x14, x29, #0x18
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	b	0x4005c8 <.text+0x308>
               	sub	x13, x29, #0x8
               	ldrsw	x15, [x13]
               	ldursw	x14, [x29, #-0x18]
               	add	x15, x15, x14
               	str	w15, [x13]
               	b	0x4005d8 <.text+0x318>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x15, x19
               	mov	x14, #0x0               // =0
               	mov	x13, #0x1               // =1
               	str	w13, [x15]
               	mov	x12, #0x4               // =4
               	add	x13, x15, #0x4
               	mov	x11, #0x2               // =2
               	str	w11, [x13]
               	add	x10, x15, #0x8
               	str	w12, [x10]
               	stur	w14, [x29, #-0x8]
               	stur	x15, [x29, #-0x10]
               	b	0x400660 <.text+0x3a0>
               	ldur	x15, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x11, x19
               	add	x11, x11, #0xc
               	cmp	x15, x11
               	b.ge	0x4006b0 <.text+0x3f0>
               	b	0x400694 <.text+0x3d4>
               	sub	x11, x29, #0x10
               	ldr	x15, [x11]
               	add	x15, x15, #0x4
               	str	x15, [x11]
               	b	0x400660 <.text+0x3a0>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	ldur	x11, [x29, #-0x10]
               	ldrsw	x10, [x11]
               	add	x14, x14, x10
               	str	w14, [x15]
               	b	0x400680 <.text+0x3c0>
               	ldursw	x0, [x29, #-0x8]
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	bl	0x40040c <.text+0x14c>
               	cmp	x0, #0x2d
               	b.eq	0x400734 <.text+0x474>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	bl	0x40040c <.text+0x14c>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4009f4 <printf>
               	sxtw	x0, w0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400474 <.text+0x1b4>
               	cmp	x0, #0x32
               	b.eq	0x400788 <.text+0x4c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x175
               	mov	x21, x19
               	bl	0x400474 <.text+0x1b4>
               	mov	x22, x0
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4009f4 <printf>
               	sxtw	x0, w0
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400510 <.text+0x250>
               	cmp	x0, #0x2a
               	b.eq	0x4007dc <.text+0x51c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x18a
               	mov	x22, x19
               	bl	0x400510 <.text+0x250>
               	mov	x20, x0
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x4009f4 <printf>
               	sxtw	x0, w0
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400564 <.text+0x2a4>
               	cmp	x0, #0x2b
               	b.eq	0x400830 <.text+0x570>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x19e
               	mov	x20, x19
               	bl	0x400564 <.text+0x2a4>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4009f4 <printf>
               	sxtw	x0, w0
               	mov	x22, #0x4               // =4
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400614 <.text+0x354>
               	cmp	x0, #0x7
               	b.eq	0x400880 <.text+0x5c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b6
               	mov	x21, x19
               	bl	0x400614 <.text+0x354>
               	mov	x22, x0
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4009f4 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
