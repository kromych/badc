
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
               	b	<addr>
               	sub	x2, x29, #0x800
               	add	x2, x2, x1
               	mov	x3, #0xaa               // =170
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	mov	w1, w0
               	cmp	w1, #0x800
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x800
               	ldp	x29, x30, [sp], #0x10
               	ret

<or_bytes>:
               	mov	x3, x0
               	mov	x5, x2
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mov	w0, w0
               	add	x6, x4, x2
               	ldrb	w6, [x6]
               	add	x6, x3, x6
               	ldrb	w6, [x6]
               	orr	x0, x0, x6
               	add	x1, x2, #0x1
               	mov	w2, w1
               	mov	w6, w5
               	cmp	w2, w6
               	b.lo	<addr>
               	mov	w0, w0
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
               	mov	x1, x0
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
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
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
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	w1, [x0, #0x8]
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
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	w1, [x0, #0x8]
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
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	w1, [x0, #0x8]
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
               	mov	x1, x0
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
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
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
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
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
               	sub	x16, x29, #0x8
               	str	x0, [x16]
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
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
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
               	mov	x17, #0x0               // =0
               	orr	x20, x0, x17
               	bl	<addr>
               	mov	w21, w20
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	w21, w21
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	w21, w21
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	w21, w21
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	w21, w21
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	w21, w21
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	w21, w21
               	mov	x0, x20
               	bl	<addr>
               	orr	x21, x21, x0
               	bl	<addr>
               	mov	w21, w21
               	mov	x0, x20
               	bl	<addr>
               	orr	x0, x21, x0
               	mov	w20, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	orr	x0, x20, x0
               	mov	w20, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	orr	x0, x20, x0
               	mov	w0, w0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
