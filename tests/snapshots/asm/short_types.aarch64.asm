
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0xf8
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x110
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x116
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x11d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf8
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0xf8
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
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
               	sub	sp, sp, #0xf0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x15, #0x4d2             // =1234
               	mov	x14, #0xffd6            // =65494
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	cmp	x15, #0x4d2
               	b.eq	<addr>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	<addr>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x13, x15, x14
               	sxtw	x13, w13
               	sxth	x13, w13
               	cmp	x13, #0x4a8
               	b.eq	<addr>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x15, x14
               	sxtw	x13, w13
               	sxth	x13, w13
               	cmp	x13, #0x4fc
               	b.eq	<addr>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x7               // =7
               	sdiv	x13, x15, x14
               	sxth	x13, w13
               	cmp	x13, #0xb0
               	b.eq	<addr>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x7               // =7
               	sdiv	x17, x15, x13
               	msub	x15, x17, x13, x15
               	sxth	x15, w15
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	lsl	x13, x20, #14
               	sxth	x13, w13
               	mov	x17, #0x4000            // =16384
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x0, x20, #16
               	bl	<addr>
               	mov	x14, x0
               	sxth	x14, w14
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x0, x20, #15
               	bl	<addr>
               	mov	x20, x0
               	sxth	x20, w20
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0xfff8            // =65528
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	asr	x20, x20, #1
               	sxth	x20, w20
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0xfffe            // =65534
               	mov	x0, #0x1                // =1
               	add	x14, x20, x0
               	sxtw	x14, w14
               	sxtw	x14, w14
               	mov	x17, #0xffff            // =65535
               	and	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	and	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x12, #0xc               // =12
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x20, x0
               	sxtw	x20, w20
               	add	x20, x20, #0x1
               	sxtw	x20, w20
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	b.eq	<addr>
               	mov	x14, #0xd               // =13
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x14, #0x1               // =1
               	add	x12, x14, x20
               	sxtw	x12, w12
               	sxtw	x12, w12
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x11, #0xe               // =14
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	sxtw	x12, w20
               	mov	x17, #0xffff            // =65535
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x11, #0xf               // =15
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x20, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, x14
               	b.hi	<addr>
               	mov	x14, #0x10              // =16
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x0, x0, #15
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x8000            // =32768
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x20, #0x11              // =17
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8000             // =32768
               	sxtw	x0, w0
               	asr	x0, x0, #1
               	sxtw	x0, w0
               	mov	x17, #0x4000            // =16384
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x20, #0x12              // =18
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd8
               	mov	x20, #0x64              // =100
               	strh	w20, [x0]
               	sub	x14, x29, #0xd8
               	add	x14, x14, #0x2
               	mov	x20, #0xc8              // =200
               	strh	w20, [x14]
               	sub	x0, x29, #0xd8
               	add	x0, x0, #0x4
               	mov	x20, #0xfed4            // =65236
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	strh	w20, [x0]
               	sub	x14, x29, #0xd8
               	add	x21, x14, #0x6
               	sub	x14, x29, #0xd8
               	ldrsh	x14, [x14]
               	sub	x0, x29, #0xd8
               	add	x0, x0, #0x2
               	ldrsh	x0, [x0]
               	add	x14, x14, x0
               	sxtw	x14, w14
               	sub	x0, x29, #0xd8
               	add	x0, x0, #0x4
               	ldrsh	x0, [x0]
               	add	x14, x14, x0
               	sxtw	x0, w14
               	bl	<addr>
               	mov	x14, x0
               	strh	w14, [x21]
               	sub	x0, x29, #0xd8
               	add	x0, x0, #0x6
               	ldrsh	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x13              // =19
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	mov	x14, #0x7               // =7
               	strh	w14, [x0]
               	sub	x21, x29, #0xe0
               	add	x21, x21, #0x2
               	mov	x14, #0xfff9            // =65529
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	strh	w14, [x21]
               	sub	x0, x29, #0xe0
               	add	x0, x0, #0x4
               	mov	x14, #0xc0de            // =49374
               	strh	w14, [x0]
               	sub	x21, x29, #0xe0
               	ldrsh	x21, [x21]
               	sub	x14, x29, #0xe0
               	add	x14, x14, #0x2
               	ldrsh	x14, [x14]
               	add	x21, x21, x14
               	sxtw	x21, w21
               	cmp	x21, #0x0
               	b.eq	<addr>
               	mov	x14, #0x14              // =20
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0xe0
               	add	x21, x21, #0x4
               	ldrh	w21, [x21]
               	mov	x17, #0xc0de            // =49374
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.eq	<addr>
               	mov	x14, #0x15              // =21
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x2a              // =42
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
