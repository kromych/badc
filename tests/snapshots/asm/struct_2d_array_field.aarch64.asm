
struct_2d_array_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x2, #0x0                // =0
               	mov	x7, #0xa                // =10
               	b	<addr>
               	sub	x4, x29, #0x30
               	lsl	x5, x1, #4
               	add	x3, x4, x5
               	add	x8, x3, #0x0
               	mul	x0, x1, x7
               	add	x6, x0, #0x0
               	str	w6, [x8]
               	add	x6, x0, #0x1
               	str	w6, [x3, #0x4]
               	add	x6, x0, #0x2
               	str	w6, [x3, #0x8]
               	add	x0, x0, #0x3
               	str	w0, [x3, #0xc]
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x3
               	b.lt	<addr>
               	sub	x4, x29, #0x30
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	lsl	x5, x3, #4
               	add	x1, x4, x5
               	add	x6, x1, #0x0
               	ldrsw	x6, [x6]
               	add	x2, x2, x6
               	ldrsw	x6, [x1, #0x4]
               	add	x2, x2, x6
               	ldrsw	x6, [x1, #0x8]
               	add	x2, x2, x6
               	ldrsw	x1, [x1, #0xc]
               	add	x2, x2, x1
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, #0x3
               	b.lt	<addr>
               	sub	x0, x2, #0x6f
               	sxtw	x0, w0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
