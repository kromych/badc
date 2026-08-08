
int128_shift.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x13, <page>
               	add	x13, x13, <lo12>
               	ldr	x1, [x13]
               	orr	x4, x2, x1
               	orr	x6, x0, x2
               	mov	x11, #0x1               // =1
               	mov	x7, #-0x8000000000000000 // =-9223372036854775808
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	lsl	x3, x0, #2
               	add	x1, x1, x3
               	ldrsw	x1, [x1]
               	mov	x17, #0x7f              // =127
               	and	x5, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x1, x17
               	mov	x8, #0x3f               // =63
               	sub	x12, x8, x3
               	lsr	x5, x5, #6
               	mov	x8, #0x0                // =0
               	sub	x5, x8, x5
               	mvn	x9, x5
               	lsl	x10, x4, x3
               	lsr	x12, x4, x12
               	lsr	x12, x12, #1
               	lsl	x3, x6, x3
               	orr	x3, x3, x12
               	and	x12, x10, x9
               	and	x8, x8, x5
               	orr	x8, x12, x8
               	and	x3, x3, x9
               	and	x5, x10, x5
               	orr	x9, x3, x5
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	lsl	x3, x0, #3
               	add	x5, x5, x3
               	ldr	x5, [x5]
               	adrp	x10, <page>
               	add	x10, x10, <lo12>
               	add	x3, x10, x3
               	ldr	x10, [x3]
               	add	x3, x0, #0x14
               	sxtw	x3, w3
               	cmp	x8, x5
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x9, x10
               	cset	x5, ne
               	cbz	x5, <addr>
               	cbnz	x3, <addr>
               	mov	x17, #0x7f              // =127
               	and	x5, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x3, x1, x17
               	mov	x8, #0x3f               // =63
               	sub	x12, x8, x3
               	lsr	x5, x5, #6
               	mov	x8, #0x0                // =0
               	sub	x5, x8, x5
               	mvn	x9, x5
               	lsr	x10, x6, x3
               	lsl	x12, x6, x12
               	lsl	x12, x12, #1
               	lsr	x3, x4, x3
               	orr	x3, x3, x12
               	and	x3, x3, x9
               	and	x12, x10, x5
               	orr	x12, x3, x12
               	and	x3, x10, x9
               	and	x5, x8, x5
               	orr	x8, x3, x5
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	lsl	x3, x0, #3
               	add	x5, x5, x3
               	ldr	x5, [x5]
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	add	x3, x9, x3
               	ldr	x9, [x3]
               	add	x3, x0, #0x1e
               	sxtw	x3, w3
               	cmp	x12, x5
               	cset	x5, ne
               	cbnz	x5, <addr>
               	cmp	x8, x9
               	cset	x5, ne
               	cbz	x5, <addr>
               	cbnz	x3, <addr>
               	mov	x17, #0x7f              // =127
               	and	x3, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	mov	x5, #0x3f               // =63
               	sub	x9, x5, x1
               	lsr	x3, x3, #6
               	mov	x5, #0x0                // =0
               	sub	x3, x5, x3
               	mvn	x5, x3
               	asr	x8, x7, x1
               	lsl	x9, x7, x9
               	lsl	x9, x9, #1
               	lsr	x1, x11, x1
               	orr	x1, x1, x9
               	and	x1, x1, x5
               	and	x9, x8, x3
               	orr	x9, x1, x9
               	and	x1, x8, x5
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x5, x1, x3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	lsl	x1, x0, #3
               	add	x3, x3, x1
               	ldr	x3, [x3]
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	add	x1, x8, x1
               	ldr	x8, [x1]
               	add	x1, x0, #0x28
               	sxtw	x1, w1
               	cmp	x9, x3
               	cset	x3, ne
               	cbnz	x3, <addr>
               	cmp	x5, x8
               	cset	x3, ne
               	cbz	x3, <addr>
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
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
               	cmp	x6, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	lsl	x0, x4, #1
               	lsl	x1, x6, #1
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
               	ret
               	lsl	x0, x4, #63
               	lsl	x1, x6, #63
               	lsr	x2, x4, #1
               	orr	x1, x1, x2
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0xb33b            // =45883
               	movk	x17, #0xa22a, lsl #16
               	movk	x17, #0x9119, lsl #32
               	movk	x17, #0x8008, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	sxtw	x0, w0
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
               	ret
               	lsl	x0, x4, #63
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	lsr	x1, x6, #1
               	lsr	x0, x4, #1
               	lsl	x2, x6, #63
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
               	ret
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x6, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	lsr	x0, x6, #63
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
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
               	and	x4, x5, x2
               	orr	x1, x1, x4
               	and	x3, x5, x3
               	and	x0, x0, x2
               	orr	x2, x3, x0
               	ldr	x0, [x13]
               	cmp	x1, x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x2, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x0                // =0
               	ret
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
               	ret
               	sxtw	x0, w3
               	ret
               	sxtw	x0, w3
               	ret
