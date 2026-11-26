
atomic_int128_operations.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	sp, sp, #0x220
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	sub	x2, x29, #0x220
               	str	xzr, [sp]
               	str	xzr, [sp, #0x8]
               	mov	x3, #0x5                // =5
               	sub	x4, x29, #0x150
               	str	x3, [sp, #0xd0]
               	str	x0, [sp, #0xd8]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x4
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x3, x16
               	cbz	w3, <addr>
               	ldr	x3, [sp]
               	ldr	x4, [sp, #0x8]
               	orr	x3, x3, x4
               	cbz	x3, <addr>
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3                // =3
               	str	x3, [sp]
               	str	xzr, [sp, #0x8]
               	mov	x3, #0x9                // =9
               	sub	x4, x29, #0x140
               	str	x3, [sp, #0xe0]
               	str	xzr, [sp, #0xe8]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x4
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x2, x16
               	cbnz	x2, <addr>
               	ldr	x2, [sp]
               	ldr	x3, [sp, #0x8]
               	mov	x17, #0x5               // =5
               	eor	x2, x2, x17
               	eor	x3, x3, #0x1
               	orr	x2, x2, x3
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x1]
               	ldr	x4, [x1, #0x8]
               	sub	x3, x29, #0x130
               	str	x2, [sp, #0xf0]
               	str	x4, [sp, #0xf8]
               	sub	x4, x29, #0x1f0
               	ldr	x2, [sp, #0xf0]
               	ldr	x5, [sp, #0xf8]
               	cmp	x2, #0x6
               	cset	x6, lo
               	sub	x2, x2, #0x6
               	sub	x5, x5, x6
               	str	x2, [sp, #0x30]
               	str	x5, [sp, #0x38]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x3
               	mov	x15, x4
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x2, x16
               	cbz	x2, <addr>
               	ldr	x2, [sp, #0xf0]
               	ldr	x3, [sp, #0xf8]
               	mov	x17, #0x5               // =5
               	eor	x2, x2, x17
               	eor	x3, x3, #0x1
               	orr	x2, x2, x3
               	cbnz	x2, <addr>
               	sub	x2, x29, #0x120
               	str	xzr, [sp, #0x100]
               	str	xzr, [sp, #0x108]
               	sub	x3, x29, #0x110
               	str	xzr, [sp, #0x110]
               	str	xzr, [sp, #0x118]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x3
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspa	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	ldr	x2, [sp, #0x100]
               	ldr	x3, [sp, #0x108]
               	mvn	x2, x2
               	orr	x2, x2, x3
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	sub	x4, x29, #0x100
               	stur	x2, [x29, #-0x100]
               	stur	x3, [x29, #-0xf8]
               	sub	x5, x29, #0x1e0
               	ldur	x2, [x29, #-0x100]
               	ldur	x6, [x29, #-0xf8]
               	add	x3, x2, #0x1
               	cmp	x3, x2
               	cset	x2, lo
               	add	x2, x6, x2
               	str	x3, [sp, #0x40]
               	str	x2, [sp, #0x48]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x4
               	mov	x15, x5
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	casp	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x2, x16
               	cbz	x2, <addr>
               	ldr	x2, [sp, #0x40]
               	ldr	x3, [sp, #0x48]
               	eor	x3, x3, x0
               	orr	x2, x2, x3
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	ldr	x5, [x1]
               	ldr	x6, [x1, #0x8]
               	sub	x4, x29, #0xf0
               	stur	x5, [x29, #-0xf0]
               	stur	x6, [x29, #-0xe8]
               	sub	x5, x29, #0x1d0
               	str	x3, [sp, #0x50]
               	str	x2, [sp, #0x58]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x4
               	mov	x15, x5
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x6, x16
               	cbz	x6, <addr>
               	ldur	x2, [x29, #-0xf0]
               	ldur	x3, [x29, #-0xe8]
               	eor	x3, x3, x0
               	orr	x2, x2, x3
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	ldr	x4, [x2, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x5, [x2]
               	ldr	x2, [x2, #0x8]
               	eor	x3, x3, x5
               	eor	x2, x4, x2
               	orr	x2, x3, x2
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x1]
               	ldr	x4, [x1, #0x8]
               	sub	x2, x29, #0xe0
               	stur	x3, [x29, #-0xe0]
               	stur	x4, [x29, #-0xd8]
               	sub	x3, x29, #0x1c0
               	ldur	x4, [x29, #-0xe0]
               	ldur	x5, [x29, #-0xd8]
               	and	x4, x4, #0x7
               	and	x5, x5, x0
               	str	x4, [sp, #0x60]
               	str	x5, [sp, #0x68]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x3
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x4, x16
               	cbz	x4, <addr>
               	ldur	x2, [x29, #-0xe0]
               	ldur	x3, [x29, #-0xd8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x4
               	eor	x0, x3, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x5               // =5
               	eor	x2, x2, x17
               	orr	x0, x2, x0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	sub	x0, x29, #0xd0
               	stur	x2, [x29, #-0xd0]
               	stur	x3, [x29, #-0xc8]
               	sub	x2, x29, #0x1b0
               	ldur	x3, [x29, #-0xd0]
               	ldur	x4, [x29, #-0xc8]
               	orr	x4, x4, #0x1800000000
               	str	x3, [sp, #0x70]
               	str	x4, [sp, #0x78]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x0
               	mov	x15, x2
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x3, x16
               	cbz	x3, <addr>
               	ldr	x0, [sp, #0x70]
               	ldr	x2, [sp, #0x78]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	eor	x2, x2, #0x1800000000
               	orr	x0, x0, x2
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	sub	x0, x29, #0xc0
               	stur	x2, [x29, #-0xc0]
               	stur	x3, [x29, #-0xb8]
               	sub	x2, x29, #0x1a0
               	ldur	x3, [x29, #-0xc0]
               	ldur	x4, [x29, #-0xb8]
               	eor	x4, x4, #0x800000000
               	str	x3, [sp, #0x80]
               	str	x4, [sp, #0x88]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x0
               	mov	x15, x2
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x3, x16
               	cbz	x3, <addr>
               	ldr	x0, [sp, #0x80]
               	ldr	x2, [sp, #0x88]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	eor	x2, x2, #0x1000000000
               	orr	x0, x0, x2
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldr	x3, [x1]
               	ldr	x4, [x1, #0x8]
               	sub	x2, x29, #0xb0
               	stur	x3, [x29, #-0xb0]
               	stur	x4, [x29, #-0xa8]
               	sub	x3, x29, #0x190
               	str	x0, [sp, #0x90]
               	str	xzr, [sp, #0x98]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x3
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspl	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x4, x16
               	cbz	x4, <addr>
               	mov	x0, #0x2a               // =42
               	sub	x2, x29, #0xa0
               	stur	x0, [x29, #-0xa0]
               	stur	xzr, [x29, #-0x98]
               	mov	x3, #0x2b               // =43
               	sub	x4, x29, #0x90
               	stur	x3, [x29, #-0x90]
               	stur	xzr, [x29, #-0x88]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x4
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	ldur	x2, [x29, #-0xa0]
               	ldur	x3, [x29, #-0x98]
               	eor	x0, x2, x0
               	orr	x0, x0, x3
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sub	x2, x29, #0x80
               	stur	x0, [x29, #-0x80]
               	stur	xzr, [x29, #-0x78]
               	mov	x0, #0x2                // =2
               	sub	x3, x29, #0x70
               	stur	x0, [x29, #-0x70]
               	stur	xzr, [x29, #-0x68]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x3
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x0, x16
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x2b              // =43
               	eor	x2, x2, x17
               	orr	x0, x2, x0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	ldr	x3, [x1]
               	ldr	x4, [x1, #0x8]
               	sub	x2, x29, #0x60
               	stur	x3, [x29, #-0x60]
               	stur	x4, [x29, #-0x58]
               	sub	x3, x29, #0x180
               	str	x0, [sp, #0xa0]
               	str	x0, [sp, #0xa8]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x3
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x4, x16
               	cbz	x4, <addr>
               	sub	x0, x29, #0x210
               	str	xzr, [sp, #0x10]
               	str	xzr, [sp, #0x18]
               	sub	x2, x29, #0x50
               	stur	xzr, [x29, #-0x50]
               	stur	xzr, [x29, #-0x48]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x0
               	mov	x15, x2
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	ldr	x0, [sp, #0x10]
               	ldr	x2, [sp, #0x18]
               	mvn	x0, x0
               	mvn	x2, x2
               	orr	x0, x0, x2
               	cbnz	x0, <addr>
               	ldr	x0, [x1]
               	ldr	x2, [x1, #0x8]
               	sub	x3, x29, #0x40
               	stur	x0, [x29, #-0x40]
               	stur	x2, [x29, #-0x38]
               	sub	x4, x29, #0x170
               	ldur	x0, [x29, #-0x40]
               	ldur	x5, [x29, #-0x38]
               	add	x2, x0, #0x1
               	cmp	x2, x0
               	cset	x0, lo
               	add	x0, x5, x0
               	str	x2, [sp, #0xb0]
               	str	x0, [sp, #0xb8]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x3
               	mov	x15, x4
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x0, x16
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x40]
               	ldur	x2, [x29, #-0x38]
               	mvn	x0, x0
               	mvn	x2, x2
               	orr	x0, x0, x2
               	cbnz	x0, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2]
               	ldr	x3, [x2, #0x8]
               	orr	x0, x0, x3
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x200
               	str	xzr, [sp, #0x20]
               	str	xzr, [sp, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x4, [x0]
               	ldr	x5, [x0, #0x8]
               	sub	x6, x29, #0x30
               	stur	x4, [x29, #-0x30]
               	stur	x5, [x29, #-0x28]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x3
               	mov	x15, x6
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x6, x16
               	cbz	w6, <addr>
               	ldr	x6, [x2]
               	ldr	x2, [x2, #0x8]
               	ldr	x7, [x0]
               	ldr	x8, [x0, #0x8]
               	eor	x6, x6, x7
               	eor	x2, x2, x8
               	orr	x2, x6, x2
               	cbz	x2, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x20
               	stur	x4, [x29, #-0x20]
               	stur	x5, [x29, #-0x18]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x3
               	mov	x15, x2
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspa	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x2, x16
               	cbnz	x2, <addr>
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x28]
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x4
               	eor	x0, x3, x0
               	orr	x0, x2, x0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x3, [x1]
               	ldr	x4, [x1, #0x8]
               	sub	x2, x29, #0x10
               	stur	x3, [x29, #-0x10]
               	stur	x4, [x29, #-0x8]
               	sub	x3, x29, #0x160
               	str	x0, [sp, #0xc0]
               	str	x0, [sp, #0xc8]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x3
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x4, x16
               	cbz	x4, <addr>
               	ldur	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, #0x1
               	eor	x0, x0, #0x1
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
