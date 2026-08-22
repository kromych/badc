
int128_unary.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xd0
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x60
               	str	x0, [x3]
               	str	x0, [x3, #0x8]
               	sub	x1, x29, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x2, [x4]
               	lsl	x2, x2, #36
               	str	x0, [x3]
               	str	x2, [x3, #0x8]
               	sub	x2, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	ldr	x3, [x1]
               	ldr	x5, [x1, #0x8]
               	eor	x3, x3, x0
               	eor	x5, x5, x0
               	orr	x3, x3, x5
               	cmp	x3, #0x0
               	cset	x3, eq
               	cmp	x3, #0x1
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldr	x3, [x2]
               	ldr	x5, [x2, #0x8]
               	eor	x3, x3, x0
               	eor	x5, x5, x0
               	orr	x3, x3, x5
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x1]
               	ldr	x6, [x1, #0x8]
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mvn	x3, x3
               	mvn	x6, x6
               	cmp	x3, x5
               	cset	x3, ne
               	cbnz	x3, <addr>
               	cmp	x6, x5
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x3, #0x2                // =2
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x2]
               	ldr	x6, [x2, #0x8]
               	cmp	x3, #0x0
               	cset	x7, hi
               	sub	x5, x0, x3
               	sub	x3, x0, x6
               	sub	x6, x3, x7
               	cmp	x5, #0x0
               	cset	x3, ne
               	cbnz	x5, <addr>
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	cmp	x6, x17
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x3, #0x3                // =3
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x1]
               	ldr	x5, [x1, #0x8]
               	orr	x3, x3, x5
               	cbz	x3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	eor	x3, x3, x0
               	eor	x2, x2, x0
               	orr	x2, x3, x2
               	cbnz	x2, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	orr	x1, x2, x1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
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
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	orr	x1, x1, x2
               	mov	x3, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x1, x29, #0xc0
               	ldr	x5, [x1]
               	ldr	x1, [x1, #0x8]
               	orr	x1, x5, x1
               	cbz	x1, <addr>
               	mov	x1, x2
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	ldr	x1, [x0]
               	ldr	x5, [x0, #0x8]
               	orr	x1, x1, x5
               	cbnz	x1, <addr>
               	mov	x1, x3
               	cbnz	x1, <addr>
               	sub	x1, x29, #0xc0
               	ldr	x5, [x1]
               	ldr	x1, [x1, #0x8]
               	orr	x1, x5, x1
               	cbnz	x1, <addr>
               	mov	x2, x3
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x4]
               	cbz	x1, <addr>
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	cmp	x2, #0x0
               	cset	x0, ne
               	cbnz	x2, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x4]
               	mov	x0, #0x0                // =0
               	cmp	x1, #0x0
               	cset	x2, hi
               	sub	x3, x0, x1
               	sub	x1, x0, x2
               	asr	x5, x1, #4
               	lsr	x2, x3, #4
               	lsl	x4, x1, #60
               	orr	x2, x2, x4
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
               	mov	x2, #0x9                // =9
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xc0
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0x8]
               	cmp	x2, x1
               	cset	x5, lo
               	cmp	x2, x1
               	cset	x1, eq
               	cmp	x4, x3
               	cset	x2, lo
               	and	x1, x1, x2
               	orr	x1, x5, x1
               	cbnz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
