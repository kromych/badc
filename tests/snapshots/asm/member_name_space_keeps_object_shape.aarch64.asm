
member_name_space_keeps_object_shape.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x10, #0x30              // =48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x3, x1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x5, w3
               	mul	x6, x5, x10
               	add	x8, x4, x6
               	sxtw	x2, w0
               	lsl	x7, x2, #4
               	add	x8, x8, x7
               	add	x9, x8, #0x0
               	add	x8, x1, #0x1
               	str	w1, [x9]
               	add	x1, x4, x6
               	add	x9, x1, x7
               	add	x1, x8, #0x1
               	str	w8, [x9, #0x4]
               	add	x8, x4, x6
               	add	x9, x8, x7
               	add	x8, x1, #0x1
               	str	w1, [x9, #0x8]
               	add	x1, x4, x6
               	add	x5, x1, x7
               	add	x1, x8, #0x1
               	str	w8, [x5, #0xc]
               	add	x0, x2, #0x1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	cmp	x3, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x5c]
               	cmp	x0, #0x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x0                // =0
               	mov	x7, #0xa                // =10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x2, w1
               	lsl	x4, x2, #3
               	add	x0, x3, x4
               	add	x6, x0, #0x0
               	mul	x0, x2, x7
               	add	x5, x0, #0x0
               	str	w5, [x6]
               	add	x6, x3, x4
               	add	x5, x0, #0x1
               	str	w5, [x6, #0x4]
               	add	x6, x3, x4
               	add	x5, x0, #0x2
               	str	w5, [x6, #0x8]
               	add	x4, x3, x4
               	add	x0, x0, #0x3
               	str	w0, [x4, #0xc]
               	add	x1, x2, #0x1
               	cmp	x1, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	x0, #0x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
