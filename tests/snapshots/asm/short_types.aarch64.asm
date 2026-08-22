
short_types.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x4d2              // =1234
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0xffd6             // =65494
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxth	x1, w20
               	cmp	x1, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sxth	x2, w0
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0x3               // =3
               	mul	x0, x2, x17
               	sxtw	x0, w0
               	sxth	x0, w0
               	mov	x17, #0xff82            // =65410
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x7                // =7
               	sdiv	x0, x1, x0
               	sxth	x0, w0
               	cmp	x0, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x7                // =7
               	sdiv	x17, x1, x0
               	msub	x0, x17, x0, x1
               	sxth	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x2, x0
               	sxth	x3, w2
               	lsl	x0, x3, #14
               	sxtw	x0, w0
               	sxth	x0, w0
               	mov	x17, #0x4000            // =16384
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	lsl	x0, x3, #16
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	sxtw	x0, w1
               	mov	x17, #0x8000            // =32768
               	and	x4, x0, x17
               	cbz	x4, <addr>
               	mov	x17, #0x10000           // =65536
               	sub	x0, x1, x17
               	sxtw	x0, w0
               	sxth	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	lsl	x0, x3, #15
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	sxtw	x0, w1
               	mov	x17, #0x8000            // =32768
               	and	x2, x0, x17
               	cbz	x2, <addr>
               	mov	x17, #0x10000           // =65536
               	sub	x0, x1, x17
               	sxtw	x0, w0
               	sxth	x0, w0
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xfff8             // =65528
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxth	x0, w0
               	asr	x0, x0, #1
               	sxth	x0, w0
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xfffe             // =65534
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x20, x0
               	mov	x17, #0xffff            // =65535
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	and	x1, x20, x17
               	add	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	and	x1, x20, x17
               	add	x0, x0, x1
               	add	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, x0
               	mov	x17, #0xffff            // =65535
               	and	x2, x1, x17
               	sxth	x0, w21
               	add	x2, x2, x0
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	w0, w0
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	cmp	x0, x1
               	b.hi	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x0, x20, x17
               	lsl	x0, x0, #15
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x8000            // =32768
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x8000             // =32768
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x0, w0
               	asr	x0, x0, #1
               	sxtw	x0, w0
               	mov	x17, #0x4000            // =16384
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0xfed4             // =65236
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxth	x2, w0
               	sxth	x1, w20
               	sxth	x3, w21
               	add	x1, x1, x3
               	add	x0, x1, x2
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	sxtw	x0, w1
               	mov	x17, #0x8000            // =32768
               	and	x2, x0, x17
               	cbz	x2, <addr>
               	mov	x17, #0x10000           // =65536
               	sub	x0, x1, x17
               	sxtw	x0, w0
               	sxth	x1, w0
               	cbz	x1, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0xc0de             // =49374
               	bl	<addr>
               	sxth	x1, w20
               	sxth	x2, w21
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xc0de            // =49374
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
