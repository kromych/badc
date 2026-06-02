
vtable_back_to_back.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x118
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x11e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x125
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	sxtw	x13, w2
               	sxtw	x12, w3
               	adrp	x14, <page>
               	add	x14, x14, #0x150
               	str	x14, [x15]
               	add	x15, x15, #0x8
               	add	x13, x13, x12
               	sxtw	x13, w13
               	str	w13, [x15]
               	mov	x0, #0x0                // =0
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	sxtw	x0, w2
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	str	w15, [x14]
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x19, [sp]
               	sub	x15, x29, #0x10
               	adrp	x14, <page>
               	add	x14, x14, #0x170
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	ldr	x15, [x15]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x2, #0x2a               // =42
               	mov	x3, #0x8                // =8
               	mov	x9, x15
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	mov	x10, x0
               	sub	x10, x29, #0x10
               	ldr	x10, [x10]
               	add	x10, x10, #0x8
               	ldr	x10, [x10]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x40
               	mov	x2, #0x1                // =1
               	mov	x9, x10
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	blr	x9
               	add	sp, sp, #0x30
               	mov	x3, x0
               	adrp	x0, <page>
               	add	x0, x0, #0x180
               	ldursw	x1, [x29, #-0x40]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	ldursw	x0, [x29, #-0x40]
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
