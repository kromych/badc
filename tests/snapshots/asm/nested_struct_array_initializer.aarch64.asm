
nested_struct_array_initializer.aarch64:	file format elf64-littleaarch64

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
               	cmp	x14, #0x64
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
               	cmp	x15, #0x1
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
               	cmp	x0, #0x2
               	b.eq	0x4002d8 <.text+0xb8>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x0, x15, #0xc
               	ldrsw	x15, [x0]
               	cmp	x15, #0x3
               	b.eq	0x40030c <.text+0xec>
               	mov	x15, #0xe               // =14
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	add	x15, x0, #0x10
               	ldrsw	x0, [x15]
               	cmp	x0, #0x4
               	b.eq	0x40033c <.text+0x11c>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x0, x15, #0x14
               	ldrsw	x15, [x0]
               	cmp	x15, #0x5
               	b.eq	0x400370 <.text+0x150>
               	mov	x15, #0x10              // =16
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	add	x15, x0, #0x18
               	ldrsw	x0, [x15]
               	cmp	x0, #0x6
               	b.eq	0x4003a0 <.text+0x180>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x0, x15, #0x1c
               	ldrsw	x15, [x0]
               	cmp	x15, #0xc8
               	b.eq	0x4003d4 <.text+0x1b4>
               	mov	x15, #0x12              // =18
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	ldrsw	x15, [x0]
               	cmp	x15, #0xa
               	b.eq	0x400404 <.text+0x1e4>
               	mov	x15, #0x15              // =21
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	add	x15, x0, #0x4
               	ldrsw	x0, [x15]
               	cmp	x0, #0x14
               	b.eq	0x400434 <.text+0x214>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	add	x0, x15, #0x8
               	ldrsw	x15, [x0]
               	cmp	x15, #0x1e
               	b.eq	0x400468 <.text+0x248>
               	mov	x15, #0x17              // =23
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	add	x15, x0, #0xc
               	ldrsw	x0, [x15]
               	cmp	x0, #0x28
               	b.eq	0x400498 <.text+0x278>
               	mov	x0, #0x18               // =24
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x15, x19
               	ldrsw	x0, [x15]
               	cmp	x0, #0x7
               	b.eq	0x4004c4 <.text+0x2a4>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x0, x15, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x8
               	b.eq	0x4004f8 <.text+0x2d8>
               	mov	x15, #0x20              // =32
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x0, x19
               	add	x15, x0, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x9
               	b.eq	0x400528 <.text+0x308>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x0, x15, #0xc
               	ldrsw	x15, [x0]
               	cmp	x15, #0xb
               	b.eq	0x40055c <.text+0x33c>
               	mov	x15, #0x22              // =34
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x0, x19
               	add	x15, x0, #0x10
               	ldrsw	x0, [x15]
               	cmp	x0, #0xd
               	b.eq	0x40058c <.text+0x36c>
               	mov	x0, #0x23               // =35
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x0, x15, #0x14
               	ldrsw	x15, [x0]
               	cmp	x15, #0x11
               	b.eq	0x4005c0 <.text+0x3a0>
               	mov	x15, #0x24              // =36
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x0, x19
               	add	x15, x0, #0x18
               	ldrsw	x0, [x15]
               	cmp	x0, #0x13
               	b.eq	0x4005f0 <.text+0x3d0>
               	mov	x0, #0x25               // =37
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
