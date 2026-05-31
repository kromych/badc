
bitfields.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x15, x29, #0x10
               	ldr	w14, [x15]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x14, x17
               	mov	x14, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x12, x14, x17
               	orr	x14, x13, x12
               	str	w14, [x15]
               	sub	x12, x29, #0x10
               	ldr	w14, [x12]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x14, x17
               	mov	x14, #0x0               // =0
               	mov	x17, #0x1               // =1
               	and	x13, x14, x17
               	lsl	x14, x13, #1
               	orr	x13, x15, x14
               	str	w13, [x12]
               	sub	x14, x29, #0x10
               	ldr	w13, [x14]
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x12, x13, x17
               	mov	x13, #0x5               // =5
               	mov	x17, #0x7               // =7
               	and	x15, x13, x17
               	lsl	x13, x15, #2
               	orr	x15, x12, x13
               	str	w15, [x14]
               	sub	x13, x29, #0x10
               	ldr	w15, [x13]
               	mov	x17, #0xfc1f            // =64543
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x15, x17
               	mov	x15, #0x11              // =17
               	mov	x17, #0x1f              // =31
               	and	x12, x15, x17
               	lsl	x15, x12, #5
               	orr	x12, x14, x15
               	str	w12, [x13]
               	sub	x15, x29, #0x10
               	add	x12, x15, #0x4
               	ldr	w15, [x12]
               	mov	x17, #0xffff00000000    // =281470681743360
               	movk	x17, #0xffff, lsl #48
               	and	x13, x15, x17
               	mov	x15, #0x5678            // =22136
               	movk	x15, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	orr	x15, x13, x14
               	str	w15, [x12]
               	sub	x14, x29, #0x10
               	add	x15, x14, #0x8
               	mov	x14, #0x3e7             // =999
               	str	w14, [x15]
               	sub	x12, x29, #0x10
               	ldr	w14, [x12]
               	mov	x17, #0x1               // =1
               	and	x12, x14, x17
               	cmp	x12, #0x1
               	b.eq	0x40038c <.text+0x15c>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	asr	x14, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x14, x17
               	cmp	x0, #0x0
               	b.eq	0x4003b8 <.text+0x188>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	asr	x14, x0, #2
               	mov	x17, #0x7               // =7
               	and	x0, x14, x17
               	cmp	x0, #0x5
               	b.eq	0x4003e4 <.text+0x1b4>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	asr	x14, x0, #5
               	mov	x17, #0x1f              // =31
               	and	x0, x14, x17
               	cmp	x0, #0x11
               	b.eq	0x400410 <.text+0x1e0>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	add	x0, x14, #0x4
               	ldr	w14, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x14, x17
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	0x400448 <.text+0x218>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	add	x0, x14, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x3e7
               	b.eq	0x400470 <.text+0x240>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w14, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x14, x17
               	mov	x14, #0x0               // =0
               	mov	x17, #0x1               // =1
               	and	x13, x14, x17
               	orr	x14, x15, x13
               	str	w14, [x0]
               	sub	x13, x29, #0x10
               	ldr	w14, [x13]
               	mov	x17, #0x1               // =1
               	and	x13, x14, x17
               	cmp	x13, #0x0
               	b.eq	0x4004c8 <.text+0x298>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	asr	x14, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x14, x17
               	cmp	x0, #0x0
               	b.eq	0x4004f4 <.text+0x2c4>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	asr	x14, x0, #2
               	mov	x17, #0x7               // =7
               	and	x0, x14, x17
               	cmp	x0, #0x5
               	b.eq	0x400520 <.text+0x2f0>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	asr	x14, x0, #5
               	mov	x17, #0x1f              // =31
               	and	x0, x14, x17
               	cmp	x0, #0x11
               	b.eq	0x40054c <.text+0x31c>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	add	x0, x14, #0x4
               	ldr	w14, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x14, x17
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	0x400584 <.text+0x354>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	add	x0, x14, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x3e7
               	b.eq	0x4005ac <.text+0x37c>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w14, [x0]
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x14, x17
               	mov	x14, #0x7               // =7
               	mov	x17, #0x7               // =7
               	and	x15, x14, x17
               	lsl	x14, x15, #2
               	orr	x15, x13, x14
               	str	w15, [x0]
               	sub	x14, x29, #0x10
               	ldr	w15, [x14]
               	asr	x14, x15, #2
               	mov	x17, #0x7               // =7
               	and	x15, x14, x17
               	cmp	x15, #0x7
               	b.eq	0x40060c <.text+0x3dc>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	asr	x14, x0, #5
               	mov	x17, #0x1f              // =31
               	and	x0, x14, x17
               	cmp	x0, #0x11
               	b.eq	0x400638 <.text+0x408>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	w0, [x14]
               	mov	x17, #0x1               // =1
               	and	x14, x0, x17
               	cmp	x14, #0x0
               	b.eq	0x400664 <.text+0x434>
               	mov	x14, #0xf               // =15
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w14, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x14, x17
               	mov	x14, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x13, x14, x17
               	orr	x14, x15, x13
               	str	w14, [x0]
               	sub	x15, x29, #0x18
               	ldr	w14, [x15]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x14, x17
               	lsl	x14, x13, #1
               	orr	x11, x0, x14
               	str	w11, [x15]
               	sub	x14, x29, #0x18
               	ldr	w11, [x14]
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x11, x17
               	mov	x11, #0x0               // =0
               	mov	x17, #0x1               // =1
               	and	x0, x11, x17
               	lsl	x11, x0, #2
               	orr	x0, x15, x11
               	str	w0, [x14]
               	sub	x11, x29, #0x18
               	ldr	w0, [x11]
               	mov	x17, #0xfff7            // =65527
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x0, x17
               	lsl	x0, x13, #3
               	orr	x13, x14, x0
               	str	w13, [x11]
               	sub	x0, x29, #0x18
               	ldr	w13, [x0]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x11, x13, x17
               	mov	x13, #0xb               // =11
               	mov	x17, #0xf               // =15
               	and	x14, x13, x17
               	lsl	x13, x14, #4
               	orr	x14, x11, x13
               	str	w14, [x0]
               	sub	x13, x29, #0x18
               	ldr	w14, [x13]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x14, x17
               	mov	x14, #0xc8              // =200
               	mov	x17, #0xff              // =255
               	and	x11, x14, x17
               	lsl	x14, x11, #8
               	orr	x11, x0, x14
               	str	w11, [x13]
               	sub	x14, x29, #0x18
               	ldr	w11, [x14]
               	mov	x17, #0x1               // =1
               	and	x14, x11, x17
               	cmp	x14, #0x1
               	b.eq	0x4007a8 <.text+0x578>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x18
               	ldr	w0, [x11]
               	asr	x11, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x11, x17
               	cmp	x0, #0x1
               	b.eq	0x4007d4 <.text+0x5a4>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x18
               	ldr	w0, [x11]
               	asr	x11, x0, #2
               	mov	x17, #0x1               // =1
               	and	x0, x11, x17
               	cmp	x0, #0x0
               	b.eq	0x400800 <.text+0x5d0>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x18
               	ldr	w0, [x11]
               	asr	x11, x0, #3
               	mov	x17, #0x1               // =1
               	and	x0, x11, x17
               	cmp	x0, #0x1
               	b.eq	0x40082c <.text+0x5fc>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x18
               	ldr	w0, [x11]
               	asr	x11, x0, #4
               	mov	x17, #0xf               // =15
               	and	x0, x11, x17
               	cmp	x0, #0xb
               	b.eq	0x400858 <.text+0x628>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x18
               	ldr	w0, [x11]
               	asr	x11, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x11, x17
               	cmp	x0, #0xc8
               	b.eq	0x400884 <.text+0x654>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x18
               	ldr	w0, [x11]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x0, x17
               	sub	x0, x29, #0x18
               	ldr	w14, [x0]
               	asr	x0, x14, #8
               	mov	x17, #0xff              // =255
               	and	x14, x0, x17
               	add	x0, x14, #0x1
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x14, x0, x17
               	lsl	x0, x14, #8
               	orr	x14, x13, x0
               	str	w14, [x11]
               	sub	x0, x29, #0x18
               	ldr	w14, [x0]
               	asr	x0, x14, #8
               	mov	x17, #0xff              // =255
               	and	x14, x0, x17
               	cmp	x14, #0xc9
               	b.eq	0x400900 <.text+0x6d0>
               	mov	x14, #0x16              // =22
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4eca35
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406f68 <exit+0x6510>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8ff8
               	tbz	w21, #0x6, 0x3fefbc
               	<unknown>
               	cbnz	w16, 0x46ef64
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400570 <.text+0x340>
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
               	bl	0x400a58 <exit>
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
               	adr	x10, 0x4ecb01
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x407034 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f90c4
               	tbz	w21, #0x6, 0x3ff088
               	<unknown>
               	cbnz	w16, 0x46f030
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40063c <.text+0x40c>
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
               	ldr	x16, [x16, #0xd0]
               	br	x16
