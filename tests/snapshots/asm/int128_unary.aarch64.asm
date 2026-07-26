
int128_unary.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x170
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffffff0
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x78
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	mov	x2, sp
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	lsl	x3, x3, #36
               	sub	x1, x29, #0x98
               	str	x0, [x1]
               	str	x3, [x1, #0x8]
               	add	x3, sp, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	mov	x1, sp
               	ldr	x3, [x1]
               	ldr	x1, [x1, #0x8]
               	eor	x3, x3, x0
               	eor	x0, x1, x0
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, sp, #0x10
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x3, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, sp
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mvn	x1, x1
               	mvn	x4, x0
               	cmp	x1, x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	cmp	x4, x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x10
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	cmp	x1, #0x0
               	cset	x4, hi
               	sub	x1, x0, x1
               	sub	x0, x0, x3
               	sub	x3, x0, x4
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, sp
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x10
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x3, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, sp
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, sp, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, sp
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x1, x1, x0
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	add	x0, sp, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x1, x1, x0
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, sp
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x1, x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, sp, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x1, x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2]
               	cbz	x0, <addr>
               	add	x0, sp, #0x10
               	add	x1, sp, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, sp, #0x20
               	ldr	x1, [x0]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x1, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x2]
               	mov	x2, #0x0                // =0
               	cmp	x1, #0x0
               	cset	x0, hi
               	sub	x3, x2, x1
               	mov	x1, #0x0                // =0
               	sub	x1, x1, x0
               	asr	x5, x1, #4
               	lsr	x0, x3, #4
               	lsl	x2, x1, #60
               	orr	x2, x0, x2
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	cmp	x2, x4
               	cset	x2, ne
               	cbnz	x2, <addr>
               	cmp	x5, x4
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x10
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x1
               	cset	x4, lo
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x2, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x170
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, sp
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
