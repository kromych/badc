
int128_bitfield.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x560
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	mov	x17, #0x1234            // =4660
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x488
               	ldr	x0, [x16]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x2, #0x5                // =5
               	mov	x17, #0x800000000       // =34359738368
               	orr	x1, x0, x17
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0x800000000       // =34359738368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x1, x17
               	mov	x1, #0x7                // =7
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	sub	x17, x29, #0x490
               	str	x1, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x488
               	ldr	x0, [x16]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x0, x0, x17
               	sub	x17, x29, #0x490
               	str	x1, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	orr	x0, x0, x17
               	sub	x17, x29, #0x490
               	str	x1, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x1, #0x1b               // =27
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x1, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x1, #0x1d               // =29
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x0, x17
               	mov	x0, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	cbz	x2, <addr>
               	mov	x2, #0x21               // =33
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x1, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x1, #0x23               // =35
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3210             // =12816
               	movk	x1, #0x7654, lsl #16
               	movk	x1, #0xba98, lsl #32
               	movk	x1, #0xfedc, lsl #48
               	mov	x2, #0xcdef             // =52719
               	movk	x2, #0x89ab, lsl #16
               	movk	x2, #0x4567, lsl #32
               	movk	x2, #0x123, lsl #48
               	sub	x17, x29, #0x480
               	str	x1, [x17]
               	sub	x17, x29, #0x478
               	str	x2, [x17]
               	mov	x2, x0
               	sub	x16, x29, #0x488
               	ldr	x1, [x16]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #-0x1000000000000000 // =-1152921504606846976
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xffd000000000    // =281268818280448
               	movk	x17, #0xffff, lsl #48
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	lsl	x2, x2, #28
               	mov	x17, #0xf000000         // =251658240
               	orr	x2, x2, x17
               	asr	x3, x2, #28
               	lsl	x2, x2, #36
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	mov	x17, #-0x1000000000000000 // =-1152921504606846976
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #36
               	asr	x2, x0, #36
               	asr	x3, x2, #63
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x0, #0x0                // =0
               	mov	x17, #0x800000000       // =34359738368
               	orr	x2, x1, x17
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x2, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x2, x17
               	lsl	x1, x1, #28
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	asr	x3, x1, #28
               	lsl	x1, x1, #36
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x2f               // =47
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x2, x17
               	mov	x17, #0x400000000       // =17179869184
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	lsl	x1, x1, #28
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	asr	x2, x1, #28
               	lsl	x1, x1, #36
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x32               // =50
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x520
               	mov	x2, #0xab               // =171
               	strb	w2, [x1]
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xf00000000000    // =263882790666240
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0x300             // =768
               	orr	x4, x2, x17
               	mov	x17, #0x200000          // =2097152
               	orr	x2, x3, x17
               	str	x4, [x1]
               	str	x2, [x1, #0x8]
               	lsr	x3, x2, #8
               	lsl	x2, x2, #56
               	mov	x17, #0x3               // =3
               	orr	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	cmp	x2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x38               // =56
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x510
               	ldr	w1, [x0]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x1f              // =31
               	orr	x1, x1, x17
               	str	w1, [x0]
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x160             // =352
               	orr	x3, x1, x17
               	mov	x17, #0x1               // =1
               	orr	x1, x2, x17
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0x1               // =1
               	movk	x17, #0xffe0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0x1f, lsl #16
               	orr	x1, x1, x17
               	str	x1, [x0, #0x8]
               	lsr	x2, x3, #5
               	lsl	x3, x1, #59
               	orr	x2, x2, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0xb               // =11
               	movk	x17, #0x800, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x39               // =57
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [x0]
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	w0, #0x1f
               	b.ne	<addr>
               	asr	x0, x1, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	cmp	w0, w17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3c               // =60
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x488
               	ldr	x0, [x16]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x1, #0x1                // =1
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	sub	x17, x29, #0x490
               	str	x1, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	mov	x17, #0x4000000         // =67108864
               	add	x2, x2, x17
               	add	x2, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	orr	x0, x0, x2
               	sub	x17, x29, #0x490
               	str	x1, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	mov	x17, #0x4000000         // =67108864
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x3e               // =62
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x1, x1, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x2, #0x3                // =3
               	orr	x0, x0, x1
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	mov	x17, #0xc000000         // =201326592
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x41               // =65
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x2, #0x0
               	sub	x1, x1, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x2, #0x2                // =2
               	orr	x0, x0, x1
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	mov	x17, #0xc000000         // =201326592
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x44               // =68
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x1, x2, #5
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x2, #0x40               // =64
               	orr	x0, x0, x1
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0x1, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x47               // =71
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x1, x2, #3
               	lsl	x2, x2, #61
               	mov	x17, #0x8               // =8
               	orr	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	orr	x1, x0, x1
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x1, x17
               	cmp	x2, #0x8
               	b.eq	<addr>
               	mov	x0, #0x49               // =73
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x0                // =0
               	mov	x17, #0xff              // =255
               	orr	x0, x2, x17
               	orr	x2, x3, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x2, x4, x0
               	orr	x0, x1, x3
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	cmp	x2, #0xff
               	b.eq	<addr>
               	mov	x1, #0x4c               // =76
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x1, x17
               	orr	x0, x0, x3
               	sub	x17, x29, #0x490
               	str	x2, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	cmp	x2, #0xf0
               	b.eq	<addr>
               	mov	x1, #0x4f               // =79
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x55              // =85
               	eor	x1, x2, x17
               	eor	x2, x3, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	orr	x1, x4, x1
               	orr	x11, x0, x2
               	sub	x17, x29, #0x490
               	str	x1, [x17]
               	sub	x17, x29, #0x488
               	str	x11, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x11, x17
               	cmp	x1, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x52               // =82
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x1, x4
               	eor	x1, x2, x4
               	cmp	x0, #0x0
               	cset	x3, lo
               	sub	x2, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x0, x0, x3
               	mov	x7, #0x7                // =7
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	cbz	x1, <addr>
               	mov	x1, #0x80               // =128
               	mov	x8, #0x1                // =1
               	mov	x6, x4
               	mov	x3, x2
               	mov	x5, x4
               	b	<addr>
               	lsr	x9, x0, #63
               	lsl	x10, x5, #1
               	lsl	x2, x6, #1
               	lsr	x5, x5, #63
               	orr	x2, x2, x5
               	orr	x5, x10, x9
               	lsl	x9, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	cmp	x2, #0x0
               	cset	x3, lo
               	cmp	x2, #0x0
               	cset	x6, eq
               	cmp	x5, #0x7
               	cset	x10, lo
               	and	x6, x6, x10
               	orr	x3, x3, x6
               	eor	x3, x3, x8
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x3
               	and	x6, x7, x6
               	cmp	x5, x6
               	cset	x10, lo
               	sub	x5, x5, x6
               	sub	x2, x2, #0x0
               	sub	x6, x2, x10
               	orr	x3, x9, x3
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	mov	x2, #0x0                // =0
               	eor	x1, x3, x2
               	eor	x0, x0, x2
               	cmp	x1, #0x0
               	cset	x3, lo
               	sub	x1, x1, #0x0
               	sub	x0, x0, #0x0
               	sub	x3, x0, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x11, x17
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	orr	x11, x3, x0
               	sub	x17, x29, #0x490
               	str	x1, [x17]
               	sub	x17, x29, #0x488
               	str	x11, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x11, x17
               	mov	x17, #0xdb85            // =56197
               	movk	x17, #0x6db6, lsl #16
               	movk	x17, #0xb6db, lsl #32
               	movk	x17, #0xdb6d, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x55               // =85
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x1, x2
               	eor	x1, x3, x2
               	cmp	x0, #0x0
               	cset	x3, lo
               	sub	x4, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x0, x0, x3
               	mov	x6, #0x4243             // =16963
               	movk	x6, #0xf, lsl #16
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	cbz	x1, <addr>
               	mov	x1, #0x80               // =128
               	mov	x8, #0x1                // =1
               	mov	x5, x2
               	mov	x3, x4
               	mov	x4, x2
               	b	<addr>
               	lsr	x7, x0, #63
               	lsl	x9, x4, #1
               	lsl	x5, x5, #1
               	lsr	x4, x4, #63
               	orr	x5, x5, x4
               	orr	x4, x9, x7
               	lsl	x9, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	cmp	x5, #0x0
               	cset	x3, lo
               	cmp	x5, #0x0
               	cset	x7, eq
               	cmp	x4, x6
               	cset	x10, lo
               	and	x7, x7, x10
               	orr	x3, x3, x7
               	eor	x3, x3, x8
               	sub	x7, x2, x3
               	and	x7, x6, x7
               	cmp	x4, x7
               	cset	x10, lo
               	sub	x4, x4, x7
               	sub	x5, x5, #0x0
               	sub	x5, x5, x10
               	orr	x3, x9, x3
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	eor	x0, x4, x2
               	eor	x1, x5, x2
               	cmp	x0, #0x0
               	cset	x2, lo
               	sub	x0, x0, #0x0
               	sub	x1, x1, #0x0
               	sub	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x11, x17
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	orr	x1, x2, x1
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	mov	x17, #0x47c3            // =18371
               	movk	x17, #0x2, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x1, x17
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x0, x0, x17
               	sub	x17, x29, #0x490
               	str	x3, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x0, x17
               	add	x1, x1, #0x0
               	add	x1, x1, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x0, x17
               	mov	x0, #0x0                // =0
               	orr	x1, x2, x1
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	cbz	x2, <addr>
               	mov	x2, #0x5c               // =92
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	sub	x2, x2, #0x1
               	add	x2, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	sub	x17, x29, #0x490
               	str	x3, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x5f               // =95
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x3, #0x5                // =5
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x3, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	add	x4, x2, #0x0
               	add	x4, x4, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x5, x4, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x4, #0x6                // =6
               	orr	x1, x1, x5
               	sub	x17, x29, #0x490
               	str	x4, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	cbz	x2, <addr>
               	mov	x2, #0x62               // =98
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	cbz	x2, <addr>
               	mov	x0, #0x65               // =101
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x1, x17
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	sub	x17, x29, #0x490
               	str	x3, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x0, x17
               	add	x1, x1, #0x0
               	add	x1, x1, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	orr	x0, x0, x1
               	sub	x17, x29, #0x490
               	str	x4, [x17]
               	sub	x17, x29, #0x488
               	str	x0, [x17]
               	cbz	x1, <addr>
               	mov	x0, #0x68               // =104
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x488
               	ldr	x0, [x16]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x0, x17
               	mov	x0, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0x3e8000000000    // =68719476736000
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	lsr	x2, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	cmp	w2, #0x3e8
               	b.ne	<addr>
               	mov	x2, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0x3ef000000000    // =69200513073152
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	lsr	x2, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	cmp	w2, #0x3ef
               	b.eq	<addr>
               	mov	x0, #0x6c               // =108
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0x3f0000000000    // =69269232549888
               	orr	x1, x1, x17
               	sub	x17, x29, #0x490
               	str	x0, [x17]
               	sub	x17, x29, #0x488
               	str	x1, [x17]
               	lsr	x2, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	cmp	w2, #0x3f0
               	b.eq	<addr>
               	mov	x0, #0x6d               // =109
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x478
               	ldr	x2, [x16]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	sub	x17, x29, #0x480
               	str	x0, [x17]
               	sub	x17, x29, #0x478
               	str	x2, [x17]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xffb000000000    // =281131379326976
               	movk	x17, #0xffff, lsl #48
               	orr	x2, x2, x17
               	sub	x17, x29, #0x480
               	str	x0, [x17]
               	sub	x17, x29, #0x478
               	str	x2, [x17]
               	lsr	x3, x2, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x3, x3, x17
               	lsl	x3, x3, #36
               	asr	x4, x3, #36
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x2, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x70               // =112
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x6e               // =110
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6b               // =107
               	add	sp, sp, #0x560
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x59               // =89
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x3, x4, x6
               	msub	x4, x3, x6, x4
               	mov	x5, x2
               	mov	x0, x2
               	b	<addr>
               	mov	x17, #0x6db6            // =28086
               	movk	x17, #0x6db, lsl #16
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x56               // =86
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
               	udiv	x3, x2, x7
               	msub	x5, x3, x7, x2
               	mov	x6, x4
               	mov	x0, x4
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x53               // =83
               	b	<addr>
               	mov	x0, x4
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x1, #0x50               // =80
               	b	<addr>
               	mov	x1, x4
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x1, #0x4d               // =77
               	b	<addr>
               	mov	x1, x4
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x4a               // =74
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x2000            // =8192
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x36               // =54
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x400000000       // =17179869184
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x33               // =51
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x17, #0xfff800000000    // =281440616972288
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x1, #0x30               // =48
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x2d               // =45
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x800000000       // =34359738368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
