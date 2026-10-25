
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

<ipv4_pktinfo>:
               	stp	x20, x21, [sp, #-0x120]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x110]
               	add	x29, sp, #0x110
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0xe8]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0xd0]
               	mov	x2, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x1, x0
               	bl	<addr>
               	mov	x22, x0
               	sub	x0, x29, #0xc8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	sturh	w0, [x29, #-0xc8]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	stur	w0, [x29, #-0xc4]
               	cmp	w22, #0x0
               	b.lt	<addr>
               	sub	x1, x29, #0xc8
               	mov	x2, #0x10               // =16
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	sub	x1, x29, #0xc8
               	sub	x2, x29, #0xe8
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sub	x3, x29, #0xd0
               	mov	x4, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x98]
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x90]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x88]
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x80]
               	sub	x0, x29, #0x78
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x1, x29, #0x78
               	sub	x0, x29, #0xc8
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0x70]
               	sub	x0, x29, #0x98
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x60]
               	mov	x2, #0x0                // =0
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0xe0
               	stur	x0, [x29, #-0x98]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x90]
               	sub	x0, x29, #0xd8
               	stur	x0, [x29, #-0x88]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x80]
               	sub	x0, x29, #0x78
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x0, x29, #0xb8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x1, x29, #0x78
               	sub	x0, x29, #0xb8
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0x70]
               	sub	x0, x29, #0x98
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x50]
               	mov	x2, #0x0                // =0
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	sub	x0, x29, #0xe0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xd8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	ldur	w0, [x29, #-0x70]
               	cmp	w0, #0x10
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0xb6]
               	ldurh	w1, [x29, #-0xc6]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldur	w20, [x29, #-0xb4]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	ldursw	x0, [x29, #-0x48]
               	mov	x17, #0x28              // =40
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	ldur	x0, [x29, #-0x50]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x20, [x29, #-0x58]
               	mov	x21, #0x0               // =0
               	cbz	x20, <addr>
               	ldrsw	x0, [x20, #0x8]
               	cbnz	w0, <addr>
               	ldrsw	x0, [x20, #0xc]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x1c
               	b.ne	<addr>
               	sub	x0, x29, #0xa8
               	add	x1, x20, #0x10
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	ldur	w21, [x29, #-0xa0]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f00, lsl #16
               	bl	<addr>
               	mov	w0, w0
               	cmp	x21, x0
               	mov	x21, #0x0               // =0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xa8]
               	cmp	w0, #0x0
               	cset	x21, gt
               	ldr	x0, [x20]
               	add	x0, x0, #0x7
               	and	x0, x0, #0xfffffffffffffff8
               	add	x0, x20, x0
               	add	x0, x0, #0x10
               	ldur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x50]
               	add	x1, x1, x2
               	cmp	x0, x1
               	b.ls	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	ldr	x0, [x20]
               	add	x0, x0, #0x7
               	and	x0, x0, #0xfffffffffffffff8
               	add	x20, x20, x0
               	cbnz	x20, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbz	x21, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, #0x13               // =19
               	b	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>

<ipv6_pktinfo>:
               	stp	x20, x21, [sp, #-0x110]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x100]
               	add	x29, sp, #0x100
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
               	mov	x22, x0
               	cmp	w22, #0x0
               	b.ge	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x61
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x14               // =20
               	b	<addr>
               	sub	x0, x29, #0x98
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1c               // =28
               	bl	<addr>
               	sub	x1, x29, #0x98
               	mov	x0, #0xa                // =10
               	sturh	w0, [x29, #-0x98]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x81]
               	mov	x2, #0x1c               // =28
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x15               // =21
               	b	<addr>
               	sub	x1, x29, #0x98
               	sub	x2, x29, #0xd8
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x1, #0x29               // =41
               	mov	x2, #0x31               // =49
               	sub	x3, x29, #0xc8
               	mov	x4, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sub	x1, x29, #0xd0
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	sub	x4, x29, #0x98
               	mov	x5, #0x1c               // =28
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sub	x0, x29, #0xd0
               	stur	x0, [x29, #-0xc0]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xb8]
               	sub	x0, x29, #0x78
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x1, x29, #0x78
               	sub	x0, x29, #0xc0
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x50]
               	mov	x2, #0x0                // =0
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xd0]
               	mov	x17, #0x36              // =54
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	ldur	x0, [x29, #-0x50]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x20, [x29, #-0x58]
               	mov	x21, #0x0               // =0
               	cbz	x20, <addr>
               	ldrsw	x0, [x20, #0x8]
               	cmp	w0, #0x29
               	b.ne	<addr>
               	ldrsw	x0, [x20, #0xc]
               	cmp	w0, #0x32
               	b.ne	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x24
               	b.ne	<addr>
               	sub	x0, x29, #0xb0
               	add	x1, x20, #0x10
               	mov	x2, #0x14               // =20
               	bl	<addr>
               	mov	x21, #0x0               // =0
               	ldur	w0, [x29, #-0xb0]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0xac]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldur	w0, [x29, #-0xa8]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0xa4]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0xa3]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0xa2]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldurb	w0, [x29, #-0xa1]
               	eor	x0, x0, #0x1
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldur	w0, [x29, #-0xa0]
               	cmp	w0, #0x0
               	cset	x21, hi
               	ldr	x0, [x20]
               	add	x0, x0, #0x7
               	and	x0, x0, #0xfffffffffffffff8
               	add	x0, x20, x0
               	add	x0, x0, #0x10
               	ldur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x50]
               	add	x1, x1, x2
               	cmp	x0, x1
               	b.ls	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	ldr	x0, [x20]
               	add	x0, x0, #0x7
               	and	x0, x0, #0xfffffffffffffff8
               	add	x20, x20, x0
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	cbnz	x20, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbz	x21, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>

<pass_descriptor>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0xa0]
               	mov	x0, #0x72               // =114
               	sturb	w0, [x29, #-0x98]
               	mov	x2, #0x0                // =0
               	sturb	w2, [x29, #-0x90]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	sub	x3, x29, #0xb0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	stur	x0, [x29, #-0x88]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x80]
               	sub	x0, x29, #0x78
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x88
               	stur	x0, [x29, #-0x68]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x60]
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x18               // =24
               	stur	x0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x58]
               	str	w1, [x0, #0x8]
               	str	w1, [x0, #0xc]
               	mov	x1, #0x14               // =20
               	str	x1, [x0]
               	add	x0, x0, #0x10
               	sub	x1, x29, #0xa8
               	mov	x2, #0x4                // =4
               	add	x1, x1, #0x4
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	ldursw	x0, [x29, #-0xb0]
               	sub	x1, x29, #0x78
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x1, x29, #0x78
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x50]
               	mov	x2, #0x0                // =0
               	sturb	w2, [x29, #-0x98]
               	ldursw	x0, [x29, #-0xac]
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x98]
               	mov	x17, #0x72              // =114
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x50]
               	cmp	x0, #0x10
               	b.lo	<addr>
               	ldur	x1, [x29, #-0x58]
               	cbz	x1, <addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldr	x0, [x1]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	add	x1, x1, #0x10
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldursw	x0, [x29, #-0xa0]
               	ldursw	x1, [x29, #-0xa4]
               	cmp	w0, w1
               	b.eq	<addr>
               	ldursw	x0, [x29, #-0xa0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xa8]
               	sub	x1, x29, #0x90
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x90]
               	eor	x0, x0, #0x78
               	cbz	w0, <addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0xa0]
               	bl	<addr>
               	ldursw	x0, [x29, #-0xa8]
               	bl	<addr>
               	ldursw	x0, [x29, #-0xa4]
               	bl	<addr>
               	ldursw	x0, [x29, #-0xb0]
               	bl	<addr>
               	ldursw	x0, [x29, #-0xac]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<walk_records>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x78
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x1, x29, #0x40
               	stur	x1, [x29, #-0x58]
               	mov	x0, #0x30               // =48
               	stur	x0, [x29, #-0x50]
               	ldur	x2, [x29, #-0x58]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	str	x0, [x2]
               	add	x0, x2, #0x18
               	add	x3, x0, #0x10
               	ldur	x4, [x29, #-0x58]
               	ldur	x5, [x29, #-0x50]
               	add	x4, x4, x5
               	cmp	x3, x4
               	b.ls	<addr>
               	mov	x0, #0x0                // =0
               	add	x3, x1, #0x18
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x13               // =19
               	str	x3, [x0]
               	add	x0, x0, #0x18
               	add	x3, x0, #0x10
               	ldur	x4, [x29, #-0x58]
               	ldur	x5, [x29, #-0x50]
               	add	x4, x4, x5
               	cmp	x3, x4
               	b.ls	<addr>
               	add	x0, x2, #0x10
               	add	x1, x1, #0x10
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
