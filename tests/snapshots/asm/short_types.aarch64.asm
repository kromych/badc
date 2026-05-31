
short_types.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
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
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w0
               	mov	x17, #0xffff            // =65535
               	and	x15, x15, x17
               	sxtw	x14, w15
               	mov	x17, #0x8000            // =32768
               	and	x14, x14, x17
               	cbz	x14, <addr>
               	sxtw	x13, w15
               	mov	x17, #0x10000           // =65536
               	sub	x13, x13, x17
               	sxtw	x0, w13
               	ret
               	sxtw	x13, w15
               	mov	x0, x13
               	ret
               	sxtw	x15, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x15, x17
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x15, #0x4d2             // =1234
               	mov	x14, #0xffd6            // =65494
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	sxth	x13, w15
               	cmp	x13, #0x4d2
               	b.eq	<addr>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x13, w14
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x13, w15
               	sxth	x12, w14
               	add	x13, x13, x12
               	sxtw	x13, w13
               	sxth	x13, w13
               	cmp	x13, #0x4a8
               	b.eq	<addr>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x13, w15
               	sxth	x12, w14
               	sub	x13, x13, x12
               	sxtw	x13, w13
               	sxth	x13, w13
               	cmp	x13, #0x4fc
               	b.eq	<addr>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x14, w14
               	mov	x17, #0x3               // =3
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	sxth	x14, w14
               	mov	x17, #0xff82            // =65410
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	<addr>
               	mov	x12, #0x5               // =5
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x14, w15
               	mov	x12, #0x7               // =7
               	sdiv	x14, x14, x12
               	sxth	x14, w14
               	cmp	x14, #0xb0
               	b.eq	<addr>
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x15, w15
               	mov	x12, #0x7               // =7
               	sdiv	x17, x15, x12
               	msub	x15, x17, x12, x15
               	sxth	x15, w15
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x12, #0x7               // =7
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	sxth	x12, w20
               	lsl	x12, x12, #14
               	sxth	x12, w12
               	mov	x17, #0x4000            // =16384
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x12, w20
               	lsl	x21, x12, #16
               	mov	x0, x21
               	bl	<addr>
               	sxth	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x21, #0x9               // =9
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x20, w20
               	lsl	x20, x20, #15
               	mov	x0, x20
               	bl	<addr>
               	sxth	x0, w0
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x20, #0xa               // =10
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff8             // =65528
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxth	x0, w0
               	asr	x0, x0, #1
               	sxth	x0, w0
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x20, #0xb               // =11
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffe             // =65534
               	mov	x20, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	and	x21, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x13, x20, x17
               	add	x21, x21, x13
               	sxtw	x21, w21
               	sxtw	x21, w21
               	mov	x17, #0xffff            // =65535
               	and	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	and	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.eq	<addr>
               	mov	x13, #0xc               // =12
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x13, x20, x17
               	add	x0, x0, x13
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x13, #0xd               // =13
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x13, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	and	x21, x13, x17
               	sxth	x11, w0
               	add	x21, x21, x11
               	sxtw	x21, w21
               	sxtw	x21, w21
               	cmp	x21, #0x0
               	b.eq	<addr>
               	mov	x11, #0xe               // =14
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxth	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x11, w0
               	mov	x17, #0xffff            // =65535
               	cmp	x11, x17
               	b.eq	<addr>
               	mov	x21, #0xf               // =15
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x0, x13
               	b.hi	<addr>
               	mov	x13, #0x10              // =16
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	lsl	x20, x20, #15
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	mov	x17, #0x8000            // =32768
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	b.eq	<addr>
               	mov	x13, #0x11              // =17
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x8000            // =32768
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	sxtw	x20, w20
               	asr	x20, x20, #1
               	sxtw	x20, w20
               	mov	x17, #0x4000            // =16384
               	cmp	x20, x17
               	b.eq	<addr>
               	mov	x13, #0x12              // =18
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0xd8
               	mov	x13, #0x64              // =100
               	strh	w13, [x20]
               	sub	x0, x29, #0xd8
               	add	x0, x0, #0x2
               	mov	x13, #0xc8              // =200
               	strh	w13, [x0]
               	sub	x20, x29, #0xd8
               	add	x20, x20, #0x4
               	mov	x13, #0xfed4            // =65236
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	strh	w13, [x20]
               	sub	x0, x29, #0xd8
               	add	x22, x0, #0x6
               	sub	x0, x29, #0xd8
               	ldrsh	x0, [x0]
               	sub	x20, x29, #0xd8
               	add	x20, x20, #0x2
               	ldrsh	x20, [x20]
               	add	x0, x0, x20
               	sxtw	x0, w0
               	sub	x20, x29, #0xd8
               	add	x20, x20, #0x4
               	ldrsh	x20, [x20]
               	add	x0, x0, x20
               	sxtw	x23, w0
               	mov	x0, x23
               	bl	<addr>
               	strh	w0, [x22]
               	sub	x23, x29, #0xd8
               	add	x23, x23, #0x6
               	ldrsh	x23, [x23]
               	cmp	x23, #0x0
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0xe0
               	mov	x0, #0x7                // =7
               	strh	w0, [x23]
               	sub	x22, x29, #0xe0
               	add	x22, x22, #0x2
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	strh	w0, [x22]
               	sub	x23, x29, #0xe0
               	add	x23, x23, #0x4
               	mov	x0, #0xc0de             // =49374
               	strh	w0, [x23]
               	sub	x22, x29, #0xe0
               	ldrsh	x22, [x22]
               	sub	x0, x29, #0xe0
               	add	x0, x0, #0x2
               	ldrsh	x0, [x0]
               	add	x22, x22, x0
               	sxtw	x22, w22
               	cmp	x22, #0x0
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0xe0
               	add	x22, x22, #0x4
               	ldrh	w22, [x22]
               	mov	x17, #0xc0de            // =49374
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x2a              // =42
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
