
bitfields.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	and	x14, x14, x17
               	mov	x13, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	orr	x14, x14, x13
               	str	w14, [x15]
               	sub	x13, x29, #0x10
               	ldr	w14, [x13]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x15, #0x0               // =0
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	lsl	x15, x15, #1
               	orr	x14, x14, x15
               	str	w14, [x13]
               	sub	x15, x29, #0x10
               	ldr	w14, [x15]
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x13, #0x5               // =5
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	lsl	x13, x13, #2
               	orr	x14, x14, x13
               	str	w14, [x15]
               	sub	x13, x29, #0x10
               	ldr	w14, [x13]
               	mov	x17, #0xfc1f            // =64543
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x15, #0x11              // =17
               	mov	x17, #0x1f              // =31
               	and	x15, x15, x17
               	lsl	x15, x15, #5
               	orr	x14, x14, x15
               	str	w14, [x13]
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x4
               	ldr	w14, [x15]
               	mov	x17, #0xffff00000000    // =281470681743360
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x13, #0x5678            // =22136
               	movk	x13, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	orr	x14, x14, x13
               	str	w14, [x15]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x8
               	mov	x14, #0x3e7             // =999
               	str	w14, [x13]
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #1
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #2
               	mov	x17, #0x7               // =7
               	and	x15, x15, x17
               	cmp	x15, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #5
               	mov	x17, #0x1f              // =31
               	and	x15, x15, x17
               	cmp	x15, #0x11
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x4
               	ldr	w15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w0, [x15]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0x0               // =0
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	orr	x0, x0, x13
               	str	w0, [x15]
               	sub	x13, x29, #0x10
               	ldr	w13, [x13]
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	ldr	w13, [x13]
               	asr	x13, x13, #1
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	ldr	w13, [x13]
               	asr	x13, x13, #2
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	cmp	x13, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	ldr	w13, [x13]
               	asr	x13, x13, #5
               	mov	x17, #0x1f              // =31
               	and	x13, x13, x17
               	cmp	x13, #0x11
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x4
               	ldr	w13, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x8
               	ldrsw	x13, [x13]
               	cmp	x13, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	ldr	w0, [x13]
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0x7               // =7
               	mov	x17, #0x7               // =7
               	and	x15, x15, x17
               	lsl	x15, x15, #2
               	orr	x0, x0, x15
               	str	w0, [x13]
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #2
               	mov	x17, #0x7               // =7
               	and	x15, x15, x17
               	cmp	x15, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #5
               	mov	x17, #0x1f              // =31
               	and	x15, x15, x17
               	cmp	x15, #0x11
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	orr	x0, x0, x13
               	str	w0, [x15]
               	sub	x12, x29, #0x18
               	ldr	w0, [x12]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	lsl	x15, x13, #1
               	orr	x0, x0, x15
               	str	w0, [x12]
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x12, #0x0               // =0
               	mov	x17, #0x1               // =1
               	and	x12, x12, x17
               	lsl	x12, x12, #2
               	orr	x0, x0, x12
               	str	w0, [x15]
               	sub	x12, x29, #0x18
               	ldr	w0, [x12]
               	mov	x17, #0xfff7            // =65527
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	lsl	x13, x13, #3
               	orr	x0, x0, x13
               	str	w0, [x12]
               	sub	x13, x29, #0x18
               	ldr	w0, [x13]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x12, #0xb               // =11
               	mov	x17, #0xf               // =15
               	and	x12, x12, x17
               	lsl	x12, x12, #4
               	orr	x0, x0, x12
               	str	w0, [x13]
               	sub	x12, x29, #0x18
               	ldr	w0, [x12]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0xc8              // =200
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	lsl	x13, x13, #8
               	orr	x0, x0, x13
               	str	w0, [x12]
               	sub	x13, x29, #0x18
               	ldr	w13, [x13]
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldr	w13, [x13]
               	asr	x13, x13, #1
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldr	w13, [x13]
               	asr	x13, x13, #2
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldr	w13, [x13]
               	asr	x13, x13, #3
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldr	w13, [x13]
               	asr	x13, x13, #4
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	cmp	x13, #0xb
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldr	w13, [x13]
               	asr	x13, x13, #8
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	cmp	x13, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldr	w0, [x13]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x12, x29, #0x18
               	ldr	w12, [x12]
               	asr	x12, x12, #8
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	lsl	x12, x12, #8
               	orr	x0, x0, x12
               	str	w0, [x13]
               	sub	x12, x29, #0x18
               	ldr	w12, [x12]
               	asr	x12, x12, #8
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	cmp	x12, #0xc9
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
