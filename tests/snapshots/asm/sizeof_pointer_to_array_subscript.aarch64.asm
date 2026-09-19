
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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x6, x1, #0x8
               	sub	x1, x6, x1
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
               	add	x1, x3, #0x20
               	sub	x1, x1, x3
               	cmp	x1, #0x20
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	add	x1, x5, #0x40
               	sub	x1, x1, x5
               	cmp	x1, #0x40
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	add	x1, x2, #0x3c
               	sub	x1, x1, x2
               	cmp	x1, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	add	x1, x2, #0x14
               	sub	x1, x1, x2
               	cmp	x1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	add	x1, x4, #0x18
               	sub	x1, x1, x4
               	cmp	x1, #0x18
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	add	x1, x4, #0xc
               	sub	x1, x1, x4
               	cmp	x1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	add	x1, x4, #0x4
               	sub	x1, x1, x4
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	mov	x1, #0x3e8              // =1000
               	strh	w1, [x0]
               	mov	x1, #0x3e9              // =1001
               	strh	w1, [x0, #0x2]
               	mov	x1, #0x3ea              // =1002
               	strh	w1, [x0, #0x4]
               	mov	x1, #0x3eb              // =1003
               	strh	w1, [x0, #0x6]
               	mov	x1, #0x3ec              // =1004
               	strh	w1, [x0, #0x8]
               	mov	x1, #0x3ed              // =1005
               	strh	w1, [x0, #0xa]
               	mov	x1, #0x3ee              // =1006
               	strh	w1, [x0, #0xc]
               	mov	x1, #0x3ef              // =1007
               	strh	w1, [x0, #0xe]
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	mov	x0, #0x1                // =1
               	str	w0, [x2, #0x4]
               	mov	x0, #0x2                // =2
               	str	w0, [x2, #0x8]
               	mov	x0, #0x3                // =3
               	str	w0, [x2, #0xc]
               	mov	x11, #0x4               // =4
               	str	w11, [x2, #0x10]
               	add	x0, x2, #0x14
               	mov	x1, #0x64               // =100
               	str	w1, [x0]
               	mov	x1, #0x65               // =101
               	str	w1, [x0, #0x4]
               	mov	x1, #0x66               // =102
               	str	w1, [x0, #0x8]
               	mov	x1, #0x67               // =103
               	str	w1, [x0, #0xc]
               	mov	x1, #0x68               // =104
               	str	w1, [x0, #0x10]
               	add	x0, x2, #0x28
               	mov	x1, #0xc8               // =200
               	str	w1, [x0]
               	mov	x1, #0xc9               // =201
               	str	w1, [x0, #0x4]
               	mov	x1, #0xca               // =202
               	str	w1, [x0, #0x8]
               	mov	x1, #0xcb               // =203
               	str	w1, [x0, #0xc]
               	mov	x1, #0xcc               // =204
               	str	w1, [x0, #0x10]
               	mov	x7, #0x0                // =0
               	mov	x8, #0x14               // =20
               	mov	x9, #0x64               // =100
               	mov	x0, x7
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mul	x5, x0, x8
               	add	x3, x2, x5
               	ldrsw	x6, [x3]
               	mul	x1, x0, x9
               	cmp	w6, w1
               	b.ne	<addr>
               	mov	x12, #0x1               // =1
               	ldrsw	x10, [x3, #0x4]
               	add	x6, x1, #0x1
               	cmp	w10, w6
               	b.ne	<addr>
               	mov	x12, #0x2               // =2
               	ldrsw	x10, [x3, #0x8]
               	add	x6, x1, #0x2
               	cmp	w10, w6
               	b.ne	<addr>
               	mov	x12, #0x3               // =3
               	ldrsw	x10, [x3, #0xc]
               	add	x6, x1, #0x3
               	cmp	w10, w6
               	b.ne	<addr>
               	ldrsw	x3, [x3, #0x10]
               	add	x1, x1, #0x4
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x7, #0x0                // =0
               	mov	x8, #0x14               // =20
               	mov	x9, #0x64               // =100
               	mov	x0, x7
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mul	x5, x0, x8
               	add	x3, x2, x5
               	ldrsw	x6, [x3]
               	mul	x1, x0, x9
               	cmp	w6, w1
               	b.ne	<addr>
               	mov	x12, #0x1               // =1
               	ldrsw	x10, [x3, #0x4]
               	add	x6, x1, #0x1
               	cmp	w10, w6
               	b.ne	<addr>
               	mov	x12, #0x2               // =2
               	ldrsw	x10, [x3, #0x8]
               	add	x6, x1, #0x2
               	cmp	w10, w6
               	b.ne	<addr>
               	mov	x12, #0x3               // =3
               	ldrsw	x10, [x3, #0xc]
               	add	x6, x1, #0x3
               	cmp	w10, w6
               	b.ne	<addr>
               	ldrsw	x3, [x3, #0x10]
               	add	x1, x1, #0x4
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x7, #0xc                // =12
               	cmp	w1, #0x2
               	b.ge	<addr>
               	mul	x0, x1, x7
               	add	x2, x4, x0
               	and	x3, x0, #0xff
               	strb	w3, [x2]
               	add	x3, x0, #0x1
               	and	x3, x3, #0xff
               	strb	w3, [x2, #0x1]
               	add	x3, x0, #0x2
               	and	x3, x3, #0xff
               	strb	w3, [x2, #0x2]
               	add	x3, x0, #0x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, #0x3]
               	add	x5, x2, #0x4
               	add	x3, x0, #0x4
               	and	x6, x3, #0xff
               	strb	w6, [x5]
               	add	x6, x3, #0x1
               	and	x6, x6, #0xff
               	strb	w6, [x5, #0x1]
               	add	x6, x3, #0x2
               	and	x6, x6, #0xff
               	strb	w6, [x5, #0x2]
               	add	x3, x3, #0x3
               	and	x3, x3, #0xff
               	strb	w3, [x5, #0x3]
               	add	x2, x2, #0x8
               	add	x0, x0, #0x8
               	and	x0, x0, #0xff
               	strb	w0, [x2]
               	mul	x0, x1, x7
               	add	x5, x4, x0
               	add	x3, x5, #0x8
               	add	x2, x0, #0x8
               	add	x6, x2, #0x1
               	and	x6, x6, #0xff
               	strb	w6, [x3, #0x1]
               	add	x6, x2, #0x2
               	and	x6, x6, #0xff
               	strb	w6, [x3, #0x2]
               	add	x0, x2, #0x3
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x3]
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	mov	x10, #0xc               // =12
               	cmp	w5, #0x2
               	b.ge	<addr>
               	mov	x9, #0x0                // =0
               	mov	x3, x9
               	cmp	w3, #0x3
               	b.ge	<addr>
               	mul	x0, x5, x10
               	add	x7, x4, x0
               	lsl	x1, x3, #2
               	add	x6, x7, x1
               	ldrb	w8, [x6]
               	add	x2, x0, x1
               	and	x11, x2, #0xff
               	cmp	w8, w11
               	b.ne	<addr>
               	mov	x12, #0x1               // =1
               	ldrb	w11, [x6, #0x1]
               	add	x8, x2, #0x1
               	and	x8, x8, #0xff
               	cmp	w11, w8
               	b.ne	<addr>
               	mov	x12, #0x2               // =2
               	ldrb	w11, [x6, #0x2]
               	add	x8, x2, #0x2
               	and	x8, x8, #0xff
               	cmp	w11, w8
               	b.ne	<addr>
               	mov	x8, #0x3                // =3
               	ldrb	w6, [x6, #0x3]
               	add	x0, x2, #0x3
               	and	x0, x0, #0xff
               	cmp	w6, w0
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0x3
               	b.lt	<addr>
               	add	x5, x5, #0x1
               	cmp	w5, #0x2
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	mov	x10, #0xc               // =12
               	cmp	w5, #0x2
               	b.ge	<addr>
               	mov	x9, #0x0                // =0
               	mov	x3, x9
               	cmp	w3, #0x3
               	b.ge	<addr>
               	mul	x0, x5, x10
               	add	x7, x4, x0
               	lsl	x1, x3, #2
               	add	x6, x7, x1
               	ldrb	w8, [x6]
               	add	x2, x0, x1
               	and	x11, x2, #0xff
               	cmp	w8, w11
               	b.ne	<addr>
               	mov	x12, #0x1               // =1
               	ldrb	w11, [x6, #0x1]
               	add	x8, x2, #0x1
               	and	x8, x8, #0xff
               	cmp	w11, w8
               	b.ne	<addr>
               	mov	x12, #0x2               // =2
               	ldrb	w11, [x6, #0x2]
               	add	x8, x2, #0x2
               	and	x8, x8, #0xff
               	cmp	w11, w8
               	b.ne	<addr>
               	mov	x8, #0x3                // =3
               	ldrb	w6, [x6, #0x3]
               	add	x0, x2, #0x3
               	and	x0, x0, #0xff
               	cmp	w6, w0
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0x3
               	b.lt	<addr>
               	add	x5, x5, #0x1
               	cmp	w5, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x9, x8
               	mov	x17, #0xc               // =12
               	mul	x0, x5, x17
               	add	x0, x0, #0x6e
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	add	x0, x0, x9
               	sxtw	x0, w0
               	ret
               	mov	x9, x12
               	b	<addr>
               	mov	x9, x12
               	b	<addr>
               	mov	x9, x8
               	mov	x17, #0xc               // =12
               	mul	x0, x5, x17
               	add	x0, x0, #0x50
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	add	x0, x0, x9
               	sxtw	x0, w0
               	ret
               	mov	x9, x12
               	b	<addr>
               	mov	x9, x12
               	b	<addr>
               	mov	x7, x11
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x0, x0, #0x3c
               	add	x0, x0, x7
               	sxtw	x0, w0
               	ret
               	mov	x7, x12
               	b	<addr>
               	mov	x7, x12
               	b	<addr>
               	mov	x7, x12
               	b	<addr>
               	mov	x7, x11
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x0, x0, #0x28
               	add	x0, x0, x7
               	sxtw	x0, w0
               	ret
               	mov	x7, x12
               	b	<addr>
               	mov	x7, x12
               	b	<addr>
               	mov	x7, x12
               	b	<addr>
