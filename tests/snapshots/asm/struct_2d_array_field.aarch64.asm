
struct_2d_array_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x38]
               	b	<addr>
               	ldursw	x15, [x29, #-0x38]
               	cmp	x15, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x38
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x40]
               	b	<addr>
               	sub	x14, x29, #0x30
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x50]
               	stur	w13, [x29, #-0x38]
               	b	<addr>
               	ldursw	x15, [x29, #-0x40]
               	cmp	x15, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x40
               	ldrsw	x15, [x13]
               	add	x15, x15, #0x1
               	str	w15, [x13]
               	b	<addr>
               	sub	x15, x29, #0x30
               	ldursw	x14, [x29, #-0x38]
               	lsl	x13, x14, #4
               	add	x15, x15, x13
               	ldursw	x13, [x29, #-0x40]
               	lsl	x12, x13, #2
               	add	x15, x15, x12
               	mov	x17, #0xa               // =10
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x14, x14, x13
               	sxtw	x14, w14
               	str	w14, [x15]
               	b	<addr>
               	b	<addr>
               	ldursw	x13, [x29, #-0x38]
               	cmp	x13, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x38
               	ldrsw	x13, [x15]
               	add	x13, x13, #0x1
               	str	w13, [x15]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x40]
               	b	<addr>
               	ldursw	x15, [x29, #-0x50]
               	sub	x15, x15, #0x6f
               	sxtw	x0, w15
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x13, [x29, #-0x40]
               	cmp	x13, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x40
               	ldrsw	x13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	<addr>
               	sub	x13, x29, #0x50
               	ldrsw	x15, [x13]
               	ldursw	x12, [x29, #-0x38]
               	lsl	x12, x12, #4
               	add	x11, x14, x12
               	ldursw	x12, [x29, #-0x40]
               	lsl	x12, x12, #2
               	add	x11, x11, x12
               	ldrsw	x12, [x11]
               	add	x15, x15, x12
               	str	w15, [x13]
               	b	<addr>
               	b	<addr>
