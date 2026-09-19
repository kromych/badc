
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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x5, [x0]
               	mov	x6, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	orr	x4, x6, x0
               	mov	x10, #-0x8000000000000000 // =-9223372036854775808
               	mov	x13, #0x1               // =1
               	mov	x0, x6
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	lsl	x2, x0, #2
               	add	x1, x1, x2
               	ldrsw	x7, [x1]
               	and	x11, x7, #0x7f
               	and	x1, x7, #0x3f
               	mov	x2, #0x3f               // =63
               	sub	x12, x2, x1
               	lsr	x2, x11, #6
               	sub	x8, x6, x2
               	mvn	x2, x8
               	lsl	x3, x4, x1
               	lsr	x9, x4, x12
               	lsr	x9, x9, #1
               	lsl	x14, x5, x1
               	orr	x9, x14, x9
               	and	x14, x3, x2
               	and	x9, x9, x2
               	and	x3, x3, x8
               	orr	x15, x9, x3
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	lsl	x3, x0, #3
               	add	x9, x9, x3
               	ldr	x20, [x9]
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	add	x9, x9, x3
               	ldr	x21, [x9]
               	add	x9, x0, #0x14
               	cmp	x14, x20
               	b.ne	<addr>
               	cmp	x15, x21
               	b.eq	<addr>
               	cbnz	x9, <addr>
               	lsr	x9, x5, x1
               	lsl	x12, x5, x12
               	lsl	x12, x12, #1
               	lsr	x1, x4, x1
               	orr	x1, x1, x12
               	and	x1, x1, x2
               	and	x8, x9, x8
               	orr	x8, x1, x8
               	and	x2, x9, x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x3
               	ldr	x9, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x3
               	ldr	x3, [x1]
               	add	x1, x0, #0x1e
               	cmp	x8, x9
               	b.ne	<addr>
               	cmp	x2, x3
               	b.eq	<addr>
               	cbnz	x1, <addr>
               	and	x1, x7, #0x3f
               	mov	x2, #0x3f               // =63
               	sub	x9, x2, x1
               	lsr	x2, x11, #6
               	mov	x3, #0x0                // =0
               	sub	x2, x3, x2
               	mvn	x7, x2
               	asr	x8, x10, x1
               	lsl	x9, x10, x9
               	lsl	x9, x9, #1
               	lsr	x1, x13, x1
               	orr	x1, x1, x9
               	and	x1, x1, x7
               	and	x9, x8, x2
               	orr	x9, x1, x9
               	and	x1, x8, x7
               	orr	x2, x1, x2
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	lsl	x1, x0, #3
               	add	x7, x7, x1
               	ldr	x7, [x7]
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	add	x1, x8, x1
               	ldr	x8, [x1]
               	add	x1, x0, #0x28
               	cmp	x9, x7
               	b.ne	<addr>
               	cmp	x2, x8
               	b.eq	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x9, x6
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	lsl	x1, x4, #1
               	lsl	x0, x5, #1
               	lsr	x2, x4, #63
               	orr	x0, x0, x2
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
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	lsl	x2, x4, #63
               	lsl	x0, x5, #63
               	lsr	x3, x4, #1
               	orr	x3, x0, x3
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0xb33b            // =45883
               	movk	x17, #0xa22a, lsl #16
               	movk	x17, #0x9119, lsl #32
               	movk	x17, #0x8008, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0x6677            // =26231
               	movk	x17, #0x4455, lsl #16
               	movk	x17, #0x2233, lsl #32
               	movk	x17, #0x11, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0xccee            // =52462
               	movk	x17, #0x88aa, lsl #16
               	movk	x17, #0x4466, lsl #32
               	movk	x17, #0x22, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	lsr	x0, x5, #1
               	mov	x17, #0xb33b            // =45883
               	movk	x17, #0xa22a, lsl #16
               	movk	x17, #0x9119, lsl #32
               	movk	x17, #0x8008, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	mov	x17, #0xf77f            // =63359
               	movk	x17, #0xe66e, lsl #16
               	movk	x17, #0xd55d, lsl #32
               	movk	x17, #0x444c, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0xeeff            // =61183
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	lsr	x0, x5, #63
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0xc
               	ldrsw	x1, [x1]
               	and	x2, x1, #0x7f
               	and	x1, x1, #0x3f
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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	cmp	x1, x3
               	b.ne	<addr>
               	cbz	x2, <addr>
               	mov	x1, #0xd                // =13
               	cbz	x1, <addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
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
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, x9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
