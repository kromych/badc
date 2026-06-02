
va_arg_int_seq.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x20
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldur	x1, [x29, #0x10]
               	ldursw	x2, [x29, #0x20]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x10]
               	b	<addr>
               	ldursw	x12, [x29, #-0x10]
               	ldursw	x2, [x29, #0x20]
               	cmp	x12, x2
               	b.ge	<addr>
               	b	<addr>
               	sub	x2, x29, #0x10
               	ldrsw	x12, [x2]
               	add	x12, x12, #0x1
               	str	w12, [x2]
               	b	<addr>
               	sub	x12, x29, #0x8
               	ldr	x1, [x12]
               	add	x17, x1, #0x10
               	str	x17, [x12]
               	ldrsw	x1, [x1]
               	stur	w1, [x29, #-0x18]
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	ldursw	x1, [x29, #-0x10]
               	ldursw	x2, [x29, #-0x18]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	b	<addr>
               	sub	x2, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, #0x162
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, #0x164
               	mov	x1, #0x3                // =3
               	mov	x2, #0xb                // =11
               	mov	x3, #0x16               // =22
               	mov	x4, #0x21               // =33
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x50
               	mov	x10, x0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
