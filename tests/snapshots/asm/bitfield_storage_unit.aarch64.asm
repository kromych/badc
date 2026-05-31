
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
               	add	x15, x15, #0x4
               	sub	x0, x29, #0x10
               	sub	x15, x15, x0
               	cmp	x15, #0x4
               	b.eq	0x4002cc <.text+0xac>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x8
               	sub	x0, x29, #0x10
               	sub	x15, x15, x0
               	cmp	x15, #0x8
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
               	and	x0, x0, x17
               	mov	x13, #0xab              // =171
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	orr	x0, x0, x13
               	str	w0, [x15]
               	sub	x13, x29, #0x18
               	ldr	w0, [x13]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	lsl	x15, x15, #8
               	orr	x0, x0, x15
               	str	w0, [x13]
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0x2345            // =9029
               	movk	x13, #0x1, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x13, x13, x17
               	lsl	x13, x13, #9
               	orr	x0, x0, x13
               	str	w0, [x15]
               	sub	x13, x29, #0x18
               	ldr	w0, [x13]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0xab
               	b.eq	0x4003bc <.text+0x19c>
               	mov	x13, #0x11              // =17
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w13, [x0]
               	asr	x13, x13, #8
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x1
               	b.eq	0x4003e8 <.text+0x1c8>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldr	w0, [x13]
               	asr	x0, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	0x400424 <.text+0x204>
               	mov	x13, #0x13              // =19
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w13, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x13, x13, x17
               	mov	x15, #0x55              // =85
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	orr	x13, x13, x15
               	str	w13, [x0]
               	sub	x15, x29, #0x18
               	ldr	w13, [x15]
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	cmp	x13, #0x55
               	b.eq	0x40047c <.text+0x25c>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldr	w0, [x13]
               	asr	x0, x0, #8
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	0x4004ac <.text+0x28c>
               	mov	x13, #0x15              // =21
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w13, [x0]
               	asr	x13, x13, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x13, x13, x17
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	x13, x17
               	b.eq	0x4004e4 <.text+0x2c4>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	ldr	w0, [x13]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0xff              // =255
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	orr	x0, x0, x15
               	str	w0, [x13]
               	sub	x15, x29, #0x20
               	ldr	w0, [x15]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0x1               // =1
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	lsl	x13, x13, #8
               	orr	x0, x0, x13
               	str	w0, [x15]
               	sub	x13, x29, #0x20
               	ldr	w0, [x13]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0x7f, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x15, x15, x17
               	lsl	x15, x15, #9
               	orr	x0, x0, x15
               	str	w0, [x13]
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x4
               	ldr	w0, [x15]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0x0               // =0
               	mov	x17, #0xff              // =255
               	and	x12, x13, x17
               	orr	x0, x0, x12
               	str	w0, [x15]
               	sub	x12, x29, #0x20
               	add	x12, x12, #0x4
               	ldr	w0, [x12]
               	mov	x17, #0xfeff            // =65279
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x1               // =1
               	and	x15, x13, x17
               	lsl	x15, x15, #8
               	orr	x0, x0, x15
               	str	w0, [x12]
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x4
               	ldr	w0, [x15]
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x13, x13, x17
               	lsl	x13, x13, #9
               	orr	x0, x0, x13
               	str	w0, [x15]
               	sub	x13, x29, #0x20
               	add	x13, x13, #0x4
               	ldr	w0, [x13]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	0x40064c <.text+0x42c>
               	mov	x13, #0x17              // =23
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x4
               	ldr	w13, [x0]
               	asr	x13, x13, #8
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	0x40067c <.text+0x45c>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	add	x13, x13, #0x4
               	ldr	w0, [x13]
               	asr	x0, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	0x4006b4 <.text+0x494>
               	mov	x13, #0x19              // =25
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
