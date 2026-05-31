
bitfield_compound_assignment.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x14, x17
               	mov	x14, #0x0               // =0
               	mov	x17, #0x1               // =1
               	and	x12, x14, x17
               	orr	x11, x13, x12
               	strh	w11, [x15]
               	sub	x12, x29, #0x8
               	ldrh	w11, [x12]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x11, x17
               	mov	x17, #0x7               // =7
               	and	x11, x14, x17
               	lsl	x13, x11, #1
               	orr	x11, x15, x13
               	strh	w11, [x12]
               	sub	x13, x29, #0x8
               	ldrh	w11, [x13]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x12, x11, x17
               	mov	x17, #0xf               // =15
               	and	x11, x14, x17
               	lsl	x15, x11, #4
               	orr	x11, x12, x15
               	strh	w11, [x13]
               	sub	x15, x29, #0x8
               	ldrh	w11, [x15]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x11, x17
               	mov	x17, #0xff              // =255
               	and	x11, x14, x17
               	lsl	x14, x11, #8
               	orr	x11, x13, x14
               	strh	w11, [x15]
               	sub	x14, x29, #0x8
               	ldrh	w11, [x14]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x11, x17
               	sub	x11, x29, #0x8
               	ldrh	w13, [x11]
               	asr	x11, x13, #1
               	mov	x17, #0x7               // =7
               	and	x13, x11, x17
               	mov	x17, #0x5               // =5
               	orr	x11, x13, x17
               	mov	x17, #0x7               // =7
               	and	x13, x11, x17
               	lsl	x11, x13, #1
               	orr	x13, x15, x11
               	strh	w13, [x14]
               	sub	x11, x29, #0x8
               	ldrh	w13, [x11]
               	asr	x11, x13, #1
               	mov	x17, #0x7               // =7
               	and	x13, x11, x17
               	cmp	x13, #0x5
               	b.eq	0x40037c <.text+0x15c>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x8
               	ldrh	w0, [x11]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x0, x17
               	sub	x0, x29, #0x8
               	ldrh	w15, [x0]
               	asr	x0, x15, #1
               	mov	x17, #0x7               // =7
               	and	x15, x0, x17
               	mov	x17, #0x2               // =2
               	orr	x0, x15, x17
               	mov	x17, #0x7               // =7
               	and	x15, x0, x17
               	lsl	x0, x15, #1
               	orr	x15, x14, x0
               	strh	w15, [x11]
               	sub	x0, x29, #0x8
               	ldrh	w15, [x0]
               	asr	x0, x15, #1
               	mov	x17, #0x7               // =7
               	and	x15, x0, x17
               	cmp	x15, #0x7
               	b.eq	0x4003f8 <.text+0x1d8>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrh	w15, [x0]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x11, x15, x17
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	asr	x15, x14, #1
               	mov	x17, #0x6               // =6
               	and	x14, x15, x17
               	lsl	x15, x14, #1
               	orr	x14, x11, x15
               	strh	w14, [x0]
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	asr	x15, x14, #1
               	mov	x17, #0x7               // =7
               	and	x14, x15, x17
               	cmp	x14, #0x6
               	b.eq	0x400460 <.text+0x240>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrh	w0, [x15]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x0, x17
               	sub	x0, x29, #0x8
               	ldrh	w11, [x0]
               	asr	x0, x11, #1
               	mov	x17, #0x7               // =7
               	and	x11, x0, x17
               	mov	x17, #0x7               // =7
               	eor	x0, x11, x17
               	mov	x17, #0x7               // =7
               	and	x11, x0, x17
               	lsl	x0, x11, #1
               	orr	x11, x14, x0
               	strh	w11, [x15]
               	sub	x0, x29, #0x8
               	ldrh	w11, [x0]
               	asr	x0, x11, #1
               	mov	x17, #0x7               // =7
               	and	x11, x0, x17
               	cmp	x11, #0x1
               	b.eq	0x4004dc <.text+0x2bc>
               	mov	x11, #0xe               // =14
               	mov	x0, x11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrh	w11, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x11, x17
               	mov	x11, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x14, x11, x17
               	orr	x11, x15, x14
               	strh	w11, [x0]
               	sub	x14, x29, #0x8
               	ldrh	w11, [x14]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x11, x17
               	mov	x11, #0xc               // =12
               	mov	x17, #0xf               // =15
               	and	x15, x11, x17
               	lsl	x11, x15, #4
               	orr	x15, x0, x11
               	strh	w15, [x14]
               	sub	x11, x29, #0x8
               	ldrh	w15, [x11]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x15, x17
               	mov	x15, #0xc8              // =200
               	mov	x17, #0xff              // =255
               	and	x0, x15, x17
               	lsl	x15, x0, #8
               	orr	x0, x14, x15
               	strh	w0, [x11]
               	sub	x15, x29, #0x8
               	ldrh	w0, [x15]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x11, x0, x17
               	sub	x0, x29, #0x8
               	ldrh	w14, [x0]
               	asr	x0, x14, #1
               	mov	x17, #0x7               // =7
               	and	x14, x0, x17
               	mov	x17, #0x7               // =7
               	eor	x0, x14, x17
               	mov	x17, #0x7               // =7
               	and	x14, x0, x17
               	lsl	x0, x14, #1
               	orr	x14, x11, x0
               	strh	w14, [x15]
               	sub	x0, x29, #0x8
               	ldrh	w14, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x14, x17
               	cmp	x0, #0x1
               	b.eq	0x4005e8 <.text+0x3c8>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrh	w0, [x14]
               	asr	x14, x0, #1
               	mov	x17, #0x7               // =7
               	and	x0, x14, x17
               	cmp	x0, #0x6
               	b.eq	0x400614 <.text+0x3f4>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrh	w0, [x14]
               	asr	x14, x0, #4
               	mov	x17, #0xf               // =15
               	and	x0, x14, x17
               	cmp	x0, #0xc
               	b.eq	0x400640 <.text+0x420>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrh	w0, [x14]
               	asr	x14, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x14, x17
               	cmp	x0, #0xc8
               	b.eq	0x40066c <.text+0x44c>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldrh	w0, [x14]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x0, x17
               	sub	x0, x29, #0x8
               	ldrh	w11, [x0]
               	asr	x0, x11, #4
               	mov	x17, #0xf               // =15
               	and	x11, x0, x17
               	add	x0, x11, #0x1
               	mov	x17, #0xf               // =15
               	and	x11, x0, x17
               	lsl	x0, x11, #4
               	orr	x11, x15, x0
               	strh	w11, [x14]
               	sub	x0, x29, #0x8
               	ldrh	w11, [x0]
               	asr	x0, x11, #4
               	mov	x17, #0xf               // =15
               	and	x11, x0, x17
               	cmp	x11, #0xd
               	b.eq	0x4006e4 <.text+0x4c4>
               	mov	x11, #0x13              // =19
               	mov	x0, x11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrh	w11, [x0]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x11, x17
               	sub	x11, x29, #0x8
               	ldrh	w15, [x11]
               	asr	x11, x15, #4
               	mov	x17, #0xf               // =15
               	and	x15, x11, x17
               	sub	x11, x15, #0x4
               	mov	x17, #0xf               // =15
               	and	x15, x11, x17
               	lsl	x11, x15, #4
               	orr	x15, x14, x11
               	strh	w15, [x0]
               	sub	x11, x29, #0x8
               	ldrh	w15, [x11]
               	asr	x11, x15, #4
               	mov	x17, #0xf               // =15
               	and	x15, x11, x17
               	cmp	x15, #0x9
               	b.eq	0x400758 <.text+0x538>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x8
               	ldrh	w0, [x11]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x0, x17
               	sub	x0, x29, #0x8
               	ldrh	w14, [x0]
               	asr	x0, x14, #8
               	mov	x17, #0xff              // =255
               	and	x14, x0, x17
               	lsl	x0, x14, #1
               	mov	x17, #0xff              // =255
               	and	x14, x0, x17
               	lsl	x0, x14, #8
               	orr	x14, x15, x0
               	strh	w14, [x11]
               	sub	x0, x29, #0x8
               	ldrh	w14, [x0]
               	asr	x0, x14, #8
               	mov	x17, #0xff              // =255
               	and	x14, x0, x17
               	mov	x0, #0x190              // =400
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x0, x17
               	mov	x0, #0x100              // =256
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	udiv	x17, x11, x15
               	msub	x0, x17, x15, x11
               	eor	x15, x14, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x15, x17
               	cmp	x0, #0x0
               	b.eq	0x400804 <.text+0x5e4>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrh	w0, [x15]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x0, x17
               	sub	x0, x29, #0x8
               	ldrh	w11, [x0]
               	asr	x0, x11, #4
               	mov	x17, #0xf               // =15
               	and	x11, x0, x17
               	asr	x0, x11, #2
               	mov	x17, #0xf               // =15
               	and	x11, x0, x17
               	lsl	x0, x11, #4
               	orr	x11, x14, x0
               	strh	w11, [x15]
               	sub	x0, x29, #0x8
               	ldrh	w11, [x0]
               	asr	x0, x11, #4
               	mov	x17, #0xf               // =15
               	and	x11, x0, x17
               	cmp	x11, #0x2
               	b.eq	0x40087c <.text+0x65c>
               	mov	x11, #0x16              // =22
               	mov	x0, x11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec9b1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ee4 <exit+0x651c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8f74
               	tbz	w21, #0x6, 0x3fef38
               	<unknown>
               	cbnz	w16, 0x46eee0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4004ec <.text+0x2cc>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x4009c8 <exit>
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
               	adr	x10, 0x4eca71
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406fa4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9034
               	tbz	w21, #0x6, 0x3feff8
               	<unknown>
               	cbnz	w16, 0x46efa0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4005ac <.text+0x38c>
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
