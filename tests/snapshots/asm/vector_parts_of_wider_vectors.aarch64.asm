
vector_parts_of_wider_vectors.aarch64:	file format elf64-littleaarch64

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

<lo>:
               	ld1	{ v0.d }[0], [x0]
               	ldr	x0, [x0, #0x8]
               	mov	v0.d[1], x0
               	ret

<hi>:
               	ldr	x1, [x0, #0x10]
               	fmov	d0, x1
               	ldr	x0, [x0, #0x18]
               	mov	v0.d[1], x0
               	ret

<swapped>:
               	ldr	x1, [x0, #0x8]
               	fmov	d0, x1
               	ld1	{ v0.d }[1], [x0]
               	ret

<mixed>:
               	ld1	{ v0.d }[0], [x0]
               	ldr	x0, [x0, #0x18]
               	mov	v0.d[1], x0
               	ret

<top>:
               	mov	d0, v0.d[1]
               	ret

<bottom>:
               	ret

<upper>:
               	mov	d0, v0.d[1]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	mov	x0, #0x64               // =100
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	sub	x1, x29, #0xb0
               	stur	x0, [x29, #-0xb0]
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	stur	x0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0xa0]
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x3
               	stur	x0, [x29, #-0x98]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	mov	x0, v0.d[0]
               	cmp	x0, #0x64
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cmp	x0, #0x65
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xb0
               	sub	x0, x29, #0x70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	mov	x0, v0.d[0]
               	cmp	x0, #0x66
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cmp	x0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xb0
               	sub	x0, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	mov	x0, v0.d[0]
               	cmp	x0, #0x65
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xb0
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	bl	<addr>
               	mov	x0, v0.d[0]
               	cmp	x0, #0x64
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cmp	x0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	sub	x7, x29, #0xb0
               	stur	w0, [x29, #-0xb0]
               	ldur	x0, [x29, #-0x8]
               	lsl	x0, x0, #1
               	stur	w0, [x29, #-0xac]
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, x0, lsl #1
               	stur	w0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0x8]
               	lsl	x0, x0, #2
               	stur	w0, [x29, #-0xa4]
               	ldr	q0, [x7]
               	bl	<addr>
               	smov	x0, v0.s[0]
               	cmp	x0, #0x12c
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x190
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0xb0
               	ldr	q0, [x7]
               	bl	<addr>
               	smov	x0, v0.s[0]
               	cmp	x0, #0x64
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xb0
               	ldur	x2, [x29, #-0x8]
               	add	x2, x2, x0
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x7, x29, #0xb0
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x1, x29, #0x10
               	stur	d0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldur	x3, [x29, #-0x8]
               	add	x3, x3, #0x8
               	add	x3, x3, x0
               	and	x3, x3, #0xff
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
