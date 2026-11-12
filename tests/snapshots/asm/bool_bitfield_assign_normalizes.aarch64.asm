
bool_bitfield_assign_normalizes.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	wzr, [x0]
               	sturb	wzr, [x29, #-0x8]
               	mov	x3, #0x2                // =2
               	sturb	w3, [x29, #-0x8]
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	sturb	w1, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w1, [x29, #-0x8]
               	sturb	wzr, [x29, #-0x8]
               	sturb	w1, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w3, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xffffffffffffffe3
               	orr	x0, x0, #0x8
               	stur	w0, [x29, #-0x8]
               	mov	w1, w0
               	ubfx	x1, x1, #2, #3
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xfffffffffffffe1f
               	orr	x0, x0, #0x20
               	stur	w0, [x29, #-0x8]
               	mov	w1, w0
               	sbfx	x1, x1, #5, #4
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xffffffffffffffe3
               	stur	w0, [x29, #-0x8]
               	mov	w1, w0
               	ubfx	x1, x1, #2, #3
               	cbz	w1, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xffffffffffffffe3
               	orr	x0, x0, #0x4
               	stur	w0, [x29, #-0x8]
               	mov	w1, w0
               	ubfx	x1, x1, #2, #3
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xfffffffffffffe1f
               	mov	x17, #0x120             // =288
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	mov	w0, w0
               	sbfx	x0, x0, #5, #4
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrb	w1, [x0, #0xc]
               	and	x3, x1, #0x1
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ubfx	x1, x1, #1, #1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [x0, #0xc]
               	ubfx	x1, x0, #2, #3
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sbfx	x0, x0, #5, #4
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x10]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x1]
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x14]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x30]
               	cbz	w0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x31]
               	cbz	w0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x1]
               	cbz	w1, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x18]
               	and	x1, x0, #0x1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ubfx	x0, x0, #1, #1
               	cbz	w0, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x2]
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x8]
               	ldur	w2, [x29, #-0x8]
               	and	x2, x2, #0xffffffffffffffe3
               	stur	w2, [x29, #-0x8]
               	and	x2, x2, #0xfffffffffffffe1f
               	stur	w2, [x29, #-0x8]
               	ldurb	w2, [x29, #-0x8]
               	ubfx	x2, x2, #1, #1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x10
               	stp	xzr, xzr, [x2]
               	sturb	w1, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffffd
               	sturb	w1, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x8]
               	ubfx	x1, x1, #1, #1
               	cbz	w1, <addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
