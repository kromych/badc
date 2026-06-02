
phi_class_diamond_join.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	cbz	x15, <addr>
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x0, #0x1                // =1
               	mov	x1, #0xa                // =10
               	mov	x20, #0x0               // =0
               	mov	x2, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x2, #0x14               // =20
               	mov	x0, x20
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x21, w21
               	sxtw	x0, w0
               	add	x21, x21, x0
               	sxtw	x0, w21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
