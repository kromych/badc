
int128_unary.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	mov	x4, #0x0                // =0
               	sub	x0, x29, #0x28
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	cmp	x1, x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	b	<addr>

<main>:
               	str	x20, [sp, #-0xf0]!
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x60
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	sub	x2, x29, #0xb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x2, [x20]
               	sub	x1, x29, #0x70
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	lsl	x2, x2, #36
               	sub	x1, x29, #0x80
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x2, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0xb0
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	eor	x2, x2, x0
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xc0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xb0
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mvn	x2, x2
               	mvn	x3, x0
               	sub	x0, x29, #0x40
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #0x2                // =2
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc0
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x0                // =0
               	cmp	x2, #0x0
               	cset	x3, hi
               	sub	x2, x1, x2
               	sub	x0, x1, x0
               	sub	x3, x0, x3
               	sub	x0, x29, #0x50
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	mov	x2, #0xfff000000000     // =281406257233920
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x3                // =3
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xb0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xb0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xc0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xb0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x1, x1, x0
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xc0
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
               	sub	x0, x29, #0xb0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x1, x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xc0
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
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	ldr	x0, [x20]
               	cbz	x0, <addr>
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x90
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1000000000       // =68719476736
               	mov	x3, #0x8                // =8
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	ldr	x2, [x20]
               	sub	x0, x29, #0x10
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	cmp	x2, #0x0
               	cset	x0, hi
               	sub	x2, x1, x2
               	sub	x1, x1, x1
               	sub	x1, x1, x0
               	sub	x0, x29, #0x20
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x2, x0, #4
               	lsr	x1, x1, #4
               	lsl	x0, x0, #60
               	orr	x1, x1, x0
               	sub	x0, x29, #0x30
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0x9                // =9
               	mov	x2, x1
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xa0
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x1
               	cset	x4, lo
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x3, x2
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xb0
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
               	b	<addr>
