
init_padding_zero.aarch64:	file format elf64-littleaarch64

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

<dirty>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x800
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x800
               	add	x1, x1, x0
               	mov	x2, #0xaa               // =170
               	strb	w2, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x800
               	b.lo	<addr>
               	add	sp, sp, #0x800
               	ldp	x29, x30, [sp], #0x10
               	ret

<or_bytes>:
               	mov	x4, x0
               	mov	x3, x1
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	cmp	w0, w2
               	b.hs	<addr>
               	ldrb	w5, [x3, x0]
               	add	x5, x4, x5
               	ldrb	w5, [x5]
               	orr	x1, x1, x5
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lo	<addr>
               	mov	x0, x1
               	ret

<struct_const>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<struct_runtime>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	strb	w1, [x0]
               	str	w1, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<struct_runtime_partial>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<struct_designated>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	strh	w1, [x0, #0xa]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<struct_empty>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<union_const>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<union_runtime>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<compound_literal>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	strb	w1, [x0]
               	str	w1, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<by_value>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<struct_by_value>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	strb	w1, [x0]
               	str	w1, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	bl	<addr>
               	bl	<addr>
               	mov	x21, x0
               	bl	<addr>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	orr	x20, x21, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	orr	x20, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	orr	x0, x20, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
