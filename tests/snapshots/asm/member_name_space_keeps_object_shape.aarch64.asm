
member_name_space_keeps_object_shape.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x6, x4, x17
               	add	x5, x5, x6
               	lsl	x6, x1, #4
               	add	x5, x5, x6
               	add	x6, x5, #0x0
               	add	x5, x2, #0x1
               	str	w2, [x6]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x6, x4, x17
               	add	x2, x2, x6
               	lsl	x6, x1, #4
               	add	x6, x2, x6
               	add	x2, x5, #0x1
               	str	w5, [x6, #0x4]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x6, x4, x17
               	add	x5, x5, x6
               	lsl	x6, x1, #4
               	add	x6, x5, x6
               	add	x5, x2, #0x1
               	str	w2, [x6, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x6, x4, x17
               	add	x2, x2, x6
               	lsl	x6, x1, #4
               	add	x6, x2, x6
               	add	x2, x5, #0x1
               	str	w5, [x6, #0xc]
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
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x3, x0, #3
               	add	x2, x2, x3
               	add	x3, x2, #0x0
               	mov	x17, #0xa               // =10
               	mul	x2, x0, x17
               	add	x2, x2, #0x0
               	str	w2, [x3]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x3, x0, #3
               	add	x3, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x0, x17
               	add	x2, x2, #0x1
               	str	w2, [x3, #0x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x3, x0, #3
               	add	x3, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x0, x17
               	add	x2, x2, #0x2
               	str	w2, [x3, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x3, x0, #3
               	add	x3, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x0, x17
               	add	x2, x2, #0x3
               	str	w2, [x3, #0xc]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
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
