
goto.aarch64:	file format elf64-littleaarch64

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
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	b	<addr>
               	ldursw	x15, [x29, #-0x8]
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x8]
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x5
               	b.ge	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x15, [x29, #-0x8]
               	add	x15, x15, #0x64
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x8]
               	b	<addr>
