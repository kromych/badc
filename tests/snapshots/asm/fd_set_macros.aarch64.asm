
fd_set_macros.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400408 <.text+0x148>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400c18 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	b	0x400420 <.text+0x160>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0x88]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x90]
               	b	0x400448 <.text+0x188>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x400420 <.text+0x160>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x98]
               	b	0x400480 <.text+0x1c0>
               	ldursw	x14, [x29, #-0x90]
               	cmp	x14, #0x80
               	b.ge	0x40047c <.text+0x1bc>
               	ldur	x14, [x29, #-0x88]
               	ldursw	x15, [x29, #-0x90]
               	add	x13, x14, x15
               	mov	x15, #0x0               // =0
               	strb	w15, [x13]
               	ldursw	x14, [x29, #-0x90]
               	add	x15, x14, #0x1
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x90]
               	b	0x400448 <.text+0x188>
               	b	0x400434 <.text+0x174>
               	ldursw	x14, [x29, #-0x98]
               	cmp	x14, #0x80
               	b.ge	0x4004b4 <.text+0x1f4>
               	sub	x14, x29, #0x80
               	ldursw	x15, [x29, #-0x98]
               	add	x13, x14, x15
               	ldrb	w15, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0x0
               	b.eq	0x4004d4 <.text+0x214>
               	b	0x4004b8 <.text+0x1f8>
               	b	0x4004e8 <.text+0x228>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x15, [x29, #-0x98]
               	add	x13, x15, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x98]
               	b	0x400480 <.text+0x1c0>
               	sub	x13, x29, #0x80
               	stur	x13, [x29, #-0xa0]
               	ldur	x15, [x29, #-0xa0]
               	mov	x13, #0x0               // =0
               	mov	x14, #0x8               // =8
               	sdiv	x12, x13, x14
               	add	x14, x15, x12
               	ldrb	w12, [x14]
               	mov	x17, #0x1               // =1
               	orr	x15, x12, x17
               	strb	w15, [x14]
               	b	0x400518 <.text+0x258>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x4004e8 <.text+0x228>
               	b	0x400524 <.text+0x264>
               	sub	x12, x29, #0x80
               	stur	x12, [x29, #-0xa8]
               	ldur	x15, [x29, #-0xa8]
               	mov	x12, #0x7               // =7
               	mov	x14, #0x8               // =8
               	sdiv	x13, x12, x14
               	add	x14, x15, x13
               	ldrb	w13, [x14]
               	mov	x15, #0x1               // =1
               	lsl	x12, x15, #7
               	orr	x15, x13, x12
               	strb	w15, [x14]
               	b	0x400558 <.text+0x298>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x400524 <.text+0x264>
               	b	0x400564 <.text+0x2a4>
               	sub	x12, x29, #0x80
               	stur	x12, [x29, #-0xb0]
               	ldur	x15, [x29, #-0xb0]
               	mov	x12, #0x8               // =8
               	sdiv	x14, x12, x12
               	add	x12, x15, x14
               	ldrb	w14, [x12]
               	mov	x17, #0x1               // =1
               	orr	x15, x14, x17
               	strb	w15, [x12]
               	b	0x400590 <.text+0x2d0>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x400564 <.text+0x2a4>
               	b	0x40059c <.text+0x2dc>
               	sub	x14, x29, #0x80
               	stur	x14, [x29, #-0xb8]
               	ldur	x15, [x29, #-0xb8]
               	mov	x14, #0x64              // =100
               	mov	x12, #0x8               // =8
               	sdiv	x13, x14, x12
               	add	x12, x15, x13
               	ldrb	w13, [x12]
               	mov	x15, #0x1               // =1
               	lsl	x14, x15, #4
               	orr	x15, x13, x14
               	strb	w15, [x12]
               	b	0x4005d0 <.text+0x310>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x40059c <.text+0x2dc>
               	sub	x14, x29, #0x80
               	mov	x15, #0x0               // =0
               	mov	x12, #0x8               // =8
               	sdiv	x13, x15, x12
               	add	x12, x14, x13
               	ldrb	w13, [x12]
               	mov	x17, #0x1               // =1
               	and	x12, x13, x17
               	cmp	x12, #0x0
               	b.ne	0x40061c <.text+0x35c>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x80
               	mov	x12, #0x7               // =7
               	mov	x14, #0x8               // =8
               	sdiv	x15, x12, x14
               	add	x14, x13, x15
               	ldrb	w15, [x14]
               	mov	x14, #0x1               // =1
               	lsl	x13, x14, #7
               	and	x14, x15, x13
               	cmp	x14, #0x0
               	b.ne	0x400664 <.text+0x3a4>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x80
               	mov	x14, #0x8               // =8
               	sdiv	x15, x14, x14
               	add	x14, x13, x15
               	ldrb	w15, [x14]
               	mov	x17, #0x1               // =1
               	and	x14, x15, x17
               	cmp	x14, #0x0
               	b.ne	0x4006a4 <.text+0x3e4>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x14, #0x64              // =100
               	mov	x13, #0x8               // =8
               	sdiv	x12, x14, x13
               	add	x13, x15, x12
               	ldrb	w12, [x13]
               	mov	x13, #0x1               // =1
               	lsl	x15, x13, #4
               	and	x13, x12, x15
               	cmp	x13, #0x0
               	b.ne	0x4006ec <.text+0x42c>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x13, #0x1               // =1
               	mov	x12, #0x8               // =8
               	sdiv	x14, x13, x12
               	add	x12, x15, x14
               	ldrb	w14, [x12]
               	lsl	x12, x13, #1
               	and	x13, x14, x12
               	cbz	x13, 0x40072c <.text+0x46c>
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x80
               	mov	x12, #0x32              // =50
               	mov	x14, #0x8               // =8
               	sdiv	x15, x12, x14
               	add	x14, x13, x15
               	ldrb	w15, [x14]
               	mov	x14, #0x1               // =1
               	lsl	x13, x14, #2
               	and	x14, x15, x13
               	cbz	x14, 0x400770 <.text+0x4b0>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x80
               	ldrb	w13, [x14]
               	mov	x17, #0x81              // =129
               	eor	x15, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0x0
               	b.eq	0x4007b0 <.text+0x4f0>
               	mov	x13, #0xb               // =11
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x15, x14, #0x1
               	ldrb	w13, [x15]
               	mov	x17, #0x1               // =1
               	eor	x15, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0x0
               	b.eq	0x4007f0 <.text+0x530>
               	mov	x13, #0xc               // =12
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x15, x14, #0xc
               	ldrb	w14, [x15]
               	mov	x17, #0x10              // =16
               	eor	x15, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	cmp	x14, #0x0
               	b.eq	0x400830 <.text+0x570>
               	mov	x14, #0xd               // =13
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400834 <.text+0x574>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0xc8]
               	ldur	x14, [x29, #-0xc8]
               	mov	x15, #0x7               // =7
               	mov	x13, #0x8               // =8
               	sdiv	x12, x15, x13
               	add	x13, x14, x12
               	ldrb	w12, [x13]
               	mov	x14, #0x1               // =1
               	lsl	x15, x14, #7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x14, x15, x17
               	and	x15, x12, x14
               	strb	w15, [x13]
               	b	0x40087c <.text+0x5bc>
               	mov	x15, #0x0               // =0
               	cbnz	x15, 0x400834 <.text+0x574>
               	sub	x14, x29, #0x80
               	mov	x15, #0x7               // =7
               	mov	x13, #0x8               // =8
               	sdiv	x12, x15, x13
               	add	x13, x14, x12
               	ldrb	w12, [x13]
               	mov	x13, #0x1               // =1
               	lsl	x14, x13, #7
               	and	x13, x12, x14
               	cbz	x13, 0x4008c8 <.text+0x608>
               	mov	x14, #0x15              // =21
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x80
               	mov	x14, #0x0               // =0
               	mov	x12, #0x8               // =8
               	sdiv	x15, x14, x12
               	add	x12, x13, x15
               	ldrb	w15, [x12]
               	mov	x17, #0x1               // =1
               	and	x12, x15, x17
               	cmp	x12, #0x0
               	b.ne	0x40090c <.text+0x64c>
               	mov	x12, #0x16              // =22
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x12, #0x8               // =8
               	sdiv	x13, x12, x12
               	add	x12, x15, x13
               	ldrb	w13, [x12]
               	mov	x17, #0x1               // =1
               	and	x12, x13, x17
               	cmp	x12, #0x0
               	b.ne	0x40094c <.text+0x68c>
               	mov	x12, #0x17              // =23
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400950 <.text+0x690>
               	sub	x13, x29, #0x80
               	stur	x13, [x29, #-0xd0]
               	ldur	x12, [x29, #-0xd0]
               	mov	x13, #0x0               // =0
               	mov	x15, #0x8               // =8
               	sdiv	x14, x13, x15
               	add	x15, x12, x14
               	ldrb	w14, [x15]
               	mov	x17, #0x1               // =1
               	orr	x12, x14, x17
               	strb	w12, [x15]
               	b	0x400980 <.text+0x6c0>
               	mov	x12, #0x0               // =0
               	cbnz	x12, 0x400950 <.text+0x690>
               	sub	x14, x29, #0x80
               	mov	x12, #0x0               // =0
               	mov	x15, #0x8               // =8
               	sdiv	x13, x12, x15
               	add	x15, x14, x13
               	ldrb	w13, [x15]
               	mov	x17, #0x1               // =1
               	and	x15, x13, x17
               	cmp	x15, #0x0
               	b.ne	0x4009cc <.text+0x70c>
               	mov	x15, #0x18              // =24
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4009d0 <.text+0x710>
               	sub	x13, x29, #0x80
               	stur	x13, [x29, #-0xd8]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0xe0]
               	b	0x400a14 <.text+0x754>
               	mov	x13, #0x0               // =0
               	cbnz	x13, 0x4009d0 <.text+0x710>
               	sub	x15, x29, #0x80
               	mov	x13, #0x0               // =0
               	mov	x14, #0x8               // =8
               	sdiv	x12, x13, x14
               	add	x14, x15, x12
               	ldrb	w12, [x14]
               	mov	x17, #0x1               // =1
               	and	x14, x12, x17
               	cbz	x14, 0x400a68 <.text+0x7a8>
               	b	0x400a4c <.text+0x78c>
               	ldursw	x15, [x29, #-0xe0]
               	cmp	x15, #0x80
               	b.ge	0x400a48 <.text+0x788>
               	ldur	x15, [x29, #-0xd8]
               	ldursw	x13, [x29, #-0xe0]
               	add	x14, x15, x13
               	mov	x13, #0x0               // =0
               	strb	w13, [x14]
               	ldursw	x15, [x29, #-0xe0]
               	add	x13, x15, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0xe0]
               	b	0x400a14 <.text+0x754>
               	b	0x4009e4 <.text+0x724>
               	mov	x12, #0x19              // =25
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x80
               	mov	x12, #0x64              // =100
               	mov	x15, #0x8               // =8
               	sdiv	x13, x12, x15
               	add	x15, x14, x13
               	ldrb	w13, [x15]
               	mov	x15, #0x1               // =1
               	lsl	x14, x15, #4
               	and	x15, x13, x14
               	cbz	x15, 0x400aac <.text+0x7ec>
               	mov	x14, #0x1a              // =26
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400c24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
