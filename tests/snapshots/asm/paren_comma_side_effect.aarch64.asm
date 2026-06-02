
paren_comma_side_effect.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x0, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x14, x19
               	str	w0, [x14]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x14, #0x0               // =0
               	str	w14, [x20]
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x14, x0
               	ldrsw	x20, [x20]
               	cmp	x20, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x14, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x1, x19
               	mov	x0, x14
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x21, x19
               	mov	x0, #0x1                // =1
               	str	w0, [x21]
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	mov	x14, x0
               	mov	x0, #0xd                // =13
               	bl	<addr>
               	mov	x14, x0
               	ldrsw	x21, [x21]
               	cmp	x21, #0xd
               	b.eq	<addr>
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x16b
               	mov	x1, x19
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
