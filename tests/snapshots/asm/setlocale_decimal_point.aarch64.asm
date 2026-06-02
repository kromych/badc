
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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x120
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
               	add	x11, x11, #0x138
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x13e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x145
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	bl	<addr>
               	mov	x20, x0
               	ldr	x0, [x20]
               	adrp	x1, <page>
               	add	x1, x1, #0x170
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x12, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x172
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
               	adrp	x1, <page>
               	add	x1, x1, #0x19a
               	mov	x0, x2
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	adrp	x1, <page>
               	add	x1, x1, #0x1a0
               	bl	<addr>
               	mov	x2, x0
               	stur	x2, [x29, #-0x10]
               	b	<addr>
               	ldur	x2, [x29, #-0x10]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1ac
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
               	adrp	x1, <page>
               	add	x1, x1, #0x1b2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x12, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x1b4
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
               	adrp	x3, <page>
               	add	x3, x3, #0x1f4
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
