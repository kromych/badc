
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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x6, x3, #0x8
               	sub	x3, x6, x3
               	cmp	x3, #0x8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	add	x3, x0, #0x10
               	sub	x3, x3, x0
               	cmp	x3, #0x10
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	add	x3, x4, #0x20
               	sub	x3, x3, x4
               	cmp	x3, #0x20
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	add	x3, x5, #0x40
               	sub	x3, x3, x5
               	cmp	x3, #0x40
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	add	x3, x1, #0x3c
               	sub	x3, x3, x1
               	cmp	x3, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	add	x3, x1, #0x14
               	sub	x3, x3, x1
               	cmp	x3, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	add	x3, x2, #0x18
               	sub	x3, x3, x2
               	cmp	x3, #0x18
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	add	x3, x2, #0xc
               	sub	x3, x3, x2
               	cmp	x3, #0xc
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	add	x3, x2, #0x4
               	sub	x3, x3, x2
               	cmp	x3, #0x4
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	add	x3, x0, #0x0
               	mov	x4, #0x3e8              // =1000
               	strh	w4, [x3]
               	mov	x3, #0x3e9              // =1001
               	strh	w3, [x0, #0x2]
               	mov	x3, #0x3ea              // =1002
               	strh	w3, [x0, #0x4]
               	mov	x3, #0x3eb              // =1003
               	strh	w3, [x0, #0x6]
               	mov	x3, #0x3ec              // =1004
               	strh	w3, [x0, #0x8]
               	mov	x3, #0x3ed              // =1005
               	strh	w3, [x0, #0xa]
               	mov	x3, #0x3ee              // =1006
               	strh	w3, [x0, #0xc]
               	mov	x3, #0x3ef              // =1007
               	strh	w3, [x0, #0xe]
               	add	x0, x1, #0x0
               	add	x3, x0, #0x0
               	mov	x4, #0x0                // =0
               	str	w4, [x3]
               	mov	x3, #0x1                // =1
               	str	w3, [x0, #0x4]
               	mov	x3, #0x2                // =2
               	str	w3, [x0, #0x8]
               	mov	x3, #0x3                // =3
               	str	w3, [x0, #0xc]
               	mov	x12, #0x4               // =4
               	str	w12, [x0, #0x10]
               	add	x0, x1, #0x14
               	add	x3, x0, #0x0
               	mov	x4, #0x64               // =100
               	str	w4, [x3]
               	mov	x3, #0x65               // =101
               	str	w3, [x0, #0x4]
               	mov	x3, #0x66               // =102
               	str	w3, [x0, #0x8]
               	mov	x3, #0x67               // =103
               	str	w3, [x0, #0xc]
               	mov	x3, #0x68               // =104
               	str	w3, [x0, #0x10]
               	add	x0, x1, #0x28
               	add	x3, x0, #0x0
               	mov	x4, #0xc8               // =200
               	str	w4, [x3]
               	mov	x3, #0xc9               // =201
               	str	w3, [x0, #0x4]
               	mov	x3, #0xca               // =202
               	str	w3, [x0, #0x8]
               	mov	x3, #0xcb               // =203
               	str	w3, [x0, #0xc]
               	mov	x3, #0xcc               // =204
               	str	w3, [x0, #0x10]
               	mov	x8, #0x0                // =0
               	mov	x9, #0x14               // =20
               	mov	x10, #0x64              // =100
               	mov	x3, x8
               	cmp	w3, #0x3
               	b.ge	<addr>
               	sxtw	x4, w3
               	mul	x6, x4, x9
               	add	x5, x1, x6
               	add	x0, x5, #0x0
               	ldrsw	x11, [x0]
               	mul	x0, x4, x10
               	add	x7, x0, #0x0
               	cmp	w11, w7
               	b.ne	<addr>
               	mov	x13, #0x1               // =1
               	ldrsw	x11, [x5, #0x4]
               	add	x7, x0, #0x1
               	cmp	w11, w7
               	b.ne	<addr>
               	mov	x13, #0x2               // =2
               	ldrsw	x11, [x5, #0x8]
               	add	x7, x0, #0x2
               	cmp	w11, w7
               	b.ne	<addr>
               	mov	x13, #0x3               // =3
               	ldrsw	x11, [x5, #0xc]
               	add	x7, x0, #0x3
               	cmp	w11, w7
               	b.ne	<addr>
               	ldrsw	x5, [x5, #0x10]
               	add	x0, x0, #0x4
               	cmp	w5, w0
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0x3
               	b.lt	<addr>
               	mov	x8, #0x0                // =0
               	mov	x9, #0x14               // =20
               	mov	x10, #0x64              // =100
               	mov	x3, x8
               	cmp	w3, #0x3
               	b.ge	<addr>
               	sxtw	x4, w3
               	mul	x6, x4, x9
               	add	x5, x1, x6
               	add	x0, x5, #0x0
               	ldrsw	x11, [x0]
               	mul	x0, x4, x10
               	add	x7, x0, #0x0
               	cmp	w11, w7
               	b.ne	<addr>
               	mov	x12, #0x1               // =1
               	ldrsw	x11, [x5, #0x4]
               	add	x7, x0, #0x1
               	cmp	w11, w7
               	b.ne	<addr>
               	mov	x12, #0x2               // =2
               	ldrsw	x11, [x5, #0x8]
               	add	x7, x0, #0x2
               	cmp	w11, w7
               	b.ne	<addr>
               	mov	x12, #0x3               // =3
               	ldrsw	x11, [x5, #0xc]
               	add	x7, x0, #0x3
               	cmp	w11, w7
               	b.ne	<addr>
               	mov	x7, #0x4                // =4
               	ldrsw	x5, [x5, #0x10]
               	add	x0, x0, #0x4
               	cmp	w5, w0
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x8, #0xc                // =12
               	cmp	w1, #0x2
               	b.ge	<addr>
               	sxtw	x3, w1
               	mul	x0, x3, x8
               	add	x5, x2, x0
               	add	x6, x5, #0x0
               	add	x9, x6, #0x0
               	add	x4, x0, #0x0
               	add	x7, x4, #0x0
               	and	x7, x7, #0xff
               	strb	w7, [x9]
               	add	x7, x4, #0x1
               	and	x7, x7, #0xff
               	strb	w7, [x6, #0x1]
               	add	x7, x4, #0x2
               	and	x7, x7, #0xff
               	strb	w7, [x6, #0x2]
               	add	x4, x4, #0x3
               	and	x4, x4, #0xff
               	strb	w4, [x6, #0x3]
               	add	x6, x5, #0x4
               	add	x9, x6, #0x0
               	add	x4, x0, #0x4
               	add	x7, x4, #0x0
               	and	x7, x7, #0xff
               	strb	w7, [x9]
               	add	x7, x4, #0x1
               	and	x7, x7, #0xff
               	strb	w7, [x6, #0x1]
               	add	x5, x4, #0x2
               	and	x5, x5, #0xff
               	strb	w5, [x6, #0x2]
               	add	x5, x2, x0
               	add	x5, x5, #0x4
               	add	x0, x4, #0x3
               	and	x0, x0, #0xff
               	strb	w0, [x5, #0x3]
               	mul	x0, x3, x8
               	add	x6, x2, x0
               	add	x5, x6, #0x8
               	add	x9, x5, #0x0
               	add	x4, x0, #0x8
               	add	x7, x4, #0x0
               	and	x7, x7, #0xff
               	strb	w7, [x9]
               	add	x7, x4, #0x1
               	and	x7, x7, #0xff
               	strb	w7, [x5, #0x1]
               	add	x7, x4, #0x2
               	and	x7, x7, #0xff
               	strb	w7, [x5, #0x2]
               	add	x0, x4, #0x3
               	and	x0, x0, #0xff
               	strb	w0, [x5, #0x3]
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.lt	<addr>
               	mov	x6, #0x0                // =0
               	mov	x12, #0xc               // =12
               	cmp	w6, #0x2
               	b.ge	<addr>
               	mov	x11, #0x0               // =0
               	mov	x3, x11
               	cmp	w3, #0x3
               	b.ge	<addr>
               	sxtw	x7, w6
               	mul	x0, x7, x12
               	add	x8, x2, x0
               	sxtw	x9, w3
               	lsl	x1, x9, #2
               	add	x5, x8, x1
               	add	x4, x5, #0x0
               	ldrb	w13, [x4]
               	add	x4, x0, x1
               	add	x10, x4, #0x0
               	and	x10, x10, #0xff
               	cmp	w13, w10
               	b.ne	<addr>
               	mov	x14, #0x1               // =1
               	ldrb	w13, [x5, #0x1]
               	add	x10, x4, #0x1
               	and	x10, x10, #0xff
               	cmp	w13, w10
               	b.ne	<addr>
               	mov	x10, #0x2               // =2
               	ldrb	w5, [x5, #0x2]
               	add	x4, x4, #0x2
               	and	x4, x4, #0xff
               	cmp	w5, w4
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	add	x4, x8, x1
               	ldrb	w4, [x4, #0x3]
               	add	x0, x0, x1
               	add	x0, x0, #0x3
               	and	x0, x0, #0xff
               	cmp	w4, w0
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0x3
               	b.lt	<addr>
               	add	x6, x6, #0x1
               	cmp	w6, #0x2
               	b.lt	<addr>
               	mov	x6, #0x0                // =0
               	mov	x12, #0xc               // =12
               	cmp	w6, #0x2
               	b.ge	<addr>
               	mov	x11, #0x0               // =0
               	mov	x3, x11
               	cmp	w3, #0x3
               	b.ge	<addr>
               	sxtw	x7, w6
               	mul	x0, x7, x12
               	add	x8, x2, x0
               	sxtw	x9, w3
               	lsl	x1, x9, #2
               	add	x5, x8, x1
               	add	x4, x5, #0x0
               	ldrb	w13, [x4]
               	add	x4, x0, x1
               	add	x10, x4, #0x0
               	and	x10, x10, #0xff
               	cmp	w13, w10
               	b.ne	<addr>
               	mov	x14, #0x1               // =1
               	ldrb	w13, [x5, #0x1]
               	add	x10, x4, #0x1
               	and	x10, x10, #0xff
               	cmp	w13, w10
               	b.ne	<addr>
               	mov	x10, #0x2               // =2
               	ldrb	w5, [x5, #0x2]
               	add	x4, x4, #0x2
               	and	x4, x4, #0xff
               	cmp	w5, w4
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	add	x4, x8, x1
               	ldrb	w4, [x4, #0x3]
               	add	x0, x0, x1
               	add	x0, x0, #0x3
               	and	x0, x0, #0xff
               	cmp	w4, w0
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0x3
               	b.lt	<addr>
               	add	x6, x6, #0x1
               	cmp	w6, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x11, x5
               	mov	x17, #0xc               // =12
               	mul	x0, x6, x17
               	add	x0, x0, #0x6e
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	add	x0, x0, x11
               	sxtw	x0, w0
               	ret
               	mov	x11, x10
               	b	<addr>
               	mov	x11, x14
               	b	<addr>
               	mov	x11, x5
               	mov	x17, #0xc               // =12
               	mul	x0, x6, x17
               	add	x0, x0, #0x50
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	add	x0, x0, x11
               	sxtw	x0, w0
               	ret
               	mov	x11, x10
               	b	<addr>
               	mov	x11, x14
               	b	<addr>
               	mov	x8, x7
               	mov	x17, #0x5               // =5
               	mul	x0, x3, x17
               	add	x0, x0, #0x3c
               	add	x0, x0, x8
               	sxtw	x0, w0
               	ret
               	mov	x8, x12
               	b	<addr>
               	mov	x8, x12
               	b	<addr>
               	mov	x8, x12
               	b	<addr>
               	mov	x8, x12
               	mov	x17, #0x5               // =5
               	mul	x0, x3, x17
               	add	x0, x0, #0x28
               	add	x0, x0, x8
               	sxtw	x0, w0
               	ret
               	mov	x8, x13
               	b	<addr>
               	mov	x8, x13
               	b	<addr>
               	mov	x8, x13
               	b	<addr>
