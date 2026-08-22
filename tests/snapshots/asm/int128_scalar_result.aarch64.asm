
int128_scalar_result.aarch64:	file format elf64-littleaarch64

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

<via_variadic>:
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
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
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
               	mov	x1, x16
               	ldrsw	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	mov	x3, x16
               	ldrsw	x3, [x3]
               	str	w3, [x2]
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x1c0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x1b0]
               	add	x29, sp, #0x1b0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	orr	x22, x0, x2
               	orr	x20, x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	orr	x23, x0, x2
               	orr	x21, x1, x0
               	mov	x1, #0x2                // =2
               	cmp	x21, x20
               	cset	x0, lo
               	cmp	x21, x20
               	cset	x24, eq
               	cmp	x23, x22
               	cset	x2, lo
               	and	x2, x24, x2
               	orr	x0, x0, x2
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
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x1, #0x2                // =2
               	cmp	x20, x21
               	cset	x0, lo
               	cmp	x22, x23
               	cset	x2, lo
               	and	x2, x24, x2
               	orr	x0, x0, x2
               	mov	x2, #0x4d               // =77
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x1, #0x2                // =2
               	eor	x24, x22, x22
               	eor	x25, x20, x20
               	orr	x0, x24, x25
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
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x1, #0x2                // =2
               	orr	x0, x24, x25
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x2, #0x4d               // =77
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x1, #0x2                // =2
               	mov	x0, #0x1                // =1
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
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x1, #0x2                // =2
               	cmp	x20, x21
               	cset	x0, lo
               	cmp	x20, x21
               	cset	x24, eq
               	cmp	x22, x23
               	cset	x2, lo
               	and	x2, x24, x2
               	orr	x0, x0, x2
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
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
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	cmp	x21, x20
               	cset	x2, lo
               	cmp	x23, x22
               	cset	x3, lo
               	and	x5, x24, x3
               	orr	x1, x2, x5
               	mov	x17, #0x3               // =3
               	mul	x0, x1, x17
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	eor	x0, x22, x23
               	eor	x4, x20, x21
               	orr	x0, x0, x4
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x0, #0x0                // =0
               	eor	x4, x22, x0
               	eor	x6, x20, x0
               	orr	x6, x4, x6
               	cmp	x6, #0x0
               	cset	x4, eq
               	cbz	x6, <addr>
               	sub	x4, x22, x22
               	sub	x6, x20, x20
               	sub	x6, x6, #0x0
               	eor	x4, x4, x0
               	eor	x6, x6, x0
               	orr	x4, x4, x6
               	cmp	x4, #0x0
               	cset	x4, eq
               	cmp	x4, #0x1
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x0, <addr>
               	cmp	x20, x21
               	cset	x0, lo
               	cmp	x20, x21
               	cset	x1, eq
               	cmp	x22, x23
               	cset	x4, lo
               	and	x4, x1, x4
               	orr	x4, x0, x4
               	mov	x0, #0x1                // =1
               	cbnz	x4, <addr>
               	and	x0, x1, x3
               	orr	x0, x2, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	cmp	x21, x20
               	cset	x4, eq
               	and	x6, x4, x3
               	orr	x5, x2, x6
               	eor	x1, x22, x22
               	eor	x7, x20, x20
               	orr	x8, x1, x7
               	cmp	x8, #0x0
               	cset	x9, eq
               	sxtw	x0, w5
               	cmp	x0, #0x1
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	sxtw	x0, w9
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x8, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	sub	x1, x29, #0xe0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	ldrsw	x0, [x1, x5, lsl #2]
               	cmp	x0, #0x14
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x21, x20
               	cset	x0, lo
               	cmp	x23, x22
               	cset	x2, lo
               	and	x2, x4, x2
               	orr	x2, x0, x2
               	eor	x0, x22, x23
               	eor	x3, x20, x21
               	orr	x0, x0, x3
               	cmp	x0, #0x0
               	cset	x0, ne
               	add	x0, x2, x0
               	sxtw	x0, w0
               	ldrsw	x0, [x1, x0, lsl #2]
               	cmp	x0, #0x1e
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	cmp	x21, x20
               	cset	x0, lo
               	cmp	x23, x22
               	cset	x2, lo
               	and	x2, x4, x2
               	orr	x0, x0, x2
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x0, #0x6f               // =111
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	str	x2, [x1, #0x8]
               	sub	x0, x29, #0x100
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x0
               	b	<addr>
               	ldr	x3, [x0]
               	ldr	x5, [x0, #0x8]
               	add	x4, x3, #0x1
               	cmp	x4, x3
               	cset	x3, lo
               	add	x5, x5, #0x0
               	add	x3, x5, x3
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x0
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	cmp	x3, #0x0
               	cset	x5, lo
               	cmp	x3, #0x0
               	cset	x3, eq
               	cmp	x4, #0x5
               	cset	x4, lo
               	and	x3, x3, x4
               	orr	x3, x5, x3
               	cbnz	x3, <addr>
               	sxtw	x0, w2
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x100
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
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	cmp	x20, x21
               	cset	x0, lo
               	cmp	x20, x21
               	cset	x1, eq
               	cmp	x22, x23
               	cset	x2, lo
               	and	x1, x1, x2
               	orr	x1, x0, x1
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, x1, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
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
