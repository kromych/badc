
bitfields.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	ldr	w2, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x1, x2, x1
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	ldr	w2, [x0]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x1, x2, x1
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x14               // =20
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	mov	x17, #0xfc1f            // =64543
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x220              // =544
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x5678             // =22136
               	movk	x1, #0x1234, lsl #16
               	ldr	w2, [x0, #0x4]
               	mov	x17, #0xffff00000000    // =281470681743360
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x1, x2, x1
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	mov	x1, #0x3e7              // =999
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #2
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #5
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	ldr	w2, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x1, x2, x1
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #2
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #5
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	mov	x17, #0xffe3            // =65507
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x1c               // =28
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #2
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #5
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	ldr	w2, [x0]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x1, x2, x1
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x2                // =2
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	ldr	w2, [x0]
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x1, x2, x1
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xfff7            // =65527
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x8                // =8
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0xb0               // =176
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0xc800             // =51200
               	orr	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #2
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #3
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #4
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x18
               	ldr	w1, [x1]
               	asr	x1, x1, #8
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	ldr	w2, [x0]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	lsl	x1, x1, #8
               	orr	x1, x2, x1
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0xc9
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
