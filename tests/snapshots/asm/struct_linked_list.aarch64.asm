
struct_linked_list.aarch64:	file format elf64-littleaarch64

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
               	b	0x4002ac <.text+0x3c>
               	ldursw	x15, [x29, #-0x20]
               	cmp	x15, #0x5
               	b.ge	0x400308 <.text+0x98>
               	b	0x4002d0 <.text+0x60>
               	sub	x15, x29, #0x20
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x4002ac <.text+0x3c>
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	bl	0x4004a8 <malloc>
               	stur	x0, [x29, #-0x10]
               	ldur	x20, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x20]
               	str	w0, [x20]
               	ldur	x15, [x29, #-0x10]
               	add	x0, x15, #0x8
               	ldur	x15, [x29, #-0x8]
               	str	x15, [x0]
               	ldur	x20, [x29, #-0x10]
               	stur	x20, [x29, #-0x8]
               	b	0x4002bc <.text+0x4c>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x18]
               	ldur	x15, [x29, #-0x8]
               	stur	x15, [x29, #-0x10]
               	b	0x40031c <.text+0xac>
               	ldur	x15, [x29, #-0x10]
               	cmp	x15, #0x0
               	b.eq	0x400350 <.text+0xe0>
               	ldursw	x15, [x29, #-0x18]
               	ldur	x20, [x29, #-0x10]
               	ldrsw	x0, [x20]
               	add	x12, x15, x0
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x18]
               	add	x0, x20, #0x8
               	ldr	x20, [x0]
               	stur	x20, [x29, #-0x10]
               	b	0x40031c <.text+0xac>
               	ldursw	x20, [x29, #-0x18]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
