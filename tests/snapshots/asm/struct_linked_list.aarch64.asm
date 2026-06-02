
struct_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x8]
               	stur	w15, [x29, #-0x20]
               	b	<addr>
               	ldursw	x15, [x29, #-0x20]
               	cmp	x15, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x20
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	ldur	x13, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x20]
               	str	w0, [x13]
               	ldur	x14, [x29, #-0x10]
               	add	x14, x14, #0x8
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x14]
               	ldur	x13, [x29, #-0x10]
               	stur	x13, [x29, #-0x8]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x18]
               	ldur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x10]
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	ldursw	x13, [x29, #-0x18]
               	ldur	x0, [x29, #-0x10]
               	ldrsw	x14, [x0]
               	add	x13, x13, x14
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
