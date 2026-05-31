
static_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	add	x15, x15, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x13, x19
               	str	x13, [x15]
               	mov	x14, #0x2               // =2
               	str	w14, [x13]
               	add	x13, x13, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x15, x19
               	str	x15, [x13]
               	mov	x14, #0x3               // =3
               	str	w14, [x15]
               	add	x15, x15, #0x8
               	mov	x13, #0x0               // =0
               	str	x13, [x15]
               	stur	w13, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x14, x19
               	ldr	x13, [x14]
               	stur	x13, [x29, #-0x10]
               	b	0x4002cc <.text+0x9c>
               	ldur	x13, [x29, #-0x10]
               	cmp	x13, #0x0
               	b.eq	0x400300 <.text+0xd0>
               	ldursw	x14, [x29, #-0x8]
               	ldur	x13, [x29, #-0x10]
               	ldrsw	x15, [x13]
               	add	x14, x14, x15
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x8]
               	add	x13, x13, #0x8
               	ldr	x15, [x13]
               	stur	x15, [x29, #-0x10]
               	b	0x4002cc <.text+0x9c>
               	ldursw	x15, [x29, #-0x8]
               	cmp	x15, #0x6
               	b.eq	0x400320 <.text+0xf0>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
