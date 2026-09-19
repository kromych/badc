
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
               	mov	x17, #0x2222222222222222 // =2459565876494606882
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x0, [x1]
               	mov	x17, #0x2222222222222222 // =2459565876494606882
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	x0, [x1, #0x8]
               	mov	x17, #0x3333333333333333 // =3689348814741910323
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	str	x1, [x2]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	mov	x2, #0x0                // =0
               	stur	x2, [x29, #-0x80]
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x1, x29, #0x88
               	str	x1, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sub	x0, x29, #0x80
               	str	x0, [x4]
               	sub	x5, x29, #0x68
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x6]
               	str	x10, [x5]
               	ldr	x10, [sp], #0x10
               	ldr	x6, [x3]
               	cmp	x1, x6
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x6, [x4]
               	cmp	x0, x6
               	b.ne	<addr>
               	mov	x17, #0x1111111111111111 // =1229782938247303441
               	cmp	x5, x17
               	b.eq	<addr>
               	str	x5, [x0]
               	ldur	x5, [x29, #-0x80]
               	cbnz	x5, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x80]
               	sub	x5, x29, #0x60
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x6]
               	str	x10, [x5]
               	ldr	x10, [x6, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	x6, [x3]
               	cmp	x1, x6
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x6, [x4]
               	cmp	x0, x6
               	b.ne	<addr>
               	mov	x17, #0x2222222222222222 // =2459565876494606882
               	cmp	x5, x17
               	b.eq	<addr>
               	str	x5, [x0]
               	ldur	x5, [x29, #-0x80]
               	cbnz	x5, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x80]
               	sub	x5, x29, #0x50
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x6]
               	str	x10, [x5]
               	ldr	x10, [x6, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [x6, #0x10]
               	str	x10, [x5, #0x10]
               	ldr	x10, [sp], #0x10
               	ldr	x3, [x3]
               	cmp	x1, x3
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x4]
               	cmp	x0, x3
               	b.ne	<addr>
               	mov	x17, #0x4444444444444444 // =4919131752989213764
               	cmp	x5, x17
               	b.eq	<addr>
               	str	x5, [x0]
               	ldur	x3, [x29, #-0x80]
               	cbnz	x3, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x80]
               	sub	x2, x29, #0x38
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x80]
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x80]
               	sub	x2, x29, #0x88
               	sub	x3, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x80
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x5, [x4]
               	cmp	x2, x5
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x6, [x5]
               	cmp	x0, x6
               	b.ne	<addr>
               	mov	x17, #0x2222222222222222 // =2459565876494606882
               	cmp	x3, x17
               	b.eq	<addr>
               	str	x3, [x0]
               	ldur	x3, [x29, #-0x80]
               	cbnz	x3, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x80]
               	sub	x3, x29, #0x18
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x6]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	ldr	x6, [x4]
               	cmp	x2, x6
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x5, [x5]
               	cmp	x0, x5
               	b.ne	<addr>
               	mov	x17, #0x1111111111111111 // =1229782938247303441
               	cmp	x3, x17
               	b.eq	<addr>
               	str	x3, [x0]
               	ldur	x3, [x29, #-0x80]
               	cbnz	x3, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x80]
               	sub	x3, x29, #0x10
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x5]
               	str	x10, [x3]
               	ldr	x10, [x5, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x6, [x5]
               	cmp	x0, x6
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d0, [x3]
               	mov	x6, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x6
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x3, #0x8]
               	mov	x6, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x6
               	fcmp	d0, d17
               	b.ne	<addr>
               	str	x3, [x0]
               	ldur	x3, [x29, #-0x80]
               	cbnz	x3, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x80]
               	ldr	x3, [x4]
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x5]
               	cmp	x0, x3
               	b.ne	<addr>
               	str	x2, [x0]
               	ldur	x3, [x29, #-0x80]
               	cmp	x3, x2
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x80]
               	sub	x3, x29, #0x78
               	ldr	x4, [x4]
               	cmp	x2, x4
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x5]
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x17, #0x2222222222222222 // =2459565876494606882
               	cmp	x3, x17
               	b.eq	<addr>
               	ldr	x2, [x3]
               	mov	x17, #0x2222222222222222 // =2459565876494606882
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x3, #0x8]
               	mov	x17, #0x3333333333333333 // =3689348814741910323
               	cmp	x2, x17
               	b.ne	<addr>
               	str	x3, [x0]
               	ldur	x0, [x29, #-0x80]
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x80]
               	sub	x2, x29, #0x88
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x80
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x5]
               	cmp	x1, x2
               	b.ne	<addr>
               	mov	x17, #0x2222222222222222 // =2459565876494606882
               	cmp	x0, x17
               	b.eq	<addr>
               	ldr	x2, [x0]
               	mov	x17, #0x2222222222222222 // =2459565876494606882
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0x3333333333333333 // =3689348814741910323
               	cmp	x2, x17
               	b.ne	<addr>
               	str	x0, [x1]
               	ldur	x1, [x29, #-0x80]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
