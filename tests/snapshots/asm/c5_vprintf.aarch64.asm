
c5_vprintf.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400e50 <.text+0xb60>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	sub	sp, sp, #0x10
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	stur	w13, [x29, #0x30]
               	sxtw	x12, w3
               	stur	w14, [x29, #-0x8]
               	ldursw	x13, [x29, #-0x8]
               	add	x14, x15, x13
               	mov	x13, #0x0               // =0
               	strb	w13, [x14]
               	ldursw	x11, [x29, #0x30]
               	cmp	x11, #0x0
               	b.ne	0x400388 <.text+0x98>
               	ldursw	x13, [x29, #-0x8]
               	sub	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x8]
               	ldursw	x11, [x29, #-0x8]
               	add	x13, x15, x11
               	mov	x11, #0x30              // =48
               	strb	w11, [x13]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	b	0x40038c <.text+0x9c>
               	ldursw	x11, [x29, #0x30]
               	cmp	x11, #0x0
               	b.eq	0x4003a4 <.text+0xb4>
               	cmp	x12, #0xa
               	b.ne	0x4003f8 <.text+0x108>
               	b	0x4003b8 <.text+0xc8>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldursw	x11, [x29, #0x30]
               	mov	x0, #0xa                // =10
               	sdiv	x17, x11, x0
               	msub	x13, x17, x0, x11
               	stur	w13, [x29, #-0x10]
               	sdiv	x11, x11, x0
               	stur	w11, [x29, #0x30]
               	b	0x4003d8 <.text+0xe8>
               	ldursw	x11, [x29, #-0x8]
               	sub	x11, x11, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x8]
               	ldursw	x10, [x29, #-0x10]
               	cmp	x10, #0xa
               	b.ge	0x400448 <.text+0x158>
               	b	0x400428 <.text+0x138>
               	ldursw	x11, [x29, #0x30]
               	mov	x17, #0xf               // =15
               	and	x0, x11, x17
               	stur	w0, [x29, #-0x10]
               	asr	x11, x11, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x11, x11, x17
               	stur	w11, [x29, #0x30]
               	b	0x4003d8 <.text+0xe8>
               	ldursw	x11, [x29, #-0x8]
               	add	x10, x15, x11
               	ldursw	x11, [x29, #-0x10]
               	add	x11, x11, #0x30
               	sxtw	x11, w11
               	strb	w11, [x10]
               	b	0x400444 <.text+0x154>
               	b	0x40038c <.text+0x9c>
               	ldursw	x11, [x29, #-0x8]
               	add	x0, x15, x11
               	ldursw	x11, [x29, #-0x10]
               	add	x11, x11, #0x61
               	sxtw	x11, w11
               	sub	x11, x11, #0xa
               	sxtw	x11, w11
               	strb	w11, [x0]
               	b	0x400444 <.text+0x154>
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	sxtw	x20, w0
               	sxtw	x14, w1
               	stur	w14, [x29, #0x20]
               	mov	x21, #0x20              // =32
               	mov	x0, x21
               	bl	0x4011d8 <malloc>
               	mov	x22, x0
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x18]
               	ldursw	x12, [x29, #0x20]
               	cmp	x12, #0x0
               	b.ge	0x4004f8 <.text+0x208>
               	mov	x21, #0x1               // =1
               	stur	w21, [x29, #-0x18]
               	ldursw	x12, [x29, #0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x12, x12, x17
               	stur	w12, [x29, #0x20]
               	b	0x4004f8 <.text+0x208>
               	mov	x23, #0x1f              // =31
               	ldursw	x24, [x29, #0x20]
               	mov	x21, #0xa               // =10
               	mov	x0, x22
               	mov	x3, x21
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x400308 <.text+0x18>
               	stur	w0, [x29, #-0x10]
               	ldursw	x21, [x29, #-0x18]
               	cbz	x21, 0x400548 <.text+0x258>
               	ldursw	x0, [x29, #-0x10]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	ldursw	x21, [x29, #-0x10]
               	add	x0, x22, x21
               	mov	x21, #0x2d              // =45
               	strb	w21, [x0]
               	b	0x400548 <.text+0x258>
               	mov	x21, #0x1f              // =31
               	ldursw	x24, [x29, #-0x10]
               	sub	x21, x21, x24
               	sxtw	x21, w21
               	add	x25, x22, x24
               	sxtw	x26, w21
               	mov	x0, x20
               	mov	x2, x26
               	mov	x1, x25
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	mov	x0, x22
               	bl	0x4011f0 <free>
               	sxtw	x0, w0
               	sxtw	x21, w21
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	sxtw	x20, w0
               	sxtw	x21, w1
               	mov	x22, #0x20              // =32
               	mov	x0, x22
               	bl	0x4011d8 <malloc>
               	mov	x23, x0
               	mov	x24, #0x1f              // =31
               	mov	x22, #0x10              // =16
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x400308 <.text+0x18>
               	sxtw	x0, w0
               	sub	x24, x24, x0
               	sxtw	x24, w24
               	add	x25, x23, x0
               	sxtw	x22, w24
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x25
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	mov	x0, x23
               	bl	0x4011f0 <free>
               	sxtw	x0, w0
               	sxtw	x24, w24
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	sxtw	x20, w0
               	sxtw	x14, w1
               	stur	w14, [x29, #0x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	mov	x22, #0x2               // =2
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	mov	x23, #0x11              // =17
               	mov	x0, x23
               	bl	0x4011d8 <malloc>
               	mov	x24, x0
               	add	x23, x24, #0x10
               	mov	x21, #0x0               // =0
               	strb	w21, [x23]
               	mov	x11, #0xf               // =15
               	stur	w11, [x29, #-0x10]
               	b	0x4006fc <.text+0x40c>
               	ldursw	x11, [x29, #-0x10]
               	cmp	x11, #0x0
               	b.lt	0x400728 <.text+0x438>
               	ldursw	x21, [x29, #0x20]
               	mov	x17, #0xf               // =15
               	and	x21, x21, x17
               	stur	w21, [x29, #-0x18]
               	ldursw	x11, [x29, #-0x18]
               	cmp	x11, #0xa
               	b.ge	0x4007c8 <.text+0x4d8>
               	b	0x400778 <.text+0x488>
               	mov	x22, #0x10              // =16
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	mov	x0, x24
               	bl	0x4011f0 <free>
               	sxtw	x0, w0
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldursw	x21, [x29, #-0x10]
               	add	x11, x24, x21
               	ldursw	x21, [x29, #-0x18]
               	add	x21, x21, #0x30
               	sxtw	x21, w21
               	strb	w21, [x11]
               	b	0x400794 <.text+0x4a4>
               	ldursw	x21, [x29, #0x20]
               	asr	x21, x21, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x21, x21, x17
               	stur	w21, [x29, #0x20]
               	ldursw	x11, [x29, #-0x10]
               	sub	x11, x11, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x10]
               	b	0x4006fc <.text+0x40c>
               	ldursw	x21, [x29, #-0x10]
               	add	x23, x24, x21
               	ldursw	x21, [x29, #-0x18]
               	add	x21, x21, #0x61
               	sxtw	x21, w21
               	sub	x21, x21, #0xa
               	sxtw	x21, w21
               	strb	w21, [x23]
               	b	0x400794 <.text+0x4a4>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	sxtw	x20, w0
               	mov	x21, x1
               	cmp	x21, #0x0
               	b.ne	0x40086c <.text+0x57c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x103
               	mov	x22, x19
               	mov	x23, #0x6               // =6
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	b	0x400878 <.text+0x588>
               	ldursw	x0, [x29, #-0x8]
               	add	x23, x21, x0
               	ldrb	w0, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	0x4008ac <.text+0x5bc>
               	ldursw	x23, [x29, #-0x8]
               	add	x23, x23, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	b	0x400878 <.text+0x588>
               	ldursw	x24, [x29, #-0x8]
               	mov	x0, x20
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	sxtw	x20, w0
               	mov	x21, x1
               	mov	x13, x2
               	stur	x13, [x29, #0x30]
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x8]
               	stur	w12, [x29, #-0x10]
               	b	0x40093c <.text+0x64c>
               	ldursw	x12, [x29, #-0x10]
               	add	x13, x21, x12
               	ldrb	w12, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	0x400990 <.text+0x6a0>
               	ldursw	x13, [x29, #-0x10]
               	add	x12, x21, x13
               	ldrb	w13, [x12]
               	sturb	w13, [x29, #-0x18]
               	ldurb	w12, [x29, #-0x18]
               	mov	x17, #0x25              // =37
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	0x400a10 <.text+0x720>
               	b	0x4009c4 <.text+0x6d4>
               	ldursw	x22, [x29, #-0x8]
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	ldurb	w13, [x29, #-0x18]
               	sturb	w13, [x29, #-0x20]
               	sub	x22, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x23, [x29, #-0x10]
               	add	x23, x23, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400a0c <.text+0x71c>
               	b	0x40093c <.text+0x64c>
               	ldursw	x23, [x29, #-0x10]
               	add	x23, x23, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	add	x23, x21, x0
               	ldrb	w0, [x23]
               	sturb	w0, [x29, #-0x18]
               	ldurb	w23, [x29, #-0x18]
               	mov	x17, #0x64              // =100
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	b.ne	0x400a98 <.text+0x7a8>
               	ldursw	x24, [x29, #-0x8]
               	add	x23, x29, #0x30
               	ldr	x22, [x23]
               	add	x17, x22, #0x10
               	str	x17, [x23]
               	ldrsw	x25, [x22]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x40046c <.text+0x17c>
               	add	x24, x24, x0
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	0x400a94 <.text+0x7a4>
               	b	0x400a0c <.text+0x71c>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x75              // =117
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	0x400b00 <.text+0x810>
               	ldursw	x22, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x25, [x0]
               	add	x17, x25, #0x10
               	str	x17, [x0]
               	ldrsw	x24, [x25]
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x40046c <.text+0x17c>
               	add	x22, x22, x0
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	0x400afc <.text+0x80c>
               	b	0x400a94 <.text+0x7a4>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	0x400b68 <.text+0x878>
               	ldursw	x25, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x24, [x0]
               	add	x17, x24, #0x10
               	str	x17, [x0]
               	ldrsw	x22, [x24]
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x4005b8 <.text+0x2c8>
               	add	x25, x25, x0
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	0x400b64 <.text+0x874>
               	b	0x400afc <.text+0x80c>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x70              // =112
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	0x400bd0 <.text+0x8e0>
               	ldursw	x24, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x22, [x0]
               	add	x17, x22, #0x10
               	str	x17, [x0]
               	ldrsw	x25, [x22]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x400678 <.text+0x388>
               	add	x24, x24, x0
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	0x400bcc <.text+0x8dc>
               	b	0x400b64 <.text+0x874>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	0x400c4c <.text+0x95c>
               	add	x24, x29, #0x30
               	ldr	x0, [x24]
               	add	x17, x0, #0x10
               	str	x17, [x24]
               	ldrsw	x24, [x0]
               	sturb	w24, [x29, #-0x20]
               	sub	x22, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x23, [x29, #-0x10]
               	add	x23, x23, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400c48 <.text+0x958>
               	b	0x400bcc <.text+0x8dc>
               	ldurb	w23, [x29, #-0x18]
               	mov	x17, #0x73              // =115
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	b.ne	0x400cb4 <.text+0x9c4>
               	ldursw	x25, [x29, #-0x8]
               	add	x23, x29, #0x30
               	ldr	x22, [x23]
               	add	x17, x22, #0x10
               	str	x17, [x23]
               	ldr	x24, [x22]
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x4007ec <.text+0x4fc>
               	add	x25, x25, x0
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	0x400cb0 <.text+0x9c0>
               	b	0x400c48 <.text+0x958>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	0x400d20 <.text+0xa30>
               	mov	x25, #0x25              // =37
               	sturb	w25, [x29, #-0x20]
               	sub	x22, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x23, [x29, #-0x10]
               	add	x23, x23, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400d1c <.text+0xa2c>
               	b	0x400cb0 <.text+0x9c0>
               	ldurb	w23, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	b.ne	0x400d40 <.text+0xa50>
               	b	0x400d3c <.text+0xa4c>
               	b	0x400d1c <.text+0xa2c>
               	mov	x0, #0x25               // =37
               	sturb	w0, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x24
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldurb	w0, [x29, #-0x18]
               	sturb	w0, [x29, #-0x20]
               	sub	x22, x29, #0x20
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x22, [x29, #-0x10]
               	add	x22, x22, #0x1
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x10]
               	b	0x400d3c <.text+0xa4c>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, x0
               	mov	x21, x1
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	0x4008ec <.text+0x5fc>
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x10
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	ldur	x20, [x29, #0x10]
               	ldur	x21, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400da8 <.text+0xab8>
               	sub	x21, x29, #0x8
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x149
               	mov	x21, x19
               	mov	x22, #0x2a              // =42
               	mov	x23, #0x41              // =65
               	mov	x24, #0xff              // =255
               	str	x24, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	bl	0x400df4 <.text+0xb04>
               	add	sp, sp, #0x50
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.gt	0x400efc <.text+0xc0c>
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x14f
               	mov	x25, x19
               	str	x25, [sp, #-0x10]!
               	bl	0x400df4 <.text+0xb04>
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400f54 <.text+0xc64>
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x24, x19
               	str	x24, [sp, #-0x10]!
               	bl	0x400df4 <.text+0xb04>
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400fac <.text+0xcbc>
               	mov	x24, #0x3               // =3
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x152
               	mov	x25, x19
               	str	x25, [sp, #-0x10]!
               	bl	0x400df4 <.text+0xb04>
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	0x401004 <.text+0xd14>
               	mov	x25, #0x4               // =4
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x156
               	mov	x24, x19
               	mov	x26, #0x0               // =0
               	str	x26, [sp, #-0x10]!
               	str	x24, [sp, #-0x10]!
               	bl	0x400df4 <.text+0xb04>
               	add	sp, sp, #0x20
               	sxtw	x0, w0
               	cmp	x0, #0x13
               	b.eq	0x401064 <.text+0xd74>
               	mov	x26, #0x5               // =5
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
