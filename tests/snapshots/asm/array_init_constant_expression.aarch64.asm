
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
               	mov	x15, x19
               	add	x0, x15, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x80
               	b.eq	0x4002a8 <.text+0x88>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	add	x15, x0, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x4
               	b.eq	0x4002d8 <.text+0xb8>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	ldrsw	x0, [x15]
               	cmp	x0, #0x90
               	b.eq	0x400304 <.text+0xe4>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	add	x0, x15, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x94
               	b.eq	0x400338 <.text+0x118>
               	mov	x15, #0xf               // =15
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x0, x19
               	add	x15, x0, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x10
               	b.eq	0x400368 <.text+0x148>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	ldrsw	x0, [x15]
               	cmp	x0, #0x100
               	b.eq	0x400394 <.text+0x174>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	add	x0, x15, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x40
               	b.eq	0x4003c8 <.text+0x1a8>
               	mov	x15, #0x12              // =18
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	ldrsw	x15, [x0]
               	cmp	x15, #0x11
               	b.eq	0x4003f8 <.text+0x1d8>
               	mov	x15, #0x13              // =19
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	add	x15, x0, #0x4
               	ldrsw	x0, [x15]
               	cmp	x0, #0x70
               	b.eq	0x400428 <.text+0x208>
               	mov	x0, #0x14               // =20
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x15, x19
               	add	x0, x15, #0x8
               	ldrsw	x15, [x0]
               	cmp	x15, #0x30
               	b.eq	0x40045c <.text+0x23c>
               	mov	x15, #0x15              // =21
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x0, x19
               	ldrsw	x15, [x0]
               	cmp	x15, #0x90
               	b.eq	0x40048c <.text+0x26c>
               	mov	x15, #0x16              // =22
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x0, x19
               	add	x15, x0, #0x4
               	ldrsw	x0, [x15]
               	cmp	x0, #0x10
               	b.eq	0x4004bc <.text+0x29c>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x15, x19
               	add	x0, x15, #0x8
               	ldrsw	x15, [x0]
               	cmp	x15, #0x4
               	b.eq	0x4004f0 <.text+0x2d0>
               	mov	x15, #0x18              // =24
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x0, x19
               	add	x15, x0, #0xc
               	ldrsw	x0, [x15]
               	cmp	x0, #0x14
               	b.eq	0x400520 <.text+0x300>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
