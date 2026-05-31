
mem2reg_addr_taken_neighbor.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002a8 <.text+0x88>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x15, w0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	lsl	x13, x15, #1
               	sxtw	x13, w13
               	sub	x15, x29, #0x8
               	stur	w14, [x29, #-0x20]
               	b	0x400264 <.text+0x44>
               	ldursw	x14, [x29, #-0x20]
               	cmp	x14, #0x3
               	b.ge	0x400298 <.text+0x78>
               	ldrsw	x14, [x15]
               	sxtw	x12, w13
               	add	x11, x14, x12
               	sxtw	x11, w11
               	str	w11, [x15]
               	ldursw	x12, [x29, #-0x20]
               	add	x11, x12, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x20]
               	b	0x400264 <.text+0x44>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
