
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
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	0x400258 <.text+0x38>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	b	0x400298 <.text+0x78>
               	ldur	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x14, [x29, #-0x10]
               	cmp	x14, #0x10
               	b.ge	0x400318 <.text+0xf8>
               	b	0x4002bc <.text+0x9c>
               	sub	x12, x29, #0x10
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	b	0x400298 <.text+0x78>
               	ldursw	x14, [x29, #-0x8]
               	lsl	x13, x14, #7
               	add	x12, x15, x13
               	ldursw	x13, [x29, #-0x10]
               	lsl	x11, x13, #3
               	add	x12, x12, x11
               	lsl	x14, x14, #4
               	sxtw	x14, w14
               	add	x14, x14, x13
               	sxtw	x14, w14
               	str	x14, [x12]
               	sub	x13, x29, #0x18
               	ldr	x14, [x13]
               	ldursw	x12, [x29, #-0x8]
               	lsl	x12, x12, #7
               	add	x11, x15, x12
               	ldursw	x12, [x29, #-0x10]
               	lsl	x12, x12, #3
               	add	x11, x11, x12
               	ldr	x12, [x11]
               	add	x14, x14, x12
               	str	x14, [x13]
               	b	0x4002a8 <.text+0x88>
               	b	0x400268 <.text+0x48>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	str	x20, [sp]
               	mov	x15, #0x40              // =64
               	sxtw	x15, w15
               	lsl	x15, x15, #3
               	sxtw	x15, w15
               	cmp	x15, #0x200
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
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x400374 <.text+0x154>
               	sub	x15, x29, #0x208
               	ldr	x13, [x15]
               	sub	x16, x29, #0x210
               	ldrsw	x14, [x16]
               	add	x13, x13, x14
               	str	x13, [x15]
               	b	0x400390 <.text+0x170>
               	sub	x20, x29, #0x200
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	sub	x16, x29, #0x208
               	ldr	x20, [x16]
               	cmp	x0, x20
               	b.eq	0x4003f4 <.text+0x1d4>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	ldr	x20, [x0]
               	cmp	x20, #0x0
               	b.eq	0x400418 <.text+0x1f8>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x200
               	add	x20, x20, #0x1f8
               	ldr	x0, [x20]
               	cmp	x0, #0x3f
               	b.eq	0x400444 <.text+0x224>
               	mov	x20, #0x4               // =4
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	add	x0, x0, #0xb8
               	ldr	x20, [x0]
               	cmp	x20, #0x17
               	b.eq	0x40046c <.text+0x24c>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
