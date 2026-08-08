
bitfield_signed_read.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	ldrh	w1, [x0]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x3               // =3
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	sub	x2, x29, #0x8
               	mov	x17, #0xffff            // =65535
               	and	x0, x1, x17
               	mov	x17, #0xfff3            // =65523
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x4               // =4
               	orr	x0, x0, x17
               	strh	w0, [x2]
               	sub	x1, x29, #0x8
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xf               // =15
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x8000            // =32768
               	orr	x0, x0, x17
               	strh	w0, [x1]
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	lsl	x1, x1, #62
               	asr	x1, x1, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	asr	x1, x1, #2
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	lsl	x1, x1, #62
               	asr	x1, x1, #62
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	asr	x1, x1, #4
               	mov	x17, #0xfff             // =4095
               	and	x1, x1, x17
               	lsl	x1, x1, #52
               	asr	x1, x1, #52
               	mov	x17, #0xf800            // =63488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x4               // =4
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x2, x29, #0x10
               	mov	w0, w1
               	mov	x17, #0xf807            // =63495
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x400             // =1024
               	orr	x0, x0, x17
               	str	w0, [x2]
               	sub	x1, x29, #0x10
               	mov	w0, w0
               	mov	x17, #0x7ff             // =2047
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xf800            // =63488
               	movk	x17, #0xffff, lsl #16
               	orr	x0, x0, x17
               	str	w0, [x1]
               	mov	w1, w0
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	lsl	x1, x1, #61
               	asr	x1, x1, #61
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #3
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	sxtb	x1, w1
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1f, lsl #16
               	and	x1, x1, x17
               	lsl	x1, x1, #43
               	asr	x1, x1, #43
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x7               // =7
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldrh	w1, [x0]
               	mov	x17, #0xcfff            // =53247
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x3000            // =12288
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	sub	x2, x29, #0x18
               	mov	x17, #0xffff            // =65535
               	and	x0, x1, x17
               	mov	x17, #0x3fff            // =16383
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x4000            // =16384
               	orr	x0, x0, x17
               	strh	w0, [x2]
               	sub	x1, x29, #0x18
               	ldr	w1, [x1]
               	mov	x17, #0xfff             // =4095
               	and	x1, x1, x17
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	asr	x1, x1, #12
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	lsl	x1, x1, #62
               	asr	x1, x1, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	asr	x1, x1, #14
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	lsl	x1, x1, #62
               	asr	x1, x1, #62
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
