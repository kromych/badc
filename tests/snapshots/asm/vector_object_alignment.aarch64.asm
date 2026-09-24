
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x0, x2, #0x7
               	cbz	w0, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x0, x3, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	and	x0, x4, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x0, x1, #0xf
               	cbnz	w0, <addr>
               	add	x5, x1, #0x10
               	and	x0, x5, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x6, x0, #0xf
               	cbnz	w6, <addr>
               	add	x6, x0, #0x10
               	and	x6, x6, #0xf
               	cbz	w6, <addr>
               	mov	x0, #0x12               // =18
               	ret
               	sub	x5, x5, x1
               	cmp	x5, #0x10
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	add	x5, x0, #0x20
               	sub	x5, x5, x0
               	cmp	x5, #0x20
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x5, #0x3                // =3
               	strh	w5, [x2, #0x2]
               	mov	x5, #0x5                // =5
               	str	w5, [x3, #0xc]
               	mov	x5, #0x7                // =7
               	str	w5, [x4, #0x1c]
               	mov	x5, #0xb                // =11
               	str	w5, [x1, #0x10]
               	mov	x5, #0xd                // =13
               	str	w5, [x0, #0x24]
               	ldrsh	x2, [x2, #0x2]
               	ldrsw	x3, [x3, #0xc]
               	add	x2, x2, x3
               	ldrsw	x3, [x4, #0x1c]
               	add	x2, x2, x3
               	ldrsw	x1, [x1, #0x10]
               	add	x1, x2, x1
               	ldrsw	x0, [x0, #0x24]
               	add	x0, x1, x0
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x0, x2, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x17               // =23
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x0, x3, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x18               // =24
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x1, x0, #0xf
               	cbnz	w1, <addr>
               	add	x1, x0, #0x10
               	and	x1, x1, #0xf
               	cbz	w1, <addr>
               	mov	x0, #0x19               // =25
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x4, x1, #0xf
               	cbnz	w4, <addr>
               	add	x4, x1, #0x10
               	and	x4, x4, #0xf
               	cbz	w4, <addr>
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x4, #0x1                // =1
               	str	w4, [x2]
               	mov	x4, #0x2                // =2
               	str	w4, [x3]
               	mov	x4, #0x3                // =3
               	str	w4, [x0, #0x10]
               	mov	x4, #0x4                // =4
               	str	w4, [x1, #0x10]
               	ldrsw	x2, [x2]
               	ldrsw	x3, [x3]
               	add	x2, x2, x3
               	ldrsw	x0, [x0, #0x10]
               	add	x0, x2, x0
               	ldrsw	x1, [x1, #0x10]
               	add	x0, x0, x1
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
               	sub	sp, sp, #0x150
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0xc0]
               	sub	x2, x29, #0x98
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0xb8]
               	sub	x3, x29, #0x150
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0xb0]
               	sub	x4, x29, #0x140
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x4, #0x10]
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0xa8]
               	sub	x0, x29, #0x120
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	mov	x1, #0x5                // =5
               	sturb	w1, [x29, #-0xa0]
               	sub	x1, x29, #0x100
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x5, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x5, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	sub	x5, x29, #0xd0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldp	x16, x17, [x6]
               	stp	x16, x17, [x5]
               	and	x2, x2, #0x7
               	cbz	w2, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x3, #0xf
               	cbz	w2, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x4, #0xf
               	cbz	w2, <addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x0, #0xf
               	cbnz	w2, <addr>
               	add	x0, x0, #0x10
               	and	x0, x0, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xf
               	cbnz	w0, <addr>
               	add	x0, x1, #0x10
               	and	x0, x0, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x5, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x150
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret

<by_value>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	stur	x0, [x29, #-0x90]
               	stur	x1, [x29, #-0x70]
               	stur	x2, [x29, #-0x60]
               	stur	q0, [x29, #-0xe0]
               	sturb	w0, [x29, #-0x90]
               	sub	x1, x29, #0xd0
               	ldur	x0, [x29, #-0x70]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0xb0
               	ldur	x2, [x29, #-0x60]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x2, x29, #0xe0
               	and	x3, x2, #0xf
               	cbz	w3, <addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x3, x1, #0xf
               	cbz	w3, <addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x3, x0, #0xf
               	cbnz	w3, <addr>
               	add	x3, x0, #0x10
               	and	x3, x3, #0xf
               	cbz	w3, <addr>
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w3, [x29, #-0x90]
               	ldrsw	x2, [x2, #0x4]
               	add	x2, x3, x2
               	ldrsw	x1, [x1, #0x14]
               	add	x1, x2, x1
               	ldrsw	x0, [x0, #0x18]
               	add	x0, x1, x0
               	cmp	w0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0xa0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x1, x29, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x2, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	mov	x0, #0x1                // =1
               	ldr	q0, [x7]
               	bl	<addr>
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
