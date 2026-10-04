
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x30               // =48
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, x0
               	mul	x5, x1, x4
               	add	x2, x3, x5
               	add	x6, x0, #0x1
               	str	w0, [x2]
               	add	x0, x6, #0x1
               	str	w6, [x2, #0x4]
               	add	x6, x0, #0x1
               	str	w0, [x2, #0x8]
               	add	x7, x6, #0x1
               	str	w6, [x2, #0xc]
               	add	x0, x2, #0x10
               	add	x2, x7, #0x1
               	str	w7, [x0]
               	add	x6, x2, #0x1
               	str	w2, [x0, #0x4]
               	add	x2, x6, #0x1
               	str	w6, [x0, #0x8]
               	add	x0, x3, x5
               	add	x6, x0, #0x10
               	add	x5, x2, #0x1
               	str	w2, [x6, #0xc]
               	add	x2, x0, #0x20
               	add	x0, x5, #0x1
               	str	w5, [x2]
               	mul	x2, x1, x4
               	add	x2, x3, x2
               	add	x2, x2, #0x20
               	add	x5, x0, #0x1
               	str	w0, [x2, #0x4]
               	add	x6, x5, #0x1
               	str	w5, [x2, #0x8]
               	add	x0, x6, #0x1
               	str	w6, [x2, #0xc]
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	mov	x2, #0x1                // =1
               	str	w2, [x1, #0x4]
               	mov	x2, #0x2                // =2
               	str	w2, [x1, #0x8]
               	mov	x4, #0x3                // =3
               	str	w4, [x1, #0xc]
               	add	x2, x1, #0x10
               	mov	x3, #0xa                // =10
               	str	w3, [x2]
               	mov	x3, #0xb                // =11
               	str	w3, [x2, #0x4]
               	mov	x3, #0xc                // =12
               	str	w3, [x2, #0x8]
               	mov	x3, #0xd                // =13
               	str	w3, [x2, #0xc]
               	add	x3, x1, #0x20
               	mov	x5, #0x14               // =20
               	str	w5, [x3]
               	mov	x5, #0x15               // =21
               	str	w5, [x3, #0x4]
               	mov	x5, #0x16               // =22
               	str	w5, [x3, #0x8]
               	mov	x5, #0x17               // =23
               	str	w5, [x3, #0xc]
               	ldrsw	x3, [x1, #0x2c]
               	cmp	w3, #0x17
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x4]
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, x4
               	ret
               	sub	x1, x2, x1
               	asr	x2, x1, #63
               	lsr	x2, x2, #62
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	cmp	x1, #0x4
               	b.ne	<addr>
               	ret
               	mov	x0, #0x6                // =6
               	ret
