
va_copy.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x10
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	sub	x13, x29, #0x10
               	sub	x14, x29, #0x8
               	ldr	x17, [x14]
               	str	x17, [x13]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x18]
               	stur	w15, [x29, #-0x20]
               	b	<addr>
               	ldursw	x15, [x29, #-0x20]
               	ldursw	x14, [x29, #0x10]
               	cmp	x15, x14
               	b.ge	<addr>
               	ldursw	x14, [x29, #-0x18]
               	sub	x15, x29, #0x10
               	ldr	x13, [x15]
               	add	x17, x13, #0x10
               	str	x17, [x15]
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	ldursw	x13, [x29, #-0x20]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x20]
               	b	<addr>
               	sub	x13, x29, #0x10
               	sub	x14, x29, #0x8
               	ldursw	x0, [x29, #-0x18]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4                // =4
               	mov	x1, #0xa                // =10
               	mov	x2, #0x14               // =20
               	mov	x3, #0x1e               // =30
               	mov	x4, #0x28               // =40
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x50
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x3, #0xb                // =11
               	mov	x0, x3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
