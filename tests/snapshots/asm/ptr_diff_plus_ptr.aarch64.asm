
ptr_diff_plus_ptr.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x15, x29, #0x30
               	adrp	x14, <page>
               	add	x14, x14, #0x148
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [x14, #0x10]
               	str	x10, [x15, #0x10]
               	ldr	x10, [x14, #0x18]
               	str	x10, [x15, #0x18]
               	ldr	x10, [x14, #0x20]
               	str	x10, [x15, #0x20]
               	ldr	x10, [x14, #0x28]
               	str	x10, [x15, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x30
               	sub	x14, x29, #0x30
               	sub	x13, x29, #0x30
               	add	x13, x13, #0x20
               	sub	x12, x13, x15
               	mov	x11, #0x10              // =16
               	sdiv	x12, x12, x11
               	lsl	x12, x12, #4
               	add	x12, x12, x14
               	sub	x11, x29, #0x30
               	add	x11, x11, #0x20
               	cmp	x12, x11
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x13, x15
               	mov	x15, #0x10              // =16
               	sdiv	x13, x13, x15
               	lsl	x13, x13, #4
               	add	x15, x14, #0x10
               	add	x13, x13, x15
               	sub	x15, x29, #0x30
               	add	x15, x15, #0x30
               	cmp	x13, x15
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x14, #0x20
               	sub	x13, x29, #0x30
               	add	x13, x13, #0x20
               	cmp	x14, x13
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
