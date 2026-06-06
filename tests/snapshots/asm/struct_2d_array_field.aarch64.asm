
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
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x30
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x30
               	sxtw	x3, w1
               	lsl	x4, x3, #4
               	add	x0, x0, x4
               	sxtw	x4, w2
               	lsl	x5, x4, #2
               	add	x0, x0, x5
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	sxtw	x3, w3
               	add	x3, x3, x4
               	sxtw	x3, w3
               	str	w3, [x0]
               	b	<addr>
               	b	<addr>
               	sxtw	x3, w1
               	cmp	x3, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	sub	x0, x0, #0x6f
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x3, w4
               	cmp	x3, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x3, w4
               	add	x4, x3, #0x1
               	b	<addr>
               	sxtw	x2, w2
               	sxtw	x3, w1
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	sxtw	x5, w4
               	lsl	x5, x5, #2
               	add	x3, x3, x5
               	ldrsw	x3, [x3]
               	add	x2, x2, x3
               	b	<addr>
               	b	<addr>
