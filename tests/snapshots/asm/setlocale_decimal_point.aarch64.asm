
setlocale_decimal_point.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0x110]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x120
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x120
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
               	add	x19, x19, #0x138
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x13e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x145
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
               	add	x19, x19, #0x120
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x120
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	bl	<addr>
               	mov	x20, x0
               	ldr	x0, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x170
               	mov	x1, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x12, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x172
               	mov	x1, x19
               	ldr	x2, [x20]
               	mov	x0, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x6                // =6
               	adrp	x19, <page>
               	add	x19, x19, #0x19a
               	mov	x1, x19
               	mov	x0, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	bl	<addr>
               	mov	x2, x0
               	stur	x2, [x29, #-0x10]
               	b	<addr>
               	ldur	x2, [x29, #-0x10]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1ac
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x21, x0
               	ldr	x0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b2
               	mov	x1, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x12, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1b4
               	mov	x1, x19
               	ldur	x2, [x29, #-0x10]
               	ldr	x3, [x21]
               	mov	x0, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1f4
               	mov	x3, x19
               	mov	x0, x3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
