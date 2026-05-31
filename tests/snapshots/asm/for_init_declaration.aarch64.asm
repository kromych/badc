
for_init_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4006c0 <.text+0x400>
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
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4009f8 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	sub	sp, sp, #0x10
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	0x400424 <.text+0x164>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0xa
               	b.ge	0x400460 <.text+0x1a0>
               	b	0x400448 <.text+0x188>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x400424 <.text+0x164>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	ldursw	x15, [x29, #-0x10]
               	add	x12, x14, x15
               	str	w12, [x13]
               	b	0x400434 <.text+0x174>
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
               	b	0x400490 <.text+0x1d0>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x15, [x29, #-0x18]
               	cmp	x14, x15
               	b.ge	0x4004fc <.text+0x23c>
               	b	0x4004d8 <.text+0x218>
               	sub	x15, x29, #0x10
               	ldrsw	x13, [x15]
               	add	x14, x13, #0x1
               	str	w14, [x15]
               	sub	x13, x29, #0x18
               	ldrsw	x14, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x15, x14, x17
               	str	w15, [x13]
               	b	0x400490 <.text+0x1d0>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	ldursw	x13, [x29, #-0x10]
               	ldursw	x12, [x29, #-0x18]
               	add	x11, x13, x12
               	sxtw	x11, w11
               	add	x12, x14, x11
               	str	w12, [x15]
               	b	0x4004a4 <.text+0x1e4>
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
               	b	0x400528 <.text+0x268>
               	ldursw	x14, [x29, #-0x10]
               	cmp	x14, #0x3
               	b.ge	0x400550 <.text+0x290>
               	b	0x40054c <.text+0x28c>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	add	x12, x13, #0x1
               	str	w12, [x14]
               	b	0x400528 <.text+0x268>
               	b	0x400538 <.text+0x278>
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
               	b	0x40057c <.text+0x2bc>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0x5
               	b.ge	0x4005b8 <.text+0x2f8>
               	b	0x4005a0 <.text+0x2e0>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x40057c <.text+0x2bc>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	ldursw	x15, [x29, #-0x10]
               	add	x12, x14, x15
               	str	w12, [x13]
               	b	0x40058c <.text+0x2cc>
               	mov	x12, #0xa               // =10
               	stur	w12, [x29, #-0x18]
               	b	0x4005c4 <.text+0x304>
               	ldursw	x12, [x29, #-0x18]
               	cmp	x12, #0xd
               	b.ge	0x400600 <.text+0x340>
               	b	0x4005e8 <.text+0x328>
               	sub	x12, x29, #0x18
               	ldrsw	x15, [x12]
               	add	x13, x15, #0x1
               	str	w13, [x12]
               	b	0x4005c4 <.text+0x304>
               	sub	x13, x29, #0x8
               	ldrsw	x15, [x13]
               	ldursw	x12, [x29, #-0x18]
               	add	x14, x15, x12
               	str	w14, [x13]
               	b	0x4005d4 <.text+0x314>
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
               	b	0x40065c <.text+0x39c>
               	ldur	x15, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x11, x19
               	add	x14, x11, #0xc
               	cmp	x15, x14
               	b.ge	0x4006ac <.text+0x3ec>
               	b	0x400690 <.text+0x3d0>
               	sub	x14, x29, #0x10
               	ldr	x11, [x14]
               	add	x15, x11, #0x4
               	str	x15, [x14]
               	b	0x40065c <.text+0x39c>
               	sub	x15, x29, #0x8
               	ldrsw	x11, [x15]
               	ldur	x14, [x29, #-0x10]
               	ldrsw	x10, [x14]
               	add	x14, x11, x10
               	str	w14, [x15]
               	b	0x40067c <.text+0x3bc>
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
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	bl	0x400408 <.text+0x148>
               	cmp	x0, #0x2d
               	b.eq	0x400738 <.text+0x478>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	bl	0x400408 <.text+0x148>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400a04 <printf>
               	sxtw	x0, w0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400470 <.text+0x1b0>
               	cmp	x0, #0x32
               	b.eq	0x400790 <.text+0x4d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x175
               	mov	x21, x19
               	bl	0x400470 <.text+0x1b0>
               	mov	x23, x0
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x400a04 <printf>
               	sxtw	x0, w0
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x40050c <.text+0x24c>
               	cmp	x0, #0x2a
               	b.eq	0x4007e8 <.text+0x528>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x18a
               	mov	x23, x19
               	bl	0x40050c <.text+0x24c>
               	mov	x22, x0
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x400a04 <printf>
               	sxtw	x0, w0
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400560 <.text+0x2a0>
               	cmp	x0, #0x2b
               	b.eq	0x400840 <.text+0x580>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x19e
               	mov	x22, x19
               	bl	0x400560 <.text+0x2a0>
               	mov	x20, x0
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x400a04 <printf>
               	sxtw	x0, w0
               	mov	x23, #0x4               // =4
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400610 <.text+0x350>
               	cmp	x0, #0x7
               	b.eq	0x400894 <.text+0x5d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b6
               	mov	x20, x19
               	bl	0x400610 <.text+0x350>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400a04 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
