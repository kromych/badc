
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
               	b.ge	0x400310 <.text+0xa0>
               	b	0x4002d4 <.text+0x64>
               	sub	x14, x29, #0x28
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x4002b0 <.text+0x40>
               	mov	x15, #0x10              // =16
               	sxtw	x20, w15
               	mov	x0, x20
               	bl	0x4004a8 <malloc>
               	stur	x0, [x29, #-0x18]
               	ldur	x20, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x28]
               	str	x0, [x20]
               	ldur	x14, [x29, #-0x18]
               	add	x14, x14, #0x8
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x14]
               	ldur	x20, [x29, #-0x18]
               	stur	x20, [x29, #-0x8]
               	b	0x4002c0 <.text+0x50>
               	ldur	x20, [x29, #-0x8]
               	stur	x20, [x29, #-0x10]
               	b	0x40031c <.text+0xac>
               	ldur	x20, [x29, #-0x10]
               	cmp	x20, #0x0
               	b.eq	0x40034c <.text+0xdc>
               	ldursw	x0, [x29, #-0x20]
               	ldur	x20, [x29, #-0x10]
               	ldr	x14, [x20]
               	add	x0, x0, x14
               	stur	w0, [x29, #-0x20]
               	add	x20, x20, #0x8
               	ldr	x14, [x20]
               	stur	x14, [x29, #-0x10]
               	b	0x40031c <.text+0xac>
               	ldursw	x14, [x29, #-0x20]
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
