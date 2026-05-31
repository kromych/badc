
typedef_array_param_decay.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400320 <.text+0x100>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	mov	x14, x1
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	b	0x400258 <.text+0x38>
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, #0x10
               	b.ge	0x400298 <.text+0x78>
               	b	0x40027c <.text+0x5c>
               	sub	x12, x29, #0x8
               	ldrsw	x13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	0x400258 <.text+0x38>
               	ldursw	x13, [x29, #-0x8]
               	lsl	x13, x13, #3
               	add	x11, x15, x13
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	str	x13, [x11]
               	b	0x400268 <.text+0x48>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x10]
               	stur	w14, [x29, #-0x8]
               	b	0x4002c8 <.text+0xa8>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x10
               	b.ge	0x400310 <.text+0xf0>
               	b	0x4002ec <.text+0xcc>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	0x4002c8 <.text+0xa8>
               	sub	x14, x29, #0x10
               	ldr	x12, [x14]
               	ldursw	x13, [x29, #-0x8]
               	lsl	x13, x13, #3
               	add	x11, x15, x13
               	ldr	x13, [x11]
               	add	x12, x12, x13
               	str	x12, [x14]
               	b	0x4002d8 <.text+0xb8>
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x108
               	str	w15, [x17]
               	b	0x400348 <.text+0x128>
               	sub	x16, x29, #0x108
               	ldrsw	x15, [x16]
               	cmp	x15, #0x10
               	b.ge	0x400390 <.text+0x170>
               	b	0x400370 <.text+0x150>
               	sub	x14, x29, #0x108
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x400348 <.text+0x128>
               	sub	x15, x29, #0x80
               	sub	x16, x29, #0x108
               	ldrsw	x13, [x16]
               	lsl	x14, x13, #3
               	add	x15, x15, x14
               	add	x13, x13, #0x1
               	str	x13, [x15]
               	b	0x40035c <.text+0x13c>
               	sub	x20, x29, #0x100
               	sub	x21, x29, #0x80
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	sub	x22, x29, #0x100
               	mov	x0, x22
               	bl	0x4002a8 <.text+0x88>
               	mov	x22, #0x110             // =272
               	sxtw	x22, w22
               	mov	x20, #0x2               // =2
               	sdiv	x22, x22, x20
               	cmp	x0, x22
               	b.eq	0x4003e8 <.text+0x1c8>
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	ldr	x22, [x0]
               	cmp	x22, #0x1
               	b.eq	0x400414 <.text+0x1f4>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x100
               	add	x22, x22, #0x78
               	ldr	x0, [x22]
               	cmp	x0, #0x10
               	b.eq	0x400448 <.text+0x228>
               	mov	x22, #0x3               // =3
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
