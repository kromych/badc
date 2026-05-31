
binary_search_tree.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400480 <.text+0x210>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	mov	x20, x0
               	mov	x21, x1
               	cmp	x20, #0x0
               	b.ne	0x400320 <.text+0xb0>
               	mov	x12, #0x10              // =16
               	sxtw	x12, w12
               	add	x13, x12, #0x8
               	sxtw	x22, w13
               	mov	x0, x22
               	bl	0x400718 <malloc>
               	mov	x22, #0x0               // =0
               	str	x21, [x0]
               	add	x11, x0, #0x8
               	str	x22, [x11]
               	add	x10, x0, #0x10
               	str	x22, [x10]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x11, [x20]
               	cmp	x21, x11
               	b.ge	0x400378 <.text+0x108>
               	add	x23, x20, #0x8
               	ldr	x24, [x23]
               	mov	x0, x24
               	mov	x1, x21
               	bl	0x400288 <.text+0x18>
               	str	x0, [x23]
               	b	0x400348 <.text+0xd8>
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x25, x20, #0x10
               	ldr	x26, [x25]
               	mov	x0, x26
               	mov	x1, x21
               	bl	0x400288 <.text+0x18>
               	str	x0, [x25]
               	b	0x400348 <.text+0xd8>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x20, x0
               	mov	x21, x1
               	cmp	x20, #0x0
               	b.ne	0x4003e4 <.text+0x174>
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x13, [x20]
               	cmp	x13, x21
               	b.ne	0x400414 <.text+0x1a4>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x12, [x20]
               	cmp	x21, x12
               	b.ge	0x400450 <.text+0x1e0>
               	add	x12, x20, #0x8
               	ldr	x22, [x12]
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400394 <.text+0x124>
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x22, x20, #0x10
               	ldr	x23, [x22]
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x400394 <.text+0x124>
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x20, #0x0               // =0
               	mov	x21, #0x32              // =50
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400288 <.text+0x18>
               	mov	x22, x0
               	mov	x23, #0x1e              // =30
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400288 <.text+0x18>
               	mov	x21, #0x46              // =70
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400288 <.text+0x18>
               	mov	x23, #0x14              // =20
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400288 <.text+0x18>
               	mov	x21, #0x28              // =40
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400288 <.text+0x18>
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400394 <.text+0x124>
               	cmp	x0, #0x0
               	b.ne	0x400530 <.text+0x2c0>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x28              // =40
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x400394 <.text+0x124>
               	cmp	x0, #0x0
               	b.ne	0x40056c <.text+0x2fc>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x63              // =99
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400394 <.text+0x124>
               	cmp	x0, #0x1
               	b.ne	0x4005a8 <.text+0x338>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
