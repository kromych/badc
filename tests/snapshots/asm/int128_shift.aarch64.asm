
int128_shift.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x25, <page>
               	add	x25, x25, <lo12>
               	ldr	x1, [x25]
               	orr	x4, x2, x1
               	orr	x9, x0, x2
               	mov	x20, #0x1               // =1
               	mov	x11, #-0x8000000000000000 // =-9223372036854775808
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	lsl	x3, x0, #2
               	add	x1, x1, x3
               	ldrsw	x1, [x1]
               	mov	x17, #0x7f              // =127
               	and	x12, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x1, x17
               	mov	x13, #0x3f              // =63
               	sub	x14, x13, x3
               	lsr	x15, x12, #6
               	mov	x10, #0x0               // =0
               	sub	x6, x10, x15
               	mvn	x7, x6
               	lsl	x5, x4, x3
               	lsr	x8, x4, x14
               	lsr	x8, x8, #1
               	lsl	x21, x9, x3
               	orr	x8, x21, x8
               	and	x21, x5, x7
               	mov	x17, #0x0               // =0
               	orr	x21, x21, x17
               	and	x8, x8, x7
               	and	x5, x5, x6
               	orr	x22, x8, x5
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	lsl	x5, x0, #3
               	add	x8, x8, x5
               	ldr	x8, [x8]
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	add	x5, x23, x5
               	ldr	x23, [x5]
               	add	x5, x0, #0x14
               	sxtw	x5, w5
               	cmp	x21, x8
               	cset	x8, ne
               	cbnz	x8, <addr>
               	cmp	x22, x23
               	cset	x8, ne
               	cbz	x8, <addr>
               	cbnz	x5, <addr>
               	lsr	x5, x9, x3
               	lsl	x8, x9, x14
               	lsl	x8, x8, #1
               	lsr	x3, x4, x3
               	orr	x3, x3, x8
               	and	x3, x3, x7
               	and	x6, x5, x6
               	orr	x6, x3, x6
               	and	x3, x5, x7
               	mov	x17, #0x0               // =0
               	orr	x7, x3, x17
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	lsl	x5, x0, #3
               	add	x3, x3, x5
               	ldr	x8, [x3]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, x5
               	ldr	x10, [x3]
               	add	x3, x0, #0x1e
               	sxtw	x3, w3
               	cmp	x6, x8
               	cset	x6, ne
               	cbnz	x6, <addr>
               	cmp	x7, x10
               	cset	x6, ne
               	cbz	x6, <addr>
               	cbnz	x3, <addr>
               	mov	x17, #0x7f              // =127
               	and	x3, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	mov	x6, #0x3f               // =63
               	sub	x10, x6, x1
               	lsr	x3, x3, #6
               	mov	x6, #0x0                // =0
               	sub	x3, x6, x3
               	mvn	x7, x3
               	asr	x8, x11, x1
               	lsl	x10, x11, x10
               	lsl	x10, x10, #1
               	lsr	x1, x20, x1
               	orr	x1, x1, x10
               	and	x1, x1, x7
               	and	x10, x8, x3
               	orr	x10, x1, x10
               	and	x1, x8, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x7, x1, x3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x5
               	ldr	x3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x5
               	ldr	x5, [x1]
               	add	x1, x0, #0x28
               	sxtw	x1, w1
               	cmp	x10, x3
               	cset	x3, ne
               	cbnz	x3, <addr>
               	cmp	x7, x5
               	cset	x3, ne
               	cbz	x3, <addr>
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, x6
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x5, x10
               	b	<addr>
               	b	<addr>
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x6
               	b.lt	<addr>
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x4, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x9, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	lsl	x0, x4, #1
               	lsl	x1, x9, #1
               	lsr	x2, x4, #63
               	orr	x1, x1, x2
               	mov	x17, #0xccee            // =52462
               	movk	x17, #0x88aa, lsl #16
               	movk	x17, #0x4466, lsl #32
               	movk	x17, #0x22, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0xddfe            // =56830
               	movk	x17, #0x99bb, lsl #16
               	movk	x17, #0x5577, lsl #32
               	movk	x17, #0x1133, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	lsl	x1, x4, #63
               	lsl	x0, x9, #63
               	lsr	x2, x4, #1
               	orr	x2, x0, x2
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0xb33b            // =45883
               	movk	x17, #0xa22a, lsl #16
               	movk	x17, #0x9119, lsl #32
               	movk	x17, #0x8008, lsl #48
               	cmp	x2, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x4, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	lsl	x0, x4, #1
               	mov	x17, #0xccee            // =52462
               	movk	x17, #0x88aa, lsl #16
               	movk	x17, #0x4466, lsl #32
               	movk	x17, #0x22, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	lsr	x1, x9, #1
               	lsr	x0, x4, #1
               	lsl	x2, x9, #63
               	orr	x0, x0, x2
               	mov	x17, #0xb33b            // =45883
               	movk	x17, #0xa22a, lsl #16
               	movk	x17, #0x9119, lsl #32
               	movk	x17, #0x8008, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0xf77f            // =63359
               	movk	x17, #0xe66e, lsl #16
               	movk	x17, #0xd55d, lsl #32
               	movk	x17, #0x444c, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x9, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	lsr	x0, x9, #63
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x2, x0
               	mov	x1, x0
               	mov	x2, x0
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0xc
               	ldrsw	x1, [x1]
               	mov	x17, #0x7f              // =127
               	and	x2, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	mov	x3, #0x3f               // =63
               	sub	x6, x3, x1
               	lsr	x2, x2, #6
               	sub	x2, x0, x2
               	mvn	x3, x2
               	lsr	x5, x4, x1
               	lsl	x4, x4, x6
               	lsl	x4, x4, #1
               	lsr	x1, x0, x1
               	orr	x1, x1, x4
               	and	x1, x1, x3
               	and	x2, x5, x2
               	orr	x1, x1, x2
               	and	x2, x5, x3
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	ldr	x3, [x25]
               	cmp	x1, x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	cmp	x2, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x1, #0xd                // =13
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
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
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sxtw	x0, w3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	sxtw	x0, w5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
