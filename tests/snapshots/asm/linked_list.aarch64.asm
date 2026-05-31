
linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400288 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x8]
               	stur	w15, [x29, #-0x20]
               	stur	w15, [x29, #-0x28]
               	b	0x4002b0 <.text+0x40>
               	ldursw	x15, [x29, #-0x28]
               	cmp	x15, #0x5
               	b.ge	0x400314 <.text+0xa4>
               	b	0x4002d4 <.text+0x64>
               	sub	x15, x29, #0x28
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x4002b0 <.text+0x40>
               	mov	x13, #0x10              // =16
               	sxtw	x20, w13
               	mov	x0, x20
               	bl	0x4004a8 <malloc>
               	mov	x14, x0
               	stur	x14, [x29, #-0x18]
               	ldur	x20, [x29, #-0x18]
               	ldursw	x14, [x29, #-0x28]
               	str	x14, [x20]
               	ldur	x15, [x29, #-0x18]
               	add	x14, x15, #0x8
               	ldur	x15, [x29, #-0x8]
               	str	x15, [x14]
               	ldur	x20, [x29, #-0x18]
               	stur	x20, [x29, #-0x8]
               	b	0x4002c0 <.text+0x50>
               	ldur	x20, [x29, #-0x8]
               	stur	x20, [x29, #-0x10]
               	b	0x400320 <.text+0xb0>
               	ldur	x20, [x29, #-0x10]
               	cmp	x20, #0x0
               	b.eq	0x400350 <.text+0xe0>
               	ldursw	x20, [x29, #-0x20]
               	ldur	x15, [x29, #-0x10]
               	ldr	x14, [x15]
               	add	x12, x20, x14
               	stur	w12, [x29, #-0x20]
               	add	x14, x15, #0x8
               	ldr	x15, [x14]
               	stur	x15, [x29, #-0x10]
               	b	0x400320 <.text+0xb0>
               	ldursw	x15, [x29, #-0x20]
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
