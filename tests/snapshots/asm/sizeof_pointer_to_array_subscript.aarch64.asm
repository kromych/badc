
sizeof_pointer_to_array_subscript.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	add	x5, x1, #0x8
               	sub	x1, x5, x1
               	cmp	x1, #0x8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	add	x1, x0, #0x10
               	sub	x1, x1, x0
               	cmp	x1, #0x10
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	add	x1, x2, #0x20
               	sub	x1, x1, x2
               	cmp	x1, #0x20
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	add	x1, x4, #0x40
               	sub	x1, x1, x4
               	cmp	x1, #0x40
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	add	x1, x3, #0x3c
               	sub	x1, x1, x3
               	cmp	x1, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	add	x1, x3, #0x14
               	sub	x1, x1, x3
               	cmp	x1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	add	x1, x8, #0x18
               	sub	x1, x1, x8
               	cmp	x1, #0x18
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	add	x1, x8, #0xc
               	sub	x1, x1, x8
               	cmp	x1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	add	x1, x8, #0x4
               	sub	x1, x1, x8
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	mov	x1, #0x3e8              // =1000
               	movk	x1, #0x3e9, lsl #16
               	str	w1, [x0]
               	mov	x1, #0x3ea              // =1002
               	movk	x1, #0x3eb, lsl #16
               	str	w1, [x0, #0x4]
               	mov	x1, #0x3ec              // =1004
               	movk	x1, #0x3ed, lsl #16
               	str	w1, [x0, #0x8]
               	mov	x1, #0x3ee              // =1006
               	movk	x1, #0x3ef, lsl #16
               	str	w1, [x0, #0xc]
               	mov	x0, #0x100000000        // =4294967296
               	str	x0, [x3]
               	mov	x0, #0x2                // =2
               	movk	x0, #0x3, lsl #32
               	mov	x10, #0x3               // =3
               	str	x0, [x3, #0x8]
               	mov	x11, #0x4               // =4
               	mov	x0, #0x4                // =4
               	movk	x0, #0x64, lsl #32
               	str	x0, [x3, #0x10]
               	mov	x0, #0x65               // =101
               	movk	x0, #0x66, lsl #32
               	str	x0, [x3, #0x18]
               	mov	x0, #0x67               // =103
               	movk	x0, #0x68, lsl #32
               	str	x0, [x3, #0x20]
               	mov	x0, #0xc8               // =200
               	movk	x0, #0xc9, lsl #32
               	str	x0, [x3, #0x28]
               	mov	x0, #0xca               // =202
               	movk	x0, #0xcb, lsl #32
               	str	x0, [x3, #0x30]
               	mov	x0, #0xcc               // =204
               	str	w0, [x3, #0x38]
               	mov	x4, #0x0                // =0
               	mov	x5, #0x14               // =20
               	mov	x6, #0x64               // =100
               	mov	x0, x4
               	mul	x1, x0, x5
               	add	x1, x3, x1
               	ldrsw	x7, [x1]
               	mul	x2, x0, x6
               	cmp	w7, w2
               	b.ne	<addr>
               	mov	x12, #0x1               // =1
               	ldrsw	x7, [x1, #0x4]
               	add	x9, x2, #0x1
               	cmp	w7, w9
               	b.ne	<addr>
               	mov	x12, #0x2               // =2
               	ldrsw	x7, [x1, #0x8]
               	add	x9, x2, #0x2
               	cmp	w7, w9
               	b.ne	<addr>
               	ldrsw	x7, [x1, #0xc]
               	add	x9, x2, #0x3
               	cmp	w7, w9
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x10]
               	add	x2, x2, #0x4
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x4, #0x0                // =0
               	mov	x5, #0x14               // =20
               	mov	x6, #0x64               // =100
               	mov	x0, x4
               	mul	x1, x0, x5
               	add	x1, x3, x1
               	ldrsw	x7, [x1]
               	mul	x2, x0, x6
               	cmp	w7, w2
               	b.ne	<addr>
               	mov	x10, #0x1               // =1
               	ldrsw	x7, [x1, #0x4]
               	add	x9, x2, #0x1
               	cmp	w7, w9
               	b.ne	<addr>
               	mov	x10, #0x2               // =2
               	ldrsw	x7, [x1, #0x8]
               	add	x9, x2, #0x2
               	cmp	w7, w9
               	b.ne	<addr>
               	mov	x10, #0x3               // =3
               	ldrsw	x7, [x1, #0xc]
               	add	x9, x2, #0x3
               	cmp	w7, w9
               	b.ne	<addr>
               	mov	x7, #0x4                // =4
               	ldrsw	x1, [x1, #0x10]
               	add	x2, x2, #0x4
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x4, #0xc                // =12
               	mul	x1, x2, x4
               	and	x0, x1, #0xff
               	strb	w0, [x8, x1]
               	add	x0, x8, x1
               	add	x3, x1, #0x1
               	and	x3, x3, #0xff
               	strb	w3, [x0, #0x1]
               	add	x3, x1, #0x2
               	and	x3, x3, #0xff
               	strb	w3, [x0, #0x2]
               	add	x3, x1, #0x3
               	and	x3, x3, #0xff
               	strb	w3, [x0, #0x3]
               	add	x3, x1, #0x4
               	and	x5, x3, #0xff
               	strb	w5, [x0, #0x4]
               	add	x5, x3, #0x1
               	and	x5, x5, #0xff
               	strb	w5, [x0, #0x5]
               	add	x5, x3, #0x2
               	and	x5, x5, #0xff
               	strb	w5, [x0, #0x6]
               	add	x3, x3, #0x3
               	and	x3, x3, #0xff
               	strb	w3, [x0, #0x7]
               	add	x1, x1, #0x8
               	and	x3, x1, #0xff
               	strb	w3, [x0, #0x8]
               	add	x1, x1, #0x1
               	and	x1, x1, #0xff
               	strb	w1, [x0, #0x9]
               	mul	x0, x2, x4
               	add	x1, x8, x0
               	add	x0, x0, #0x8
               	add	x3, x0, #0x2
               	and	x3, x3, #0xff
               	strb	w3, [x1, #0xa]
               	add	x0, x0, #0x3
               	and	x0, x0, #0xff
               	strb	w0, [x1, #0xb]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.lt	<addr>
               	mov	x9, #0x0                // =0
               	mov	x10, #0xc               // =12
               	mov	x5, #0x0                // =0
               	mul	x4, x9, x10
               	add	x3, x8, x4
               	mov	x0, x5
               	lsl	x2, x0, #2
               	ldrb	w6, [x3, x2]
               	add	x1, x4, x2
               	and	x7, x1, #0xff
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x11, #0x1               // =1
               	add	x2, x3, x2
               	ldrb	w6, [x2, #0x1]
               	add	x7, x1, #0x1
               	and	x7, x7, #0xff
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x11, #0x2               // =2
               	ldrb	w6, [x2, #0x2]
               	add	x7, x1, #0x2
               	and	x7, x7, #0xff
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x6, #0x3                // =3
               	ldrb	w2, [x2, #0x3]
               	add	x1, x1, #0x3
               	and	x1, x1, #0xff
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x9, x9, #0x1
               	cmp	w9, #0x2
               	b.lt	<addr>
               	mov	x9, #0x0                // =0
               	mov	x10, #0xc               // =12
               	mov	x5, #0x0                // =0
               	mul	x4, x9, x10
               	add	x3, x8, x4
               	mov	x0, x5
               	lsl	x2, x0, #2
               	ldrb	w6, [x3, x2]
               	add	x1, x4, x2
               	and	x7, x1, #0xff
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x11, #0x1               // =1
               	add	x2, x3, x2
               	ldrb	w6, [x2, #0x1]
               	add	x7, x1, #0x1
               	and	x7, x7, #0xff
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x11, #0x2               // =2
               	ldrb	w6, [x2, #0x2]
               	add	x7, x1, #0x2
               	and	x7, x7, #0xff
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x6, #0x3                // =3
               	ldrb	w2, [x2, #0x3]
               	add	x1, x1, #0x3
               	and	x1, x1, #0xff
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x9, x9, #0x1
               	cmp	w9, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x5, x6
               	mov	x17, #0xc               // =12
               	mul	x1, x9, x17
               	add	x1, x1, #0x6e
               	add	x0, x1, x0, lsl #2
               	add	x0, x0, x5
               	ret
               	mov	x5, x11
               	b	<addr>
               	mov	x5, x11
               	b	<addr>
               	mov	x5, x6
               	mov	x17, #0xc               // =12
               	mul	x1, x9, x17
               	add	x1, x1, #0x50
               	add	x0, x1, x0, lsl #2
               	add	x0, x0, x5
               	ret
               	mov	x5, x11
               	b	<addr>
               	mov	x5, x11
               	b	<addr>
               	mov	x4, x7
               	add	x0, x0, x0, lsl #2
               	add	x0, x0, #0x3c
               	add	x0, x0, x4
               	ret
               	mov	x4, x10
               	b	<addr>
               	mov	x4, x10
               	b	<addr>
               	mov	x4, x10
               	b	<addr>
               	mov	x4, x11
               	add	x0, x0, x0, lsl #2
               	add	x0, x0, #0x28
               	add	x0, x0, x4
               	ret
               	mov	x4, x10
               	b	<addr>
               	mov	x4, x12
               	b	<addr>
               	mov	x4, x12
               	b	<addr>
