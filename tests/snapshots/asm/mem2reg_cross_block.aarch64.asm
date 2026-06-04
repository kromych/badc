
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
               	mov	x0, #0xe                // =14
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	sxtw	x3, w2
               	cmp	x3, #0x3
               	b.ge	<addr>
               	sxtw	x1, w1
               	add	x1, x1, x0
               	sxtw	x1, w1
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	b	<addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
