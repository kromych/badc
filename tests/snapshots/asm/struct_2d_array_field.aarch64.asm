
struct_2d_array_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x30
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	add	x2, x2, #0x0
               	mov	x17, #0xa               // =10
               	mul	x3, x0, x17
               	add	x3, x3, #0x0
               	str	w3, [x2]
               	sub	x2, x29, #0x30
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x3, x0, x17
               	add	x3, x3, #0x1
               	str	w3, [x2, #0x4]
               	sub	x2, x29, #0x30
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x3, x0, x17
               	add	x3, x3, #0x2
               	str	w3, [x2, #0x8]
               	sub	x2, x29, #0x30
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x3, x0, x17
               	add	x3, x3, #0x3
               	str	w3, [x2, #0xc]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x30
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	add	x4, x4, #0x0
               	ldrsw	x4, [x4]
               	add	x2, x2, x4
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrsw	x4, [x4, #0x4]
               	add	x2, x2, x4
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrsw	x4, [x4, #0x8]
               	add	x2, x2, x4
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrsw	x4, [x4, #0xc]
               	add	x2, x2, x4
               	add	x1, x3, #0x1
               	sxtw	x3, w1
               	cmp	x3, #0x3
               	b.lt	<addr>
               	sub	x0, x2, #0x6f
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
