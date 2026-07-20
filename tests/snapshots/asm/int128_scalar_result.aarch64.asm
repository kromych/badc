
int128_scalar_result.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrsw	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	str	w2, [x1]
               	sub	x1, x29, #0x20
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x250
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	sub	x1, x29, #0xc8
               	str	x2, [x1]
               	mov	x0, #0x0                // =0
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0xd8
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	orr	x3, x0, x1
               	orr	x2, x2, x0
               	sub	x1, x29, #0xe8
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	sub	x2, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	sub	x1, x29, #0xf8
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x108
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	orr	x3, x0, x1
               	orr	x2, x2, x0
               	sub	x1, x29, #0x118
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	sub	x2, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x2, #0x1                // =1
               	sub	x1, x29, #0x128
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	lsl	x4, x2, #36
               	sub	x1, x29, #0x138
               	str	x0, [x1]
               	str	x4, [x1, #0x8]
               	mov	x5, #0x3039             // =12345
               	add	x3, x0, x5
               	cmp	x3, x0
               	cset	x1, lo
               	add	x4, x4, #0x0
               	add	x4, x4, x1
               	sub	x1, x29, #0x148
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	cmp	x3, #0x0
               	cset	x1, hi
               	sub	x3, x0, x3
               	sub	x4, x0, x4
               	sub	x4, x4, x1
               	sub	x1, x29, #0x158
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	sub	x3, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	sub	x1, x29, #0x168
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	lsl	x2, x2, #36
               	sub	x1, x29, #0x178
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	add	x1, x0, x5
               	cmp	x1, x0
               	cset	x0, lo
               	add	x2, x2, #0x0
               	add	x2, x2, x0
               	sub	x0, x29, #0x188
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x2, #0x2                // =2
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x1
               	cset	x5, lo
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x4, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x1, x5, x0
               	mov	x0, #0x4d               // =77
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x2                // =2
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x5, lo
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x3, x4
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x1, x5, x0
               	mov	x0, #0x4d               // =77
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x30
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x4
               	eor	x0, x3, x0
               	orr	x0, x2, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x2, #0x4d               // =77
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x30
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x4
               	eor	x0, x3, x0
               	orr	x0, x2, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x2, #0x4d               // =77
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x2                // =2
               	sub	x0, x29, #0x40
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x50
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x5, lt
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x3, x4
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x1, x5, x0
               	mov	x0, #0x4d               // =77
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x2                // =2
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x5, lo
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x3, x4
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x5, x0
               	mov	x17, #0x1               // =1
               	eor	x1, x0, x17
               	mov	x0, #0x4d               // =77
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
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
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x30
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x2
               	cset	x4, lo
               	sub	x1, x1, x2
               	sub	x0, x3, x0
               	sub	x2, x0, x4
               	sub	x0, x29, #0x1d8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	eor	x1, x1, x0
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x1
               	cset	x4, lo
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x3, x2
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x1, x4, x0
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x20
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x4, lo
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x2, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x4, lo
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x2, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x1, x4, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
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
               	cset	x0, ne
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
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
               	sub	x1, x29, #0x80
               	str	w0, [x1]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x80
               	add	x1, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x30
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x1, eq
               	sub	x0, x29, #0x80
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x80
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x80
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	ldr	x1, [x0, #0x10]
               	ldr	x2, [x0, #0x18]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x90
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x2
               	cset	x5, lo
               	cmp	x0, x2
               	cset	x0, eq
               	cmp	x4, x3
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x0, x5, x0
               	ldrsw	x0, [x1, x0, lsl #2]
               	cmp	x0, #0x14
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x1, x29, #0x90
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x2
               	cset	x5, lo
               	cmp	x0, x2
               	cset	x0, eq
               	cmp	x4, x3
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x2, x5, x0
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x3, x3, x5
               	eor	x0, x4, x0
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	add	x0, x2, x0
               	sxtw	x0, w0
               	ldrsw	x0, [x1, x0, lsl #2]
               	cmp	x0, #0x1e
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
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
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
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
               	cbz	x0, <addr>
               	mov	x0, #0x6f               // =111
               	cmp	x0, #0x6f
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x220
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	sub	x2, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	b	<addr>
               	sub	x4, x29, #0xa8
               	sub	x0, x29, #0xa8
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x3, x2, #0x1
               	cmp	x3, x2
               	cset	x2, lo
               	add	x0, x0, #0x0
               	add	x2, x0, x2
               	sub	x0, x29, #0x230
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sub	x0, x29, #0xa8
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x3, lo
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x2, #0x5
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x0, x3, x0
               	cbnz	x0, <addr>
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	mov	x17, #0x0               // =0
               	eor	x0, x0, x17
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x1
               	cset	x4, lo
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x3, x2
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x1, x4, x0
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x2, x0
               	cset	x5, lo
               	cmp	x2, x0
               	cset	x0, eq
               	cmp	x3, x4
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x2, x5, x0
               	sxtw	x0, w1
               	cmp	x0, #0x1
               	cset	x3, ne
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sxtw	x0, w2
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, x1, x2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xde               // =222
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
