
ternary_middle_comma.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400410 <.text+0x150>
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
               	bl	0x400ba8 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	sub	x15, x29, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x14]
               	strb	w10, [x15]
               	ldrb	w10, [x14, #0x1]
               	strb	w10, [x15, #0x1]
               	ldrb	w10, [x14, #0x2]
               	strb	w10, [x15, #0x2]
               	ldrb	w10, [x14, #0x3]
               	strb	w10, [x15, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	mov	x20, #0x2a              // =42
               	sxtw	x14, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x14, x17
               	cmp	x15, #0x80
               	b.hs	0x4004b0 <.text+0x1f0>
               	sub	x15, x29, #0x8
               	sxtw	x14, w20
               	mov	x17, #0xff              // =255
               	and	x12, x14, x17
               	strb	w12, [x15]
               	mov	x14, #0x1               // =1
               	stur	x14, [x29, #-0x88]
               	b	0x4004bc <.text+0x1fc>
               	mov	x14, #0x63              // =99
               	stur	x14, [x29, #-0x88]
               	b	0x4004bc <.text+0x1fc>
               	ldur	x14, [x29, #-0x88]
               	sxtw	x12, w14
               	cmp	x12, #0x1
               	cset	x15, ne
               	stur	x15, [x29, #-0x90]
               	cbnz	x15, 0x400500 <.text+0x240>
               	sub	x12, x29, #0x8
               	ldrb	w15, [x12]
               	mov	x17, #0x2a              // =42
               	eor	x12, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x12, x17
               	cmp	x15, #0x0
               	cset	x12, ne
               	stur	x12, [x29, #-0x90]
               	b	0x400500 <.text+0x240>
               	ldur	x12, [x29, #-0x90]
               	cbz	x12, 0x400568 <.text+0x2a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x154
               	mov	x21, x19
               	sxtw	x22, w14
               	sub	x14, x29, #0x8
               	ldrb	w23, [x14]
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x400bb4 <printf>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0x20
               	adrp	x19, 0x410000
               	add	x19, x19, #0x16a
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x14]
               	strb	w10, [x23]
               	ldrb	w10, [x14, #0x1]
               	strb	w10, [x23, #0x1]
               	ldrb	w10, [x14, #0x2]
               	strb	w10, [x23, #0x2]
               	ldrb	w10, [x14, #0x3]
               	strb	w10, [x23, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x22, x23
               	sxtw	x22, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x22, x17
               	cmp	x14, #0x80
               	b.hs	0x4005dc <.text+0x31c>
               	sub	x14, x29, #0x20
               	sxtw	x22, w20
               	mov	x17, #0xff              // =255
               	and	x23, x22, x17
               	strb	w23, [x14]
               	mov	x22, #0x1               // =1
               	stur	x22, [x29, #-0x98]
               	b	0x4005e8 <.text+0x328>
               	mov	x22, #0x63              // =99
               	stur	x22, [x29, #-0x98]
               	b	0x4005e8 <.text+0x328>
               	ldur	x22, [x29, #-0x98]
               	sxtw	x23, w22
               	cmp	x23, #0x1
               	cset	x14, ne
               	stur	x14, [x29, #-0xa0]
               	cbnz	x14, 0x40062c <.text+0x36c>
               	sub	x23, x29, #0x20
               	ldrb	w14, [x23]
               	mov	x17, #0x2a              // =42
               	eor	x23, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x23, x17
               	cmp	x14, #0x0
               	cset	x23, ne
               	stur	x23, [x29, #-0xa0]
               	b	0x40062c <.text+0x36c>
               	ldur	x23, [x29, #-0xa0]
               	cbz	x23, 0x400694 <.text+0x3d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x16e
               	mov	x24, x19
               	sxtw	x25, w22
               	sub	x22, x29, #0x20
               	ldrb	w23, [x22]
               	mov	x0, x24
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x400bb4 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0x30
               	adrp	x19, 0x410000
               	add	x19, x19, #0x184
               	mov	x22, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x22]
               	strb	w10, [x23]
               	ldrb	w10, [x22, #0x1]
               	strb	w10, [x23, #0x1]
               	ldrb	w10, [x22, #0x2]
               	strb	w10, [x23, #0x2]
               	ldrb	w10, [x22, #0x3]
               	strb	w10, [x23, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x25, x23
               	sxtw	x25, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x25, x17
               	cmp	x22, #0x80
               	b.hs	0x400708 <.text+0x448>
               	sub	x22, x29, #0x30
               	sxtw	x25, w20
               	mov	x17, #0xff              // =255
               	and	x23, x25, x17
               	strb	w23, [x22]
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0xa8]
               	b	0x400714 <.text+0x454>
               	mov	x25, #0x63              // =99
               	stur	x25, [x29, #-0xa8]
               	b	0x400714 <.text+0x454>
               	ldur	x25, [x29, #-0xa8]
               	sxtw	x23, w25
               	cmp	x23, #0x1
               	cset	x22, ne
               	stur	x22, [x29, #-0xb0]
               	cbnz	x22, 0x400758 <.text+0x498>
               	sub	x23, x29, #0x30
               	ldrb	w22, [x23]
               	mov	x17, #0x2a              // =42
               	eor	x23, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x23, x17
               	cmp	x22, #0x0
               	cset	x23, ne
               	stur	x23, [x29, #-0xb0]
               	b	0x400758 <.text+0x498>
               	ldur	x23, [x29, #-0xb0]
               	cbz	x23, 0x4007c0 <.text+0x500>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	sxtw	x22, w25
               	sub	x25, x29, #0x30
               	ldrb	w23, [x25]
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x400bb4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x3               // =3
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0x40]
               	stur	w23, [x29, #-0x48]
               	stur	w23, [x29, #-0x50]
               	sxtw	x25, w20
               	cmp	x25, #0x0
               	b.le	0x400818 <.text+0x558>
               	mov	x25, #0x1               // =1
               	stur	w25, [x29, #-0x40]
               	mov	x20, #0x2               // =2
               	stur	w20, [x29, #-0x48]
               	mov	x25, #0x3               // =3
               	stur	w25, [x29, #-0x50]
               	ldursw	x20, [x29, #-0x40]
               	ldursw	x25, [x29, #-0x48]
               	add	x23, x20, x25
               	sxtw	x23, w23
               	ldursw	x25, [x29, #-0x50]
               	add	x20, x23, x25
               	sxtw	x20, w20
               	stur	x20, [x29, #-0xb8]
               	b	0x400830 <.text+0x570>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	stur	x20, [x29, #-0xb8]
               	b	0x400830 <.text+0x570>
               	ldur	x20, [x29, #-0xb8]
               	sxtw	x25, w20
               	cmp	x25, #0x6
               	cset	x23, ne
               	stur	x23, [x29, #-0xd0]
               	cbnz	x23, 0x40085c <.text+0x59c>
               	ldursw	x25, [x29, #-0x40]
               	cmp	x25, #0x1
               	cset	x23, ne
               	stur	x23, [x29, #-0xd0]
               	b	0x40085c <.text+0x59c>
               	ldur	x23, [x29, #-0xd0]
               	stur	x23, [x29, #-0xc8]
               	cbnz	x23, 0x40087c <.text+0x5bc>
               	ldursw	x25, [x29, #-0x48]
               	cmp	x25, #0x2
               	cset	x23, ne
               	stur	x23, [x29, #-0xc8]
               	b	0x40087c <.text+0x5bc>
               	ldur	x23, [x29, #-0xc8]
               	stur	x23, [x29, #-0xc0]
               	cbnz	x23, 0x40089c <.text+0x5dc>
               	ldursw	x25, [x29, #-0x50]
               	cmp	x25, #0x3
               	cset	x23, ne
               	stur	x23, [x29, #-0xc0]
               	b	0x40089c <.text+0x5dc>
               	ldur	x23, [x29, #-0xc0]
               	cbz	x23, 0x400910 <.text+0x650>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x19e
               	mov	x24, x19
               	sxtw	x25, w20
               	ldursw	x23, [x29, #-0x40]
               	ldursw	x20, [x29, #-0x48]
               	ldursw	x22, [x29, #-0x50]
               	mov	x0, x24
               	mov	x4, x22
               	mov	x3, x20
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x400bb4 <printf>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x4               // =4
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x60
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1bb
               	mov	x10, x19
               	str	x11, [sp, #-0x10]!
               	ldrb	w11, [x10]
               	strb	w11, [x22]
               	ldrb	w11, [x10, #0x1]
               	strb	w11, [x22, #0x1]
               	ldrb	w11, [x10, #0x2]
               	strb	w11, [x22, #0x2]
               	ldrb	w11, [x10, #0x3]
               	strb	w11, [x22, #0x3]
               	ldr	x11, [sp], #0x10
               	mov	x20, x22
               	mov	x20, #0xc8              // =200
               	sxtw	x10, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x10, x17
               	cmp	x22, #0x80
               	b.hs	0x400988 <.text+0x6c8>
               	sub	x22, x29, #0x60
               	sxtw	x10, w20
               	mov	x17, #0xff              // =255
               	and	x20, x10, x17
               	strb	w20, [x22]
               	mov	x10, #0x1               // =1
               	stur	x10, [x29, #-0xd8]
               	b	0x400994 <.text+0x6d4>
               	mov	x10, #0x63              // =99
               	stur	x10, [x29, #-0xd8]
               	b	0x400994 <.text+0x6d4>
               	ldur	x10, [x29, #-0xd8]
               	sxtw	x20, w10
               	cmp	x20, #0x63
               	cset	x22, ne
               	stur	x22, [x29, #-0xe0]
               	cbnz	x22, 0x4009d0 <.text+0x710>
               	sub	x20, x29, #0x60
               	ldrb	w22, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x22, x17
               	cmp	x20, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xe0]
               	b	0x4009d0 <.text+0x710>
               	ldur	x22, [x29, #-0xe0]
               	cbz	x22, 0x400a38 <.text+0x778>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1bf
               	mov	x21, x19
               	sxtw	x20, w10
               	sub	x10, x29, #0x60
               	ldrb	w22, [x10]
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x20
               	bl	0x400bb4 <printf>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x5               // =5
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ecb8d
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4070c0 <exit+0x6500>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9150
               	tbz	w21, #0x6, 0x3ff114
               	<unknown>
               	cbnz	w16, 0x46f0bc
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4006c8 <.text+0x408>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
               	udf	#0x0
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x400bc0 <exit>
               	uxtb	w0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ecc51
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x407184 <exit+0x65c4>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9214
               	tbz	w21, #0x6, 0x3ff1d8
               	<unknown>
               	cbnz	w16, 0x46f180
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40078c <.text+0x4cc>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<dlsym>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	br	x16

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16
