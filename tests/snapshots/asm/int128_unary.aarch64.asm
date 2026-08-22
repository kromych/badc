
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
               	sub	x1, x29, #0x60
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	sub	x2, x29, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x1, [x2]
               	lsl	x3, x1, #36
               	sub	x1, x29, #0x60
               	str	x0, [x1]
               	str	x3, [x1, #0x8]
               	sub	x3, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	sub	x1, x29, #0xd0
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
               	sub	x0, x29, #0xc0
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x3, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mvn	x3, x3
               	mvn	x4, x0
               	cmp	x3, x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x4, x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	cmp	x1, #0x0
               	cset	x4, hi
               	sub	x1, x0, x1
               	sub	x0, x0, x3
               	sub	x3, x0, x4
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	mov	x17, #0xfff000000000    // =281406257233920
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x3, x0
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x1, x0
               	cbz	x0, <addr>
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
               	cset	x1, eq
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0xd0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x1, x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
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
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2]
               	cbz	x0, <addr>
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xb0
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x3, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2]
               	mov	x1, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x3, hi
               	sub	x2, x1, x0
               	mov	x0, #0x0                // =0
               	sub	x0, x0, x3
               	asr	x4, x0, #4
               	lsr	x1, x2, #4
               	lsl	x3, x0, #60
               	orr	x1, x1, x3
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	cmp	x1, x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	cmp	x4, x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x1, #0x9                // =9
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	ldr	x3, [x1]
               	ldr	x1, [x1, #0x8]
               	cmp	x1, x0
               	cset	x4, lo
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x3, x2
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0xd0
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
