
ternary_middle_comma.aarch64:	file format elf64-littleaarch64

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
               	bl	0x400b78 <dlsym>
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
               	b.hs	0x4004a8 <.text+0x1e8>
               	sub	x15, x29, #0x8
               	sxtw	x14, w20
               	mov	x17, #0xff              // =255
               	and	x12, x14, x17
               	strb	w12, [x15]
               	mov	x14, #0x1               // =1
               	stur	x14, [x29, #-0x88]
               	b	0x4004b4 <.text+0x1f4>
               	mov	x14, #0x63              // =99
               	stur	x14, [x29, #-0x88]
               	b	0x4004b4 <.text+0x1f4>
               	ldur	x14, [x29, #-0x88]
               	sxtw	x12, w14
               	cmp	x12, #0x1
               	cset	x15, ne
               	stur	x15, [x29, #-0x90]
               	cbnz	x15, 0x4004f8 <.text+0x238>
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
               	b	0x4004f8 <.text+0x238>
               	ldur	x12, [x29, #-0x90]
               	cbz	x12, 0x400558 <.text+0x298>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x154
               	mov	x21, x19
               	sxtw	x22, w14
               	sub	x14, x29, #0x8
               	ldrb	w23, [x14]
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x400b84 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
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
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x23]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x23, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x23, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x23, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x22, x23
               	sxtw	x22, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x22, x17
               	cmp	x0, #0x80
               	b.hs	0x4005cc <.text+0x30c>
               	sub	x0, x29, #0x20
               	sxtw	x22, w20
               	mov	x17, #0xff              // =255
               	and	x23, x22, x17
               	strb	w23, [x0]
               	mov	x22, #0x1               // =1
               	stur	x22, [x29, #-0x98]
               	b	0x4005d8 <.text+0x318>
               	mov	x22, #0x63              // =99
               	stur	x22, [x29, #-0x98]
               	b	0x4005d8 <.text+0x318>
               	ldur	x22, [x29, #-0x98]
               	sxtw	x23, w22
               	cmp	x23, #0x1
               	cset	x0, ne
               	stur	x0, [x29, #-0xa0]
               	cbnz	x0, 0x40061c <.text+0x35c>
               	sub	x23, x29, #0x20
               	ldrb	w0, [x23]
               	mov	x17, #0x2a              // =42
               	eor	x23, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	cset	x23, ne
               	stur	x23, [x29, #-0xa0]
               	b	0x40061c <.text+0x35c>
               	ldur	x23, [x29, #-0xa0]
               	cbz	x23, 0x40067c <.text+0x3bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x16e
               	mov	x24, x19
               	sxtw	x25, w22
               	sub	x22, x29, #0x20
               	ldrb	w23, [x22]
               	mov	x0, x24
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x400b84 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
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
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x23]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x23, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x23, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x23, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x25, x23
               	sxtw	x25, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	cmp	x0, #0x80
               	b.hs	0x4006f0 <.text+0x430>
               	sub	x0, x29, #0x30
               	sxtw	x25, w20
               	mov	x17, #0xff              // =255
               	and	x23, x25, x17
               	strb	w23, [x0]
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0xa8]
               	b	0x4006fc <.text+0x43c>
               	mov	x25, #0x63              // =99
               	stur	x25, [x29, #-0xa8]
               	b	0x4006fc <.text+0x43c>
               	ldur	x25, [x29, #-0xa8]
               	sxtw	x23, w25
               	cmp	x23, #0x1
               	cset	x0, ne
               	stur	x0, [x29, #-0xb0]
               	cbnz	x0, 0x400740 <.text+0x480>
               	sub	x23, x29, #0x30
               	ldrb	w0, [x23]
               	mov	x17, #0x2a              // =42
               	eor	x23, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	cset	x23, ne
               	stur	x23, [x29, #-0xb0]
               	b	0x400740 <.text+0x480>
               	ldur	x23, [x29, #-0xb0]
               	cbz	x23, 0x4007a0 <.text+0x4e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	sxtw	x21, w25
               	sub	x25, x29, #0x30
               	ldrb	w23, [x25]
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x400b84 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
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
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.le	0x4007f8 <.text+0x538>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x40]
               	mov	x20, #0x2               // =2
               	stur	w20, [x29, #-0x48]
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x50]
               	ldursw	x20, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x48]
               	add	x23, x20, x0
               	sxtw	x23, w23
               	ldursw	x0, [x29, #-0x50]
               	add	x20, x23, x0
               	sxtw	x20, w20
               	stur	x20, [x29, #-0xb8]
               	b	0x400810 <.text+0x550>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	stur	x20, [x29, #-0xb8]
               	b	0x400810 <.text+0x550>
               	ldur	x20, [x29, #-0xb8]
               	sxtw	x0, w20
               	cmp	x0, #0x6
               	cset	x23, ne
               	stur	x23, [x29, #-0xd0]
               	cbnz	x23, 0x40083c <.text+0x57c>
               	ldursw	x0, [x29, #-0x40]
               	cmp	x0, #0x1
               	cset	x23, ne
               	stur	x23, [x29, #-0xd0]
               	b	0x40083c <.text+0x57c>
               	ldur	x23, [x29, #-0xd0]
               	stur	x23, [x29, #-0xc8]
               	cbnz	x23, 0x40085c <.text+0x59c>
               	ldursw	x0, [x29, #-0x48]
               	cmp	x0, #0x2
               	cset	x23, ne
               	stur	x23, [x29, #-0xc8]
               	b	0x40085c <.text+0x59c>
               	ldur	x23, [x29, #-0xc8]
               	stur	x23, [x29, #-0xc0]
               	cbnz	x23, 0x40087c <.text+0x5bc>
               	ldursw	x0, [x29, #-0x50]
               	cmp	x0, #0x3
               	cset	x23, ne
               	stur	x23, [x29, #-0xc0]
               	b	0x40087c <.text+0x5bc>
               	ldur	x23, [x29, #-0xc0]
               	cbz	x23, 0x4008e8 <.text+0x628>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x19e
               	mov	x25, x19
               	sxtw	x24, w20
               	ldursw	x23, [x29, #-0x40]
               	ldursw	x20, [x29, #-0x48]
               	ldursw	x21, [x29, #-0x50]
               	mov	x0, x25
               	mov	x4, x21
               	mov	x3, x20
               	mov	x2, x23
               	mov	x1, x24
               	bl	0x400b84 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
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
               	sub	x21, x29, #0x60
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1bb
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x21]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x21, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x21, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x21, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x20, x21
               	mov	x20, #0xc8              // =200
               	sxtw	x0, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	cmp	x21, #0x80
               	b.hs	0x400960 <.text+0x6a0>
               	sub	x21, x29, #0x60
               	sxtw	x0, w20
               	mov	x17, #0xff              // =255
               	and	x20, x0, x17
               	strb	w20, [x21]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xd8]
               	b	0x40096c <.text+0x6ac>
               	mov	x0, #0x63               // =99
               	stur	x0, [x29, #-0xd8]
               	b	0x40096c <.text+0x6ac>
               	ldur	x0, [x29, #-0xd8]
               	sxtw	x20, w0
               	cmp	x20, #0x63
               	cset	x21, ne
               	stur	x21, [x29, #-0xe0]
               	cbnz	x21, 0x4009a8 <.text+0x6e8>
               	sub	x20, x29, #0x60
               	ldrb	w21, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x21, x17
               	cmp	x20, #0x0
               	cset	x21, ne
               	stur	x21, [x29, #-0xe0]
               	b	0x4009a8 <.text+0x6e8>
               	ldur	x21, [x29, #-0xe0]
               	cbz	x21, 0x400a08 <.text+0x748>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1bf
               	mov	x22, x19
               	sxtw	x20, w0
               	sub	x0, x29, #0x60
               	ldrb	w21, [x0]
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	0x400b84 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
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
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
