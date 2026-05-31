
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
               	and	x13, x14, x17
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	mov	x17, #0x3               // =3
               	and	x12, x14, x17
               	orr	x14, x13, x12
               	strh	w14, [x15]
               	sub	x12, x29, #0x8
               	ldrh	w14, [x12]
               	mov	x17, #0xfff3            // =65523
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x14, x17
               	mov	x14, #0x1               // =1
               	mov	x17, #0x3               // =3
               	and	x13, x14, x17
               	lsl	x14, x13, #2
               	orr	x13, x15, x14
               	strh	w13, [x12]
               	sub	x14, x29, #0x8
               	ldrh	w13, [x14]
               	mov	x17, #0xf               // =15
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x12, x13, x17
               	mov	x13, #0xf800            // =63488
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	mov	x17, #0xfff             // =4095
               	and	x15, x13, x17
               	lsl	x13, x15, #4
               	orr	x15, x12, x13
               	strh	w15, [x14]
               	sub	x13, x29, #0x8
               	ldrh	w15, [x13]
               	mov	x17, #0x3               // =3
               	and	x13, x15, x17
               	lsl	x15, x13, #62
               	asr	x13, x15, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x13, x17
               	b.eq	0x400334 <.text+0x114>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrh	w0, [x15]
               	asr	x15, x0, #2
               	mov	x17, #0x3               // =3
               	and	x0, x15, x17
               	lsl	x15, x0, #62
               	asr	x0, x15, #62
               	cmp	x0, #0x1
               	b.eq	0x400368 <.text+0x148>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrh	w0, [x15]
               	asr	x15, x0, #4
               	mov	x17, #0xfff             // =4095
               	and	x0, x15, x17
               	lsl	x15, x0, #52
               	asr	x0, x15, #52
               	mov	x17, #0xf800            // =63488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x4003ac <.text+0x18c>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrh	w0, [x15]
               	mov	x17, #0x3               // =3
               	and	x15, x0, x17
               	lsl	x0, x15, #62
               	asr	x15, x0, #62
               	add	x0, x15, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	0x4003e4 <.text+0x1c4>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w0, [x15]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x0, x17
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x17, #0x7               // =7
               	and	x12, x0, x17
               	orr	x0, x14, x12
               	str	w0, [x15]
               	sub	x12, x29, #0x10
               	ldr	w0, [x12]
               	mov	x17, #0xf807            // =63495
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x0, x17
               	mov	x0, #0xff80             // =65408
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x17, #0xff              // =255
               	and	x14, x0, x17
               	lsl	x0, x14, #3
               	orr	x14, x15, x0
               	str	w14, [x12]
               	sub	x0, x29, #0x10
               	ldr	w14, [x0]
               	mov	x17, #0x7ff             // =2047
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x12, x14, x17
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x15, x14, x17
               	lsl	x14, x15, #11
               	orr	x15, x12, x14
               	str	w15, [x0]
               	sub	x14, x29, #0x10
               	ldr	w15, [x14]
               	mov	x17, #0x7               // =7
               	and	x14, x15, x17
               	lsl	x15, x14, #61
               	asr	x14, x15, #61
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x4004e0 <.text+0x2c0>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w0, [x15]
               	asr	x15, x0, #3
               	mov	x17, #0xff              // =255
               	and	x0, x15, x17
               	sxtb	x0, w0
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x400520 <.text+0x300>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w0, [x15]
               	asr	x15, x0, #11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x0, x15, x17
               	lsl	x15, x0, #43
               	asr	x0, x15, #43
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x400568 <.text+0x348>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w0, [x15]
               	mov	x17, #0x7               // =7
               	and	x15, x0, x17
               	lsl	x0, x15, #61
               	asr	x15, x0, #61
               	cmp	x15, #0x0
               	b.le	0x40059c <.text+0x37c>
               	mov	x15, #0x18              // =24
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w15, [x0]
               	asr	x0, x15, #11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x15, x0, x17
               	lsl	x0, x15, #43
               	asr	x15, x0, #43
               	cmp	x15, #0x0
               	b.lt	0x4005d8 <.text+0x3b8>
               	mov	x15, #0x19              // =25
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w15, [x0]
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x15, x17
               	mov	x15, #0x7               // =7
               	mov	x17, #0xfff             // =4095
               	and	x12, x15, x17
               	orr	x15, x14, x12
               	str	w15, [x0]
               	sub	x12, x29, #0x18
               	add	x15, x12, #0x4
               	ldrh	w12, [x15]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x12, x17
               	mov	x12, #0xffff            // =65535
               	movk	x12, #0xffff, lsl #16
               	movk	x12, #0xffff, lsl #32
               	movk	x12, #0xffff, lsl #48
               	mov	x17, #0x3               // =3
               	and	x14, x12, x17
               	orr	x12, x0, x14
               	strh	w12, [x15]
               	sub	x14, x29, #0x18
               	add	x12, x14, #0x4
               	ldrh	w14, [x12]
               	mov	x17, #0xfff3            // =65523
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x14, x17
               	mov	x14, #0x1               // =1
               	mov	x17, #0x3               // =3
               	and	x0, x14, x17
               	lsl	x14, x0, #2
               	orr	x0, x15, x14
               	strh	w0, [x12]
               	sub	x14, x29, #0x18
               	ldr	w0, [x14]
               	mov	x17, #0xfff             // =4095
               	and	x14, x0, x17
               	cmp	x14, #0x7
               	b.eq	0x4006ac <.text+0x48c>
               	mov	x14, #0x1f              // =31
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x14, x0, #0x4
               	ldrh	w0, [x14]
               	mov	x17, #0x3               // =3
               	and	x14, x0, x17
               	lsl	x0, x14, #62
               	asr	x14, x0, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x4006f4 <.text+0x4d4>
               	mov	x14, #0x20              // =32
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x14, x0, #0x4
               	ldrh	w0, [x14]
               	asr	x14, x0, #2
               	mov	x17, #0x3               // =3
               	and	x0, x14, x17
               	lsl	x14, x0, #62
               	asr	x0, x14, #62
               	cmp	x0, #0x1
               	b.eq	0x40072c <.text+0x50c>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x6               // =6
               	sub	x0, x29, #0x18
               	add	x12, x0, #0x4
               	ldrh	w0, [x12]
               	mov	x17, #0x3               // =3
               	and	x12, x0, x17
               	lsl	x0, x12, #62
               	asr	x12, x0, #62
               	sxtw	x0, w14
               	add	x14, x12, x0
               	sxtw	x14, w14
               	cmp	x14, #0x5
               	b.eq	0x400774 <.text+0x554>
               	mov	x14, #0x22              // =34
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec8a9
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ddc <exit+0x6514>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8e6c
               	tbz	w21, #0x6, 0x3fee30
               	<unknown>
               	cbnz	w16, 0x46edd8
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4003e4 <.text+0x1c4>
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
               	bl	0x4008c8 <exit>
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
               	adr	x10, 0x4ec971
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ea4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8f34
               	tbz	w21, #0x6, 0x3feef8
               	<unknown>
               	cbnz	w16, 0x46eea0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4004ac <.text+0x28c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	br	x16
