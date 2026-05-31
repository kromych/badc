
short_types.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400414 <.text+0x194>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
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
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400d88 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	sxtw	x15, w0
               	mov	x17, #0xffff            // =65535
               	and	x14, x15, x17
               	sxtw	x15, w14
               	mov	x17, #0x8000            // =32768
               	and	x13, x15, x17
               	cbz	x13, 0x4003f8 <.text+0x178>
               	sxtw	x15, w14
               	mov	x17, #0x10000           // =65536
               	sub	x13, x15, x17
               	sxtw	x0, w13
               	ret
               	sxtw	x15, w14
               	mov	x0, x15
               	ret
               	sxtw	x15, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x15, x17
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
               	str	x26, [sp, #0x30]
               	mov	x15, #0x4d2             // =1234
               	mov	x14, #0xffd6            // =65494
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	sxth	x13, w15
               	cmp	x13, #0x4d2
               	b.eq	0x40048c <.text+0x20c>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x12, w14
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x12, x17
               	b.eq	0x4004d8 <.text+0x258>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x13, w15
               	sxth	x12, w14
               	add	x11, x13, x12
               	sxtw	x11, w11
               	sxth	x12, w11
               	cmp	x12, #0x4a8
               	b.eq	0x400524 <.text+0x2a4>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x11, w15
               	sxth	x12, w14
               	sub	x13, x11, x12
               	sxtw	x13, w13
               	sxth	x12, w13
               	cmp	x12, #0x4fc
               	b.eq	0x400570 <.text+0x2f0>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x13, w14
               	mov	x17, #0x3               // =3
               	mul	x12, x13, x17
               	sxtw	x12, w12
               	sxth	x13, w12
               	mov	x17, #0xff82            // =65410
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x13, x17
               	b.eq	0x4005cc <.text+0x34c>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x12, w15
               	mov	x13, #0x7               // =7
               	sdiv	x14, x12, x13
               	sxth	x13, w14
               	cmp	x13, #0xb0
               	b.eq	0x400614 <.text+0x394>
               	mov	x13, #0x6               // =6
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x14, w15
               	mov	x13, #0x7               // =7
               	sdiv	x17, x14, x13
               	msub	x15, x17, x13, x14
               	sxth	x13, w15
               	cmp	x13, #0x2
               	b.eq	0x400660 <.text+0x3e0>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	sxth	x13, w20
               	lsl	x14, x13, #14
               	sxth	x13, w14
               	mov	x17, #0x4000            // =16384
               	cmp	x13, x17
               	b.eq	0x4006ac <.text+0x42c>
               	mov	x13, #0x8               // =8
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x14, w20
               	lsl	x21, x14, #16
               	mov	x0, x21
               	bl	0x4003c8 <.text+0x148>
               	sxth	x21, w0
               	cmp	x21, #0x0
               	b.eq	0x4006f8 <.text+0x478>
               	mov	x21, #0x9               // =9
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x0, w20
               	lsl	x22, x0, #15
               	mov	x0, x22
               	bl	0x4003c8 <.text+0x148>
               	sxth	x22, w0
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	b.eq	0x400754 <.text+0x4d4>
               	mov	x22, #0xa               // =10
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff8             // =65528
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxth	x22, w0
               	asr	x0, x22, #1
               	sxth	x22, w0
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	b.eq	0x4007b8 <.text+0x538>
               	mov	x22, #0xb               // =11
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xfffe            // =65534
               	mov	x23, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	and	x20, x21, x17
               	mov	x17, #0xffff            // =65535
               	and	x12, x23, x17
               	add	x11, x20, x12
               	sxtw	x11, w11
               	sxtw	x22, w11
               	mov	x0, x22
               	bl	0x400404 <.text+0x184>
               	mov	x17, #0xffff            // =65535
               	and	x22, x0, x17
               	mov	x17, #0xffff            // =65535
               	eor	x0, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x0, x17
               	cmp	x22, #0x0
               	b.eq	0x400838 <.text+0x5b8>
               	mov	x22, #0xc               // =12
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	and	x22, x23, x17
               	add	x21, x0, x22
               	sxtw	x21, w21
               	add	x22, x21, #0x1
               	sxtw	x24, w22
               	mov	x0, x24
               	bl	0x400404 <.text+0x184>
               	mov	x17, #0xffff            // =65535
               	and	x24, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	cmp	x0, #0x0
               	b.eq	0x4008a8 <.text+0x628>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x22, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	and	x21, x22, x17
               	sxth	x20, w24
               	add	x10, x21, x20
               	sxtw	x10, w10
               	sxtw	x20, w10
               	cmp	x20, #0x0
               	b.eq	0x40090c <.text+0x68c>
               	mov	x20, #0xe               // =14
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x25, w24
               	mov	x0, x25
               	bl	0x400404 <.text+0x184>
               	sxtw	x25, w0
               	mov	x17, #0xffff            // =65535
               	cmp	x25, x17
               	b.eq	0x400958 <.text+0x6d8>
               	mov	x25, #0xf               // =15
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x24, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x24, x17
               	mov	x17, #0xffff            // =65535
               	and	x24, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x24, x17
               	cmp	x25, x22
               	b.hi	0x4009b4 <.text+0x734>
               	mov	x22, #0x10              // =16
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x24, x23, x17
               	lsl	x20, x24, #15
               	mov	x0, x20
               	bl	0x400404 <.text+0x184>
               	mov	x17, #0xffff            // =65535
               	and	x20, x0, x17
               	mov	x17, #0x8000            // =32768
               	eor	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x0, x17
               	cmp	x20, #0x0
               	b.eq	0x400a1c <.text+0x79c>
               	mov	x20, #0x11              // =17
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8000             // =32768
               	mov	x17, #0xffff            // =65535
               	and	x20, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x0, x20, x17
               	sxtw	x20, w0
               	asr	x0, x20, #1
               	sxtw	x20, w0
               	mov	x17, #0x4000            // =16384
               	cmp	x20, x17
               	b.eq	0x400a78 <.text+0x7f8>
               	mov	x20, #0x12              // =18
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd8
               	mov	x20, #0x64              // =100
               	strh	w20, [x0]
               	sub	x23, x29, #0xd8
               	add	x20, x23, #0x2
               	mov	x23, #0xc8              // =200
               	strh	w23, [x20]
               	sub	x0, x29, #0xd8
               	add	x23, x0, #0x4
               	mov	x0, #0xfed4             // =65236
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	strh	w0, [x23]
               	sub	x20, x29, #0xd8
               	add	x22, x20, #0x6
               	sub	x20, x29, #0xd8
               	ldrsh	x23, [x20]
               	sub	x20, x29, #0xd8
               	add	x25, x20, #0x2
               	ldrsh	x20, [x25]
               	add	x25, x23, x20
               	sxtw	x25, w25
               	sub	x20, x29, #0xd8
               	add	x23, x20, #0x4
               	ldrsh	x20, [x23]
               	add	x23, x25, x20
               	sxtw	x26, w23
               	mov	x0, x26
               	bl	0x4003c8 <.text+0x148>
               	strh	w0, [x22]
               	sub	x26, x29, #0xd8
               	add	x0, x26, #0x6
               	ldrsh	x26, [x0]
               	cmp	x26, #0x0
               	b.eq	0x400b38 <.text+0x8b8>
               	mov	x26, #0x13              // =19
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	mov	x26, #0x7               // =7
               	strh	w26, [x0]
               	sub	x22, x29, #0xe0
               	add	x26, x22, #0x2
               	mov	x22, #0xfff9            // =65529
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	strh	w22, [x26]
               	sub	x0, x29, #0xe0
               	add	x22, x0, #0x4
               	mov	x0, #0xc0de             // =49374
               	strh	w0, [x22]
               	sub	x26, x29, #0xe0
               	ldrsh	x0, [x26]
               	sub	x26, x29, #0xe0
               	add	x22, x26, #0x2
               	ldrsh	x26, [x22]
               	add	x22, x0, x26
               	sxtw	x22, w22
               	cmp	x22, #0x0
               	b.eq	0x400bc4 <.text+0x944>
               	mov	x22, #0x14              // =20
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x26, x29, #0xe0
               	add	x22, x26, #0x4
               	ldrh	w26, [x22]
               	mov	x17, #0xc0de            // =49374
               	eor	x22, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x22, x17
               	cmp	x26, #0x0
               	b.eq	0x400c1c <.text+0x99c>
               	mov	x26, #0x15              // =21
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x2a              // =42
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
