
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
               	mov	x3, x1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x4, w3
               	mov	x17, #0x30              // =48
               	mul	x5, x4, x17
               	add	x7, x2, x5
               	sxtw	x2, w0
               	lsl	x6, x2, #4
               	add	x7, x7, x6
               	add	x8, x7, #0x0
               	add	x7, x1, #0x1
               	str	w1, [x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x5
               	add	x8, x1, x6
               	add	x1, x7, #0x1
               	str	w7, [x8, #0x4]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	add	x7, x7, x5
               	add	x8, x7, x6
               	add	x7, x1, #0x1
               	str	w1, [x8, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x5
               	add	x4, x1, x6
               	add	x1, x7, #0x1
               	str	w7, [x4, #0xc]
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	cmp	w3, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x5c]
               	cmp	w0, #0x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w1
               	lsl	x3, x2, #3
               	add	x0, x0, x3
               	add	x5, x0, #0x0
               	mov	x17, #0xa               // =10
               	mul	x0, x2, x17
               	add	x4, x0, #0x0
               	str	w4, [x5]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x5, x4, x3
               	add	x4, x0, #0x1
               	str	w4, [x5, #0x4]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x5, x4, x3
               	add	x4, x0, #0x2
               	str	w4, [x5, #0x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x3, x4, x3
               	add	x0, x0, #0x3
               	str	w0, [x3, #0xc]
               	add	x1, x2, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w0, #0x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
