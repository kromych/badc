
typedef_array_outer_dim.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40031c <.text+0xfc>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, x0
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x18]
               	stur	w14, [x29, #-0x8]
               	b	0x400258 <.text+0x38>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x4
               	b.ge	0x400288 <.text+0x68>
               	b	0x40027c <.text+0x5c>
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	add	x12, x13, #0x1
               	str	w12, [x14]
               	b	0x400258 <.text+0x38>
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x10]
               	b	0x400298 <.text+0x78>
               	ldur	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x12, [x29, #-0x10]
               	cmp	x12, #0x10
               	b.ge	0x400318 <.text+0xf8>
               	b	0x4002bc <.text+0x9c>
               	sub	x12, x29, #0x10
               	ldrsw	x13, [x12]
               	add	x14, x13, #0x1
               	str	w14, [x12]
               	b	0x400298 <.text+0x78>
               	ldursw	x14, [x29, #-0x8]
               	lsl	x13, x14, #7
               	add	x12, x15, x13
               	ldursw	x13, [x29, #-0x10]
               	lsl	x11, x13, #3
               	add	x10, x12, x11
               	lsl	x11, x14, #4
               	sxtw	x11, w11
               	add	x14, x11, x13
               	sxtw	x14, w14
               	str	x14, [x10]
               	sub	x11, x29, #0x18
               	ldr	x14, [x11]
               	ldursw	x10, [x29, #-0x8]
               	lsl	x13, x10, #7
               	add	x10, x15, x13
               	ldursw	x13, [x29, #-0x10]
               	lsl	x12, x13, #3
               	add	x13, x10, x12
               	ldr	x12, [x13]
               	add	x13, x14, x12
               	str	x13, [x11]
               	b	0x4002a8 <.text+0x88>
               	b	0x400268 <.text+0x48>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	str	x20, [sp]
               	mov	x15, #0x40              // =64
               	sxtw	x15, w15
               	lsl	x14, x15, #3
               	sxtw	x14, w14
               	cmp	x14, #0x200
               	b.eq	0x40035c <.text+0x13c>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x208
               	str	x15, [x17]
               	sub	x17, x29, #0x210
               	str	w15, [x17]
               	b	0x400374 <.text+0x154>
               	sub	x16, x29, #0x210
               	ldrsw	x15, [x16]
               	mov	x14, #0x40              // =64
               	sxtw	x14, w14
               	cmp	x15, x14
               	b.ge	0x4003c0 <.text+0x1a0>
               	b	0x4003a4 <.text+0x184>
               	sub	x14, x29, #0x210
               	ldrsw	x13, [x14]
               	add	x15, x13, #0x1
               	str	w15, [x14]
               	b	0x400374 <.text+0x154>
               	sub	x15, x29, #0x208
               	ldr	x13, [x15]
               	sub	x16, x29, #0x210
               	ldrsw	x14, [x16]
               	add	x12, x13, x14
               	str	x12, [x15]
               	b	0x400390 <.text+0x170>
               	sub	x20, x29, #0x200
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	sub	x16, x29, #0x208
               	ldr	x20, [x16]
               	cmp	x14, x20
               	b.eq	0x4003f8 <.text+0x1d8>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x200
               	ldr	x20, [x15]
               	cmp	x20, #0x0
               	b.eq	0x400420 <.text+0x200>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x200
               	add	x20, x15, #0x1f8
               	ldr	x15, [x20]
               	cmp	x15, #0x3f
               	b.eq	0x40044c <.text+0x22c>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x200
               	add	x15, x20, #0xb8
               	ldr	x20, [x15]
               	cmp	x20, #0x17
               	b.eq	0x400478 <.text+0x258>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
