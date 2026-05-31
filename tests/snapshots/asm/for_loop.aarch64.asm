
for_loop.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x10]
               	stur	w15, [x29, #-0x8]
               	b	0x400254 <.text+0x34>
               	ldursw	x15, [x29, #-0x8]
               	cmp	x15, #0x5
               	b.ge	0x400290 <.text+0x70>
               	b	0x400278 <.text+0x58>
               	sub	x14, x29, #0x8
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x400254 <.text+0x34>
               	ldursw	x15, [x29, #-0x10]
               	ldursw	x13, [x29, #-0x8]
               	add	x15, x15, x13
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x10]
               	b	0x400264 <.text+0x44>
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
