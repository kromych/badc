
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
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xe0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
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
               	mov	x0, #0x2                // =2
               	cmp	x21, x20
               	cset	x1, lo
               	cmp	x21, x20
               	cset	x2, eq
               	cmp	x23, x22
               	cset	x3, lo
               	and	x2, x2, x3
               	orr	x1, x1, x2
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x2                // =2
               	cmp	x20, x21
               	cset	x1, lo
               	cmp	x20, x21
               	cset	x2, eq
               	cmp	x22, x23
               	cset	x3, lo
               	and	x2, x2, x3
               	orr	x1, x1, x2
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x2                // =2
               	eor	x1, x22, x22
               	eor	x2, x20, x20
               	orr	x1, x1, x2
               	cmp	x1, #0x0
               	cset	x1, eq
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x2                // =2
               	eor	x1, x22, x22
               	eor	x2, x20, x20
               	orr	x1, x1, x2
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x2                // =2
               	cmp	x20, x21
               	cset	x1, lo
               	cmp	x20, x21
               	cset	x2, eq
               	cmp	x22, x23
               	cset	x3, lo
               	and	x2, x2, x3
               	orr	x1, x1, x2
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4d
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	cmp	x21, x20
               	cset	x3, lo
               	cmp	x21, x20
               	cset	x1, eq
               	cmp	x23, x22
               	cset	x4, lo
               	and	x5, x1, x4
               	orr	x2, x3, x5
               	mov	x17, #0x3               // =3
               	mul	x0, x2, x17
               	cmp	w0, #0x3
               	b.ne	<addr>
               	eor	x6, x22, x23
               	eor	x7, x20, x21
               	orr	x8, x6, x7
               	cmp	x8, #0x0
               	cset	x0, eq
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x0                // =0
               	eor	x9, x22, x0
               	eor	x10, x20, x0
               	orr	x9, x9, x10
               	cbz	x9, <addr>
               	sub	x9, x22, x22
               	sub	x10, x20, x20
               	sub	x10, x10, #0x0
               	eor	x9, x9, x0
               	eor	x10, x10, x0
               	orr	x9, x9, x10
               	cmp	x9, #0x0
               	cset	x9, eq
               	cmp	w9, #0x1
               	cset	x9, ne
               	cbz	x9, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	cbz	x2, <addr>
               	cmp	x20, x21
               	cset	x2, lo
               	cmp	x22, x23
               	cset	x3, lo
               	and	x1, x1, x3
               	orr	x2, x2, x1
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	mov	x1, x0
               	eor	x2, x22, x22
               	eor	x3, x20, x20
               	orr	x4, x2, x3
               	cmp	x4, #0x0
               	cset	x1, eq
               	cmp	w1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	cmp	x4, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	sub	x1, x29, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	cmp	x8, #0x0
               	cset	x2, ne
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	ldrsw	x1, [x1, x2, lsl #2]
               	cmp	w1, #0x1e
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x1, #0x6f               // =111
               	mov	x1, x0
               	mov	x2, x0
               	b	<addr>
               	add	x3, x0, #0x1
               	cmp	x3, x0
               	cset	x0, lo
               	add	x1, x1, #0x0
               	add	x1, x1, x0
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	mov	x0, x3
               	cmp	x1, #0x0
               	cset	x3, lo
               	cmp	x1, #0x0
               	cset	x4, eq
               	cmp	x0, #0x5
               	cset	x5, lo
               	and	x4, x4, x5
               	orr	x3, x3, x4
               	cbnz	x3, <addr>
               	cmp	w2, #0x5
               	b.ne	<addr>
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	mov	x17, #0x0               // =0
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	cmp	x20, x21
               	cset	x0, lo
               	cmp	x20, x21
               	cset	x1, eq
               	cmp	x22, x23
               	cset	x2, lo
               	and	x1, x1, x2
               	orr	x0, x0, x1
               	cmp	w0, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	b	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
