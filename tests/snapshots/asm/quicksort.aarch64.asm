
quicksort.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4004a0 <.text+0x230>
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
               	b.gt	0x4003e4 <.text+0x174>
               	b	0x4003a8 <.text+0x138>
               	ldursw	x24, [x29, #-0x10]
               	add	x11, x24, #0x1
               	sxtw	x11, w11
               	lsl	x24, x11, #2
               	add	x25, x20, x24
               	lsl	x24, x21, #2
               	add	x26, x20, x24
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x400288 <.text+0x18>
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x10]
               	add	x26, x24, #0x1
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
               	mov	x11, x0
               	b	0x4003e4 <.text+0x174>
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
               	b.ge	0x400478 <.text+0x208>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x4002ac <.text+0x3c>
               	mov	x11, x0
               	stur	w11, [x29, #-0x8]
               	ldursw	x12, [x29, #-0x8]
               	sub	x11, x12, #0x1
               	sxtw	x23, w11
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x4003e8 <.text+0x178>
               	mov	x12, x0
               	ldursw	x12, [x29, #-0x8]
               	add	x23, x12, #0x1
               	sxtw	x24, w23
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x4003e8 <.text+0x178>
               	mov	x12, x0
               	b	0x400478 <.text+0x208>
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
               	bl	0x400788 <malloc>
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
               	bl	0x4003e8 <.text+0x178>
               	mov	x13, x0
               	ldrsw	x13, [x21]
               	cmp	x13, #0x5
               	b.eq	0x400554 <.text+0x2e4>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x21, #0x4
               	ldrsw	x13, [x20]
               	cmp	x13, #0x7
               	b.eq	0x400588 <.text+0x318>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x21, #0x8
               	ldrsw	x13, [x20]
               	cmp	x13, #0xa
               	b.eq	0x4005bc <.text+0x34c>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x21, #0xc
               	ldrsw	x13, [x20]
               	cmp	x13, #0xc
               	b.eq	0x4005f0 <.text+0x380>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
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
               	b.eq	0x400624 <.text+0x3b4>
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
