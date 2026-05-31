
static_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	add	x15, x15, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x13, x19
               	str	x13, [x15]
               	mov	x14, #0x2               // =2
               	str	w14, [x13]
               	add	x13, x13, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
               	str	x15, [x13]
               	mov	x14, #0x3               // =3
               	str	w14, [x15]
               	add	x15, x15, #0x8
               	mov	x13, #0x0               // =0
               	str	x13, [x15]
               	stur	w13, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x14, x19
               	ldr	x14, [x14]
               	stur	x14, [x29, #-0x10]
               	b	<addr>
               	ldur	x14, [x29, #-0x10]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	ldursw	x13, [x29, #-0x8]
               	ldur	x14, [x29, #-0x10]
               	ldrsw	x15, [x14]
               	add	x13, x13, x15
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x8]
               	add	x14, x14, #0x8
               	ldr	x14, [x14]
               	stur	x14, [x29, #-0x10]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
