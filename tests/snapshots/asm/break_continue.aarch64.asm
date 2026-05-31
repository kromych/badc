
break_continue.aarch64:	file format elf64-littleaarch64

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
               	cmp	x15, #0xa
               	b.ge	0x400288 <.text+0x68>
               	b	0x400278 <.text+0x58>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x400254 <.text+0x34>
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, #0x5
               	b.ne	0x40029c <.text+0x7c>
               	b	0x400298 <.text+0x78>
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400288 <.text+0x68>
               	ldursw	x13, [x29, #-0x8]
               	mov	x14, #0x2               // =2
               	sdiv	x17, x13, x14
               	msub	x15, x17, x14, x13
               	cmp	x15, #0x0
               	b.ne	0x4002b8 <.text+0x98>
               	b	0x400264 <.text+0x44>
               	ldursw	x15, [x29, #-0x10]
               	ldursw	x14, [x29, #-0x8]
               	add	x13, x15, x14
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x10]
               	b	0x400264 <.text+0x44>
