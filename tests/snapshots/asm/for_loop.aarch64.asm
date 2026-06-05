
for_loop.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b	<addr>
               	sxtw	x0, w1
               	ldursw	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	b	<addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
