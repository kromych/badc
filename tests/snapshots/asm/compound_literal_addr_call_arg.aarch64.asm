
compound_literal_addr_call_arg.aarch64:	file format elf64-littleaarch64

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

<take16>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	movk	x17, #0x2222, lsl #32
               	movk	x17, #0x2222, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x0, [x1]
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	movk	x17, #0x2222, lsl #32
               	movk	x17, #0x2222, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	x0, [x1, #0x8]
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	str	x1, [x2]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x80]
               	sub	x1, x29, #0x78
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	sub	x3, x29, #0x88
               	str	x3, [x21]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	sub	x1, x29, #0x80
               	str	x1, [x20]
               	sub	x2, x29, #0x68
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x4, x2
               	ldr	x4, [x21]
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x2, #0x1                // =1
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x2, [x29, #-0x80]
               	cbnz	x2, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	stur	x0, [x29, #-0x80]
               	sub	x2, x29, #0x60
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x2]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x2
               	ldr	x4, [x21]
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x0, [x29, #-0x80]
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x80]
               	sub	x3, x29, #0x88
               	sub	x1, x29, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	sub	x2, x29, #0x80
               	ldr	x4, [x21]
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x1, [x29, #-0x80]
               	cbnz	x1, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	stur	x0, [x29, #-0x80]
               	sub	x1, x29, #0x38
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, x3
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x0, [x29, #-0x80]
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x80]
               	sub	x3, x29, #0x88
               	sub	x2, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x80
               	ldr	x4, [x21]
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldr	x4, [x20]
               	cmp	x0, x4
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	movk	x17, #0x2222, lsl #32
               	movk	x17, #0x2222, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	b	<addr>
               	mov	x4, x1
               	str	x2, [x0]
               	ldur	x2, [x29, #-0x80]
               	cbnz	x2, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	stur	x1, [x29, #-0x80]
               	sub	x2, x29, #0x18
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x4, x2
               	ldr	x4, [x21]
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x2, #0x1                // =1
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x2, [x29, #-0x80]
               	cbnz	x2, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	stur	x1, [x29, #-0x80]
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	ldr	x2, [x20]
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x0, [x29, #-0x80]
               	cbnz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x80]
               	sub	x2, x29, #0x88
               	sub	x3, x29, #0x80
               	ldr	x1, [x21]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x1, [x29, #-0x80]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	stur	x0, [x29, #-0x80]
               	sub	x1, x29, #0x78
               	ldr	x4, [x21]
               	cmp	x2, x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x0, [x29, #-0x80]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x80]
               	sub	x3, x29, #0x88
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x80
               	ldr	x4, [x21]
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x0, [x29, #-0x80]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldr	x3, [x20]
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	movk	x17, #0x2222, lsl #32
               	movk	x17, #0x2222, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	ldr	x3, [x0]
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	movk	x17, #0x2222, lsl #32
               	movk	x17, #0x2222, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	cmp	x3, x17
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	str	x0, [x2]
               	mov	x0, x1
               	b	<addr>
               	ldr	x2, [x20]
               	cmp	x3, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	movk	x17, #0x2222, lsl #32
               	movk	x17, #0x2222, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	ldr	x2, [x1]
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	movk	x17, #0x2222, lsl #32
               	movk	x17, #0x2222, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1, #0x8]
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	cmp	x2, x17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	str	x1, [x3]
               	b	<addr>
               	ldr	x1, [x20]
               	cmp	x3, x1
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x1, x0
               	str	x2, [x3]
               	mov	x1, x0
               	b	<addr>
               	ldr	d0, [x1]
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x1, #0x8]
               	mov	x2, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldr	x3, [x20]
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x2, #0x2                // =2
               	b	<addr>
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	movk	x17, #0x1111, lsl #32
               	movk	x17, #0x1111, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x2, #0x3                // =3
               	b	<addr>
               	str	x2, [x0]
               	mov	x2, x1
               	b	<addr>
               	ldr	x4, [x20]
               	cmp	x2, x4
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x17, #0x4444            // =17476
               	movk	x17, #0x4444, lsl #16
               	movk	x17, #0x4444, lsl #32
               	movk	x17, #0x4444, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	mov	x4, x0
               	mov	x4, x0
               	str	x1, [x2]
               	mov	x1, x0
               	b	<addr>
               	ldr	x3, [x20]
               	cmp	x1, x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	movk	x17, #0x2222, lsl #32
               	movk	x17, #0x2222, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x3, x0
               	str	x2, [x1]
               	b	<addr>
               	ldr	x4, [x20]
               	cmp	x1, x4
               	b.eq	<addr>
               	mov	x2, #0x2                // =2
               	b	<addr>
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	movk	x17, #0x1111, lsl #32
               	movk	x17, #0x1111, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x2, #0x3                // =3
               	b	<addr>
               	str	x2, [x1]
               	mov	x2, x0
               	b	<addr>
