
c5_vprintf.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400ec8 <.text+0xbd8>
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
               	bl	0x401268 <malloc>
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
               	mov	x10, x0
               	stur	w10, [x29, #-0x10]
               	ldursw	x21, [x29, #-0x18]
               	cbz	x21, 0x400550 <.text+0x260>
               	ldursw	x10, [x29, #-0x10]
               	sub	x21, x10, #0x1
               	sxtw	x21, w21
               	stur	w21, [x29, #-0x10]
               	ldursw	x10, [x29, #-0x10]
               	add	x21, x22, x10
               	mov	x10, #0x2d              // =45
               	strb	w10, [x21]
               	b	0x400550 <.text+0x260>
               	mov	x10, #0x1f              // =31
               	ldursw	x24, [x29, #-0x10]
               	sub	x21, x10, x24
               	sxtw	x25, w21
               	add	x21, x22, x24
               	sxtw	x26, w25
               	mov	x0, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x0, x22
               	bl	0x401280 <free>
               	sxtw	x0, w0
               	mov	x23, x0
               	sxtw	x23, w25
               	mov	x0, x23
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
               	bl	0x401268 <malloc>
               	mov	x23, x0
               	mov	x24, #0x1f              // =31
               	mov	x22, #0x10              // =16
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x400308 <.text+0x18>
               	mov	x10, x0
               	sxtw	x22, w10
               	sub	x10, x24, x22
               	sxtw	x25, w10
               	add	x26, x23, x22
               	sxtw	x24, w25
               	mov	x0, x20
               	mov	x2, x24
               	mov	x1, x26
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x0, x23
               	bl	0x401280 <free>
               	sxtw	x0, w0
               	mov	x21, x0
               	sxtw	x21, w25
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
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x23, #0x11              // =17
               	mov	x0, x23
               	bl	0x401268 <malloc>
               	mov	x24, x0
               	add	x23, x24, #0x10
               	mov	x21, #0x0               // =0
               	strb	w21, [x23]
               	mov	x11, #0xf               // =15
               	stur	w11, [x29, #-0x10]
               	b	0x400724 <.text+0x434>
               	ldursw	x11, [x29, #-0x10]
               	cmp	x11, #0x0
               	b.lt	0x400750 <.text+0x460>
               	ldursw	x11, [x29, #0x20]
               	mov	x17, #0xf               // =15
               	and	x21, x11, x17
               	stur	w21, [x29, #-0x18]
               	ldursw	x11, [x29, #-0x18]
               	cmp	x11, #0xa
               	b.ge	0x4007fc <.text+0x50c>
               	b	0x4007ac <.text+0x4bc>
               	mov	x22, #0x10              // =16
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x0, x24
               	bl	0x401280 <free>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x12              // =18
               	mov	x0, x21
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
               	b	0x4007c8 <.text+0x4d8>
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
               	b	0x400724 <.text+0x434>
               	ldursw	x23, [x29, #-0x10]
               	add	x11, x24, x23
               	ldursw	x23, [x29, #-0x18]
               	add	x21, x23, #0x61
               	sxtw	x21, w21
               	sub	x23, x21, #0xa
               	sxtw	x23, w23
               	strb	w23, [x11]
               	b	0x4007c8 <.text+0x4d8>
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
               	b.ne	0x4008a4 <.text+0x5b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x103
               	mov	x22, x19
               	mov	x23, #0x6               // =6
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x11, x0
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
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x8]
               	b	0x4008b0 <.text+0x5c0>
               	ldursw	x11, [x29, #-0x8]
               	add	x23, x21, x11
               	ldrb	w11, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x11, x17
               	cmp	x23, #0x0
               	b.eq	0x4008e4 <.text+0x5f4>
               	ldursw	x23, [x29, #-0x8]
               	add	x11, x23, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x8]
               	b	0x4008b0 <.text+0x5c0>
               	ldursw	x24, [x29, #-0x8]
               	mov	x0, x20
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x23, x0
               	ldursw	x23, [x29, #-0x8]
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
               	b	0x40097c <.text+0x68c>
               	ldursw	x12, [x29, #-0x10]
               	add	x13, x21, x12
               	ldrb	w12, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x12, x17
               	cmp	x13, #0x0
               	b.eq	0x4009d0 <.text+0x6e0>
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
               	b.eq	0x400a54 <.text+0x764>
               	b	0x400a04 <.text+0x714>
               	ldursw	x25, [x29, #-0x8]
               	mov	x0, x25
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
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x11, x0
               	ldursw	x11, [x29, #-0x8]
               	add	x23, x11, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	ldursw	x11, [x29, #-0x10]
               	add	x23, x11, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400a50 <.text+0x760>
               	b	0x40097c <.text+0x68c>
               	ldursw	x23, [x29, #-0x10]
               	add	x11, x23, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x10]
               	ldursw	x23, [x29, #-0x10]
               	add	x11, x21, x23
               	ldrb	w23, [x11]
               	sturb	w23, [x29, #-0x18]
               	ldurb	w11, [x29, #-0x18]
               	mov	x17, #0x64              // =100
               	eor	x23, x11, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x23, x17
               	cmp	x11, #0x0
               	b.ne	0x400ae0 <.text+0x7f0>
               	ldursw	x24, [x29, #-0x8]
               	add	x23, x29, #0x30
               	ldr	x22, [x23]
               	add	x17, x22, #0x10
               	str	x17, [x23]
               	ldrsw	x25, [x22]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x400470 <.text+0x180>
               	mov	x22, x0
               	add	x25, x24, x22
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x22, [x29, #-0x10]
               	add	x25, x22, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400adc <.text+0x7ec>
               	b	0x400a50 <.text+0x760>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0x75              // =117
               	eor	x22, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x22, x17
               	cmp	x25, #0x0
               	b.ne	0x400b4c <.text+0x85c>
               	ldursw	x23, [x29, #-0x8]
               	add	x22, x29, #0x30
               	ldr	x24, [x22]
               	add	x17, x24, #0x10
               	str	x17, [x22]
               	ldrsw	x25, [x24]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x400470 <.text+0x180>
               	mov	x24, x0
               	add	x25, x23, x24
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x24, [x29, #-0x10]
               	add	x25, x24, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400b48 <.text+0x858>
               	b	0x400adc <.text+0x7ec>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0x78              // =120
               	eor	x24, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x24, x17
               	cmp	x25, #0x0
               	b.ne	0x400bb8 <.text+0x8c8>
               	ldursw	x22, [x29, #-0x8]
               	add	x24, x29, #0x30
               	ldr	x23, [x24]
               	add	x17, x23, #0x10
               	str	x17, [x24]
               	ldrsw	x25, [x23]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x4005c8 <.text+0x2d8>
               	mov	x23, x0
               	add	x25, x22, x23
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x23, [x29, #-0x10]
               	add	x25, x23, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400bb4 <.text+0x8c4>
               	b	0x400b48 <.text+0x858>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0x70              // =112
               	eor	x23, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x23, x17
               	cmp	x25, #0x0
               	b.ne	0x400c24 <.text+0x934>
               	ldursw	x24, [x29, #-0x8]
               	add	x23, x29, #0x30
               	ldr	x22, [x23]
               	add	x17, x22, #0x10
               	str	x17, [x23]
               	ldrsw	x25, [x22]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x40069c <.text+0x3ac>
               	mov	x22, x0
               	add	x25, x24, x22
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x22, [x29, #-0x10]
               	add	x25, x22, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400c20 <.text+0x930>
               	b	0x400bb4 <.text+0x8c4>
               	ldurb	w25, [x29, #-0x18]
               	mov	x17, #0x63              // =99
               	eor	x22, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x22, x17
               	cmp	x25, #0x0
               	b.ne	0x400ca4 <.text+0x9b4>
               	add	x25, x29, #0x30
               	ldr	x22, [x25]
               	add	x17, x22, #0x10
               	str	x17, [x25]
               	ldrsw	x25, [x22]
               	sturb	w25, [x29, #-0x20]
               	sub	x23, x29, #0x20
               	mov	x22, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x23
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x8]
               	add	x22, x24, #0x1
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x8]
               	ldursw	x24, [x29, #-0x10]
               	add	x22, x24, #0x1
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x10]
               	b	0x400ca0 <.text+0x9b0>
               	b	0x400c20 <.text+0x930>
               	ldurb	w22, [x29, #-0x18]
               	mov	x17, #0x73              // =115
               	eor	x24, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x24, x17
               	cmp	x22, #0x0
               	b.ne	0x400d10 <.text+0xa20>
               	ldursw	x25, [x29, #-0x8]
               	add	x24, x29, #0x30
               	ldr	x23, [x24]
               	add	x17, x23, #0x10
               	str	x17, [x24]
               	ldr	x22, [x23]
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x400820 <.text+0x530>
               	mov	x23, x0
               	add	x22, x25, x23
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x8]
               	ldursw	x23, [x29, #-0x10]
               	add	x22, x23, #0x1
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x10]
               	b	0x400d0c <.text+0xa1c>
               	b	0x400ca0 <.text+0x9b0>
               	ldurb	w22, [x29, #-0x18]
               	mov	x17, #0x25              // =37
               	eor	x23, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x23, x17
               	cmp	x22, #0x0
               	b.ne	0x400d80 <.text+0xa90>
               	mov	x22, #0x25              // =37
               	sturb	w22, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x24
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x25, x0
               	ldursw	x25, [x29, #-0x8]
               	add	x23, x25, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	ldursw	x25, [x29, #-0x10]
               	add	x23, x25, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400d7c <.text+0xa8c>
               	b	0x400d0c <.text+0xa1c>
               	ldurb	w23, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x23, x17
               	cmp	x25, #0x0
               	b.ne	0x400da0 <.text+0xab0>
               	b	0x400d9c <.text+0xaac>
               	b	0x400d7c <.text+0xa8c>
               	mov	x25, #0x25              // =37
               	sturb	w25, [x29, #-0x20]
               	sub	x22, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x24, x0
               	ldurb	w24, [x29, #-0x18]
               	sturb	w24, [x29, #-0x20]
               	sub	x25, x29, #0x20
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x401274 <write>
               	sxtw	x0, w0
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x8]
               	add	x25, x24, #0x2
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x8]
               	ldursw	x24, [x29, #-0x10]
               	add	x25, x24, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x400d9c <.text+0xaac>
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
               	bl	0x40092c <.text+0x63c>
               	mov	x12, x0
               	mov	x0, x12
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
               	bl	0x400e10 <.text+0xb20>
               	mov	x15, x0
               	sub	x21, x29, #0x8
               	sxtw	x20, w15
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
               	bl	0x400e64 <.text+0xb74>
               	add	sp, sp, #0x50
               	mov	x10, x0
               	sxtw	x24, w10
               	cmp	x24, #0x0
               	b.gt	0x400f78 <.text+0xc88>
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
               	bl	0x400e64 <.text+0xb74>
               	add	sp, sp, #0x10
               	mov	x24, x0
               	sxtw	x25, w24
               	cmp	x25, #0x0
               	b.eq	0x400fd4 <.text+0xce4>
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
               	mov	x26, x19
               	str	x26, [sp, #-0x10]!
               	bl	0x400e64 <.text+0xb74>
               	add	sp, sp, #0x10
               	mov	x25, x0
               	sxtw	x26, w25
               	cmp	x26, #0x0
               	b.eq	0x401030 <.text+0xd40>
               	mov	x26, #0x3               // =3
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x152
               	mov	x24, x19
               	str	x24, [sp, #-0x10]!
               	bl	0x400e64 <.text+0xb74>
               	add	sp, sp, #0x10
               	mov	x26, x0
               	sxtw	x24, w26
               	cmp	x24, #0x3
               	b.eq	0x40108c <.text+0xd9c>
               	mov	x24, #0x4               // =4
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
               	add	x19, x19, #0x156
               	mov	x25, x19
               	mov	x26, #0x0               // =0
               	str	x26, [sp, #-0x10]!
               	str	x25, [sp, #-0x10]!
               	bl	0x400e64 <.text+0xb74>
               	add	sp, sp, #0x20
               	mov	x23, x0
               	sxtw	x26, w23
               	cmp	x26, #0x13
               	b.eq	0x4010f0 <.text+0xe00>
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
               	mov	x23, #0x0               // =0
               	mov	x0, x23
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
               	<unknown>
               	adr	x10, 0x4ed249
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x40777c <exit+0x64f0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f980c
               	tbz	w21, #0x6, 0x3ff7d0
               	<unknown>
               	cbnz	w16, 0x46f778
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400d84 <.text+0xa94>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
		...
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x40128c <exit>
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
               	adr	x10, 0x4ed311
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x407844 <exit+0x65b8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f98d4
               	tbz	w21, #0x6, 0x3ff898
               	<unknown>
               	cbnz	w16, 0x46f840
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400e4c <.text+0xb5c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<malloc>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	br	x16

<write>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	br	x16

<free>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16
