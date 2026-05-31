
bitfield_signed_read.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x13, #0x3               // =3
               	orr	x14, x14, x13
               	strh	w14, [x15]
               	sub	x13, x29, #0x8
               	ldrh	w14, [x13]
               	mov	x17, #0xfff3            // =65523
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x15, #0x4               // =4
               	orr	x14, x14, x15
               	strh	w14, [x13]
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	mov	x17, #0xf               // =15
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x14, x14, x17
               	mov	x13, #0x8000            // =32768
               	orr	x14, x14, x13
               	strh	w14, [x15]
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	mov	x17, #0x3               // =3
               	and	x13, x13, x17
               	lsl	x13, x13, #62
               	asr	x13, x13, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #2
               	mov	x17, #0x3               // =3
               	and	x13, x13, x17
               	lsl	x13, x13, #62
               	asr	x13, x13, #62
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	asr	x13, x13, #4
               	mov	x17, #0xfff             // =4095
               	and	x13, x13, x17
               	lsl	x13, x13, #52
               	asr	x13, x13, #52
               	mov	x17, #0xf800            // =63488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldrh	w13, [x13]
               	mov	x17, #0x3               // =3
               	and	x13, x13, x17
               	lsl	x13, x13, #62
               	asr	x13, x13, #62
               	add	x13, x13, #0x2
               	sxtw	x13, w13
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	ldr	w0, [x13]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0x4               // =4
               	orr	x0, x0, x15
               	str	w0, [x13]
               	sub	x15, x29, #0x10
               	ldr	w0, [x15]
               	mov	x17, #0xf807            // =63495
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0x400             // =1024
               	orr	x0, x0, x13
               	str	w0, [x15]
               	sub	x13, x29, #0x10
               	ldr	w0, [x13]
               	mov	x17, #0x7ff             // =2047
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0xf800            // =63488
               	movk	x15, #0xffff, lsl #16
               	orr	x0, x0, x15
               	str	w0, [x13]
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	mov	x17, #0x7               // =7
               	and	x15, x15, x17
               	lsl	x15, x15, #61
               	asr	x15, x15, #61
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #3
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	sxtb	x15, w15
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x15, x15, x17
               	lsl	x15, x15, #43
               	asr	x15, x15, #43
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	mov	x17, #0x7               // =7
               	and	x15, x15, x17
               	lsl	x15, x15, #61
               	asr	x15, x15, #61
               	cmp	x15, #0x0
               	b.le	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x15, x15, x17
               	lsl	x15, x15, #43
               	asr	x15, x15, #43
               	cmp	x15, #0x0
               	b.lt	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldr	w0, [x15]
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0x7               // =7
               	orr	x0, x0, x13
               	str	w0, [x15]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x4
               	ldrh	w0, [x13]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x15, #0x3               // =3
               	orr	x0, x0, x15
               	strh	w0, [x13]
               	sub	x15, x29, #0x18
               	add	x15, x15, #0x4
               	ldrh	w0, [x15]
               	mov	x17, #0xfff3            // =65523
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x13, #0x4               // =4
               	orr	x0, x0, x13
               	strh	w0, [x15]
               	sub	x13, x29, #0x18
               	ldr	w13, [x13]
               	mov	x17, #0xfff             // =4095
               	and	x13, x13, x17
               	cmp	x13, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x4
               	ldrh	w13, [x13]
               	mov	x17, #0x3               // =3
               	and	x13, x13, x17
               	lsl	x13, x13, #62
               	asr	x13, x13, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x13, x17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x4
               	ldrh	w13, [x13]
               	asr	x13, x13, #2
               	mov	x17, #0x3               // =3
               	and	x13, x13, x17
               	lsl	x13, x13, #62
               	asr	x13, x13, #62
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x6               // =6
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x4
               	ldrh	w0, [x0]
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	lsl	x0, x0, #62
               	asr	x0, x0, #62
               	add	x0, x0, x13
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x13, #0x22              // =34
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
