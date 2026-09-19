
overaligned_vector_object.aarch64:	file format elf64-littleaarch64

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

<automatic_boundaries>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	add	x0, sp, #0x10
               	and	x1, x0, #0xf
               	cbz	w1, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, sp
               	and	x2, x1, #0x1f
               	cbz	w2, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x7                // =7
               	sturb	w2, [x29, #-0x8]
               	mov	x3, #0x8                // =8
               	sturb	w3, [x29, #-0x20]
               	mov	x3, #0xb                // =11
               	str	w3, [x0]
               	mov	x3, #0xd                // =13
               	str	w3, [x0, #0xc]
               	mov	x3, #0x11               // =17
               	str	w3, [x1, #0x4]
               	ldrsw	x1, [x0]
               	ldrsw	x0, [x0, #0xc]
               	add	x0, x1, x0
               	mov	x1, x3
               	add	x0, x0, x1
               	cmp	w0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x20]
               	add	x0, x0, x1
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, x2
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x1, x0, #0xf
               	cbz	w1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x2, x1, #0x1f
               	cbz	w2, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x13               // =19
               	str	w2, [x0, #0x8]
               	mov	x2, #0x17               // =23
               	str	w2, [x1]
               	ldrsw	x0, [x0, #0x8]
               	mov	x1, x2
               	add	x0, x0, x1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
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
               	cmp	w0, #0x6
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x0, x0, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x0, x0, #0x3f
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
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
               	cmp	w0, #0xf
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
