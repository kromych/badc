
int128_bitfield.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<chk>:
               	sub	sp, sp, #0x30
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
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
               	ldr	x2, [x0, #0x8]
               	cmp	x2, x1
               	b.eq	<addr>
               	add	x0, x3, #0x1
               	sxtw	x0, w0
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
               	sub	sp, sp, #0xa30
               	stp	x20, x21, [sp]
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x1, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x0, x17
               	sub	x0, x29, #0x5b0
               	str	x2, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	mov	x2, #0x9                // =9
               	mov	x3, #0x10               // =16
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9b0
               	mov	x2, #0x5                // =5
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x1, x17
               	mov	x1, #0x5                // =5
               	mov	x17, #0x800000000       // =34359738368
               	orr	x20, x3, x17
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x20, x17
               	sub	x0, x29, #0x610
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x1, #0x800000000        // =34359738368
               	mov	x3, #0x14               // =20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9b0
               	mov	x3, #0x0                // =0
               	mov	x4, #0x7                // =7
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x20, x17
               	mov	x1, #0x7                // =7
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	sub	x0, x29, #0x670
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x17               // =23
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9c0
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x2, x1, x17
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x9c0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	orr	x20, x2, x17
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
               	sub	x0, x29, #0x6e0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xf, lsl #32
               	mov	x2, #0x1a               // =26
               	mov	x4, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x20, #36
               	mov	x1, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x0, x17
               	sub	x0, x29, #0x6f0
               	str	x2, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xfff, lsl #16
               	mov	x3, #0x1d               // =29
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9c0
               	mov	x2, #0x0                // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x20, x17
               	mov	x1, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x20, x3, x17
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x20, x17
               	sub	x0, x29, #0x720
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #0x20               // =32
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x20, #36
               	mov	x1, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x0, x17
               	sub	x0, x29, #0x730
               	str	x2, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xfff, lsl #16
               	mov	x3, #0x23               // =35
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9d0
               	mov	x3, #0xcdef             // =52719
               	movk	x3, #0x89ab, lsl #16
               	movk	x3, #0x4567, lsl #32
               	movk	x3, #0x123, lsl #48
               	mov	x4, #0x3210             // =12816
               	movk	x4, #0x7654, lsl #16
               	movk	x4, #0xba98, lsl #32
               	movk	x4, #0xfedc, lsl #48
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
               	sub	x0, x29, #0x790
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x26               // =38
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9e0
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
               	sub	x0, x29, #0x9e0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x2, #-0x1000000000000000 // =-1152921504606846976
               	mov	x17, #0xffd000000000    // =281268818280448
               	movk	x17, #0xffff, lsl #48
               	orr	x20, x1, x17
               	str	x2, [x0]
               	str	x20, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x20, x17
               	lsl	x0, x0, #28
               	mov	x17, #0xf000000         // =251658240
               	orr	x0, x0, x17
               	asr	x2, x0, #28
               	lsl	x0, x0, #36
               	mov	x17, #0x0               // =0
               	orr	x3, x0, x17
               	sub	x0, x29, #0x7f0
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	mov	x2, #-0x1000000000000000 // =-1152921504606846976
               	mov	x3, #0x29               // =41
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x20, #36
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9e0
               	mov	x2, #0x0                // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x20, x17
               	mov	x3, #0x0                // =0
               	mov	x17, #0x800000000       // =34359738368
               	orr	x20, x1, x17
               	str	x3, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x20, x17
               	lsl	x0, x0, #28
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	asr	x1, x0, #28
               	lsl	x0, x0, #36
               	mov	x17, #0x0               // =0
               	orr	x3, x0, x17
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9e0
               	mov	x2, #0x0                // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x20, x17
               	mov	x3, #0x0                // =0
               	mov	x17, #0x400000000       // =17179869184
               	orr	x1, x1, x17
               	str	x3, [x0]
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
               	orr	x3, x0, x17
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9f0
               	mov	x1, #0xab               // =171
               	strb	w1, [x0]
               	sub	x0, x29, #0x9f0
               	mov	x2, #0x3                // =3
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xf00000000000    // =263882790666240
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0x300             // =768
               	orr	x4, x1, x17
               	mov	x17, #0x200000          // =2097152
               	orr	x1, x3, x17
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x0, x1, #8
               	lsl	x1, x1, #56
               	mov	x17, #0x3               // =3
               	orr	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	sub	x0, x29, #0x900
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x1, #0x2000             // =8192
               	mov	x3, #0x35               // =53
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
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
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
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
               	mov	x2, #0x0                // =0
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0x160             // =352
               	orr	x1, x1, x17
               	mov	x17, #0x1               // =1
               	orr	x3, x3, x17
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0xa00
               	mov	x17, #0x1               // =1
               	movk	x17, #0xffe0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0x1f, lsl #16
               	orr	x20, x3, x17
               	str	x20, [x0, #0x8]
               	lsr	x0, x1, #5
               	lsl	x1, x20, #59
               	orr	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x1, x0, x17
               	sub	x0, x29, #0x960
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xb                // =11
               	movk	x1, #0x800, lsl #48
               	mov	x3, #0x39               // =57
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa00
               	ldr	w0, [x0]
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	x0, #0x1f
               	cset	x0, ne
               	cbnz	x0, <addr>
               	asr	x0, x20, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3c               // =60
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x3, #0x1                // =1
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x1                // =1
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x1, x17
               	mov	x17, #0x4000000         // =67108864
               	add	x2, x4, x17
               	add	x4, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x4, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x1, x17
               	mov	x1, #0x1                // =1
               	orr	x20, x4, x2
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
               	sub	x0, x29, #0x320
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x4000000          // =67108864
               	mov	x2, #0x3d               // =61
               	mov	x4, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x20, x17
               	mov	x2, #0x3                // =3
               	mul	x1, x3, x2
               	add	x3, x1, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x20, x17
               	mov	x1, #0x3                // =3
               	orr	x20, x4, x3
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x20, x17
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
               	sub	x1, x2, #0x0
               	sub	x2, x1, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x20, x17
               	mov	x1, #0x2                // =2
               	orr	x20, x3, x2
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
               	lsl	x1, x2, #5
               	mov	x17, #0x0               // =0
               	orr	x2, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x20, x17
               	mov	x1, #0x40               // =64
               	orr	x20, x3, x2
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
               	asr	x3, x2, #3
               	lsl	x1, x2, #61
               	mov	x17, #0x8               // =8
               	orr	x2, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x20, x17
               	mov	x17, #0x0               // =0
               	orr	x21, x2, x17
               	orr	x20, x3, x1
               	str	x21, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x20, x17
               	sub	x0, x29, #0x460
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x20, x17
               	mov	x2, #0xff               // =255
               	mov	x3, #0x0                // =0
               	orr	x5, x21, x2
               	orr	x4, x4, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x4, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x20, x17
               	orr	x21, x3, x5
               	orr	x20, x4, x1
               	str	x21, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x20, x17
               	sub	x0, x29, #0x4b0
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x30000000         // =805306368
               	mov	x3, #0x4c               // =76
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x20, x17
               	mov	x17, #0x0               // =0
               	orr	x21, x3, x17
               	orr	x20, x2, x1
               	str	x21, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x20, x17
               	sub	x0, x29, #0x520
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x20, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x55              // =85
               	eor	x4, x21, x17
               	eor	x3, x3, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x20, x17
               	orr	x21, x2, x4
               	orr	x20, x3, x1
               	str	x21, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x20, x17
               	sub	x0, x29, #0x570
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x9, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x20, x17
               	mov	x10, #0x0               // =0
               	eor	x0, x21, x10
               	eor	x1, x1, x10
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
               	and	x1, x20, x17
               	mov	x17, #0x0               // =0
               	orr	x21, x4, x17
               	orr	x20, x1, x0
               	str	x21, [x9]
               	str	x20, [x9, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x20, x17
               	sub	x0, x29, #0x280
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x9, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x20, x17
               	mov	x10, #0x0               // =0
               	eor	x0, x21, x10
               	eor	x1, x1, x10
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
               	eor	x1, x3, x10
               	eor	x0, x0, x10
               	cmp	x1, #0x0
               	cset	x2, lo
               	sub	x3, x1, #0x0
               	sub	x0, x0, #0x0
               	sub	x1, x0, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x1, #0x0                // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x20, x17
               	orr	x2, x1, x3
               	orr	x20, x4, x0
               	str	x2, [x9]
               	str	x20, [x9, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x20, x17
               	sub	x0, x29, #0xf0
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	mov	x2, #0x47c3             // =18371
               	movk	x2, #0x2, lsl #16
               	mov	x3, #0x58               // =88
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x2, #0x0                // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x20, x17
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x1, x1, x17
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x1, x17
               	add	x3, x3, #0x0
               	add	x3, x3, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x1, x17
               	mov	x1, #0x0                // =0
               	orr	x20, x4, x3
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x20, x17
               	sub	x0, x29, #0x160
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #0x5b               // =91
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x20, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	sub	x2, x2, #0x1
               	add	x2, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x1, x17
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	orr	x20, x4, x2
               	str	x1, [x0]
               	str	x20, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x20, x17
               	sub	x0, x29, #0x1a0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xf, lsl #32
               	mov	x2, #0x5e               // =94
               	mov	x4, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x5, #0x5                // =5
               	mov	x6, #0x0                // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x20, x17
               	mov	x3, #0x5                // =5
               	mov	x17, #0x0               // =0
               	orr	x2, x1, x17
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x4, x2, x17
               	sub	x1, x29, #0x1d0
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	add	x3, x4, #0x0
               	add	x3, x3, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x21, #0x6               // =6
               	orr	x20, x2, x3
               	str	x21, [x0]
               	str	x20, [x0, #0x8]
               	mov	x3, #0x61               // =97
               	mov	x0, x1
               	mov	x4, x3
               	mov	x3, x5
               	mov	x2, x6
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x20, x17
               	sub	x0, x29, #0x1f0
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
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
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa10
               	mov	x3, #0x0                // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x20, x17
               	mov	x2, #0x5                // =5
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	mov	x4, #0x6                // =6
               	add	x2, x2, #0x0
               	add	x2, x2, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x5, #0x6                // =6
               	orr	x1, x1, x2
               	str	x5, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x220
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	mov	x2, #0x6                // =6
               	mov	x1, #0x67               // =103
               	mov	x4, x1
               	mov	x16, x3
               	mov	x3, x2
               	mov	x2, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9a0
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x2, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x9a0
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
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9a0
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
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x9a0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x3, #0x0                // =0
               	mov	x17, #0x3f0000000000    // =69269232549888
               	orr	x1, x1, x17
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x0, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x3f0
               	b.eq	<addr>
               	mov	x0, #0x6d               // =109
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x970
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x4, #0x0                // =0
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x970
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x4, #0x0                // =0
               	mov	x17, #0xffb000000000    // =281131379326976
               	movk	x17, #0xffff, lsl #48
               	orr	x2, x2, x17
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	lsr	x0, x2, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #36
               	asr	x4, x0, #36
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x4, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x6e               // =110
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	sub	x0, x29, #0x10
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x0                // =0
               	mov	x3, #0x6f               // =111
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x99               // =153
               	mov	x1, #0x99               // =153
               	mov	x3, #0x10000            // =65536
               	sub	x0, x29, #0x80
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x1, #0x10000            // =65536
               	mov	x3, #0x72               // =114
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x123              // =291
               	sub	x0, x29, #0x90
               	str	x2, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	mov	x2, #0x123              // =291
               	mov	x3, #0x75               // =117
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0xa30
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
               	udiv	x4, x3, x6
               	udiv	x17, x3, x6
               	msub	x3, x17, x6, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
