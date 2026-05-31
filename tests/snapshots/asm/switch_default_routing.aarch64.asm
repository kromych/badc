
switch_default_routing.aarch64:	file format elf64-littleaarch64

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
               	mov	x15, #0x63              // =99
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	sxtw	x15, w15
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0xa               // =10
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	mov	x13, #0x14              // =20
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	mov	x13, #0x64              // =100
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	cmp	x15, #0x1
               	b.eq	<addr>
               	cmp	x15, #0x2
               	b.eq	<addr>
               	b	<addr>
