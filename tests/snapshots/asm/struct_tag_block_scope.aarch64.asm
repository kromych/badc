
struct_tag_block_scope.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x15, x29, #0x8
               	mov	x14, #0x2               // =2
               	str	w14, [x15]
               	sub	x13, x29, #0x10
               	mov	x14, #0x5               // =5
               	str	w14, [x13]
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	cmp	x14, #0x5
               	b.eq	0x40027c <.text+0x5c>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	mov	x0, #0x3                // =3
               	str	w0, [x15]
               	sub	x13, x29, #0x8
               	ldrsw	x0, [x13]
               	cmp	x0, #0x2
               	b.eq	0x4002a8 <.text+0x88>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldrsw	x0, [x13]
               	cmp	x0, #0x3
               	b.eq	0x4002c8 <.text+0xa8>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
