
sizeof_pointer_to_array_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x4, x3, #0x8
               	sub	x3, x4, x3
               	cmp	x3, #0x8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	add	x3, x2, #0x10
               	sub	x3, x3, x2
               	cmp	x3, #0x10
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	add	x3, x5, #0x20
               	sub	x3, x3, x5
               	cmp	x3, #0x20
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	add	x3, x6, #0x40
               	sub	x3, x3, x6
               	cmp	x3, #0x40
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	add	x3, x0, #0x3c
               	sub	x3, x3, x0
               	cmp	x3, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	add	x3, x0, #0x14
               	sub	x3, x3, x0
               	cmp	x3, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	add	x3, x1, #0x18
               	sub	x3, x3, x1
               	cmp	x3, #0x18
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	add	x3, x1, #0xc
               	sub	x3, x3, x1
               	cmp	x3, #0xc
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	add	x3, x1, #0x4
               	sub	x3, x3, x1
               	cmp	x3, #0x4
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	mov	x3, #0x3e8              // =1000
               	movk	x3, #0x3e9, lsl #16
               	str	w3, [x2]
               	mov	x3, #0x3ea              // =1002
               	movk	x3, #0x3eb, lsl #16
               	str	w3, [x2, #0x4]
               	mov	x3, #0x3ec              // =1004
               	movk	x3, #0x3ed, lsl #16
               	str	w3, [x2, #0x8]
               	mov	x3, #0x3ee              // =1006
               	movk	x3, #0x3ef, lsl #16
               	str	w3, [x2, #0xc]
               	mov	x2, #0x100000000        // =4294967296
               	str	x2, [x0]
               	mov	x2, #0x2                // =2
               	movk	x2, #0x3, lsl #32
               	mov	x10, #0x3               // =3
               	str	x2, [x0, #0x8]
               	mov	x11, #0x4               // =4
               	mov	x2, #0x4                // =4
               	movk	x2, #0x64, lsl #32
               	str	x2, [x0, #0x10]
               	mov	x2, #0x65               // =101
               	movk	x2, #0x66, lsl #32
               	str	x2, [x0, #0x18]
               	mov	x2, #0x67               // =103
               	movk	x2, #0x68, lsl #32
               	str	x2, [x0, #0x20]
               	mov	x2, #0xc8               // =200
               	movk	x2, #0xc9, lsl #32
               	str	x2, [x0, #0x28]
               	mov	x2, #0xca               // =202
               	movk	x2, #0xcb, lsl #32
               	str	x2, [x0, #0x30]
               	mov	x2, #0xcc               // =204
               	str	w2, [x0, #0x38]
               	mov	x5, #0x0                // =0
               	mov	x6, #0x14               // =20
               	mov	x7, #0x64               // =100
               	mov	x2, x5
               	mul	x3, x2, x6
               	add	x3, x0, x3
               	ldrsw	x8, [x3]
               	mul	x4, x2, x7
               	cmp	w8, w4
               	b.ne	<addr>
               	mov	x12, #0x1               // =1
               	ldrsw	x8, [x3, #0x4]
               	add	x9, x4, #0x1
               	cmp	w8, w9
               	b.ne	<addr>
               	mov	x12, #0x2               // =2
               	ldrsw	x8, [x3, #0x8]
               	add	x9, x4, #0x2
               	cmp	w8, w9
               	b.ne	<addr>
               	ldrsw	x8, [x3, #0xc]
               	add	x9, x4, #0x3
               	cmp	w8, w9
               	b.ne	<addr>
               	ldrsw	x3, [x3, #0x10]
               	add	x4, x4, #0x4
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	mov	x6, #0x14               // =20
               	mov	x7, #0x64               // =100
               	mov	x2, x5
               	mul	x3, x2, x6
               	add	x3, x0, x3
               	ldrsw	x8, [x3]
               	mul	x4, x2, x7
               	cmp	w8, w4
               	b.ne	<addr>
               	mov	x10, #0x1               // =1
               	ldrsw	x8, [x3, #0x4]
               	add	x9, x4, #0x1
               	cmp	w8, w9
               	b.ne	<addr>
               	mov	x10, #0x2               // =2
               	ldrsw	x8, [x3, #0x8]
               	add	x9, x4, #0x2
               	cmp	w8, w9
               	b.ne	<addr>
               	mov	x10, #0x3               // =3
               	ldrsw	x8, [x3, #0xc]
               	add	x9, x4, #0x3
               	cmp	w8, w9
               	b.ne	<addr>
               	mov	x8, #0x4                // =4
               	ldrsw	x3, [x3, #0x10]
               	add	x4, x4, #0x4
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	mov	x5, #0xc                // =12
               	mul	x2, x3, x5
               	strb	w2, [x1, x2]
               	add	x0, x1, x2
               	add	x4, x2, #0x1
               	strb	w4, [x0, #0x1]
               	add	x4, x2, #0x2
               	strb	w4, [x0, #0x2]
               	add	x4, x2, #0x3
               	strb	w4, [x0, #0x3]
               	add	x4, x2, #0x4
               	strb	w4, [x0, #0x4]
               	add	x6, x4, #0x1
               	strb	w6, [x0, #0x5]
               	add	x6, x4, #0x2
               	strb	w6, [x0, #0x6]
               	add	x4, x4, #0x3
               	strb	w4, [x0, #0x7]
               	add	x2, x2, #0x8
               	strb	w2, [x0, #0x8]
               	add	x2, x2, #0x1
               	strb	w2, [x0, #0x9]
               	mul	x0, x3, x5
               	add	x2, x1, x0
               	add	x0, x0, #0x8
               	add	x4, x0, #0x2
               	strb	w4, [x2, #0xa]
               	add	x0, x0, #0x3
               	strb	w0, [x2, #0xb]
               	add	x3, x3, #0x1
               	cmp	w3, #0x2
               	b.lt	<addr>
               	mov	x4, #0x0                // =0
               	mov	x10, #0xc               // =12
               	mov	x6, #0x0                // =0
               	mul	x7, x4, x10
               	add	x5, x1, x7
               	mov	x0, x6
               	lsl	x3, x0, #2
               	ldrb	w8, [x5, x3]
               	add	x2, x7, x3
               	cmp	w8, w2
               	b.ne	<addr>
               	mov	x11, #0x1               // =1
               	add	x3, x5, x3
               	ldrb	w8, [x3, #0x1]
               	add	x9, x2, #0x1
               	cmp	w8, w9
               	b.ne	<addr>
               	mov	x11, #0x2               // =2
               	ldrb	w8, [x3, #0x2]
               	add	x9, x2, #0x2
               	cmp	w8, w9
               	b.ne	<addr>
               	mov	x8, #0x3                // =3
               	ldrb	w3, [x3, #0x3]
               	add	x2, x2, #0x3
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x4, x4, #0x1
               	cmp	w4, #0x2
               	b.lt	<addr>
               	mov	x4, #0x0                // =0
               	mov	x10, #0xc               // =12
               	mov	x6, #0x0                // =0
               	mul	x7, x4, x10
               	add	x5, x1, x7
               	mov	x0, x6
               	lsl	x3, x0, #2
               	ldrb	w8, [x5, x3]
               	add	x2, x7, x3
               	cmp	w8, w2
               	b.ne	<addr>
               	mov	x11, #0x1               // =1
               	add	x3, x5, x3
               	ldrb	w8, [x3, #0x1]
               	add	x9, x2, #0x1
               	cmp	w8, w9
               	b.ne	<addr>
               	mov	x11, #0x2               // =2
               	ldrb	w8, [x3, #0x2]
               	add	x9, x2, #0x2
               	cmp	w8, w9
               	b.ne	<addr>
               	mov	x8, #0x3                // =3
               	ldrb	w3, [x3, #0x3]
               	add	x2, x2, #0x3
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x4, x4, #0x1
               	cmp	w4, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x6, x8
               	mov	x17, #0xc               // =12
               	mul	x1, x4, x17
               	add	x1, x1, #0x6e
               	add	x0, x1, x0, lsl #2
               	add	x0, x0, x6
               	ret
               	mov	x6, x11
               	b	<addr>
               	mov	x6, x11
               	b	<addr>
               	mov	x6, x8
               	mov	x17, #0xc               // =12
               	mul	x1, x4, x17
               	add	x1, x1, #0x50
               	add	x0, x1, x0, lsl #2
               	add	x0, x0, x6
               	ret
               	mov	x6, x11
               	b	<addr>
               	mov	x6, x11
               	b	<addr>
               	mov	x5, x8
               	add	x0, x2, x2, lsl #2
               	add	x0, x0, #0x3c
               	add	x0, x0, x5
               	ret
               	mov	x5, x10
               	b	<addr>
               	mov	x5, x10
               	b	<addr>
               	mov	x5, x10
               	b	<addr>
               	mov	x5, x11
               	add	x0, x2, x2, lsl #2
               	add	x0, x0, #0x28
               	add	x0, x0, x5
               	ret
               	mov	x5, x10
               	b	<addr>
               	mov	x5, x12
               	b	<addr>
               	mov	x5, x12
               	b	<addr>
