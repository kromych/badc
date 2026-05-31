
do_while.aarch64:	file format elf64-littleaarch64

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
               	stur	w15, [x29, #-0x8]
               	b	0x400250 <.text+0x30>
               	ldursw	x15, [x29, #-0x8]
               	add	x14, x15, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x8]
               	b	0x400264 <.text+0x44>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x5
               	b.lt	0x400250 <.text+0x30>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
