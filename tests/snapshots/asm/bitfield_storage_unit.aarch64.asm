
bitfield_storage_unit.aarch64:	file format elf64-littleaarch64

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
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40025c <.text+0x3c>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400274 <.text+0x54>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40028c <.text+0x6c>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002a4 <.text+0x84>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	add	x0, x15, #0x4
               	sub	x15, x29, #0x10
               	sub	x13, x0, x15
               	cmp	x13, #0x4
               	b.eq	0x4002cc <.text+0xac>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	add	x0, x15, #0x8
               	sub	x15, x29, #0x10
               	sub	x13, x0, x15
               	cmp	x13, #0x8
               	b.eq	0x4002f4 <.text+0xd4>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x0, x17
               	mov	x0, #0xab               // =171
               	mov	x17, #0xff              // =255
               	and	x12, x0, x17
               	orr	x0, x13, x12
               	str	w0, [x15]
               	sub	x12, x29, #0x18
               	ldr	w0, [x12]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x0, x17
               	mov	x0, #0x1                // =1
               	mov	x17, #0x1               // =1
               	and	x13, x0, x17
               	lsl	x0, x13, #8
               	orr	x13, x15, x0
               	str	w13, [x12]
               	sub	x0, x29, #0x18
               	ldr	w13, [x0]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x12, x13, x17
               	mov	x13, #0x2345            // =9029
               	movk	x13, #0x1, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x15, x13, x17
               	lsl	x13, x15, #9
               	orr	x15, x12, x13
               	str	w15, [x0]
               	sub	x13, x29, #0x18
               	ldr	w15, [x13]
               	mov	x17, #0xff              // =255
               	and	x13, x15, x17
               	cmp	x13, #0xab
               	b.eq	0x4003b8 <.text+0x198>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	asr	x15, x0, #8
               	mov	x17, #0x1               // =1
               	and	x0, x15, x17
               	cmp	x0, #0x1
               	b.eq	0x4003e4 <.text+0x1c4>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	asr	x15, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x0, x15, x17
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	0x40041c <.text+0x1fc>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x0, x17
               	mov	x0, #0x55               // =85
               	mov	x17, #0xff              // =255
               	and	x12, x0, x17
               	orr	x0, x13, x12
               	str	w0, [x15]
               	sub	x12, x29, #0x18
               	ldr	w0, [x12]
               	mov	x17, #0xff              // =255
               	and	x12, x0, x17
               	cmp	x12, #0x55
               	b.eq	0x400478 <.text+0x258>
               	mov	x12, #0x14              // =20
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w12, [x0]
               	asr	x0, x12, #8
               	mov	x17, #0x1               // =1
               	and	x12, x0, x17
               	cmp	x12, #0x1
               	b.eq	0x4004a8 <.text+0x288>
               	mov	x12, #0x15              // =21
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w12, [x0]
               	asr	x0, x12, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x12, x0, x17
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	x12, x17
               	b.eq	0x4004e4 <.text+0x2c4>
               	mov	x12, #0x16              // =22
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	w12, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x12, x17
               	mov	x12, #0xff              // =255
               	mov	x17, #0xff              // =255
               	and	x13, x12, x17
               	orr	x12, x15, x13
               	str	w12, [x0]
               	sub	x13, x29, #0x20
               	ldr	w12, [x13]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x12, x17
               	mov	x12, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x15, x12, x17
               	lsl	x12, x15, #8
               	orr	x15, x0, x12
               	str	w15, [x13]
               	sub	x12, x29, #0x20
               	ldr	w15, [x12]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x15, x17
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0x7f, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x0, x15, x17
               	lsl	x15, x0, #9
               	orr	x0, x13, x15
               	str	w0, [x12]
               	sub	x15, x29, #0x20
               	add	x0, x15, #0x4
               	ldr	w15, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x12, x15, x17
               	mov	x15, #0x0               // =0
               	mov	x17, #0xff              // =255
               	and	x13, x15, x17
               	orr	x11, x12, x13
               	str	w11, [x0]
               	sub	x13, x29, #0x20
               	add	x11, x13, #0x4
               	ldr	w13, [x11]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x13, x17
               	mov	x17, #0x1               // =1
               	and	x13, x15, x17
               	lsl	x12, x13, #8
               	orr	x13, x0, x12
               	str	w13, [x11]
               	sub	x12, x29, #0x20
               	add	x13, x12, #0x4
               	ldr	w12, [x13]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x11, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x12, x15, x17
               	lsl	x15, x12, #9
               	orr	x12, x11, x15
               	str	w12, [x13]
               	sub	x15, x29, #0x20
               	add	x12, x15, #0x4
               	ldr	w15, [x12]
               	mov	x17, #0xff              // =255
               	and	x12, x15, x17
               	cmp	x12, #0x0
               	b.eq	0x400648 <.text+0x428>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	add	x0, x15, #0x4
               	ldr	w15, [x0]
               	asr	x0, x15, #8
               	mov	x17, #0x1               // =1
               	and	x15, x0, x17
               	cmp	x15, #0x0
               	b.eq	0x40067c <.text+0x45c>
               	mov	x15, #0x18              // =24
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x15, x0, #0x4
               	ldr	w0, [x15]
               	asr	x15, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x0, x15, x17
               	cmp	x0, #0x0
               	b.eq	0x4006b0 <.text+0x490>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec7e9
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406d1c <exit+0x6514>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8dac
               	tbz	w21, #0x6, 0x3fed70
               	<unknown>
               	cbnz	w16, 0x46ed18
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400324 <.text+0x104>
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
               	bl	0x400808 <exit>
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
               	adr	x10, 0x4ec8b1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406de4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8e74
               	tbz	w21, #0x6, 0x3fee38
               	<unknown>
               	cbnz	w16, 0x46ede0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4003ec <.text+0x1cc>
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
