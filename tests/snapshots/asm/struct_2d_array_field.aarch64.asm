
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
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x38]
               	b	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x38
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x40]
               	b	<addr>
               	sub	x0, x29, #0x30
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x50]
               	stur	w1, [x29, #-0x38]
               	b	<addr>
               	ldursw	x0, [x29, #-0x40]
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x30
               	ldursw	x1, [x29, #-0x38]
               	lsl	x2, x1, #4
               	add	x0, x0, x2
               	ldursw	x2, [x29, #-0x40]
               	lsl	x3, x2, #2
               	add	x0, x0, x3
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	str	w1, [x0]
               	b	<addr>
               	b	<addr>
               	ldursw	x1, [x29, #-0x38]
               	cmp	x1, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x38
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x40]
               	b	<addr>
               	ldursw	x0, [x29, #-0x50]
               	sub	x0, x0, #0x6f
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x1, [x29, #-0x40]
               	cmp	x1, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	b	<addr>
               	sub	x1, x29, #0x50
               	ldrsw	x2, [x1]
               	ldursw	x3, [x29, #-0x38]
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldursw	x4, [x29, #-0x40]
               	lsl	x4, x4, #2
               	add	x3, x3, x4
               	ldrsw	x3, [x3]
               	add	x2, x2, x3
               	str	w2, [x1]
               	b	<addr>
               	b	<addr>
