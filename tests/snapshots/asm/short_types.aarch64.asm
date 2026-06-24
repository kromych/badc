
short_types.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x1, w0
               	mov	x17, #0x8000            // =32768
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x17, #0x10000           // =65536
               	sub	x0, x0, x17
               	sxtw	x0, w0
               	ret
               	sxtw	x0, w0
               	ret

<as_ushort>:
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xf0
               	str	x20, [sp]
               	mov	x0, #0x4d2              // =1234
               	mov	x1, #0xffd6             // =65494
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	cmp	x0, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x0, x1
               	sxtw	x2, w2
               	sxth	x2, w2
               	cmp	x2, #0x4a8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x0, x1
               	sxtw	x2, w2
               	sxth	x2, w2
               	cmp	x2, #0x4fc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	sxth	x1, w1
               	mov	x17, #0xff82            // =65410
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	sdiv	x1, x0, x1
               	sxth	x1, w1
               	cmp	x1, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	sxth	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	lsl	x0, x20, #14
               	sxtw	x0, w0
               	sxth	x0, w0
               	mov	x17, #0x4000            // =16384
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x0, x20, #16
               	sxtw	x0, w0
               	bl	<addr>
               	sxth	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x0, x20, #15
               	sxtw	x0, w0
               	bl	<addr>
               	sxth	x0, w0
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff8             // =65528
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	asr	x0, x0, #1
               	sxth	x0, w0
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffe             // =65534
               	mov	x1, #0x1                // =1
               	add	x2, x0, x1
               	sxtw	x2, w2
               	sxtw	x2, w2
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, x1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x2, #0x1                // =1
               	add	x3, x2, x0
               	sxtw	x3, w3
               	cmp	x3, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x3, w0
               	mov	x17, #0xffff            // =65535
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w0
               	mov	w0, w0
               	cmp	x0, x2
               	b.hi	<addr>
               	mov	x0, #0x10               // =16
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x0, x1, #15
               	sxtw	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x8000            // =32768
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldr	x20, [sp]
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
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd8
               	mov	x1, #0x64               // =100
               	strh	w1, [x0]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xc8               // =200
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xfed4             // =65236
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	strh	w1, [x0, #0x4]
               	sub	x20, x29, #0xd8
               	sub	x0, x29, #0xd8
               	ldrsh	x0, [x0]
               	sub	x1, x29, #0xd8
               	ldrsh	x1, [x1, #0x2]
               	add	x0, x0, x1
               	sub	x1, x29, #0xd8
               	ldrsh	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	bl	<addr>
               	strh	w0, [x20, #0x6]
               	sub	x0, x29, #0xd8
               	ldrsh	x0, [x0, #0x6]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	mov	x1, #0x7                // =7
               	strh	w1, [x0]
               	sub	x0, x29, #0xe0
               	mov	x1, #0xfff9             // =65529
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0xe0
               	mov	x1, #0xc0de             // =49374
               	strh	w1, [x0, #0x4]
               	sub	x0, x29, #0xe0
               	ldrsh	x0, [x0]
               	sub	x1, x29, #0xe0
               	ldrsh	x1, [x1, #0x2]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	ldrh	w0, [x0, #0x4]
               	mov	x17, #0xc0de            // =49374
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
