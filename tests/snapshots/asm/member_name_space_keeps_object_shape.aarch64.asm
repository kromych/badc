
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
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	mov	x3, x2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x5, x4, x17
               	add	x7, x6, x5
               	lsl	x6, x1, #4
               	add	x7, x7, x6
               	add	x8, x7, #0x0
               	add	x7, x2, #0x1
               	str	w2, [x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, x5
               	add	x8, x2, x6
               	add	x2, x7, #0x1
               	str	w7, [x8, #0x4]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	add	x7, x7, x5
               	add	x8, x7, x6
               	add	x7, x2, #0x1
               	str	w2, [x8, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, x5
               	add	x5, x2, x6
               	add	x2, x7, #0x1
               	str	w7, [x5, #0xc]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.lt	<addr>
               	add	x3, x4, #0x1
               	sxtw	x4, w3
               	cmp	x4, #0x2
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
               	mov	x2, #0x0                // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	lsl	x3, x1, #3
               	add	x0, x0, x3
               	add	x5, x0, #0x0
               	mov	x17, #0xa               // =10
               	mul	x0, x1, x17
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
               	add	x2, x1, #0x1
               	sxtw	x1, w2
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
