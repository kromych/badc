
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
               	mov	x3, #0x0                // =0
               	mov	x6, #0x30               // =48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x3
               	cmp	w0, #0x2
               	b.ge	<addr>
               	mul	x2, x0, x6
               	add	x4, x1, x2
               	add	x4, x4, #0x0
               	add	x5, x4, #0x0
               	add	x4, x3, #0x1
               	str	w3, [x5]
               	add	x3, x1, x2
               	add	x5, x3, #0x0
               	add	x3, x4, #0x1
               	str	w4, [x5, #0x4]
               	add	x4, x1, x2
               	add	x5, x4, #0x0
               	add	x4, x3, #0x1
               	str	w3, [x5, #0x8]
               	add	x3, x1, x2
               	add	x5, x3, #0x0
               	add	x3, x4, #0x1
               	str	w4, [x5, #0xc]
               	add	x4, x1, x2
               	add	x4, x4, #0x10
               	add	x5, x4, #0x0
               	add	x4, x3, #0x1
               	str	w3, [x5]
               	add	x3, x1, x2
               	add	x5, x3, #0x10
               	add	x3, x4, #0x1
               	str	w4, [x5, #0x4]
               	add	x4, x1, x2
               	add	x5, x4, #0x10
               	add	x4, x3, #0x1
               	str	w3, [x5, #0x8]
               	add	x3, x1, x2
               	add	x5, x3, #0x10
               	add	x3, x4, #0x1
               	str	w4, [x5, #0xc]
               	add	x4, x1, x2
               	add	x4, x4, #0x20
               	add	x5, x4, #0x0
               	add	x4, x3, #0x1
               	str	w3, [x5]
               	add	x3, x1, x2
               	add	x5, x3, #0x20
               	add	x3, x4, #0x1
               	str	w4, [x5, #0x4]
               	add	x4, x1, x2
               	add	x5, x4, #0x20
               	add	x4, x3, #0x1
               	str	w3, [x5, #0x8]
               	add	x2, x1, x2
               	add	x2, x2, #0x20
               	add	x3, x4, #0x1
               	str	w4, [x2, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x5c]
               	cmp	w0, #0x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	add	x0, x0, #0x0
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	mov	x2, #0x3                // =3
               	str	w2, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	add	x0, x0, #0x0
               	mov	x3, #0xa                // =10
               	str	w3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	mov	x3, #0xb                // =11
               	str	w3, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	mov	x3, #0xc                // =12
               	str	w3, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	mov	x3, #0xd                // =13
               	str	w3, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	add	x0, x0, #0x0
               	mov	x3, #0x14               // =20
               	str	w3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	mov	x3, #0x15               // =21
               	str	w3, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	mov	x3, #0x16               // =22
               	str	w3, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	mov	x3, #0x17               // =23
               	str	w3, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w0, #0x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, x2
               	ret
               	mov	x0, x1
               	ret
