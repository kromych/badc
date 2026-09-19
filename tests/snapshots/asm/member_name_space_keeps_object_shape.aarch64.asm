
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
               	mov	x4, #0x0                // =0
               	mov	x7, #0x30               // =48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x4
               	cmp	w0, #0x2
               	b.ge	<addr>
               	mul	x3, x0, x7
               	add	x1, x2, x3
               	add	x5, x4, #0x1
               	str	w4, [x1]
               	add	x4, x5, #0x1
               	str	w5, [x1, #0x4]
               	add	x5, x4, #0x1
               	str	w4, [x1, #0x8]
               	add	x6, x5, #0x1
               	str	w5, [x1, #0xc]
               	add	x4, x1, #0x10
               	add	x5, x6, #0x1
               	str	w6, [x4]
               	add	x6, x5, #0x1
               	str	w5, [x4, #0x4]
               	add	x1, x6, #0x1
               	str	w6, [x4, #0x8]
               	add	x5, x2, x3
               	add	x6, x5, #0x10
               	add	x4, x1, #0x1
               	str	w1, [x6, #0xc]
               	add	x1, x5, #0x20
               	add	x3, x4, #0x1
               	str	w4, [x1]
               	mul	x4, x0, x7
               	add	x5, x2, x4
               	add	x1, x5, #0x20
               	add	x6, x3, #0x1
               	str	w3, [x1, #0x4]
               	add	x3, x6, #0x1
               	str	w6, [x1, #0x8]
               	add	x4, x3, #0x1
               	str	w3, [x1, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x5c]
               	cmp	w1, #0x17
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x4]
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0x8]
               	mov	x3, #0x3                // =3
               	str	w3, [x0, #0xc]
               	add	x1, x0, #0x8
               	mov	x4, #0xa                // =10
               	str	w4, [x1]
               	mov	x4, #0xb                // =11
               	str	w4, [x1, #0x4]
               	mov	x4, #0xc                // =12
               	str	w4, [x1, #0x8]
               	mov	x4, #0xd                // =13
               	str	w4, [x1, #0xc]
               	add	x1, x0, #0x10
               	mov	x4, #0x14               // =20
               	str	w4, [x1]
               	mov	x4, #0x15               // =21
               	str	w4, [x1, #0x4]
               	mov	x4, #0x16               // =22
               	str	w4, [x1, #0x8]
               	mov	x4, #0x17               // =23
               	str	w4, [x1, #0xc]
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w0, #0x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, x3
               	ret
               	mov	x0, x2
               	ret
