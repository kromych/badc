
mem2reg_addr_taken_neighbor.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x15, w0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	lsl	x15, x15, #1
               	sxtw	x15, w15
               	sub	x13, x29, #0x8
               	stur	w14, [x29, #-0x20]
               	b	<addr>
               	ldursw	x14, [x29, #-0x20]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	ldrsw	x12, [x13]
               	sxtw	x14, w15
               	add	x12, x12, x14
               	sxtw	x12, w12
               	str	w12, [x13]
               	ldursw	x14, [x29, #-0x20]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x20]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x14, x0
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
