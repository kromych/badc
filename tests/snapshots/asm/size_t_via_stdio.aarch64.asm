
size_t_via_stdio.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
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
               	add	x11, x11, #0x110
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x116
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x11d
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
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	mov	x0, #0x0                // =0
               	ret
               	mov	x15, x0
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	mov	x0, #0x0                // =0
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	adrp	x14, <page>
               	add	x14, x14, #0x148
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x14, x0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x14, x0
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	mov	x13, x0
               	adrp	x13, <page>
               	add	x13, x13, #0x148
               	ldrsw	x0, [x13]
               	ldp	x29, x30, [sp], #0x10
               	ret
