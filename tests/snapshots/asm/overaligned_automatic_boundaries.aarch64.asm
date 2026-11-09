
overaligned_automatic_boundaries.aarch64:	file format elf64-littleaarch64

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

<at_page>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	str	xzr, [sp]
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffff000
               	str	xzr, [sp]
               	mov	x0, sp
               	adrp	x1, <page>
               	str	x0, [x1, #0x30]
               	mov	x1, #0x1                // =1
               	strb	w1, [sp]
               	mov	x1, #0x2                // =2
               	strb	w1, [sp, #0xfff]
               	and	x1, x0, #0xfff
               	mov	x0, #0x0                // =0
               	cbnz	w1, <addr>
               	ldrb	w1, [sp]
               	cmp	w1, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [sp, #0xfff]
               	cmp	w0, #0x2
               	cset	x0, eq
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>

<over_a_page>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x340
               	str	xzr, [sp]
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	str	xzr, [sp]
               	mov	x0, sp
               	adrp	x1, <page>
               	str	x0, [x1, #0x30]
               	mov	x1, #0x1                // =1
               	strb	w1, [sp]
               	add	x1, x0, #0x1, lsl #12   // =0x1000
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	mov	x17, #0x2327            // =8999
               	add	x2, x0, x17
               	mov	x3, #0x3                // =3
               	strb	w3, [x2]
               	and	x3, x0, #0x3f
               	mov	x0, #0x0                // =0
               	cbnz	w3, <addr>
               	ldrb	w3, [sp]
               	cmp	w3, #0x1
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w1, [x1]
               	cmp	w1, #0x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [x2]
               	cmp	w0, #0x3
               	cset	x0, eq
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x180
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x3, sp
               	adrp	x0, <page>
               	str	x3, [x0, #0x30]
               	mov	x1, #0x1                // =1
               	strh	w1, [sp]
               	mov	x2, #0x2                // =2
               	strh	w2, [sp, #0x7e]
               	and	x3, x3, #0xf
               	cbnz	w3, <addr>
               	ldrsh	x3, [sp]
               	cmp	w3, #0x1
               	b.ne	<addr>
               	add	x3, sp, #0x120
               	str	x3, [x0, #0x30]
               	mov	x4, #0x7                // =7
               	str	x4, [sp, #0x120]
               	mov	x4, #0x8                // =8
               	str	x4, [sp, #0x138]
               	and	x3, x3, #0xf
               	cbnz	w3, <addr>
               	ldr	x3, [sp, #0x120]
               	cmp	x3, #0x7
               	b.ne	<addr>
               	mov	x3, sp
               	str	x3, [x0, #0x30]
               	mov	x4, #0x9                // =9
               	str	w4, [sp]
               	mov	x4, #0xa                // =10
               	str	w4, [sp, #0x4]
               	and	x3, x3, #0x1f
               	cbnz	w3, <addr>
               	ldrsw	x3, [sp]
               	cmp	w3, #0x9
               	b.ne	<addr>
               	add	x3, sp, #0x140
               	strb	w1, [sp, #0x140]
               	add	x1, sp, #0x100
               	strb	w2, [sp, #0x100]
               	mov	x2, sp
               	mov	x4, #0x3                // =3
               	strb	w4, [sp]
               	str	x3, [x0, #0x30]
               	and	x0, x3, #0xf
               	cbnz	w0, <addr>
               	and	x0, x1, #0x1f
               	cbnz	w0, <addr>
               	and	x0, x2, #0x3f
               	cbnz	w0, <addr>
               	ldrb	w0, [sp, #0x140]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrb	w0, [sp, #0x100]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldrb	w0, [sp]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x80
               	adrp	x1, <page>
               	str	x0, [x1, #0x30]
               	mov	x2, #0x4                // =4
               	strh	w2, [sp, #0x80]
               	and	x0, x0, #0x1f
               	cbnz	w0, <addr>
               	ldr	x0, [x1, #0x30]
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
