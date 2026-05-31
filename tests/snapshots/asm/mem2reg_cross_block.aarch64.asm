
mem2reg_cross_block.aarch64:	file format elf64-littleaarch64

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
               	mov	x15, #0xe               // =14
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	stur	w14, [x29, #-0x18]
               	b	0x400258 <.text+0x38>
               	ldursw	x14, [x29, #-0x18]
               	cmp	x14, #0x3
               	b.ge	0x40028c <.text+0x6c>
               	ldursw	x14, [x29, #-0x10]
               	sxtw	x13, w15
               	add	x12, x14, x13
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	ldursw	x13, [x29, #-0x18]
               	add	x12, x13, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x18]
               	b	0x400258 <.text+0x38>
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
