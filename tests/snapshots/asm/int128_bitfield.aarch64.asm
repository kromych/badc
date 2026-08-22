
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
               	ldr	x4, [x0]
               	cmp	x4, x2
               	b.eq	<addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
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
               	sub	sp, sp, #0x3c0
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	sub	x20, x29, #0x2d0
               	str	x1, [x20]
               	str	x0, [x20, #0x8]
               	mov	x1, #0x800000000        // =34359738368
               	mov	x2, #0x1234             // =4660
               	mov	x3, #0xa                // =10
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
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
               	str	x1, [x20]
               	str	x0, [x20, #0x8]
               	mov	x21, #0x0               // =0
               	mov	x2, #0x7                // =7
               	mov	x3, #0xd                // =13
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	lsr	x0, x0, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	str	x0, [x20]
               	str	x21, [x20, #0x8]
               	mov	x2, #0x9                // =9
               	mov	x3, #0x10               // =16
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x390
               	mov	x2, #0x5                // =5
               	ldr	x0, [x21, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x800000000       // =34359738368
               	orr	x22, x0, x17
               	str	x2, [x21]
               	str	x22, [x21, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x22, x17
               	str	x2, [x20]
               	str	x0, [x20, #0x8]
               	mov	x1, #0x800000000        // =34359738368
               	mov	x3, #0x14               // =20
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	mov	x2, #0x7                // =7
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x22, x17
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	str	x2, [x21]
               	str	x1, [x21, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	sub	x21, x29, #0x2d0
               	str	x2, [x21]
               	str	x0, [x21, #0x8]
               	mov	x0, #0x17               // =23
               	mov	x4, x0
               	mov	x0, x21
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x380
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	ldr	x0, [x20, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x1, x0, x17
               	str	x2, [x20]
               	str	x1, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	orr	x22, x0, x17
               	str	x2, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x22, x17
               	str	x2, [x21]
               	str	x0, [x21, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xf, lsl #32
               	mov	x3, #0x1a               // =26
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x22, #36
               	mov	x21, #0x0               // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x1, x0, x17
               	sub	x0, x29, #0x2d0
               	str	x1, [x0]
               	str	x21, [x0, #0x8]
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xfff, lsl #16
               	mov	x3, #0x1d               // =29
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x22, x17
               	mov	x17, #0x0               // =0
               	orr	x22, x0, x17
               	str	x21, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x22, x17
               	sub	x20, x29, #0x2d0
               	str	x21, [x20]
               	str	x0, [x20, #0x8]
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x21
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x22, #36
               	mov	x1, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xfff, lsl #16
               	mov	x3, #0x23               // =35
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x370
               	mov	x1, #0xcdef             // =52719
               	movk	x1, #0x89ab, lsl #16
               	movk	x1, #0x4567, lsl #32
               	movk	x1, #0x123, lsl #48
               	mov	x2, #0x3210             // =12816
               	movk	x2, #0x7654, lsl #16
               	movk	x2, #0xba98, lsl #32
               	movk	x2, #0xfedc, lsl #48
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	str	x2, [x20]
               	str	x1, [x20, #0x8]
               	mov	x3, #0x26               // =38
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x360
               	ldr	x0, [x21, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x2, #-0x1000000000000000 // =-1152921504606846976
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x0, x0, x17
               	str	x2, [x21]
               	str	x0, [x21, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x0, x17
               	mov	x17, #0xffd000000000    // =281268818280448
               	movk	x17, #0xffff, lsl #48
               	orr	x23, x0, x17
               	str	x2, [x21]
               	str	x23, [x21, #0x8]
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x23, x17
               	lsl	x0, x0, #28
               	mov	x17, #0xf000000         // =251658240
               	orr	x0, x0, x17
               	asr	x1, x0, #28
               	lsl	x0, x0, #36
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	mov	x3, #0x29               // =41
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x0, x23, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #36
               	asr	x1, x0, #36
               	sub	x20, x29, #0x2d0
               	str	x1, [x20]
               	asr	x0, x1, #63
               	str	x0, [x20, #0x8]
               	mov	x2, #0xfffd             // =65533
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x2c               // =44
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x23, x17
               	mov	x17, #0x800000000       // =34359738368
               	orr	x23, x0, x17
               	str	x22, [x21]
               	str	x23, [x21, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x23, x17
               	lsl	x0, x0, #28
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	asr	x1, x0, #28
               	lsl	x0, x0, #36
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	mov	x1, #0xfff800000000     // =281440616972288
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0x2f               // =47
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x22
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x360
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x23, x17
               	mov	x17, #0x400000000       // =17179869184
               	orr	x1, x1, x17
               	str	x22, [x0]
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
               	sub	x20, x29, #0x2d0
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	mov	x1, #0x400000000        // =17179869184
               	mov	x3, #0x32               // =50
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x22
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x350
               	mov	x0, #0xab               // =171
               	strb	w0, [x21]
               	mov	x2, #0x3                // =3
               	ldr	x0, [x21]
               	ldr	x1, [x21, #0x8]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xf00000000000    // =263882790666240
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x300             // =768
               	orr	x3, x0, x17
               	mov	x17, #0x200000          // =2097152
               	orr	x0, x1, x17
               	str	x3, [x21]
               	str	x0, [x21, #0x8]
               	lsr	x1, x0, #8
               	lsl	x0, x0, #56
               	mov	x17, #0x3               // =3
               	orr	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	mov	x1, #0x2000             // =8192
               	mov	x3, #0x35               // =53
               	mov	x0, x20
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x21]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x38               // =56
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x340
               	ldr	w0, [x20]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x1f              // =31
               	orr	x0, x0, x17
               	str	w0, [x20]
               	ldr	x0, [x20]
               	ldr	x1, [x20, #0x8]
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x1, x17
               	mov	x17, #0x160             // =352
               	orr	x1, x0, x17
               	mov	x17, #0x1               // =1
               	orr	x0, x2, x17
               	str	x1, [x20]
               	str	x0, [x20, #0x8]
               	mov	x17, #0x1               // =1
               	movk	x17, #0xffe0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0x1f, lsl #16
               	orr	x23, x0, x17
               	str	x23, [x20, #0x8]
               	lsr	x0, x1, #5
               	lsl	x1, x23, #59
               	orr	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x0, x0, x17
               	sub	x21, x29, #0x2d0
               	str	x0, [x21]
               	str	x22, [x21, #0x8]
               	mov	x2, #0xb                // =11
               	movk	x2, #0x800, lsl #48
               	mov	x3, #0x39               // =57
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [x20]
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	x0, #0x1f
               	cset	x0, ne
               	cbnz	x0, <addr>
               	asr	x0, x23, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3c               // =60
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x330
               	mov	x2, #0x1                // =1
               	ldr	x0, [x20, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	str	x2, [x20]
               	str	x0, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x0, x17
               	mov	x17, #0x4000000         // =67108864
               	add	x1, x3, x17
               	add	x3, x1, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	orr	x22, x0, x1
               	str	x2, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x23, x22, x17
               	str	x2, [x21]
               	str	x23, [x21, #0x8]
               	mov	x1, #0x4000000          // =67108864
               	mov	x3, #0x3d               // =61
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3                // =3
               	mul	x0, x23, x2
               	add	x1, x0, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x22, x17
               	orr	x22, x1, x0
               	str	x2, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x23, x22, x17
               	sub	x21, x29, #0x2d0
               	str	x2, [x21]
               	str	x23, [x21, #0x8]
               	mov	x1, #0xc000000          // =201326592
               	mov	x3, #0x40               // =64
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x23, #0x0
               	sub	x1, x0, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x22, x17
               	mov	x2, #0x2                // =2
               	orr	x22, x1, x0
               	str	x2, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x23, x22, x17
               	str	x2, [x21]
               	str	x23, [x21, #0x8]
               	mov	x1, #0xc000000          // =201326592
               	mov	x3, #0x43               // =67
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x330
               	lsl	x0, x23, #5
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x22, x17
               	mov	x2, #0x40               // =64
               	orr	x22, x1, x0
               	str	x2, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x23, x22, x17
               	sub	x21, x29, #0x2d0
               	str	x2, [x21]
               	str	x23, [x21, #0x8]
               	mov	x1, #0x80000000         // =2147483648
               	movk	x1, #0x1, lsl #32
               	mov	x3, #0x46               // =70
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x1, x23, #3
               	lsl	x0, x23, #61
               	mov	x17, #0x8               // =8
               	orr	x2, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x22, x17
               	mov	x17, #0x0               // =0
               	orr	x23, x2, x17
               	orr	x22, x1, x0
               	str	x23, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x24, x22, x17
               	str	x23, [x21]
               	str	x24, [x21, #0x8]
               	mov	x25, #0x30000000        // =805306368
               	mov	x2, #0x8                // =8
               	mov	x3, #0x49               // =73
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x25
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x330
               	mov	x2, #0xff               // =255
               	mov	x1, #0x0                // =0
               	orr	x3, x23, x2
               	orr	x4, x24, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x4, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x4, x22, x17
               	orr	x22, x1, x3
               	orr	x21, x4, x0
               	str	x22, [x20]
               	str	x21, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x23, x21, x17
               	sub	x0, x29, #0x2d0
               	str	x22, [x0]
               	str	x23, [x0, #0x8]
               	mov	x3, #0x4c               // =76
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x25
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x2, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x21, x17
               	mov	x17, #0x0               // =0
               	orr	x23, x1, x17
               	orr	x22, x2, x0
               	str	x23, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x24, x22, x17
               	sub	x21, x29, #0x2d0
               	str	x23, [x21]
               	str	x24, [x21, #0x8]
               	mov	x1, #0x30000000         // =805306368
               	mov	x2, #0xf0               // =240
               	mov	x3, #0x4f               // =79
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x330
               	mov	x1, #0x0                // =0
               	mov	x17, #0x55              // =85
               	eor	x2, x23, x17
               	eor	x3, x24, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x3, x22, x17
               	orr	x23, x1, x2
               	orr	x22, x3, x0
               	str	x23, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x24, x22, x17
               	str	x23, [x21]
               	str	x24, [x21, #0x8]
               	mov	x1, #0x30000000         // =805306368
               	mov	x2, #0xa5               // =165
               	mov	x3, #0x52               // =82
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	eor	x0, x23, x2
               	eor	x1, x24, x2
               	cmp	x0, #0x0
               	cset	x3, lo
               	sub	x4, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x0, x0, x3
               	mov	x7, #0x7                // =7
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	cbz	x1, <addr>
               	mov	x1, #0x80               // =128
               	mov	x5, x2
               	mov	x3, x4
               	mov	x4, x2
               	b	<addr>
               	lsr	x6, x0, #63
               	lsl	x8, x4, #1
               	lsl	x5, x5, #1
               	lsr	x4, x4, #63
               	orr	x5, x5, x4
               	orr	x4, x8, x6
               	lsl	x8, x3, #1
               	lsl	x0, x0, #1
               	lsr	x3, x3, #63
               	orr	x0, x0, x3
               	cmp	x5, #0x0
               	cset	x3, lo
               	cmp	x5, #0x0
               	cset	x6, eq
               	cmp	x4, #0x7
               	cset	x9, lo
               	and	x6, x6, x9
               	orr	x3, x3, x6
               	mov	x17, #0x1               // =1
               	eor	x3, x3, x17
               	sub	x6, x2, x3
               	and	x6, x7, x6
               	cmp	x4, x6
               	cset	x9, lo
               	sub	x4, x4, x6
               	sub	x5, x5, #0x0
               	sub	x5, x5, x9
               	orr	x3, x8, x3
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	mov	x21, #0x0               // =0
               	eor	x1, x3, x21
               	eor	x0, x0, x21
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
               	and	x2, x22, x17
               	mov	x17, #0x0               // =0
               	orr	x22, x1, x17
               	orr	x23, x2, x0
               	str	x22, [x20]
               	str	x23, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x20, x23, x17
               	sub	x0, x29, #0x2d0
               	str	x22, [x0]
               	str	x20, [x0, #0x8]
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
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x10, x29, #0x330
               	eor	x0, x22, x21
               	eor	x1, x20, x21
               	cmp	x0, #0x0
               	cset	x2, lo
               	sub	x3, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x0, x0, x2
               	mov	x6, #0x4243             // =16963
               	movk	x6, #0xf, lsl #16
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	cbz	x1, <addr>
               	mov	x4, #0x0                // =0
               	mov	x1, #0x80               // =128
               	mov	x5, x4
               	mov	x2, x3
               	mov	x3, x4
               	b	<addr>
               	lsr	x7, x0, #63
               	lsl	x8, x3, #1
               	lsl	x5, x5, #1
               	lsr	x3, x3, #63
               	orr	x5, x5, x3
               	orr	x3, x8, x7
               	lsl	x8, x2, #1
               	lsl	x0, x0, #1
               	lsr	x2, x2, #63
               	orr	x0, x0, x2
               	cmp	x5, #0x0
               	cset	x2, lo
               	cmp	x5, #0x0
               	cset	x7, eq
               	cmp	x3, x6
               	cset	x9, lo
               	and	x7, x7, x9
               	orr	x2, x2, x7
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	sub	x7, x4, x2
               	and	x7, x6, x7
               	cmp	x3, x7
               	cset	x9, lo
               	sub	x3, x3, x7
               	sub	x5, x5, #0x0
               	sub	x5, x5, x9
               	orr	x2, x8, x2
               	sub	x1, x1, #0x1
               	cbnz	x1, <addr>
               	eor	x0, x3, x21
               	eor	x1, x5, x21
               	cmp	x0, #0x0
               	cset	x2, lo
               	sub	x3, x0, #0x0
               	sub	x0, x1, #0x0
               	sub	x1, x0, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	mov	x22, #0x0               // =0
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x23, x17
               	orr	x1, x22, x3
               	orr	x23, x2, x0
               	str	x1, [x10]
               	str	x23, [x10, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x23, x17
               	sub	x21, x29, #0x2d0
               	str	x1, [x21]
               	str	x0, [x21, #0x8]
               	mov	x2, #0x47c3             // =18371
               	movk	x2, #0x2, lsl #16
               	mov	x3, #0x58               // =88
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x330
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x23, x17
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	orr	x0, x0, x17
               	str	x24, [x20]
               	str	x0, [x20, #0x8]
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
               	and	x0, x0, x17
               	orr	x23, x0, x1
               	str	x22, [x20]
               	str	x23, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x23, x17
               	str	x22, [x21]
               	str	x0, [x21, #0x8]
               	mov	x3, #0x5b               // =91
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x22
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x23, x17
               	mov	x25, #0x0               // =0
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	str	x25, [x20]
               	str	x0, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x0, x17
               	sub	x1, x1, #0x1
               	add	x1, x1, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	orr	x22, x0, x2
               	str	x1, [x20]
               	str	x22, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x22, x17
               	sub	x21, x29, #0x2d0
               	str	x1, [x21]
               	str	x0, [x21, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xf, lsl #32
               	mov	x3, #0x5e               // =94
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x24
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x330
               	mov	x2, #0x5                // =5
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x22, x17
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	str	x2, [x20]
               	str	x0, [x20, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x0, x17
               	str	x2, [x21]
               	str	x1, [x21, #0x8]
               	add	x1, x1, #0x0
               	add	x1, x1, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x22, #0x6               // =6
               	orr	x23, x0, x1
               	str	x22, [x20]
               	str	x23, [x20, #0x8]
               	mov	x3, #0x61               // =97
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x25
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x23, x17
               	sub	x21, x29, #0x2d0
               	str	x22, [x21]
               	str	x0, [x21, #0x8]
               	mov	x24, #0x0               // =0
               	mov	x3, #0x64               // =100
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x0, x23, x17
               	mov	x2, #0x5                // =5
               	mov	x17, #0x0               // =0
               	orr	x1, x0, x17
               	str	x2, [x20]
               	str	x1, [x20, #0x8]
               	sub	x0, x29, #0x330
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x1, x17
               	mov	x2, #0x6                // =6
               	add	x3, x3, #0x0
               	add	x3, x3, #0x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x3, x3, x17
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x3
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	str	x2, [x21]
               	str	x3, [x21, #0x8]
               	mov	x3, #0x67               // =103
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x320
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x20, #0x0               // =0
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	x20, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0x3e8000000000    // =68719476736000
               	orr	x1, x1, x17
               	str	x20, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x3, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x4, x3, x17
               	cmp	x4, #0x3e8
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x2, x20
               	cbz	x2, <addr>
               	mov	x0, #0x6b               // =107
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x4, #0x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	lsl	x2, x2, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	str	x20, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x2, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x3ef
               	b.eq	<addr>
               	mov	x0, #0x6c               // =108
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x1, x1, x17
               	mov	x17, #0x3f0000000000    // =69269232549888
               	orr	x1, x1, x17
               	str	x20, [x0]
               	str	x1, [x0, #0x8]
               	lsr	x0, x1, #36
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x3f0
               	b.eq	<addr>
               	mov	x0, #0x6d               // =109
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x310
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	str	x20, [x0]
               	str	x2, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x2, x2, x17
               	mov	x17, #0xffb000000000    // =281131379326976
               	movk	x17, #0xffff, lsl #48
               	orr	x2, x2, x17
               	str	x20, [x0]
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
               	mov	x0, x20
               	cbz	x0, <addr>
               	mov	x0, #0x6e               // =110
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	and	x0, x1, x17
               	sub	x21, x29, #0x2d0
               	str	x20, [x21]
               	str	x0, [x21, #0x8]
               	mov	x3, #0x6f               // =111
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x20
               	mov	x2, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x99               // =153
               	mov	x1, #0x10000            // =65536
               	str	x2, [x21]
               	str	x1, [x21, #0x8]
               	mov	x3, #0x72               // =114
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x123              // =291
               	str	x2, [x21]
               	mov	x22, #0x0               // =0
               	str	x22, [x21, #0x8]
               	mov	x3, #0x75               // =117
               	mov	x0, x21
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x22
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	udiv	x2, x3, x6
               	mul	x0, x2, x6
               	sub	x3, x3, x0
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	b	<addr>
               	udiv	x3, x4, x7
               	mul	x0, x3, x7
               	sub	x4, x4, x0
               	mov	x5, x2
               	mov	x0, x2
               	b	<addr>
               	b	<addr>
