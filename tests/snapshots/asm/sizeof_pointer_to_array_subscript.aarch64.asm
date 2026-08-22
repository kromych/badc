
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
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
               	add	x0, x5, #0x40
               	sub	x0, x0, x5
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	add	x0, x3, #0x3c
               	sub	x0, x0, x3
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	add	x0, x3, #0x14
               	sub	x0, x0, x3
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	add	x0, x4, #0x18
               	sub	x0, x0, x4
               	cmp	x0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	add	x0, x4, #0xc
               	sub	x0, x0, x4
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	add	x0, x4, #0x4
               	sub	x0, x0, x4
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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsh	x6, [x1, x2, lsl #1]
               	add	x5, x2, #0x3e8
               	sxtw	x7, w5
               	sxth	x5, w7
               	cmp	w6, w5
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsh	x6, [x1, x2, lsl #1]
               	add	x5, x2, #0x3e8
               	sxtw	x7, w5
               	sxth	x5, w7
               	cmp	w6, w5
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x8, #0x14               // =20
               	mov	x9, #0x64               // =100
               	b	<addr>
               	sxtw	x1, w2
               	mul	x6, x1, x8
               	add	x5, x3, x6
               	add	x10, x5, #0x0
               	mul	x0, x1, x9
               	add	x7, x0, #0x0
               	str	w7, [x10]
               	add	x7, x0, #0x1
               	str	w7, [x5, #0x4]
               	add	x7, x0, #0x2
               	str	w7, [x5, #0x8]
               	add	x7, x0, #0x3
               	str	w7, [x5, #0xc]
               	add	x0, x0, #0x4
               	str	w0, [x5, #0x10]
               	add	x2, x1, #0x1
               	cmp	x2, #0x3
               	b.lt	<addr>
               	mov	x6, #0x0                // =0
               	mov	x7, #0x14               // =20
               	mov	x8, #0x64               // =100
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w6
               	mul	x1, x2, x7
               	add	x5, x3, x1
               	sxtw	x1, w0
               	ldrsw	x5, [x5, x1, lsl #2]
               	mul	x2, x2, x8
               	add	x2, x2, x1
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w6
               	add	x6, x0, #0x1
               	cmp	x6, #0x3
               	b.lt	<addr>
               	mov	x6, #0x0                // =0
               	mov	x7, #0x14               // =20
               	mov	x8, #0x64               // =100
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w6
               	mul	x1, x2, x7
               	add	x5, x3, x1
               	sxtw	x1, w0
               	ldrsw	x5, [x5, x1, lsl #2]
               	mul	x2, x2, x8
               	add	x2, x2, x1
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w6
               	add	x6, x0, #0x1
               	cmp	x6, #0x3
               	b.lt	<addr>
               	mov	x7, #0x0                // =0
               	mov	x12, #0xc               // =12
               	mov	x8, #0xff               // =255
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	sxtw	x9, w7
               	mul	x0, x9, x12
               	add	x10, x4, x0
               	sxtw	x6, w3
               	lsl	x1, x6, #2
               	add	x5, x10, x1
               	add	x13, x5, #0x0
               	add	x2, x0, x1
               	add	x11, x2, #0x0
               	and	x11, x11, x8
               	strb	w11, [x13]
               	add	x11, x2, #0x1
               	and	x11, x11, x8
               	strb	w11, [x5, #0x1]
               	add	x11, x2, #0x2
               	and	x11, x11, x8
               	strb	w11, [x5, #0x2]
               	add	x0, x2, #0x3
               	and	x0, x0, x8
               	strb	w0, [x5, #0x3]
               	add	x3, x6, #0x1
               	cmp	x3, #0x3
               	b.lt	<addr>
               	sxtw	x0, w7
               	add	x7, x0, #0x1
               	cmp	x7, #0x2
               	b.lt	<addr>
               	mov	x6, #0x0                // =0
               	mov	x7, #0xc                // =12
               	mov	x8, #0xff               // =255
               	b	<addr>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w6
               	mul	x1, x1, x7
               	add	x3, x4, x1
               	sxtw	x2, w5
               	lsl	x2, x2, #2
               	add	x9, x3, x2
               	sxtw	x3, w0
               	add	x9, x9, x3
               	ldrb	w9, [x9]
               	add	x1, x1, x2
               	add	x1, x1, x3
               	and	x1, x1, x8
               	cmp	x9, x1
               	b.ne	<addr>
               	add	x0, x3, #0x1
               	cmp	x0, #0x4
               	b.lt	<addr>
               	sxtw	x0, w5
               	add	x5, x0, #0x1
               	cmp	x5, #0x3
               	b.lt	<addr>
               	sxtw	x0, w6
               	add	x6, x0, #0x1
               	cmp	w6, #0x2
               	b.lt	<addr>
               	mov	x6, #0x0                // =0
               	mov	x7, #0xc                // =12
               	mov	x8, #0xff               // =255
               	b	<addr>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w6
               	mul	x1, x1, x7
               	add	x3, x4, x1
               	sxtw	x2, w5
               	lsl	x2, x2, #2
               	add	x9, x3, x2
               	sxtw	x3, w0
               	add	x9, x9, x3
               	ldrb	w9, [x9]
               	add	x1, x1, x2
               	add	x1, x1, x3
               	and	x1, x1, x8
               	cmp	x9, x1
               	b.ne	<addr>
               	add	x0, x3, #0x1
               	cmp	x0, #0x4
               	b.lt	<addr>
               	sxtw	x0, w5
               	add	x5, x0, #0x1
               	cmp	x5, #0x3
               	b.lt	<addr>
               	sxtw	x0, w6
               	add	x6, x0, #0x1
               	cmp	x6, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x17, #0xc               // =12
               	mul	x1, x6, x17
               	add	x1, x1, #0x6e
               	lsl	x2, x5, #2
               	add	x1, x1, x2
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	mov	x17, #0xc               // =12
               	mul	x1, x6, x17
               	add	x1, x1, #0x50
               	lsl	x2, x5, #2
               	add	x1, x1, x2
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	mov	x17, #0x5               // =5
               	mul	x1, x6, x17
               	add	x1, x1, #0x3c
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	mov	x17, #0x5               // =5
               	mul	x1, x6, x17
               	add	x1, x1, #0x28
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	add	x0, x0, #0x1c
               	sxtw	x0, w0
               	ret
               	add	x0, x0, #0x14
               	sxtw	x0, w0
               	ret
