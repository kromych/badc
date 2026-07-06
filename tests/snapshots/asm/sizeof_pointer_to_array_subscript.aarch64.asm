
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
               	sxtw	x0, w2
               	ldrsh	x3, [x1, x0, lsl #1]
               	add	x0, x0, #0x3e8
               	sxtw	x6, w0
               	sxth	x0, w6
               	cmp	x3, x0
               	b.ne	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x8
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	ldrsh	x3, [x1, x0, lsl #1]
               	add	x0, x0, #0x3e8
               	sxtw	x6, w0
               	sxth	x0, w6
               	cmp	x3, x0
               	b.ne	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x8
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	add	x2, x2, #0x0
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, #0x0
               	str	w0, [x2]
               	sxtw	x0, w1
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	str	w0, [x2, #0x4]
               	sxtw	x0, w1
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, #0x2
               	str	w0, [x2, #0x8]
               	sxtw	x0, w1
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, #0x3
               	str	w0, [x2, #0xc]
               	sxtw	x0, w1
               	mov	x17, #0x14              // =20
               	mul	x2, x0, x17
               	add	x2, x4, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, #0x4
               	str	w0, [x2, #0x10]
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x14              // =20
               	mul	x3, x0, x17
               	add	x3, x4, x3
               	sxtw	x6, w2
               	ldrsw	x3, [x3, x6, lsl #2]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x6
               	sxtw	x0, w0
               	cmp	x3, x0
               	b.ne	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x14              // =20
               	mul	x3, x0, x17
               	add	x3, x4, x3
               	sxtw	x6, w2
               	ldrsw	x3, [x3, x6, lsl #2]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x6
               	sxtw	x0, w0
               	cmp	x3, x0
               	b.ne	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	add	x3, x5, x0
               	sxtw	x4, w2
               	lsl	x4, x4, #2
               	add	x3, x3, x4
               	add	x3, x3, #0x0
               	add	x0, x0, x4
               	add	x0, x0, #0x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x3]
               	sxtw	x0, w1
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	add	x3, x5, x0
               	sxtw	x4, w2
               	lsl	x4, x4, #2
               	add	x3, x3, x4
               	add	x0, x0, x4
               	add	x0, x0, #0x1
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x3, #0x1]
               	sxtw	x0, w1
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	add	x3, x5, x0
               	sxtw	x4, w2
               	lsl	x4, x4, #2
               	add	x3, x3, x4
               	add	x0, x0, x4
               	add	x0, x0, #0x2
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x3, #0x2]
               	sxtw	x0, w1
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	add	x3, x5, x0
               	sxtw	x4, w2
               	lsl	x4, x4, #2
               	add	x3, x3, x4
               	add	x0, x0, x4
               	add	x0, x0, #0x3
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x3, #0x3]
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	add	x4, x5, x0
               	sxtw	x6, w2
               	lsl	x6, x6, #2
               	add	x4, x4, x6
               	sxtw	x7, w3
               	add	x4, x4, x7
               	ldrb	w4, [x4]
               	add	x0, x0, x6
               	add	x0, x0, x7
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x4, x0
               	b.ne	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	sxtw	x0, w3
               	cmp	x0, #0x4
               	b.lt	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	add	x4, x5, x0
               	sxtw	x6, w2
               	lsl	x6, x6, #2
               	add	x4, x4, x6
               	sxtw	x7, w3
               	add	x4, x4, x7
               	ldrb	w4, [x4]
               	add	x0, x0, x6
               	add	x0, x0, x7
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x4, x0
               	b.ne	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	sxtw	x0, w3
               	cmp	x0, #0x4
               	b.lt	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x17, #0xc               // =12
               	mul	x0, x1, x17
               	add	x0, x0, #0x6e
               	lsl	x1, x2, #2
               	add	x0, x0, x1
               	add	x0, x0, x3
               	sxtw	x0, w0
               	ret
               	mov	x17, #0xc               // =12
               	mul	x0, x1, x17
               	add	x0, x0, #0x50
               	lsl	x1, x2, #2
               	add	x0, x0, x1
               	add	x0, x0, x3
               	sxtw	x0, w0
               	ret
               	mov	x17, #0x5               // =5
               	mul	x0, x1, x17
               	add	x0, x0, #0x3c
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ret
               	mov	x17, #0x5               // =5
               	mul	x0, x1, x17
               	add	x0, x0, #0x28
               	add	x0, x0, x2
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
