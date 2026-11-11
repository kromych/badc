
vector_lanes_of_8_byte_vectors.aarch64:	file format elf64-littleaarch64

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

<read_b>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	add	v0.8b, v0.8b, v1.8b
               	sub	x1, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	and	x0, x0, #0x7
               	ldrsb	x0, [x1, x0]
               	ldursb	x1, [x29, #-0x1]
               	add	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<write_h>:
               	mov	x0, #-0x7               // =-7
               	sub	v0.4h, v0.4h, v1.4h
               	mov	v0.h[2], w0
               	ret

<read_s>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, v0.d[0]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x2, lsl #32
               	eor	x0, x0, x17
               	stur	x0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x7, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x7]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	mov	x0, #0x3                // =3
               	ldr	d0, [x7]
               	ldr	d1, [x1]
               	bl	<addr>
               	cmp	w0, #0xab
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x0, #0x0                // =0
               	ldr	d0, [x7]
               	ldr	d1, [x1]
               	bl	<addr>
               	cmp	w0, #0x8a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x7]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	mov	x0, #-0x7               // =-7
               	ldr	d0, [x7]
               	ldr	d1, [x1]
               	bl	<addr>
               	stur	d0, [x29, #-0x10]
               	ldursh	x0, [x29, #-0x10]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldursh	x0, [x29, #-0xe]
               	cmp	w0, #0xc6
               	b.ne	<addr>
               	ldursh	x0, [x29, #-0xc]
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.ne	<addr>
               	ldursh	x0, [x29, #-0xa]
               	mov	x17, #-0x194            // =-404
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x7]
               	ldr	d0, [x7]
               	bl	<addr>
               	mov	x17, #0x2               // =2
               	movk	x17, #0x8000, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0xe]
               	ldurh	w1, [x29, #-0xa]
               	sxth	x1, w1
               	mov	x17, #-0x194            // =-404
               	cmp	w1, w17
               	b.ne	<addr>
               	sxth	x0, w0
               	cmp	w0, #0xc6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
