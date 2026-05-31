
static_locals.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003a8 <.text+0x178>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	str	w13, [x15]
               	ldrsw	x0, [x15]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x15, w0
               	cbz	x15, 0x4002cc <.text+0x9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x14, x19
               	mov	x15, #0x64              // =100
               	str	w15, [x14]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x13, x19
               	mov	x15, #0x0               // =0
               	str	w15, [x13]
               	b	0x4002cc <.text+0x9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x15, x19
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	str	w13, [x15]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x14, x19
               	ldrsw	x13, [x14]
               	ldrsw	x12, [x15]
               	add	x11, x13, x12
               	sxtw	x11, w11
               	str	w11, [x14]
               	ldrsw	x12, [x15]
               	ldrsw	x15, [x14]
               	add	x14, x12, x15
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x15, x19
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	str	w13, [x15]
               	ldrsw	x0, [x15]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x15, x19
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	str	w13, [x15]
               	ldrsw	x0, [x15]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	bl	0x400248 <.text+0x18>
               	cmp	x0, #0x1
               	b.eq	0x4003e4 <.text+0x1b4>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400248 <.text+0x18>
               	cmp	x0, #0x2
               	b.eq	0x40040c <.text+0x1dc>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400248 <.text+0x18>
               	cmp	x0, #0x3
               	b.eq	0x400430 <.text+0x200>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	0x400288 <.text+0x58>
               	cmp	x0, #0xca
               	b.eq	0x40045c <.text+0x22c>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	0x400288 <.text+0x58>
               	cmp	x0, #0x131
               	b.eq	0x400488 <.text+0x258>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	0x400288 <.text+0x58>
               	cmp	x0, #0xca
               	b.eq	0x4004b8 <.text+0x288>
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400328 <.text+0xf8>
               	cmp	x0, #0x1
               	b.eq	0x4004e0 <.text+0x2b0>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400328 <.text+0xf8>
               	cmp	x0, #0x2
               	b.eq	0x400508 <.text+0x2d8>
               	mov	x21, #0x8               // =8
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400368 <.text+0x138>
               	cmp	x0, #0x3e9
               	b.eq	0x400530 <.text+0x300>
               	mov	x20, #0x9               // =9
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400368 <.text+0x138>
               	cmp	x0, #0x3ea
               	b.eq	0x400558 <.text+0x328>
               	mov	x21, #0xa               // =10
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400328 <.text+0xf8>
               	cmp	x0, #0x3
               	b.eq	0x40057c <.text+0x34c>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
