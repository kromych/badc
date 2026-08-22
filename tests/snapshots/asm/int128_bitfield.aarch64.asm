
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
               	sub	sp, sp, #0x5d0
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
               	add	sp, sp, #0x5d0
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
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5d0
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x5                // =5
               	mov	x17, #0x800000000       // =34359738368
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
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
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5d0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x7                // =7
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5c0
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x5c0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5c0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5b0
               	mov	x1, #0x3210             // =12816
               	movk	x1, #0x7654, lsl #16
               	movk	x1, #0xba98, lsl #32
               	movk	x1, #0xfedc, lsl #48
               	mov	x2, #0xcdef             // =52719
               	movk	x2, #0x89ab, lsl #16
               	movk	x2, #0x4567, lsl #32
               	movk	x2, #0x123, lsl #48
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x5a0
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #-0x1000000000000000 // =-1152921504606846976
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x5a0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x2, #-0x1000000000000000 // =-1152921504606846976
               	mov	x17, #0xffd000000000    // =281268818280448
               	movk	x17, #0xffff, lsl #48
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	lsl	x0, x0, #28
               	mov	x17, #0xf000000         // =251658240
               	orr	x0, x0, x17
               	asr	x2, x0, #28
               	lsl	x0, x0, #36
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	mov	x17, #-0x1000000000000000 // =-1152921504606846976
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
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
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5a0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x800000000       // =34359738368
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	lsl	x0, x0, #28
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	asr	x2, x0, #28
               	lsl	x0, x0, #36
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x2f               // =47
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5a0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x400000000       // =17179869184
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	lsl	x0, x0, #28
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	asr	x1, x0, #28
               	lsl	x0, x0, #36
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x32               // =50
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x590
               	mov	x1, #0xab               // =171
               	strb	w1, [x0]
               	sub	x0, x29, #0x590
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xf00000000000    // =263882790666240
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x300             // =768
               	orr	x3, x1, x17
               	mov	x17, #0x200000          // =2097152
               	orr	x1, x2, x17
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x0, x1, #8
               	lsl	x1, x1, #56
               	mov	x17, #0x3               // =3
               	orr	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x590
               	ldrb	w0, [x0]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x38               // =56
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x580
               	ldr	w1, [x0]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x1f              // =31
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x0, x29, #0x580
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x2, x17
               	mov	x17, #0x160             // =352
               	orr	x2, x1, x17
               	mov	x17, #0x1               // =1
               	orr	x3, x3, x17
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x1, x29, #0x580
               	mov	x17, #0x1               // =1
               	movk	x17, #0xffe0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x3, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0x1f, lsl #16
               	orr	x0, x0, x17
               	str	x0, [x1, #0x8]
               	lsr	x1, x2, #5
               	lsl	x2, x0, #59
               	orr	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xb               // =11
               	movk	x17, #0x800, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x1, #0x39               // =57
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x580
               	ldr	w1, [x1]
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	x1, #0x1f
               	cset	x1, ne
               	cbnz	x1, <addr>
               	asr	x0, x0, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3c               // =60
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x1                // =1
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	mov	x17, #0x4000000         // =67108864
               	add	x2, x2, x17
               	add	x2, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x3, #0x1                // =1
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0x4000000         // =67108864
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3e               // =62
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	add	x2, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x3, #0x3                // =3
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xc000000         // =201326592
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x41               // =65
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	sub	x2, x2, #0x0
               	sub	x2, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x3, #0x2                // =2
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xc000000         // =201326592
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x44               // =68
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	lsl	x2, x2, #5
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x3, #0x40               // =64
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x47               // =71
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	asr	x3, x2, #3
               	lsl	x2, x2, #61
               	mov	x17, #0x8               // =8
               	orr	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	orr	x1, x1, x3
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	cmp	x2, #0x8
               	b.eq	<addr>
               	mov	x0, #0x49               // =73
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x1, x17
               	mov	x3, #0x0                // =0
               	mov	x17, #0xff              // =255
               	orr	x2, x2, x17
               	orr	x4, x4, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x4, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x2, x3, x2
               	orr	x1, x1, x4
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	cmp	x2, #0xff
               	b.eq	<addr>
               	mov	x0, #0x4c               // =76
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x1, x17
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	orr	x1, x1, x3
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	cmp	x2, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x4f               // =79
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x1, x17
               	mov	x3, #0x0                // =0
               	mov	x17, #0x55              // =85
               	eor	x2, x2, x17
               	eor	x4, x4, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x4, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x5, x1, x17
               	orr	x1, x3, x2
               	orr	x10, x5, x4
               	str	x1, [x0]
               	str	x10, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x10, x17
               	cmp	x1, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x52               // =82
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x9, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x10, x17
               	mov	x11, #0x0               // =0
               	eor	x0, x1, x11
               	eor	x1, x2, x11
               	cmp	x0, #0x0
               	cset	x2, lo
               	sub	x3, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x1, x0, x2
               	mov	x6, #0x7                // =7
               	mov	x17, #0x0               // =0
               	orr	x0, x1, x17
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x5, x1, #63
               	lsl	x7, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x7, x5
               	lsl	x7, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x5, eq
               	cmp	x3, #0x7
               	cset	x8, lo
               	and	x5, x5, x8
               	orr	x4, x4, x5
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x5, #0x0                // =0
               	sub	x5, x5, x4
               	and	x5, x6, x5
               	cmp	x3, x5
               	cset	x8, lo
               	sub	x3, x3, x5
               	sub	x0, x0, #0x0
               	sub	x0, x0, x8
               	orr	x4, x7, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x2, #0x0                // =0
               	eor	x4, x4, x2
               	eor	x1, x1, x2
               	cmp	x4, #0x0
               	cset	x2, lo
               	sub	x4, x4, #0x0
               	sub	x1, x1, #0x0
               	sub	x2, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x10, x17
               	mov	x17, #0x0               // =0
               	orr	x1, x4, x17
               	orr	x10, x2, x0
               	str	x1, [x9]
               	str	x10, [x9, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x10, x17
               	mov	x17, #0xdb85            // =56197
               	movk	x17, #0x6db6, lsl #16
               	movk	x17, #0xb6db, lsl #32
               	movk	x17, #0xdb6d, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x55               // =85
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x9, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x10, x17
               	mov	x11, #0x0               // =0
               	eor	x0, x1, x11
               	eor	x1, x2, x11
               	cmp	x0, #0x0
               	cset	x2, lo
               	sub	x3, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x1, x0, x2
               	mov	x5, #0x4243             // =16963
               	movk	x5, #0xf, lsl #16
               	mov	x17, #0x0               // =0
               	orr	x0, x1, x17
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x6, x1, #63
               	lsl	x7, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x7, x6
               	lsl	x7, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x6, eq
               	cmp	x3, x5
               	cset	x8, lo
               	and	x6, x6, x8
               	orr	x4, x4, x6
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x4
               	and	x6, x5, x6
               	cmp	x3, x6
               	cset	x8, lo
               	sub	x3, x3, x6
               	sub	x0, x0, #0x0
               	sub	x0, x0, x8
               	orr	x4, x7, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x1, x3, x11
               	eor	x0, x0, x11
               	cmp	x1, #0x0
               	cset	x2, lo
               	sub	x1, x1, #0x0
               	sub	x0, x0, #0x0
               	sub	x0, x0, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x10, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x1, x17
               	orr	x1, x3, x0
               	str	x2, [x9]
               	str	x1, [x9, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0x47c3            // =18371
               	movk	x17, #0x2, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x58               // =88
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	add	x2, x2, #0x0
               	add	x2, x2, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x3, #0x0                // =0
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	cbz	x0, <addr>
               	mov	x0, #0x5c               // =92
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x570
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
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5f               // =95
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x5                // =5
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	add	x3, x2, #0x0
               	add	x3, x3, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x4, #0x6                // =6
               	orr	x1, x1, x3
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	cbz	x2, <addr>
               	mov	x0, #0x62               // =98
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	cbz	x0, <addr>
               	mov	x0, #0x65               // =101
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x570
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x5                // =5
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x570
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	add	x2, x2, #0x0
               	add	x2, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x3, #0x6                // =6
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	cbz	x2, <addr>
               	mov	x0, #0x68               // =104
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x560
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x560
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x3e8000000000    // =68719476736000
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x0, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x3e8
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x6b               // =107
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x560
               	lsr	x2, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	add	x2, x2, #0x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	lsl	x2, x2, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x3, #0x0                // =0
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x0, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x3ef
               	b.eq	<addr>
               	mov	x0, #0x6c               // =108
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x560
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x3f0000000000    // =69269232549888
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x0, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x3f0
               	b.eq	<addr>
               	mov	x0, #0x6d               // =109
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x550
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x3, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x550
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x3, #0x0                // =0
               	mov	x17, #0xffb000000000    // =281131379326976
               	movk	x17, #0xffff, lsl #48
               	orr	x2, x2, x17
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	lsr	x0, x2, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #36
               	asr	x3, x0, #36
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x6e               // =110
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	cbz	x0, <addr>
               	mov	x0, #0x70               // =112
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x5d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x59               // =89
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x4, x3, x5
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mov	x17, #0x6db6            // =28086
               	movk	x17, #0x6db, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x56               // =86
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x53               // =83
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x50               // =80
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4d               // =77
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x30000000        // =805306368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4a               // =74
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x2000            // =8192
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x36               // =54
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x400000000       // =17179869184
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xfff800000000    // =281440616972288
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x30               // =48
               	b	<addr>
               	mov	x0, #0x0                // =0
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
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
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
