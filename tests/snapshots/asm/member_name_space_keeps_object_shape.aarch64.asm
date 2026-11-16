
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
               	mov	x4, #0x30               // =48
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, x1
               	mul	x5, x2, x4
               	add	x0, x3, x5
               	add	x6, x1, #0x1
               	str	w1, [x0]
               	add	x1, x6, #0x1
               	str	w6, [x0, #0x4]
               	add	x6, x1, #0x1
               	str	w1, [x0, #0x8]
               	add	x1, x6, #0x1
               	str	w6, [x0, #0xc]
               	add	x6, x1, #0x1
               	str	w1, [x0, #0x10]
               	add	x1, x6, #0x1
               	str	w6, [x0, #0x14]
               	add	x6, x1, #0x1
               	str	w1, [x0, #0x18]
               	add	x0, x3, x5
               	add	x1, x6, #0x1
               	str	w6, [x0, #0x1c]
               	add	x5, x1, #0x1
               	str	w1, [x0, #0x20]
               	mul	x0, x2, x4
               	add	x0, x3, x0
               	add	x1, x5, #0x1
               	str	w5, [x0, #0x24]
               	add	x5, x1, #0x1
               	str	w1, [x0, #0x28]
               	add	x1, x5, #0x1
               	str	w5, [x0, #0x2c]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
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
               	mov	x2, #0x100000000        // =4294967296
               	str	x2, [x1]
               	mov	x2, #0x2                // =2
               	movk	x2, #0x3, lsl #32
               	mov	x3, #0x3                // =3
               	str	x2, [x1, #0x8]
               	mov	x2, #0xa                // =10
               	movk	x2, #0xb, lsl #32
               	str	x2, [x1, #0x10]
               	mov	x2, #0xc                // =12
               	movk	x2, #0xd, lsl #32
               	str	x2, [x1, #0x18]
               	mov	x2, #0x14               // =20
               	movk	x2, #0x15, lsl #32
               	str	x2, [x1, #0x20]
               	mov	x2, #0x16               // =22
               	movk	x2, #0x17, lsl #32
               	str	x2, [x1, #0x28]
               	ldrsw	x2, [x1, #0x4]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, x3
               	ret
               	add	x2, x1, #0x10
               	sub	x1, x2, x1
               	asr	x2, x1, #63
               	add	x1, x1, x2, lsr #62
               	asr	x1, x1, #2
               	cmp	x1, #0x4
               	b.ne	<addr>
               	ret
               	mov	x0, #0x6                // =6
               	ret
