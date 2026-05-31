
bitfield_signed_read.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x13, #0xffff            // =65535
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	mov	x17, #0x3               // =3
               	and	x13, x13, x17
               	orr	x14, x14, x13
               	strh	w14, [x15]
               	sub	x13, x29, #0x8
               	ldrh	w14, [x13]
               	mov	x17, #0xfff3            // =65523
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x15, #0x1               // =1
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	lsl	x15, x15, #2
               	orr	x14, x14, x15
               	strh	w14, [x13]
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	mov	x17, #0xf               // =15
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x13, #0xf800            // =63488
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	mov	x17, #0xfff             // =4095
               	and	x13, x13, x17
               	lsl	x13, x13, #4
               	orr	x14, x14, x13
               	strh	w14, [x15]
               	sub	x13, x29, #0x8
               	ldrh	w14, [x13]
               	mov	x17, #0x3               // =3
               	and	x14, x14, x17
               	lsl	x14, x14, #62
               	asr	x14, x14, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x400334 <.text+0x114>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrh	w0, [x14]
               	asr	x0, x0, #2
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	lsl	x0, x0, #62
               	asr	x0, x0, #62
               	cmp	x0, #0x1
               	b.eq	0x40036c <.text+0x14c>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrh	w14, [x0]
               	asr	x14, x14, #4
               	mov	x17, #0xfff             // =4095
               	and	x14, x14, x17
               	lsl	x14, x14, #52
               	asr	x14, x14, #52
               	mov	x17, #0xf800            // =63488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrh	w0, [x14]
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	lsl	x0, x0, #62
               	asr	x0, x0, #62
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	0x4003ec <.text+0x1cc>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w14, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x15, #0xfffc            // =65532
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	mov	x17, #0x7               // =7
               	and	x15, x15, x17
               	orr	x14, x14, x15
               	str	w14, [x0]
               	sub	x15, x29, #0x10
               	ldr	w14, [x15]
               	mov	x17, #0xf807            // =63495
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x0, #0xff80             // =65408
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	lsl	x0, x0, #3
               	orr	x14, x14, x0
               	str	w14, [x15]
               	sub	x0, x29, #0x10
               	ldr	w14, [x0]
               	mov	x17, #0x7ff             // =2047
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x15, x15, x17
               	lsl	x15, x15, #11
               	orr	x14, x14, x15
               	str	w14, [x0]
               	sub	x15, x29, #0x10
               	ldr	w14, [x15]
               	mov	x17, #0x7               // =7
               	and	x14, x14, x17
               	lsl	x14, x14, #61
               	asr	x14, x14, #61
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x4004e8 <.text+0x2c8>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	asr	x0, x0, #3
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtb	x0, w0
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x40052c <.text+0x30c>
               	mov	x14, #0x16              // =22
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w14, [x0]
               	asr	x14, x14, #11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x14, x14, x17
               	lsl	x14, x14, #43
               	asr	x14, x14, #43
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x400574 <.text+0x354>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	lsl	x0, x0, #61
               	asr	x0, x0, #61
               	cmp	x0, #0x0
               	b.le	0x4005a8 <.text+0x388>
               	mov	x14, #0x18              // =24
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w14, [x0]
               	asr	x14, x14, #11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x14, x14, x17
               	lsl	x14, x14, #43
               	asr	x14, x14, #43
               	cmp	x14, #0x0
               	b.lt	0x4005e0 <.text+0x3c0>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	ldr	w0, [x14]
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0x7               // =7
               	mov	x17, #0xfff             // =4095
               	and	x15, x15, x17
               	orr	x0, x0, x15
               	str	w0, [x14]
               	sub	x15, x29, #0x18
               	add	x15, x15, #0x4
               	ldrh	w0, [x15]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	mov	x17, #0x3               // =3
               	and	x14, x14, x17
               	orr	x0, x0, x14
               	strh	w0, [x15]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x4
               	ldrh	w0, [x14]
               	mov	x17, #0xfff3            // =65523
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0x1               // =1
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	lsl	x15, x15, #2
               	orr	x0, x0, x15
               	strh	w0, [x14]
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	mov	x17, #0xfff             // =4095
               	and	x0, x0, x17
               	cmp	x0, #0x7
               	b.eq	0x4006b4 <.text+0x494>
               	mov	x15, #0x1f              // =31
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x4
               	ldrh	w15, [x0]
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	lsl	x15, x15, #62
               	asr	x15, x15, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	0x4006f8 <.text+0x4d8>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	add	x15, x15, #0x4
               	ldrh	w0, [x15]
               	asr	x0, x0, #2
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	lsl	x0, x0, #62
               	asr	x0, x0, #62
               	cmp	x0, #0x1
               	b.eq	0x400734 <.text+0x514>
               	mov	x15, #0x21              // =33
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	sub	x15, x29, #0x18
               	add	x15, x15, #0x4
               	ldrh	w14, [x15]
               	mov	x17, #0x3               // =3
               	and	x14, x14, x17
               	lsl	x14, x14, #62
               	asr	x14, x14, #62
               	sxtw	x0, w0
               	add	x14, x14, x0
               	sxtw	x14, w14
               	cmp	x14, #0x5
               	b.eq	0x400778 <.text+0x558>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
