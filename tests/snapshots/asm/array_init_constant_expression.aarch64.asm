
array_init_constant_expression.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldrsw	x14, [x15]
               	cmp	x14, #0x10
               	b.eq	0x400274 <.text+0x54>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x14, x19
               	add	x14, x14, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x80
               	b.eq	0x4002a8 <.text+0x88>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	add	x0, x0, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x4
               	b.eq	0x4002d8 <.text+0xb8>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x14, x19
               	ldrsw	x0, [x14]
               	cmp	x0, #0x90
               	b.eq	0x400308 <.text+0xe8>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x0, x19
               	add	x0, x0, #0x4
               	ldrsw	x14, [x0]
               	cmp	x14, #0x94
               	b.eq	0x400338 <.text+0x118>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x14, x19
               	add	x14, x14, #0x8
               	ldrsw	x0, [x14]
               	cmp	x0, #0x10
               	b.eq	0x40036c <.text+0x14c>
               	mov	x14, #0x10              // =16
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	ldrsw	x14, [x0]
               	cmp	x14, #0x100
               	b.eq	0x400398 <.text+0x178>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x14, x19
               	add	x14, x14, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x40
               	b.eq	0x4003cc <.text+0x1ac>
               	mov	x14, #0x12              // =18
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	ldrsw	x14, [x0]
               	cmp	x14, #0x11
               	b.eq	0x4003f8 <.text+0x1d8>
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	add	x14, x14, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x70
               	b.eq	0x40042c <.text+0x20c>
               	mov	x14, #0x14              // =20
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	add	x0, x0, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x30
               	b.eq	0x40045c <.text+0x23c>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x14, x19
               	ldrsw	x0, [x14]
               	cmp	x0, #0x90
               	b.eq	0x40048c <.text+0x26c>
               	mov	x14, #0x16              // =22
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x0, x19
               	add	x0, x0, #0x4
               	ldrsw	x14, [x0]
               	cmp	x14, #0x10
               	b.eq	0x4004bc <.text+0x29c>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x14, x19
               	add	x14, x14, #0x8
               	ldrsw	x0, [x14]
               	cmp	x0, #0x4
               	b.eq	0x4004f0 <.text+0x2d0>
               	mov	x14, #0x18              // =24
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x0, x19
               	add	x0, x0, #0xc
               	ldrsw	x14, [x0]
               	cmp	x14, #0x14
               	b.eq	0x400520 <.text+0x300>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
