
msghdr_control_messages_round_trip.aarch64:	file format elf64-littleaarch64

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

<ipv6_pktinfo>:
               	stp	x20, x21, [sp, #-0x100]!
               	stp	x29, x30, [sp, #0xf0]
               	add	x29, sp, #0xf0
               	mov	x0, #0x1c               // =28
               	stur	w0, [x29, #-0xd8]
               	mov	x0, #0x36               // =54
               	sturb	w0, [x29, #-0xd0]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0xc8]
               	mov	x2, #0x0                // =0
               	mov	x0, #0xa                // =10
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	cmp	w21, #0x0
               	b.ge	<addr>
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x14               // =20
               	ldrsw	x0, [x0]
               	cmp	w0, #0x61
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	sub	x1, x29, #0x98
               	mov	x2, #0xa                // =10
               	stur	xzr, [x29, #-0x90]
               	mov	x3, #0x100000000000000  // =72057594037927936
               	stur	wzr, [x29, #-0x80]
               	stur	x2, [x29, #-0x98]
               	stur	x3, [x29, #-0x88]
               	mov	x2, #0x1c               // =28
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, x21
               	bl	<addr>
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x15               // =21
               	ldrsw	x0, [x0]
               	cmp	w0, #0x63
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	sub	x1, x29, #0x98
               	sub	x2, x29, #0xd8
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x1, #0x29               // =41
               	mov	x2, #0x31               // =49
               	sub	x3, x29, #0xc8
               	mov	x4, #0x4                // =4
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	sub	x1, x29, #0xd0
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	sub	x4, x29, #0x98
               	mov	x5, #0x1c               // =28
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	sub	x3, x29, #0xc0
               	sub	x0, x29, #0xd0
               	stur	x0, [x29, #-0xc0]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xb8]
               	sub	x1, x29, #0x78
               	mov	x2, #0x0                // =0
               	stur	x2, [x29, #-0x78]
               	stur	x2, [x29, #-0x70]
               	stur	x2, [x29, #-0x68]
               	stur	x2, [x29, #-0x60]
               	stur	x2, [x29, #-0x58]
               	stur	x2, [x29, #-0x50]
               	stur	x2, [x29, #-0x48]
               	stur	x3, [x29, #-0x68]
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x50]
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xd0]
               	cmp	w0, #0x36
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	ldur	x0, [x29, #-0x50]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x0, [x29, #-0x58]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x1, x29, #0x78
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x29
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x32
               	b.ne	<addr>
               	ldr	x1, [x0]
               	cmp	x1, #0x24
               	b.ne	<addr>
               	sub	x1, x29, #0xb0
               	add	x2, x0, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldr	w16, [x2, #0x10]
               	str	w16, [x1, #0x10]
               	mov	x20, #0x0               // =0
               	ldur	w1, [x29, #-0xb0]
               	cbnz	w1, <addr>
               	ldur	w1, [x29, #-0xac]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldur	w1, [x29, #-0xa8]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w1, [x29, #-0xa4]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w1, [x29, #-0xa3]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w1, [x29, #-0xa2]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w1, [x29, #-0xa1]
               	cmp	w1, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldur	w1, [x29, #-0xa0]
               	cmp	w1, #0x0
               	cset	x20, hi
               	b	<addr>
               	mov	x1, x20
               	b	<addr>
               	mov	x1, x20
               	b	<addr>
               	mov	x1, x20
               	b	<addr>
               	mov	x1, x20
               	b	<addr>
               	mov	x1, x20
               	b	<addr>
               	mov	x1, x20
               	b	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1b               // =27
               	cmp	x20, #0x0
               	csel	x0, x0, x1, ne
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x120]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x110]
               	add	x29, sp, #0x110
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.lt	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0x28]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0xe8]
               	mov	x2, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x1, x0
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x2                // =2
               	stur	xzr, [x29, #-0x8]
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	stur	w0, [x29, #-0xc]
               	cmp	w22, #0x0
               	b.lt	<addr>
               	sub	x1, x29, #0x10
               	mov	x2, #0x10               // =16
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x18]
               	mov	x0, #0x72               // =114
               	sturb	w0, [x29, #-0x20]
               	mov	x2, #0x0                // =0
               	sturb	w2, [x29, #-0x28]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	sub	x3, x29, #0x8
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	sub	x1, x29, #0x40
               	stur	xzr, [x29, #-0x40]
               	stur	xzr, [x29, #-0x38]
               	stur	xzr, [x29, #-0x30]
               	stur	xzr, [x29, #-0x28]
               	stur	xzr, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	sub	x0, x29, #0x78
               	stur	xzr, [x29, #-0x78]
               	stur	xzr, [x29, #-0x70]
               	stur	xzr, [x29, #-0x68]
               	stur	xzr, [x29, #-0x60]
               	stur	xzr, [x29, #-0x58]
               	stur	xzr, [x29, #-0x50]
               	stur	xzr, [x29, #-0x48]
               	stur	x1, [x29, #-0x58]
               	mov	x2, #0x30               // =48
               	stur	x2, [x29, #-0x50]
               	mov	x2, #0x14               // =20
               	str	x2, [x1]
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x18
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, #0x13               // =19
               	str	x0, [x1]
               	sub	x0, x29, #0x78
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	b	<addr>
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x40
               	add	x1, x1, #0x10
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	b	<addr>
               	sub	x1, x29, #0x40
               	str	xzr, [x1]
               	sub	x0, x29, #0x78
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2d               // =45
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	sub	x1, x29, #0x40
               	str	x0, [x1]
               	sub	x0, x29, #0x78
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2e               // =46
               	b	<addr>
               	mov	x0, #0xf                // =15
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x38
               	sub	x0, x29, #0x20
               	stur	x0, [x29, #-0x38]
               	mov	x3, #0x1                // =1
               	stur	x3, [x29, #-0x30]
               	sub	x1, x29, #0x70
               	mov	x2, #0x0                // =0
               	stur	x2, [x29, #-0x70]
               	stur	x2, [x29, #-0x68]
               	stur	x2, [x29, #-0x60]
               	stur	x2, [x29, #-0x58]
               	stur	x2, [x29, #-0x50]
               	stur	x2, [x29, #-0x48]
               	stur	x2, [x29, #-0x40]
               	sub	x0, x29, #0xb0
               	stur	x2, [x29, #-0xb0]
               	stur	x2, [x29, #-0xa8]
               	stur	x2, [x29, #-0xa0]
               	stur	x2, [x29, #-0x98]
               	stur	x2, [x29, #-0x90]
               	stur	x2, [x29, #-0x88]
               	stur	x2, [x29, #-0x80]
               	stur	x2, [x29, #-0x78]
               	stur	x4, [x29, #-0x60]
               	stur	x3, [x29, #-0x58]
               	stur	x0, [x29, #-0x50]
               	mov	x3, #0x18               // =24
               	stur	x3, [x29, #-0x48]
               	mov	x3, #0x100000001        // =4294967297
               	str	x3, [x0, #0x8]
               	mov	x3, #0x14               // =20
               	str	x3, [x0]
               	add	x0, x0, #0x10
               	sub	x3, x29, #0x10
               	add	x3, x3, #0x4
               	ldr	w16, [x3]
               	str	w16, [x0]
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	b	<addr>
               	mov	x2, #0x0                // =0
               	stur	x2, [x29, #-0xb0]
               	stur	x2, [x29, #-0xa8]
               	stur	x2, [x29, #-0xa0]
               	stur	x2, [x29, #-0x98]
               	stur	x2, [x29, #-0x90]
               	stur	x2, [x29, #-0x88]
               	stur	x2, [x29, #-0x80]
               	stur	x2, [x29, #-0x78]
               	sub	x1, x29, #0x70
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x48]
               	sturb	w2, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x4]
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x20]
               	cmp	w0, #0x72
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x0]
               	cmp	x1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	b	<addr>
               	sub	x1, x29, #0x18
               	add	x0, x0, #0x10
               	ldr	w16, [x0]
               	str	w16, [x1]
               	ldursw	x0, [x29, #-0x18]
               	ldursw	x1, [x29, #-0xc]
               	cmp	w0, w1
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	sub	x1, x29, #0x28
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x28]
               	cmp	w0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	bl	<addr>
               	ldursw	x0, [x29, #-0xc]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	ldursw	x0, [x29, #-0x4]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x28
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sub	x3, x29, #0xe8
               	mov	x4, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	sub	x0, x29, #0x58
               	mov	x2, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x58]
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x50]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x48]
               	mov	x1, #0x5                // =5
               	stur	x1, [x29, #-0x40]
               	sub	x1, x29, #0x90
               	stur	x2, [x29, #-0x90]
               	mov	x3, #0x10               // =16
               	stur	x2, [x29, #-0x80]
               	stur	x2, [x29, #-0x78]
               	stur	x2, [x29, #-0x70]
               	stur	x2, [x29, #-0x68]
               	stur	x2, [x29, #-0x60]
               	sub	x4, x29, #0x10
               	stur	x4, [x29, #-0x90]
               	stur	x3, [x29, #-0x88]
               	stur	x0, [x29, #-0x80]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x78]
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	b	<addr>
               	sub	x0, x29, #0x58
               	mov	x2, #0x0                // =0
               	sub	x1, x29, #0x30
               	stur	x1, [x29, #-0x58]
               	mov	x1, #0x4                // =4
               	stur	x1, [x29, #-0x50]
               	sub	x1, x29, #0x38
               	stur	x1, [x29, #-0x48]
               	mov	x1, #0x8                // =8
               	stur	x1, [x29, #-0x40]
               	sub	x1, x29, #0x90
               	stur	x2, [x29, #-0x90]
               	mov	x3, #0x10               // =16
               	stur	x2, [x29, #-0x80]
               	stur	x2, [x29, #-0x78]
               	stur	x2, [x29, #-0x70]
               	stur	x2, [x29, #-0x68]
               	stur	x2, [x29, #-0x60]
               	sub	x4, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	stur	x4, [x29, #-0x90]
               	stur	x3, [x29, #-0x88]
               	stur	x0, [x29, #-0x80]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x78]
               	sub	x0, x29, #0xd0
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x68]
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	b	<addr>
               	ldur	w0, [x29, #-0x88]
               	cmp	w0, #0x10
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x1e]
               	ldurh	w1, [x29, #-0xe]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w20, [x29, #-0x1c]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	b	<addr>
               	ldursw	x0, [x29, #-0x60]
               	mov	x17, #0x28              // =40
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	b	<addr>
               	ldur	x0, [x29, #-0x68]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x20, [x29, #-0x70]
               	mov	x21, #0x0               // =0
               	b	<addr>
               	sub	x0, x29, #0x90
               	mov	x1, x20
               	bl	<addr>
               	mov	x20, x0
               	cbz	x20, <addr>
               	ldrsw	x0, [x20, #0x8]
               	cbnz	w0, <addr>
               	ldrsw	x0, [x20, #0xc]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x1c
               	b.ne	<addr>
               	sub	x0, x29, #0xe0
               	add	x1, x20, #0x10
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	ldur	w21, [x29, #-0xd8]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	cmp	x21, x0
               	mov	x21, #0x0               // =0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xe0]
               	cmp	w0, #0x0
               	cset	x21, gt
               	b	<addr>
               	mov	x0, #0x12               // =18
               	b	<addr>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x13               // =19
               	cmp	x21, #0x0
               	csel	x0, x0, x1, ne
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
