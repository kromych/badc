
sizeof_pointer_to_array_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	add	x6, x0, #0x8
               	sub	x0, x6, x0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	add	x0, x1, #0x10
               	sub	x0, x0, x1
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	add	x0, x2, #0x20
               	sub	x0, x0, x2
               	cmp	x0, #0x20
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	add	x0, x3, #0x40
               	sub	x0, x0, x3
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	add	x0, x4, #0x3c
               	sub	x0, x0, x4
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	add	x0, x4, #0x14
               	sub	x0, x0, x4
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	add	x0, x5, #0x18
               	sub	x0, x0, x5
               	cmp	x0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	add	x0, x5, #0xc
               	sub	x0, x0, x5
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	add	x0, x5, #0x4
               	sub	x0, x0, x5
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	add	x0, x1, #0x0
               	mov	x2, #0x3e8              // =1000
               	strh	w2, [x0]
               	mov	x0, #0x3e9              // =1001
               	strh	w0, [x1, #0x2]
               	mov	x0, #0x3ea              // =1002
               	strh	w0, [x1, #0x4]
               	mov	x0, #0x3eb              // =1003
               	strh	w0, [x1, #0x6]
               	mov	x0, #0x3ec              // =1004
               	strh	w0, [x1, #0x8]
               	mov	x0, #0x3ed              // =1005
               	strh	w0, [x1, #0xa]
               	mov	x0, #0x3ee              // =1006
               	strh	w0, [x1, #0xc]
               	mov	x0, #0x3ef              // =1007
               	strh	w0, [x1, #0xe]
               	mov	x2, #0x0                // =0
               	b	<addr>
               	ldrsh	x3, [x1, x0, lsl #1]
               	add	x6, x0, #0x3e8
               	sxtw	x7, w6
               	sxth	x6, w7
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x8
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	ldrsh	x3, [x1, x0, lsl #1]
               	add	x6, x0, #0x3e8
               	sxtw	x7, w6
               	sxth	x6, w7
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x8
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	add	x2, x2, #0x0
               	mov	x17, #0x64              // =100
               	mul	x3, x0, x17
               	add	x3, x3, #0x0
               	str	w3, [x2]
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	mov	x17, #0x64              // =100
               	mul	x3, x0, x17
               	add	x3, x3, #0x1
               	str	w3, [x2, #0x4]
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	mov	x17, #0x64              // =100
               	mul	x3, x0, x17
               	add	x3, x3, #0x2
               	str	w3, [x2, #0x8]
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	mov	x17, #0x64              // =100
               	mul	x3, x0, x17
               	add	x3, x3, #0x3
               	str	w3, [x2, #0xc]
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	mov	x17, #0x64              // =100
               	mul	x3, x0, x17
               	add	x3, x3, #0x4
               	str	w3, [x2, #0x10]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x14              // =20
               	mul	x6, x0, x17
               	add	x6, x4, x6
               	ldrsw	x6, [x6, x2, lsl #2]
               	mov	x17, #0x64              // =100
               	mul	x7, x0, x17
               	add	x7, x7, x2
               	sxtw	x7, w7
               	cmp	x6, x7
               	b.ne	<addr>
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, #0x5
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x14              // =20
               	mul	x6, x0, x17
               	add	x6, x4, x6
               	ldrsw	x6, [x6, x2, lsl #2]
               	mov	x17, #0x64              // =100
               	mul	x7, x0, x17
               	add	x7, x7, x2
               	sxtw	x7, w7
               	cmp	x6, x7
               	b.ne	<addr>
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, #0x5
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xc               // =12
               	mul	x4, x0, x17
               	add	x6, x5, x4
               	lsl	x7, x2, #2
               	add	x6, x6, x7
               	add	x6, x6, #0x0
               	add	x4, x4, x7
               	add	x4, x4, #0x0
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x6]
               	mov	x17, #0xc               // =12
               	mul	x4, x0, x17
               	add	x6, x5, x4
               	lsl	x7, x2, #2
               	add	x6, x6, x7
               	add	x4, x4, x7
               	add	x4, x4, #0x1
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x6, #0x1]
               	mov	x17, #0xc               // =12
               	mul	x4, x0, x17
               	add	x6, x5, x4
               	lsl	x7, x2, #2
               	add	x6, x6, x7
               	add	x4, x4, x7
               	add	x4, x4, #0x2
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x6, #0x2]
               	mov	x17, #0xc               // =12
               	mul	x4, x0, x17
               	add	x6, x5, x4
               	lsl	x7, x2, #2
               	add	x6, x6, x7
               	add	x4, x4, x7
               	add	x4, x4, #0x3
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x6, #0x3]
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, #0x3
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x6, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xc               // =12
               	mul	x7, x0, x17
               	add	x8, x5, x7
               	lsl	x9, x2, #2
               	add	x8, x8, x9
               	add	x8, x8, x4
               	ldrb	w8, [x8]
               	add	x7, x7, x9
               	add	x7, x7, x4
               	sxtw	x7, w7
               	mov	x17, #0xff              // =255
               	and	x7, x7, x17
               	cmp	x8, x7
               	b.ne	<addr>
               	add	x6, x4, #0x1
               	sxtw	x4, w6
               	cmp	x4, #0x4
               	b.lt	<addr>
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, #0x3
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x6, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xc               // =12
               	mul	x7, x0, x17
               	add	x8, x5, x7
               	lsl	x9, x2, #2
               	add	x8, x8, x9
               	add	x8, x8, x4
               	ldrb	w8, [x8]
               	add	x7, x7, x9
               	add	x7, x7, x4
               	sxtw	x7, w7
               	mov	x17, #0xff              // =255
               	and	x7, x7, x17
               	cmp	x8, x7
               	b.ne	<addr>
               	add	x6, x4, #0x1
               	sxtw	x4, w6
               	cmp	x4, #0x4
               	b.lt	<addr>
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, #0x3
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x17, #0xc               // =12
               	mul	x0, x1, x17
               	add	x0, x0, #0x6e
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	add	x0, x0, x6
               	sxtw	x0, w0
               	ret
               	mov	x17, #0xc               // =12
               	mul	x0, x1, x17
               	add	x0, x0, #0x50
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	add	x0, x0, x6
               	sxtw	x0, w0
               	ret
               	mov	x17, #0x5               // =5
               	mul	x0, x1, x17
               	add	x0, x0, #0x3c
               	add	x0, x0, x3
               	sxtw	x0, w0
               	ret
               	mov	x17, #0x5               // =5
               	mul	x0, x1, x17
               	add	x0, x0, #0x28
               	add	x0, x0, x3
               	sxtw	x0, w0
               	ret
               	add	x0, x2, #0x1c
               	sxtw	x0, w0
               	ret
               	add	x0, x2, #0x14
               	sxtw	x0, w0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
