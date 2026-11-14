
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
               	adrp	x0, <page>
               	ldr	x4, [x0, #0x18]
               	mov	x5, #0x0                // =0
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	orr	x3, x5, x0
               	mov	x8, #-0x8000000000000000 // =-9223372036854775808
               	mov	x11, #0x1               // =1
               	mov	x0, x5
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x0, lsl #2
               	ldrsw	x1, [x1]
               	and	x2, x1, #0x7f
               	and	x1, x1, #0x3f
               	mov	x6, #0x3f               // =63
               	sub	x9, x6, x1
               	lsr	x10, x2, #6
               	neg	x6, x10
               	mvn	x2, x6
               	lsl	x7, x3, x1
               	lsr	x12, x3, x9
               	lsl	x13, x4, x1
               	orr	x12, x13, x12, lsr #1
               	and	x13, x7, x2
               	and	x12, x12, x2
               	and	x7, x7, x6
               	orr	x12, x12, x7
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	ldr	x14, [x7, x0, lsl #3]
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	ldr	x15, [x7, x0, lsl #3]
               	add	x7, x0, #0x14
               	cmp	x13, x14
               	b.ne	<addr>
               	cmp	x12, x15
               	b.eq	<addr>
               	cbnz	x7, <addr>
               	lsr	x7, x4, x1
               	lsl	x9, x4, x9
               	lsr	x12, x3, x1
               	orr	x9, x12, x9, lsl #1
               	and	x9, x9, x2
               	and	x6, x7, x6
               	orr	x6, x9, x6
               	and	x7, x7, x2
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldr	x9, [x2, x0, lsl #3]
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldr	x12, [x2, x0, lsl #3]
               	add	x2, x0, #0x1e
               	cmp	x6, x9
               	b.ne	<addr>
               	cmp	x7, x12
               	b.eq	<addr>
               	cbnz	x2, <addr>
               	mov	x2, #0x3f               // =63
               	sub	x9, x2, x1
               	neg	x2, x10
               	mvn	x6, x2
               	asr	x7, x8, x1
               	lsl	x9, x8, x9
               	lsr	x1, x11, x1
               	orr	x1, x1, x9, lsl #1
               	and	x1, x1, x6
               	and	x9, x7, x2
               	orr	x9, x1, x9
               	and	x1, x7, x6
               	orr	x2, x1, x2
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x6, [x1, x0, lsl #3]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x7, [x1, x0, lsl #3]
               	add	x1, x0, #0x28
               	cmp	x9, x6
               	b.ne	<addr>
               	cmp	x2, x7
               	b.eq	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, x5
               	b	<addr>
               	mov	x7, x5
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ret
               	lsl	x1, x3, #1
               	lsl	x0, x4, #1
               	orr	x0, x0, x3, lsr #63
               	mov	x17, #0xccee            // =52462
               	movk	x17, #0x88aa, lsl #16
               	movk	x17, #0x4466, lsl #32
               	movk	x17, #0x22, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x17, #0xddfe            // =56830
               	movk	x17, #0x99bb, lsl #16
               	movk	x17, #0x5577, lsl #32
               	movk	x17, #0x1133, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	cbz	x0, <addr>
               	ret
               	lsl	x2, x3, #63
               	lsl	x0, x4, #63
               	orr	x5, x0, x3, lsr #1
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0xb33b            // =45883
               	movk	x17, #0xa22a, lsl #16
               	movk	x17, #0x9119, lsl #32
               	movk	x17, #0x8008, lsl #48
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	ret
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	ret
               	mov	x17, #0xccee            // =52462
               	movk	x17, #0x88aa, lsl #16
               	movk	x17, #0x4466, lsl #32
               	movk	x17, #0x22, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	cbz	x0, <addr>
               	ret
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	cbz	x0, <addr>
               	ret
               	lsr	x0, x4, #1
               	mov	x17, #0xb33b            // =45883
               	movk	x17, #0xa22a, lsl #16
               	movk	x17, #0x9119, lsl #32
               	movk	x17, #0x8008, lsl #48
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x17, #0xf77f            // =63359
               	movk	x17, #0xe66e, lsl #16
               	movk	x17, #0xd55d, lsl #32
               	movk	x17, #0x444c, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	cbz	x0, <addr>
               	ret
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ret
               	lsr	x0, x4, #63
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0xc]
               	and	x2, x1, #0x7f
               	and	x1, x1, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x6, x4, x1
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x4, x2
               	lsr	x5, x3, x1
               	lsl	x3, x3, x6
               	lsr	x1, x0, x1
               	orr	x1, x1, x3, lsl #1
               	and	x1, x1, x4
               	and	x2, x5, x2
               	orr	x1, x1, x2
               	and	x2, x5, x4
               	adrp	x3, <page>
               	ldr	x3, [x3, <lo12>]
               	cmp	x1, x3
               	b.ne	<addr>
               	cbz	x2, <addr>
               	mov	x1, #0xd                // =13
               	cbz	x1, <addr>
               	mov	x0, x1
               	ret
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0x8                // =8
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
               	mov	x0, x1
               	ret
               	mov	x0, x2
               	ret
               	mov	x0, x7
               	ret
