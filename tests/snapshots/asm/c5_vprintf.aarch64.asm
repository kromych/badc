
c5_vprintf.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400e58 <.text+0xb68>
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
               	ldursw	x11, [x29, #-0x8]
               	sub	x13, x11, #0x1
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
               	b.ne	0x4003fc <.text+0x10c>
               	b	0x4003bc <.text+0xcc>
               	ldursw	x11, [x29, #-0x8]
               	mov	x0, x11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldursw	x0, [x29, #0x30]
               	mov	x11, #0xa               // =10
               	sdiv	x17, x0, x11
               	msub	x13, x17, x11, x0
               	stur	w13, [x29, #-0x10]
               	sdiv	x10, x0, x11
               	stur	w10, [x29, #0x30]
               	b	0x4003dc <.text+0xec>
               	ldursw	x10, [x29, #-0x8]
               	sub	x0, x10, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x10, [x29, #-0x10]
               	cmp	x10, #0xa
               	b.ge	0x40044c <.text+0x15c>
               	b	0x40042c <.text+0x13c>
               	ldursw	x10, [x29, #0x30]
               	mov	x17, #0xf               // =15
               	and	x11, x10, x17
               	stur	w11, [x29, #-0x10]
               	asr	x0, x10, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x10, x0, x17
               	stur	w10, [x29, #0x30]
               	b	0x4003dc <.text+0xec>
               	ldursw	x10, [x29, #-0x8]
               	add	x0, x15, x10
               	ldursw	x10, [x29, #-0x10]
               	add	x11, x10, #0x30
               	sxtw	x11, w11
               	strb	w11, [x0]
               	b	0x400448 <.text+0x158>
               	b	0x40038c <.text+0x9c>
               	ldursw	x11, [x29, #-0x8]
               	add	x10, x15, x11
               	ldursw	x11, [x29, #-0x10]
               	add	x0, x11, #0x61
               	sxtw	x0, w0
               	sub	x11, x0, #0xa
               	sxtw	x11, w11
               	strb	w11, [x10]
               	b	0x400448 <.text+0x158>
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
               	b.ge	0x4004fc <.text+0x20c>
               	mov	x12, #0x1               // =1
               	stur	w12, [x29, #-0x18]
               	ldursw	x21, [x29, #0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x12, x21, x17
               	stur	w12, [x29, #0x20]
               	b	0x4004fc <.text+0x20c>
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
               	cbz	x21, 0x40054c <.text+0x25c>
               	ldursw	x0, [x29, #-0x10]
               	sub	x21, x0, #0x1
               	sxtw	x21, w21
               	stur	w21, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	add	x21, x22, x0
               	mov	x0, #0x2d               // =45
               	strb	w0, [x21]
               	b	0x40054c <.text+0x25c>
               	mov	x0, #0x1f               // =31
               	ldursw	x24, [x29, #-0x10]
               	sub	x21, x0, x24
               	sxtw	x25, w21
               	add	x21, x22, x24
               	sxtw	x26, w25
               	mov	x0, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	mov	x0, x22
               	bl	0x4011f0 <free>
               	sxtw	x0, w0
               	sxtw	x0, w25
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
               	sxtw	x22, w0
               	sub	x0, x24, x22
               	sxtw	x25, w0
               	add	x26, x23, x22
               	sxtw	x24, w25
               	mov	x0, x20
               	mov	x2, x24
               	mov	x1, x26
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	mov	x0, x23
               	bl	0x4011f0 <free>
               	sxtw	x0, w0
               	sxtw	x0, w25
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
               	b	0x400700 <.text+0x410>
               	ldursw	x11, [x29, #-0x10]
               	cmp	x11, #0x0
               	b.lt	0x40072c <.text+0x43c>
               	ldursw	x11, [x29, #0x20]
               	mov	x17, #0xf               // =15
               	and	x21, x11, x17
               	stur	w21, [x29, #-0x18]
               	ldursw	x11, [x29, #-0x18]
               	cmp	x11, #0xa
               	b.ge	0x4007cc <.text+0x4dc>
               	b	0x40077c <.text+0x48c>
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
               	ldursw	x11, [x29, #-0x10]
               	add	x21, x24, x11
               	ldursw	x11, [x29, #-0x18]
               	add	x23, x11, #0x30
               	sxtw	x23, w23
               	strb	w23, [x21]
               	b	0x400798 <.text+0x4a8>
               	ldursw	x23, [x29, #0x20]
               	asr	x21, x23, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x23, x21, x17
               	stur	w23, [x29, #0x20]
               	ldursw	x21, [x29, #-0x10]
               	sub	x23, x21, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400700 <.text+0x410>
               	ldursw	x23, [x29, #-0x10]
               	add	x11, x24, x23
               	ldursw	x23, [x29, #-0x18]
               	add	x21, x23, #0x61
               	sxtw	x21, w21
               	sub	x23, x21, #0xa
               	sxtw	x23, w23
               	strb	w23, [x11]
               	b	0x400798 <.text+0x4a8>
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
               	b.ne	0x400870 <.text+0x580>
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
               	b	0x40087c <.text+0x58c>
               	ldursw	x0, [x29, #-0x8]
               	add	x23, x21, x0
               	ldrb	w0, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	cmp	x23, #0x0
               	b.eq	0x4008b0 <.text+0x5c0>
               	ldursw	x23, [x29, #-0x8]
               	add	x0, x23, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	b	0x40087c <.text+0x58c>
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
               	b	0x400940 <.text+0x650>
               	ldursw	x12, [x29, #-0x10]
               	add	x13, x21, x12
               	ldrb	w12, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x12, x17
               	cmp	x13, #0x0
               	b.eq	0x400994 <.text+0x6a4>
               	ldursw	x13, [x29, #-0x10]
               	add	x12, x21, x13
               	ldrb	w13, [x12]
               	sturb	w13, [x29, #-0x18]
               	ldurb	w12, [x29, #-0x18]
               	mov	x17, #0x25              // =37
               	eor	x13, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x13, x17
               	cmp	x12, #0x0
               	b.eq	0x400a14 <.text+0x724>
               	b	0x4009c8 <.text+0x6d8>
               	ldursw	x24, [x29, #-0x8]
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
               	add	sp, sp, #0x30
               	ret
               	ldurb	w12, [x29, #-0x18]
               	sturb	w12, [x29, #-0x20]
               	sub	x22, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x23, x0, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x23, x0, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400a10 <.text+0x720>
               	b	0x400940 <.text+0x650>
               	ldursw	x23, [x29, #-0x10]
               	add	x0, x23, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	ldursw	x23, [x29, #-0x10]
               	add	x0, x21, x23
               	ldrb	w23, [x0]
               	sturb	w23, [x29, #-0x18]
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x64              // =100
               	eor	x23, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	b.ne	0x400a9c <.text+0x7ac>
               	ldursw	x24, [x29, #-0x8]
               	add	x23, x29, #0x30
               	ldr	x22, [x23]
               	add	x17, x22, #0x10
               	str	x17, [x23]
               	ldrsw	x25, [x22]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x400470 <.text+0x180>
               	add	x25, x24, x0
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x25, x0, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400a98 <.text+0x7a8>
               	b	0x400a10 <.text+0x720>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0x75              // =117
               	eor	x0, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	cmp	x25, #0x0
               	b.ne	0x400b04 <.text+0x814>
               	ldursw	x22, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x24, [x0]
               	add	x17, x24, #0x10
               	str	x17, [x0]
               	ldrsw	x25, [x24]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x400470 <.text+0x180>
               	add	x25, x22, x0
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x25, x0, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400b00 <.text+0x810>
               	b	0x400a98 <.text+0x7a8>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0x78              // =120
               	eor	x0, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	cmp	x25, #0x0
               	b.ne	0x400b6c <.text+0x87c>
               	ldursw	x24, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x22, [x0]
               	add	x17, x22, #0x10
               	str	x17, [x0]
               	ldrsw	x25, [x22]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x4005b8 <.text+0x2c8>
               	add	x25, x24, x0
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x25, x0, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400b68 <.text+0x878>
               	b	0x400b00 <.text+0x810>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0x70              // =112
               	eor	x0, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	cmp	x25, #0x0
               	b.ne	0x400bd4 <.text+0x8e4>
               	ldursw	x22, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x24, [x0]
               	add	x17, x24, #0x10
               	str	x17, [x0]
               	ldrsw	x25, [x24]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x40067c <.text+0x38c>
               	add	x25, x22, x0
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x25, x0, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400bd0 <.text+0x8e0>
               	b	0x400b68 <.text+0x878>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0x63              // =99
               	eor	x0, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	cmp	x25, #0x0
               	b.ne	0x400c50 <.text+0x960>
               	add	x25, x29, #0x30
               	ldr	x0, [x25]
               	add	x17, x0, #0x10
               	str	x17, [x25]
               	ldrsw	x25, [x0]
               	sturb	w25, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x24
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x23, x0, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x23, x0, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400c4c <.text+0x95c>
               	b	0x400bd0 <.text+0x8e0>
               	ldurb	w23, [x29, #-0x18]
               	mov	x17, #0x73              // =115
               	eor	x0, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	cmp	x23, #0x0
               	b.ne	0x400cb8 <.text+0x9c8>
               	ldursw	x22, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x24, [x0]
               	add	x17, x24, #0x10
               	str	x17, [x0]
               	ldr	x23, [x24]
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x4007f0 <.text+0x500>
               	add	x23, x22, x0
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x23, x0, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400cb4 <.text+0x9c4>
               	b	0x400c4c <.text+0x95c>
               	ldurb	w23, [x29, #-0x18]
               	mov	x17, #0x25              // =37
               	eor	x0, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	cmp	x23, #0x0
               	b.ne	0x400d24 <.text+0xa34>
               	mov	x23, #0x25              // =37
               	sturb	w23, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	mov	x25, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x25
               	mov	x1, x24
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x25, x0, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x25, x0, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400d20 <.text+0xa30>
               	b	0x400cb4 <.text+0x9c4>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	cmp	x0, #0x0
               	b.ne	0x400d44 <.text+0xa54>
               	b	0x400d40 <.text+0xa50>
               	b	0x400d20 <.text+0xa30>
               	mov	x0, #0x25               // =37
               	sturb	w0, [x29, #-0x20]
               	sub	x22, x29, #0x20
               	mov	x25, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x25
               	mov	x1, x22
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldurb	w0, [x29, #-0x18]
               	sturb	w0, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	mov	x0, x20
               	mov	x2, x25
               	mov	x1, x24
               	bl	0x4011e4 <write>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x24, x0, #0x2
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x24, x0, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x400d40 <.text+0xa50>
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
               	bl	0x4008f0 <.text+0x600>
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
               	bl	0x400dac <.text+0xabc>
               	sub	x21, x29, #0x8
               	sxtw	x20, w0
               	mov	x0, x20
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
               	bl	0x400df8 <.text+0xb08>
               	add	sp, sp, #0x50
               	sxtw	x24, w0
               	cmp	x24, #0x0
               	b.gt	0x400f04 <.text+0xc14>
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
               	bl	0x400df8 <.text+0xb08>
               	add	sp, sp, #0x10
               	sxtw	x25, w0
               	cmp	x25, #0x0
               	b.eq	0x400f5c <.text+0xc6c>
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
               	bl	0x400df8 <.text+0xb08>
               	add	sp, sp, #0x10
               	sxtw	x24, w0
               	cmp	x24, #0x0
               	b.eq	0x400fb4 <.text+0xcc4>
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
               	bl	0x400df8 <.text+0xb08>
               	add	sp, sp, #0x10
               	sxtw	x25, w0
               	cmp	x25, #0x3
               	b.eq	0x40100c <.text+0xd1c>
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
               	bl	0x400df8 <.text+0xb08>
               	add	sp, sp, #0x20
               	sxtw	x26, w0
               	cmp	x26, #0x13
               	b.eq	0x40106c <.text+0xd7c>
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
