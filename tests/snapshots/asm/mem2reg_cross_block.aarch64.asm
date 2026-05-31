
mem2reg_cross_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0xe               // =14
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	ldursw	x14, [x29, #-0x18]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	ldursw	x13, [x29, #-0x10]
               	add	x13, x13, x15
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x10]
               	ldursw	x14, [x29, #-0x18]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
