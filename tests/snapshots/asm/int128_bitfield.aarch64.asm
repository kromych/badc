
int128_bitfield.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x30
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x16
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x2
               	b.eq	<addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	cmp	x1, x4
               	b.eq	<addr>
               	add	x0, x3, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x590
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x800000000        // =34359738368
               	mov	x2, #0x1234             // =4660
               	mov	x3, #0xa                // =10
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x5a0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x7                // =7
               	mov	x3, #0xd                // =13
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x2, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x0, x17
               	sub	x0, x29, #0x5b0
               	str	x1, [x0]
               	asr	x1, x1, #63
               	str	x1, [x0, #0x8]
               	mov	x1, #0x9                // =9
               	mov	x3, #0x10               // =16
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9b0
               	mov	x3, #0x1                // =1
               	sub	x1, x29, #0x5c0
               	str	x3, [x1]
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x8]
               	lsl	x4, x3, #35
               	sub	x1, x29, #0x5d0
               	str	x2, [x1]
               	str	x4, [x1, #0x8]
               	mov	x5, #0x5                // =5
               	orr	x3, x2, x5
               	orr	x4, x4, x2
               	sub	x1, x29, #0x5e0
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	sub	x1, x29, #0x5f0
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x4, x17
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x2, x2, x3
               	orr	x4, x4, x1
               	str	x2, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x600
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x9b0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x610
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x800000000        // =34359738368
               	mov	x3, #0x14               // =20
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x5
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9b0
               	mov	x3, #0x1                // =1
               	sub	x2, x29, #0x620
               	str	x3, [x2]
               	mov	x1, #0x0                // =0
               	str	x1, [x2, #0x8]
               	lsl	x4, x3, #36
               	sub	x2, x29, #0x630
               	str	x1, [x2]
               	str	x4, [x2, #0x8]
               	mov	x5, #0x7                // =7
               	orr	x3, x1, x5
               	orr	x4, x4, x1
               	sub	x2, x29, #0x640
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	sub	x2, x29, #0x650
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x4, x17
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x6, x1, x3
               	orr	x4, x4, x2
               	str	x6, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x660
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x9b0
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	sub	x0, x29, #0x670
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #0x17               // =23
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x5
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x9c0
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x680
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mvn	x3, x0
               	mvn	x4, x0
               	sub	x2, x29, #0x690
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	sub	x2, x29, #0x6a0
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x4, x17
               	ldr	x4, [x1, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x6, x0, x3
               	orr	x4, x4, x2
               	str	x6, [x1]
               	str	x4, [x1, #0x8]
               	sub	x1, x29, #0x6b0
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x9c0
               	sub	x2, x29, #0x6c0
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	mvn	x3, x0
               	mvn	x4, x0
               	sub	x2, x29, #0x6d0
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x3, x17
               	lsl	x2, x2, #36
               	ldr	x3, [x1]
               	ldr	x4, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x4, x17
               	orr	x0, x3, x0
               	orr	x2, x4, x2
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x0, x29, #0x9c0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x6e0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xf, lsl #32
               	mov	x3, #0x1a               // =26
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x5
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9c0
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x2, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x0, x17
               	sub	x0, x29, #0x6f0
               	str	x1, [x0]
               	asr	x1, x1, #63
               	str	x1, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xfff, lsl #16
               	mov	x3, #0x1d               // =29
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9c0
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x700
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x4, x1, x1
               	orr	x3, x3, x2
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x710
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x9c0
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	sub	x0, x29, #0x720
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #0x20               // =32
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9c0
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x2, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x0, x17
               	sub	x0, x29, #0x730
               	str	x1, [x0]
               	asr	x1, x1, #63
               	str	x1, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xfff, lsl #16
               	mov	x3, #0x23               // =35
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x9d0
               	mov	x3, #0xcdef             // =52719
               	movk	x3, #0x89ab, lsl #16
               	movk	x3, #0x4567, lsl #32
               	movk	x3, #0x123, lsl #48
               	sub	x2, x29, #0x740
               	str	x3, [x2]
               	mov	x0, #0x0                // =0
               	str	x0, [x2, #0x8]
               	sub	x2, x29, #0x750
               	str	x0, [x2]
               	str	x3, [x2, #0x8]
               	mov	x6, #0x3210             // =12816
               	movk	x6, #0x7654, lsl #16
               	movk	x6, #0xba98, lsl #32
               	movk	x6, #0xfedc, lsl #48
               	orr	x4, x0, x6
               	orr	x5, x3, x0
               	sub	x2, x29, #0x760
               	str	x4, [x2]
               	str	x5, [x2, #0x8]
               	sub	x2, x29, #0x770
               	str	x4, [x2]
               	str	x5, [x2, #0x8]
               	orr	x2, x0, x4
               	orr	x0, x0, x5
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	sub	x0, x29, #0x780
               	str	x4, [x0]
               	str	x5, [x0, #0x8]
               	sub	x0, x29, #0x9d0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x790
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x26               // =38
               	mov	x2, x3
               	mov	x4, x1
               	mov	x3, x6
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x9e0
               	mov	x3, #0x1                // =1
               	sub	x2, x29, #0x7a0
               	str	x3, [x2]
               	mov	x0, #0x0                // =0
               	str	x0, [x2, #0x8]
               	lsl	x4, x3, #60
               	lsl	x2, x0, #60
               	lsr	x3, x3, #4
               	orr	x3, x2, x3
               	sub	x2, x29, #0x7b0
               	str	x4, [x2]
               	str	x3, [x2, #0x8]
               	cmp	x4, #0x0
               	cset	x5, hi
               	sub	x2, x0, x4
               	sub	x3, x0, x3
               	sub	x4, x3, x5
               	sub	x3, x29, #0x7c0
               	str	x2, [x3]
               	str	x4, [x3, #0x8]
               	sub	x3, x29, #0x7d0
               	str	x2, [x3]
               	str	x4, [x3, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x4, x17
               	ldr	x4, [x1, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x5, x0, x2
               	orr	x4, x4, x3
               	str	x5, [x1]
               	str	x4, [x1, #0x8]
               	lsl	x4, x2, #28
               	lsl	x1, x3, #28
               	lsr	x2, x2, #36
               	orr	x1, x1, x2
               	asr	x2, x1, #28
               	lsr	x3, x4, #28
               	lsl	x1, x1, #36
               	orr	x3, x3, x1
               	sub	x1, x29, #0x7e0
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x9e0
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	orr	x0, x2, x0
               	mov	x17, #0xffd000000000    // =281268818280448
               	movk	x17, #0xffff, lsl #48
               	orr	x2, x3, x17
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	sub	x0, x29, #0x9e0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	lsl	x3, x1, #28
               	lsl	x0, x0, #28
               	lsr	x1, x1, #36
               	orr	x0, x0, x1
               	asr	x1, x0, #28
               	lsr	x3, x3, #28
               	lsl	x0, x0, #36
               	orr	x3, x3, x0
               	sub	x0, x29, #0x7f0
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #-0x1000000000000000 // =-1152921504606846976
               	mov	x3, #0x29               // =41
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9e0
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #36
               	asr	x1, x0, #36
               	sub	x0, x29, #0x800
               	str	x1, [x0]
               	asr	x1, x1, #63
               	str	x1, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0xfffd             // =65533
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x2c               // =44
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9e0
               	mov	x3, #0x1                // =1
               	sub	x1, x29, #0x810
               	str	x3, [x1]
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x8]
               	lsl	x3, x3, #35
               	sub	x1, x29, #0x820
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x830
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x4, x2, x2
               	orr	x3, x3, x1
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	lsl	x3, x2, #28
               	lsl	x0, x1, #28
               	lsr	x1, x2, #36
               	orr	x0, x0, x1
               	asr	x1, x0, #28
               	lsr	x3, x3, #28
               	lsl	x0, x0, #36
               	orr	x3, x3, x0
               	sub	x0, x29, #0x840
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x9e0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	lsl	x3, x1, #28
               	lsl	x0, x0, #28
               	lsr	x1, x1, #36
               	orr	x0, x0, x1
               	asr	x1, x0, #28
               	lsr	x3, x3, #28
               	lsl	x0, x0, #36
               	orr	x3, x3, x0
               	sub	x0, x29, #0x850
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0xfff800000000     // =281440616972288
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0x2f               // =47
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9e0
               	mov	x3, #0x1                // =1
               	sub	x1, x29, #0x860
               	str	x3, [x1]
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x8]
               	lsl	x3, x3, #34
               	sub	x1, x29, #0x870
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x880
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x4, x2, x2
               	orr	x3, x3, x1
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	lsl	x3, x2, #28
               	lsl	x0, x1, #28
               	lsr	x1, x2, #36
               	orr	x0, x0, x1
               	asr	x1, x0, #28
               	lsr	x3, x3, #28
               	lsl	x0, x0, #36
               	orr	x3, x3, x0
               	sub	x0, x29, #0x890
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x9e0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	lsl	x3, x1, #28
               	lsl	x0, x0, #28
               	lsr	x1, x1, #36
               	orr	x0, x0, x1
               	asr	x1, x0, #28
               	lsr	x3, x3, #28
               	lsl	x0, x0, #36
               	orr	x3, x3, x0
               	sub	x0, x29, #0x8a0
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x400000000        // =17179869184
               	mov	x3, #0x32               // =50
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9f0
               	mov	x1, #0xab               // =171
               	strb	w1, [x0]
               	sub	x0, x29, #0x9f0
               	mov	x3, #0x1                // =1
               	sub	x1, x29, #0x8b0
               	str	x3, [x1]
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x8]
               	lsl	x3, x3, #13
               	sub	x1, x29, #0x8c0
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x4, #0x3                // =3
               	orr	x1, x2, x4
               	orr	x3, x3, x2
               	sub	x2, x29, #0x8d0
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	sub	x2, x29, #0x8e0
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x3, x17
               	lsl	x3, x1, #8
               	lsl	x5, x2, #8
               	lsr	x6, x1, #56
               	orr	x5, x5, x6
               	ldr	x6, [x0]
               	ldr	x7, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x6, x6, x17
               	mov	x17, #0xf00000000000    // =263882790666240
               	movk	x17, #0xffff, lsl #48
               	and	x7, x7, x17
               	orr	x3, x6, x3
               	orr	x5, x7, x5
               	str	x3, [x0]
               	str	x5, [x0, #0x8]
               	sub	x0, x29, #0x8f0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x9f0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	lsr	x2, x0, #8
               	lsr	x1, x1, #8
               	lsl	x0, x0, #56
               	orr	x1, x1, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	sub	x0, x29, #0x900
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x2000             // =8192
               	mov	x3, #0x35               // =53
               	mov	x2, x1
               	mov	x16, x3
               	mov	x3, x4
               	mov	x4, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9f0
               	ldrb	w0, [x0]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x38               // =56
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa00
               	ldr	w1, [x0]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x1f              // =31
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x0, x29, #0xa00
               	mov	x3, #0x1                // =1
               	sub	x2, x29, #0x910
               	str	x3, [x2]
               	mov	x1, #0x0                // =0
               	str	x1, [x2, #0x8]
               	lsl	x4, x3, #59
               	lsl	x2, x1, #59
               	lsr	x3, x3, #5
               	orr	x5, x2, x3
               	sub	x2, x29, #0x920
               	str	x4, [x2]
               	str	x5, [x2, #0x8]
               	mov	x17, #0xb               // =11
               	orr	x3, x4, x17
               	orr	x4, x5, x1
               	sub	x2, x29, #0x930
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	sub	x2, x29, #0x940
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x2, x3, x17
               	lsl	x3, x2, #5
               	lsr	x4, x2, #59
               	orr	x4, x1, x4
               	ldr	x5, [x0]
               	ldr	x6, [x0, #0x8]
               	mov	x17, #0x1f              // =31
               	and	x5, x5, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x6, x6, x17
               	orr	x3, x5, x3
               	orr	x4, x6, x4
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x950
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa00
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0x1               // =1
               	movk	x17, #0xffe0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0x1f, lsl #16
               	orr	x2, x2, x17
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa00
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	lsr	x2, x2, #5
               	lsl	x0, x0, #59
               	orr	x0, x2, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x2, x0, x17
               	sub	x0, x29, #0x960
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x2, #0xb                // =11
               	movk	x2, #0x800, lsl #48
               	mov	x3, #0x39               // =57
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa00
               	ldr	w0, [x0]
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	x0, #0x1f
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa00
               	ldr	x0, [x0, #0x8]
               	asr	x0, x0, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3c               // =60
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa10
               	mov	x2, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x2a0
               	str	x2, [x3]
               	str	x0, [x3, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	ldr	x4, [x1, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x5, x0, x2
               	orr	x4, x4, x3
               	str	x5, [x1]
               	str	x4, [x1, #0x8]
               	sub	x1, x29, #0x2b0
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0xa10
               	sub	x3, x29, #0xa10
               	ldr	x4, [x3]
               	ldr	x3, [x3, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x5, x3, x17
               	sub	x3, x29, #0x2c0
               	str	x4, [x3]
               	str	x5, [x3, #0x8]
               	sub	x3, x29, #0x2d0
               	str	x2, [x3]
               	str	x0, [x3, #0x8]
               	lsl	x6, x2, #26
               	sub	x3, x29, #0x2e0
               	str	x0, [x3]
               	str	x6, [x3, #0x8]
               	add	x3, x4, x0
               	cmp	x3, x4
               	cset	x4, lo
               	add	x5, x5, x6
               	add	x5, x5, x4
               	sub	x4, x29, #0x2f0
               	str	x3, [x4]
               	str	x5, [x4, #0x8]
               	sub	x4, x29, #0x300
               	str	x3, [x4]
               	str	x5, [x4, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x5, x17
               	ldr	x5, [x1, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x5, x5, x17
               	orr	x0, x0, x3
               	orr	x5, x5, x4
               	str	x0, [x1]
               	str	x5, [x1, #0x8]
               	sub	x0, x29, #0x310
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	sub	x0, x29, #0x320
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x1, #0x4000000          // =67108864
               	mov	x3, #0x3d               // =61
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	sub	x2, x29, #0xa10
               	ldr	x1, [x2]
               	ldr	x2, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x5, x2, x17
               	sub	x2, x29, #0x330
               	str	x1, [x2]
               	str	x5, [x2, #0x8]
               	mov	x2, #0x3                // =3
               	mov	x3, #0x0                // =0
               	mul	x4, x1, x2
               	mov	w6, w1
               	lsr	x7, x1, #32
               	mul	x8, x6, x2
               	lsr	x8, x8, #32
               	mul	x9, x7, x2
               	add	x8, x9, x8
               	mov	w9, w8
               	lsr	x8, x8, #32
               	mul	x6, x6, x3
               	add	x6, x6, x9
               	lsr	x6, x6, #32
               	mul	x7, x7, x3
               	add	x7, x7, x8
               	add	x6, x7, x6
               	mul	x1, x1, x3
               	mul	x5, x5, x2
               	add	x1, x6, x1
               	add	x5, x1, x5
               	sub	x1, x29, #0x340
               	str	x4, [x1]
               	str	x5, [x1, #0x8]
               	sub	x1, x29, #0x350
               	str	x4, [x1]
               	str	x5, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x5, x17
               	ldr	x5, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x5, x5, x17
               	orr	x3, x3, x4
               	orr	x5, x5, x1
               	str	x3, [x0]
               	str	x5, [x0, #0x8]
               	sub	x0, x29, #0x360
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	sub	x0, x29, #0x370
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x1, #0xc000000          // =201326592
               	mov	x3, #0x40               // =64
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	sub	x1, x29, #0xa10
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x1, x17
               	sub	x1, x29, #0x380
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	cmp	x2, #0x1
               	cset	x1, lo
               	sub	x2, x2, #0x1
               	sub	x3, x3, #0x0
               	sub	x3, x3, x1
               	sub	x1, x29, #0x390
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x3a0
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0x0               // =0
               	orr	x4, x2, x17
               	orr	x3, x3, x1
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x3b0
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x3c0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xc000000          // =201326592
               	mov	x2, #0x2                // =2
               	mov	x3, #0x43               // =67
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	sub	x1, x29, #0xa10
               	ldr	x3, [x1]
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x1, x17
               	sub	x1, x29, #0x3d0
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	lsl	x2, x3, #5
               	lsl	x1, x4, #5
               	lsr	x3, x3, #59
               	orr	x3, x1, x3
               	sub	x1, x29, #0x3e0
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x3f0
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0x0               // =0
               	orr	x4, x2, x17
               	orr	x3, x3, x1
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x400
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x410
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x80000000         // =2147483648
               	movk	x1, #0x1, lsl #32
               	mov	x2, #0x40               // =64
               	mov	x3, #0x46               // =70
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	sub	x1, x29, #0xa10
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	sub	x1, x29, #0x420
               	str	x4, [x1]
               	str	x2, [x1, #0x8]
               	asr	x3, x2, #3
               	lsr	x1, x4, #3
               	lsl	x2, x2, #61
               	orr	x2, x1, x2
               	sub	x1, x29, #0x430
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x440
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0x0               // =0
               	orr	x4, x2, x17
               	orr	x3, x3, x1
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x450
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x460
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x30000000         // =805306368
               	mov	x2, #0x8                // =8
               	mov	x3, #0x49               // =73
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	sub	x1, x29, #0xa10
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x1, x17
               	sub	x1, x29, #0x470
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x4, #0xff               // =255
               	mov	x5, #0x0                // =0
               	orr	x2, x2, x4
               	orr	x3, x3, x5
               	sub	x1, x29, #0x480
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x490
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x5, x5, x2
               	orr	x3, x3, x1
               	str	x5, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x4a0
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x4b0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x30000000         // =805306368
               	mov	x3, #0x4c               // =76
               	mov	x2, x1
               	mov	x16, x3
               	mov	x3, x4
               	mov	x4, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	sub	x1, x29, #0xa10
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x1, x17
               	sub	x1, x29, #0x4c0
               	str	x2, [x1]
               	str	x4, [x1, #0x8]
               	mov	x5, #0xf                // =15
               	sub	x1, x29, #0x4d0
               	str	x5, [x1]
               	mov	x3, #0x0                // =0
               	str	x3, [x1, #0x8]
               	mvn	x5, x5
               	mvn	x6, x3
               	sub	x1, x29, #0x4e0
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	and	x2, x2, x5
               	and	x4, x4, x6
               	sub	x1, x29, #0x4f0
               	str	x2, [x1]
               	str	x4, [x1, #0x8]
               	sub	x1, x29, #0x500
               	str	x2, [x1]
               	str	x4, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x4, x17
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x3, x3, x2
               	orr	x4, x4, x1
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x510
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x520
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x30000000         // =805306368
               	mov	x2, #0xf0               // =240
               	mov	x3, #0x4f               // =79
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	sub	x1, x29, #0xa10
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x1, x17
               	sub	x1, x29, #0x530
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x4, #0x0                // =0
               	mov	x17, #0x55              // =85
               	eor	x2, x2, x17
               	eor	x3, x3, x4
               	sub	x1, x29, #0x540
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x550
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x4, x4, x2
               	orr	x3, x3, x1
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x560
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x570
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x30000000         // =805306368
               	mov	x2, #0xa5               // =165
               	mov	x3, #0x52               // =82
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0xa10
               	sub	x0, x29, #0xa10
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x0, x17
               	sub	x0, x29, #0x580
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	asr	x8, x1, #63
               	eor	x0, x2, x8
               	eor	x1, x1, x8
               	cmp	x0, x8
               	cset	x2, lo
               	sub	x3, x0, x8
               	sub	x0, x1, x8
               	sub	x1, x0, x2
               	mov	x7, #0x7                // =7
               	mov	x9, #0x0                // =0
               	orr	x0, x1, x9
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x4, x3
               	mov	x3, x0
               	b	<addr>
               	lsr	x5, x1, #63
               	lsl	x6, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	orr	x3, x6, x5
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x5, eq
               	cmp	x3, #0x7
               	cset	x6, lo
               	and	x5, x5, x6
               	orr	x4, x4, x5
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x5, #0x0                // =0
               	sub	x5, x5, x4
               	and	x6, x7, x5
               	and	x5, x9, x5
               	cmp	x3, x6
               	cset	x11, lo
               	sub	x3, x3, x6
               	sub	x0, x0, x5
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x17, #0x0               // =0
               	eor	x2, x8, x17
               	eor	x4, x4, x2
               	eor	x5, x1, x2
               	cmp	x4, x2
               	cset	x6, lo
               	sub	x1, x4, x2
               	sub	x2, x5, x2
               	sub	x2, x2, x6
               	sub	x0, x29, #0x250
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x260
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	ldr	x0, [x12, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x0               // =0
               	orr	x3, x1, x17
               	orr	x0, x0, x2
               	str	x3, [x12]
               	str	x0, [x12, #0x8]
               	sub	x0, x29, #0x270
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x280
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x6db6             // =28086
               	movk	x1, #0x6db, lsl #16
               	mov	x2, #0xdb85             // =56197
               	movk	x2, #0x6db6, lsl #16
               	movk	x2, #0xb6db, lsl #32
               	movk	x2, #0xdb6d, lsl #48
               	mov	x3, #0x55               // =85
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0xa10
               	sub	x0, x29, #0xa10
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x0, x17
               	sub	x0, x29, #0x290
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	asr	x8, x1, #63
               	eor	x0, x2, x8
               	eor	x1, x1, x8
               	cmp	x0, x8
               	cset	x2, lo
               	sub	x3, x0, x8
               	sub	x0, x1, x8
               	sub	x1, x0, x2
               	mov	x5, #0x4243             // =16963
               	movk	x5, #0xf, lsl #16
               	mov	x9, #0x0                // =0
               	orr	x0, x1, x9
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
               	lsl	x10, x4, #1
               	lsl	x1, x1, #1
               	lsr	x4, x4, #63
               	orr	x1, x1, x4
               	cmp	x0, #0x0
               	cset	x4, lo
               	cmp	x0, #0x0
               	cset	x6, eq
               	cmp	x3, x5
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x4, x4, x6
               	mov	x17, #0x1               // =1
               	eor	x4, x4, x17
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x4
               	and	x7, x5, x6
               	and	x6, x9, x6
               	cmp	x3, x7
               	cset	x11, lo
               	sub	x3, x3, x7
               	sub	x0, x0, x6
               	sub	x0, x0, x11
               	orr	x4, x10, x4
               	sub	x2, x2, #0x1
               	cbnz	x2, <addr>
               	eor	x1, x3, x8
               	eor	x0, x0, x8
               	cmp	x1, x8
               	cset	x2, lo
               	sub	x1, x1, x8
               	sub	x0, x0, x8
               	sub	x2, x0, x2
               	sub	x0, x29, #0xc0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xd0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	ldr	x0, [x12, #0x8]
               	mov	x3, #0x0                // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	orr	x4, x3, x1
               	orr	x0, x0, x2
               	str	x4, [x12]
               	str	x0, [x12, #0x8]
               	sub	x0, x29, #0xe0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0xf0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x2, #0x47c3             // =18371
               	movk	x2, #0x2, lsl #16
               	mov	x1, #0x58               // =88
               	mov	x4, x1
               	mov	x16, x3
               	mov	x3, x2
               	mov	x2, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x100
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	mvn	x3, x1
               	mvn	x4, x1
               	sub	x2, x29, #0x110
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	sub	x2, x29, #0x120
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x4, x17
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x5, x1, x3
               	orr	x4, x4, x2
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x130
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x3, x17
               	sub	x3, x29, #0x140
               	str	x2, [x3]
               	str	x4, [x3, #0x8]
               	add	x3, x2, #0x1
               	cmp	x3, x2
               	cset	x2, lo
               	add	x4, x4, #0x0
               	add	x2, x4, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x5, x1, x3
               	orr	x4, x4, x2
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x150
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	sub	x0, x29, #0x160
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #0x5b               // =91
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa10
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x170
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x4, x0, x0
               	orr	x3, x3, x2
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x180
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0xa10
               	ldr	x3, [x1]
               	ldr	x4, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x5, x4, x17
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	sub	x2, x3, #0x1
               	cmp	x2, x3
               	cset	x3, lo
               	sub	x5, x5, #0x1
               	add	x3, x5, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x0, x0, x2
               	orr	x4, x4, x3
               	str	x0, [x1]
               	str	x4, [x1, #0x8]
               	sub	x0, x29, #0x190
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x1a0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xf, lsl #32
               	mov	x3, #0x5e               // =94
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x6
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x3, #0x5                // =5
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x1b0
               	str	x3, [x2]
               	str	x1, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x5, x1, x3
               	orr	x4, x4, x2
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x1c0
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x4, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x6, x2, x17
               	sub	x2, x29, #0x1d0
               	str	x4, [x2]
               	str	x6, [x2, #0x8]
               	add	x5, x4, #0x1
               	cmp	x5, x4
               	cset	x4, lo
               	add	x6, x6, #0x0
               	add	x4, x6, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x4, x17
               	ldr	x6, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x6, x6, x17
               	orr	x7, x1, x5
               	orr	x6, x6, x4
               	str	x7, [x0]
               	str	x6, [x0, #0x8]
               	sub	x0, x29, #0x1e0
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	mov	x0, #0x61               // =97
               	mov	x4, x0
               	mov	x0, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x1f0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x6                // =6
               	mov	x3, #0x64               // =100
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x3, #0x5                // =5
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x200
               	str	x3, [x2]
               	str	x1, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x5, x1, x3
               	orr	x4, x4, x2
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x210
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x5, x4, x17
               	add	x2, x3, #0x1
               	cmp	x2, x3
               	cset	x3, lo
               	add	x5, x5, #0x0
               	add	x3, x5, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	orr	x5, x1, x2
               	orr	x4, x4, x3
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x220
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	mov	x2, #0x6                // =6
               	mov	x3, #0x67               // =103
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x9a0
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x230
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x4, x0, x0
               	orr	x3, x3, x2
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	sub	x1, x29, #0x240
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x9a0
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	orr	x0, x2, x0
               	mov	x17, #0x3e8000000000    // =68719476736000
               	orr	x2, x3, x17
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x0, x29, #0x9a0
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x3e8
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x9a0
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	cmp	x0, #0xbb8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6b               // =107
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9a0
               	sub	x1, x29, #0x9a0
               	ldr	x1, [x1, #0x8]
               	lsr	x1, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x1, x17
               	add	x1, x1, #0x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x1, x17
               	lsl	x1, x1, #36
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	orr	x1, x3, x1
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x9a0
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x3ef
               	b.eq	<addr>
               	mov	x0, #0x6c               // =108
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9a0
               	ldr	x4, [x0]
               	ldr	x1, [x0, #0x8]
               	lsr	x2, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	add	x3, x2, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x3, x17
               	lsl	x2, x2, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0x0               // =0
               	orr	x3, x4, x17
               	orr	x1, x1, x2
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x9a0
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x3f0
               	b.eq	<addr>
               	mov	x0, #0x6d               // =109
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x970
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xa0
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x4, x0, x0
               	orr	x3, x3, x2
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	lsl	x3, x0, #28
               	lsl	x1, x2, #28
               	lsr	x2, x0, #36
               	orr	x1, x1, x2
               	asr	x2, x1, #28
               	lsr	x3, x3, #28
               	lsl	x1, x1, #36
               	orr	x3, x3, x1
               	sub	x1, x29, #0xb0
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x970
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	orr	x0, x2, x0
               	mov	x17, #0xffb000000000    // =281131379326976
               	movk	x17, #0xffff, lsl #48
               	orr	x2, x3, x17
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x0, x29, #0x970
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #36
               	asr	x1, x0, #36
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x970
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #36
               	asr	x1, x0, #36
               	cmp	x1, #0x0
               	cset	x0, lt
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x6e               // =110
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9a0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x0                // =0
               	mov	x3, #0x6f               // =111
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x1, x29, #0x20
               	str	x2, [x1]
               	mov	x0, #0x0                // =0
               	str	x0, [x1, #0x8]
               	lsl	x2, x2, #16
               	sub	x1, x29, #0x30
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	mov	x4, #0x99               // =153
               	orr	x3, x0, x4
               	orr	x2, x2, x0
               	sub	x1, x29, #0x40
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	sub	x2, x29, #0x980
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x990
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x980
               	ldr	x3, [x1]
               	ldr	x5, [x1, #0x8]
               	sub	x1, x29, #0x50
               	str	x3, [x1]
               	str	x5, [x1, #0x8]
               	sub	x2, x29, #0x990
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x5, x5, x17
               	ldr	x1, [x2, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x6, x0, x3
               	orr	x1, x1, x5
               	str	x6, [x2]
               	str	x1, [x2, #0x8]
               	sub	x1, x29, #0x60
               	str	x3, [x1]
               	str	x5, [x1, #0x8]
               	mov	x2, #0x123              // =291
               	sub	x1, x29, #0x70
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x990
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	lsl	x2, x2, #36
               	ldr	x3, [x1]
               	ldr	x5, [x1, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x5, x5, x17
               	orr	x0, x3, x0
               	orr	x2, x5, x2
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x0, x29, #0x990
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x80
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x10000            // =65536
               	mov	x3, #0x72               // =114
               	mov	x2, x1
               	mov	x16, x3
               	mov	x3, x4
               	mov	x4, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x990
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x2, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x0, x17
               	sub	x0, x29, #0x90
               	str	x1, [x0]
               	asr	x1, x1, #63
               	str	x1, [x0, #0x8]
               	mov	x1, #0x123              // =291
               	mov	x3, #0x75               // =117
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	udiv	x4, x3, x5
               	udiv	x17, x3, x5
               	msub	x3, x17, x5, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	udiv	x4, x3, x7
               	udiv	x17, x3, x7
               	msub	x3, x17, x7, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
