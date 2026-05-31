
quicksort.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40048c <.text+0x21c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	mov	x15, x0
               	mov	x14, x1
               	ldrsw	x13, [x15]
               	ldrsw	x12, [x14]
               	str	w12, [x15]
               	sxtw	x11, w13
               	str	w11, [x14]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	mov	x20, x0
               	sxtw	x14, w1
               	sxtw	x21, w2
               	lsl	x12, x21, #2
               	add	x11, x20, x12
               	ldrsw	x22, [x11]
               	sub	x11, x14, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x10]
               	stur	w14, [x29, #-0x18]
               	b	0x400300 <.text+0x90>
               	ldursw	x14, [x29, #-0x18]
               	cmp	x14, x21
               	b.ge	0x400344 <.text+0xd4>
               	b	0x400324 <.text+0xb4>
               	sub	x14, x29, #0x18
               	ldrsw	x10, [x14]
               	add	x11, x10, #0x1
               	str	w11, [x14]
               	b	0x400300 <.text+0x90>
               	ldursw	x11, [x29, #-0x18]
               	lsl	x10, x11, #2
               	add	x11, x20, x10
               	ldrsw	x10, [x11]
               	sxtw	x11, w22
               	cmp	x10, x11
               	b.gt	0x4003dc <.text+0x16c>
               	b	0x4003a4 <.text+0x134>
               	ldursw	x24, [x29, #-0x10]
               	add	x0, x24, #0x1
               	sxtw	x0, w0
               	lsl	x24, x0, #2
               	add	x25, x20, x24
               	lsl	x24, x21, #2
               	add	x26, x20, x24
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x400288 <.text+0x18>
               	ldursw	x0, [x29, #-0x10]
               	add	x26, x0, #0x1
               	sxtw	x26, w26
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x10
               	ldrsw	x14, [x11]
               	add	x10, x14, #0x1
               	str	w10, [x11]
               	ldursw	x14, [x29, #-0x10]
               	lsl	x10, x14, #2
               	add	x23, x20, x10
               	ldursw	x10, [x29, #-0x18]
               	lsl	x11, x10, #2
               	add	x24, x20, x11
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x400288 <.text+0x18>
               	b	0x4003dc <.text+0x16c>
               	b	0x400310 <.text+0xa0>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x20, x0
               	sxtw	x21, w1
               	sxtw	x22, w2
               	cmp	x21, x22
               	b.ge	0x400464 <.text+0x1f4>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x4002ac <.text+0x3c>
               	stur	w0, [x29, #-0x8]
               	ldursw	x12, [x29, #-0x8]
               	sub	x0, x12, #0x1
               	sxtw	x23, w0
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x4003e0 <.text+0x170>
               	ldursw	x0, [x29, #-0x8]
               	add	x23, x0, #0x1
               	sxtw	x24, w23
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x4003e0 <.text+0x170>
               	b	0x400464 <.text+0x1f4>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x14              // =20
               	sxtw	x20, w15
               	mov	x0, x20
               	bl	0x400768 <malloc>
               	mov	x21, x0
               	mov	x22, #0x0               // =0
               	mov	x13, #0xc               // =12
               	str	w13, [x21]
               	mov	x20, #0x4               // =4
               	add	x13, x21, #0x4
               	mov	x11, #0x7               // =7
               	str	w11, [x13]
               	add	x10, x21, #0x8
               	mov	x11, #0xf               // =15
               	str	w11, [x10]
               	add	x13, x21, #0xc
               	mov	x11, #0x5               // =5
               	str	w11, [x13]
               	add	x10, x21, #0x10
               	mov	x11, #0xa               // =10
               	str	w11, [x10]
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	0x4003e0 <.text+0x170>
               	ldrsw	x0, [x21]
               	cmp	x0, #0x5
               	b.eq	0x400538 <.text+0x2c8>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x21, #0x4
               	ldrsw	x0, [x20]
               	cmp	x0, #0x7
               	b.eq	0x400568 <.text+0x2f8>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x21, #0x8
               	ldrsw	x0, [x20]
               	cmp	x0, #0xa
               	b.eq	0x400598 <.text+0x328>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x21, #0xc
               	ldrsw	x0, [x20]
               	cmp	x0, #0xc
               	b.eq	0x4005c8 <.text+0x358>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x21, #0x10
               	ldrsw	x21, [x20]
               	cmp	x21, #0xf
               	b.eq	0x4005fc <.text+0x38c>
               	mov	x21, #0x5               // =5
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
