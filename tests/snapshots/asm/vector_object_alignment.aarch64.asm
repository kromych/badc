
vector_object_alignment.aarch64:	file format elf64-littleaarch64

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

<file_scope_objects>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x7               // =7
               	and	x1, x0, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x10
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x10
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x2, x1, #0x10
               	sub	x1, x2, x1
               	cmp	x1, #0x10
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x2, x1, #0x20
               	sub	x1, x2, x1
               	cmp	x1, #0x20
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x1, #0x3                // =3
               	strh	w1, [x0, #0x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5                // =5
               	str	w2, [x1, #0xc]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x7                // =7
               	str	w3, [x2, #0x1c]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0xb                // =11
               	str	w4, [x3, #0x10]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x5, #0xd                // =13
               	str	w5, [x4, #0x24]
               	ldrsh	x0, [x0, #0x2]
               	ldrsw	x1, [x1, #0xc]
               	add	x0, x0, x1
               	ldrsw	x1, [x2, #0x1c]
               	add	x0, x0, x1
               	ldrsw	x1, [x3, #0x10]
               	add	x0, x0, x1
               	add	x0, x0, #0xd
               	cmp	w0, #0x27
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	mov	x0, #0x0                // =0
               	ret

<static_local_objects>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x0, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x17               // =23
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x18               // =24
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x10
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x19               // =25
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x10
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x2                // =2
               	str	w1, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x3                // =3
               	str	w3, [x1, #0x10]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x4                // =4
               	str	w4, [x3, #0x10]
               	ldrsw	x0, [x0]
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	ldrsw	x1, [x1, #0x10]
               	add	x0, x0, x1
               	add	x0, x0, #0x4
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ret
               	mov	x0, #0x0                // =0
               	ret

<automatic_objects>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x160
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0xc0]
               	sub	x3, x29, #0x98
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0xb8]
               	sub	x4, x29, #0x160
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0xb0]
               	sub	x5, x29, #0x150
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x5]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x5, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x5, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0xa8]
               	sub	x0, x29, #0x130
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
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, #0x5                // =5
               	sturb	w1, [x29, #-0xa0]
               	sub	x1, x29, #0x110
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	sub	x2, x29, #0xe0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x6]
               	str	x10, [x2]
               	ldr	x10, [x6, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x6, x2
               	mov	x17, #0x7               // =7
               	and	x3, x3, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x3, x4, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x3, x5, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x3, x0, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbnz	x3, <addr>
               	add	x0, x0, #0x10
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x0, x1, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	add	x0, x1, #0x10
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x0, x2, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0xc0]
               	ldurb	w1, [x29, #-0xb8]
               	add	x0, x0, x1
               	ldurb	w1, [x29, #-0xb0]
               	add	x0, x0, x1
               	ldurb	w1, [x29, #-0xa8]
               	add	x0, x0, x1
               	ldurb	w1, [x29, #-0xa0]
               	add	x0, x0, x1
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret

<by_value>:
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	sub	x16, x29, #0xb0
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	stur	x0, [x29, #0x10]
               	sub	x1, x29, #0xa0
               	ldur	x0, [x29, #0x30]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x80
               	ldur	x2, [x29, #0x40]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	sub	x2, x29, #0xb0
               	mov	x17, #0xf               // =15
               	and	x3, x2, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x17, #0xf               // =15
               	and	x3, x1, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x17, #0xf               // =15
               	and	x3, x0, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbnz	x3, <addr>
               	add	x3, x0, #0x10
               	mov	x17, #0xf               // =15
               	and	x3, x3, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldurb	w3, [x29, #0x10]
               	ldrsw	x2, [x2, #0x4]
               	add	x2, x3, x2
               	ldrsw	x1, [x1, #0x14]
               	add	x1, x2, x1
               	ldrsw	x0, [x0, #0x18]
               	add	x0, x1, x0
               	cmp	w0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x3, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x1                // =1
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
