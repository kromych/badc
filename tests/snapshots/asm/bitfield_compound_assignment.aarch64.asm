
bitfield_compound_assignment.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	and	x14, x14, x17
               	mov	x13, #0x0               // =0
               	mov	x17, #0x1               // =1
               	and	x12, x13, x17
               	orr	x14, x14, x12
               	strh	w14, [x15]
               	sub	x12, x29, #0x8
               	ldrh	w14, [x12]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x17, #0x7               // =7
               	and	x15, x13, x17
               	lsl	x15, x15, #1
               	orr	x14, x14, x15
               	strh	w14, [x12]
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x17, #0xf               // =15
               	and	x12, x13, x17
               	lsl	x12, x12, #4
               	orr	x14, x14, x12
               	strh	w14, [x15]
               	sub	x12, x29, #0x8
               	ldrh	w14, [x12]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	lsl	x13, x13, #8
               	orr	x14, x14, x13
               	strh	w14, [x12]
               	sub	x13, x29, #0x8
               	ldrh	w14, [x13]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	sub	x12, x29, #0x8
               	ldrh	w12, [x12]
               	asr	x12, x12, #1
               	mov	x17, #0x7               // =7
               	and	x12, x12, x17
               	mov	x17, #0x5               // =5
               	orr	x12, x12, x17
               	mov	x17, #0x7               // =7
               	and	x12, x12, x17
               	lsl	x12, x12, #1
               	orr	x14, x14, x12
               	strh	w14, [x13]
               	sub	x12, x29, #0x8
               	ldrh	w12, [x12]
               	asr	x12, x12, #1
               	mov	x17, #0x7               // =7
               	and	x12, x12, x17
               	cmp	x12, #0x5
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x8
               	ldrh	w0, [x12]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #1
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	mov	x17, #0x2               // =2
               	orr	x13, x13, x17
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	lsl	x13, x13, #1
               	orr	x0, x0, x13
               	strh	w0, [x12]
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #1
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	cmp	x13, #0x7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w0, [x13]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x12, x29, #0x8
               	ldrh	w12, [x12]
               	asr	x12, x12, #1
               	mov	x17, #0x6               // =6
               	and	x12, x12, x17
               	lsl	x12, x12, #1
               	orr	x0, x0, x12
               	strh	w0, [x13]
               	sub	x12, x29, #0x8
               	ldrh	w12, [x12]
               	asr	x12, x12, #1
               	mov	x17, #0x7               // =7
               	and	x12, x12, x17
               	cmp	x12, #0x6
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x8
               	ldrh	w0, [x12]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #1
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	mov	x17, #0x7               // =7
               	eor	x13, x13, x17
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	lsl	x13, x13, #1
               	orr	x0, x0, x13
               	strh	w0, [x12]
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #1
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w0, [x13]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x12, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x12, x12, x17
               	orr	x0, x0, x12
               	strh	w0, [x13]
               	sub	x12, x29, #0x8
               	ldrh	w0, [x12]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0xc               // =12
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	lsl	x13, x13, #4
               	orr	x0, x0, x13
               	strh	w0, [x12]
               	sub	x13, x29, #0x8
               	ldrh	w0, [x13]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x12, #0xc8              // =200
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	lsl	x12, x12, #8
               	orr	x0, x0, x12
               	strh	w0, [x13]
               	sub	x12, x29, #0x8
               	ldrh	w0, [x12]
               	mov	x17, #0xfff1            // =65521
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #1
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	mov	x17, #0x7               // =7
               	eor	x13, x13, x17
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	lsl	x13, x13, #1
               	orr	x0, x0, x13
               	strh	w0, [x12]
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #1
               	mov	x17, #0x7               // =7
               	and	x13, x13, x17
               	cmp	x13, #0x6
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #4
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	cmp	x13, #0xc
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #8
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	cmp	x13, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w0, [x13]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x12, x29, #0x8
               	ldrh	w12, [x12]
               	asr	x12, x12, #4
               	mov	x17, #0xf               // =15
               	and	x12, x12, x17
               	add	x12, x12, #0x1
               	mov	x17, #0xf               // =15
               	and	x12, x12, x17
               	lsl	x12, x12, #4
               	orr	x0, x0, x12
               	strh	w0, [x13]
               	sub	x12, x29, #0x8
               	ldrh	w12, [x12]
               	asr	x12, x12, #4
               	mov	x17, #0xf               // =15
               	and	x12, x12, x17
               	cmp	x12, #0xd
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x8
               	ldrh	w0, [x12]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #4
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	sub	x13, x13, #0x4
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	lsl	x13, x13, #4
               	orr	x0, x0, x13
               	strh	w0, [x12]
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #4
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	cmp	x13, #0x9
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w0, [x13]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x12, x29, #0x8
               	ldrh	w12, [x12]
               	asr	x12, x12, #8
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	lsl	x12, x12, #1
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	lsl	x12, x12, #8
               	orr	x0, x0, x12
               	strh	w0, [x13]
               	sub	x12, x29, #0x8
               	ldrh	w12, [x12]
               	asr	x12, x12, #8
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	mov	x0, #0x190              // =400
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x13, #0x100             // =256
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	udiv	x17, x0, x13
               	msub	x0, x17, x13, x0
               	eor	x12, x12, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x8
               	ldrh	w0, [x12]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #4
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	asr	x13, x13, #2
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	lsl	x13, x13, #4
               	orr	x0, x0, x13
               	strh	w0, [x12]
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #4
               	mov	x17, #0xf               // =15
               	and	x13, x13, x17
               	cmp	x13, #0x2
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
